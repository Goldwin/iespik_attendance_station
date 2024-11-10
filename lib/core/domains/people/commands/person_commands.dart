import '../../attendance/entities/people/person.dart';

abstract class PersonCommands {
  Future<Person> addPerson(Person person);
}
