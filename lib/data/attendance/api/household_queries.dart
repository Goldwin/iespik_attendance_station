import 'package:iespik_attendance_station/app/attendance/domain/entities/people/household.dart';
import 'package:iespik_attendance_station/app/attendance/domain/entities/people/person.dart';
import 'package:iespik_attendance_station/app/attendance/domain/queries/household_queries.dart';
import 'package:iespik_attendance_station/infra/api/people/people_client.dart';

class HouseholdQueriesImpl extends HouseholdQueries {
  final PeopleService _peopleService;

  HouseholdQueriesImpl(this._peopleService);

  Person _personMapper(PersonData personData) => Person(
        id: personData.id,
        firstName: personData.firstName,
        lastName: personData.lastName,
        birthday: personData.birthday,
      );

  @override
  Future<List<Household>> listHouseholds({String name = "", int limit = 10}) {
    return _peopleService
        .searchHouseholds(SearchHouseholdFilter(name, limit))
        .then((value) => value
            .map((HouseholdData householdData) => Household(
                head: _personMapper(householdData.householdHead),
                members: householdData.members.map(_personMapper).toList(),
                id: householdData.id,
                name: householdData.name))
            .toList());
  }
}
