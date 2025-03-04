import 'dart:convert';

import 'package:http/http.dart';
import 'package:iespik_attendance_station/core/commons/auth.dart';
import 'package:iespik_attendance_station/core/commons/response.dart';

import '../../../domains/attendance/entities/people/household.dart';
import '../../../domains/attendance/entities/people/person.dart';

class PersonData {
  final String id;
  final String firstName;
  final String lastName;
  final String profilePictureUrl;
  final String birthday;

  PersonData(this.id, this.firstName, this.lastName, this.profilePictureUrl,
      this.birthday);

  factory PersonData.fromJson(Map<String, dynamic> json) {
    return PersonData(json['id'], json['firstName'], json['lastName'],
        json['profilePictureUrl'], json['birthday']);
  }
}

class HouseholdData {
  final String id;
  final String name;
  final String pictureUrl;
  final PersonData householdHead;
  final List<PersonData> members;

  HouseholdData(
      this.id, this.name, this.pictureUrl, this.householdHead, this.members);

  factory HouseholdData.fromJson(Map<String, dynamic> json) {
    final membersList = json['members'] as List<dynamic>;
    final List<PersonData> members = membersList
        .map(
          (member) => member as Map<String, dynamic>,
        )
        .map((json) => PersonData.fromJson(json))
        .toList();
    return HouseholdData(json['id'], json['name'], json['pictureUrl'],
        PersonData.fromJson(json['householdHead']), members);
  }
}

class SearchHouseholdFilter {
  final String namePrefix;
  final int limit;

  SearchHouseholdFilter(this.namePrefix, this.limit);
}

class PeopleService {
  final String peopleServiceUrl = 'https://api.brightfellow.net/people';

  Future<List<HouseholdData>> searchHouseholds(
      SearchHouseholdFilter filter) async {
    var body = jsonEncode(<String, dynamic>{
      'namePrefix': filter.namePrefix,
      'limit': filter.limit
    });
    final token = await getToken();
    return post(Uri.parse('$peopleServiceUrl/households/search'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
              'Authorization': 'Bearer $token'
            },
            body: body)
        .then((response) {
      Map<String, dynamic> x =
          jsonDecode(response.body) as Map<String, dynamic>;

      APIResponse<List<HouseholdData>> apiResponse =
          APIResponse<List<HouseholdData>>.fromJsonList(x,
              (List<Map<String, dynamic>> list) {
        return list.map(HouseholdData.fromJson).toList();
      });

      if (apiResponse.isError()) {
        throw apiResponse.error!;
      }

      if (apiResponse.data == null) {
        throw Exception('No data returned');
      }

      return apiResponse.data!;
    });
  }

  Future<Household> addHousehold(Household household) async {
    final body = jsonEncode(<String, dynamic>{
      'name': household.name,
      'headPersonId': household.head.id,
      'memberPersonIds': household.members.map((e) => e.id).toList()
    });
    final token = await getToken();
    return post(Uri.parse('$peopleServiceUrl/households'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
              'Authorization': 'Bearer $token'
            },
            body: body)
        .then((response) {
      Map<String, dynamic> x =
          jsonDecode(response.body) as Map<String, dynamic>;

      APIResponse<Household> apiResponse =
          APIResponse<Household>.fromJson(x, Household.fromJson);

      if (apiResponse.isError()) {
        throw apiResponse.error!;
      }

      if (apiResponse.data == null) {
        throw Exception('No data returned');
      }

      return apiResponse.data!;
    });
  }

  Future<Household> updateHousehold(Household household) async {
    final body = jsonEncode(<String, dynamic>{
      'name': household.name,
      'headPersonId': household.head.id,
      'memberPersonIds': household.members.map((e) => e.id).toList()
    });
    final token = await getToken();
    return put(Uri.parse('$peopleServiceUrl/households/${household.id}'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
              'Authorization': 'Bearer $token'
            },
            body: body)
        .then((response) {
      Map<String, dynamic> x =
          jsonDecode(response.body) as Map<String, dynamic>;

      APIResponse<Household> apiResponse =
          APIResponse<Household>.fromJson(x, Household.fromJson);

      if (apiResponse.isError()) {
        throw apiResponse.error!;
      }

      if (apiResponse.data == null) {
        throw Exception('No data returned');
      }

      return apiResponse.data!;
    });
  }

  Future<Person> addPerson(Person person) async {
    post(Uri.parse('$peopleServiceUrl/people/persons'));
    var body = jsonEncode(person);
    final token = await getToken();
    return post(Uri.parse('$peopleServiceUrl/persons'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
              'Authorization': 'Bearer $token'
            },
            body: body)
        .then((response) {
      Map<String, dynamic> x =
          jsonDecode(response.body) as Map<String, dynamic>;

      APIResponse<Person> apiResponse =
          APIResponse<Person>.fromJson(x, Person.fromJson);

      if (apiResponse.isError()) {
        throw apiResponse.error!;
      }

      if (apiResponse.data == null) {
        throw Exception('No data returned');
      }

      return apiResponse.data!;
    });
  }
}
