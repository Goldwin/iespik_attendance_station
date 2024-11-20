import 'person.dart';

class Household {
  final String id;
  final String name;
  Person head;
  final List<Person> members;

  Household(
      {required this.id,
      required this.name,
      required this.head,
      required this.members});

  factory Household.fromJson(Map<String, dynamic> json) {
    return Household(
      id: json['id'],
      name: json['name'],
      head: Person.fromJson(json['householdHead']),
      members: json['members']
          .map((e) => Person.fromJson(e))
          .toList()
          .cast<Person>(),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['head'] = head.toJson();
    data['members'] = members.map((e) => e.toJson()).toList();
    return data;
  }
}
