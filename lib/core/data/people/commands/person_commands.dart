import 'package:iespik_attendance_station/core/domains/attendance/entities/people/household.dart';
import 'package:iespik_attendance_station/core/domains/attendance/entities/people/person.dart';
import 'package:iespik_attendance_station/core/domains/people/commands/person_commands.dart';
import 'package:iespik_attendance_station/core/infra/api/people/people_client.dart';

class APIPersonCommandsImpl extends PersonCommands {
  final PeopleService peopleService;

  APIPersonCommandsImpl(this.peopleService);

  @override
  Future<Household> addPerson(Person person, Household household) async {
    final addedPerson = await peopleService.addPerson(person);
    if (household.id.isEmpty) {
      household.head = addedPerson;
      return peopleService.addHousehold(household);
    }
    household.members.add(addedPerson);
    return await peopleService.updateHousehold(household);
  }
}
