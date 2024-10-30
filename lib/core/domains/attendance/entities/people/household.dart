import 'person.dart';

class Household {
  final String id;
  final String name;
  final Person head;
  final List<Person> members;

  Household(
      {required this.id,
      required this.name,
      required this.head,
      required this.members});
}
