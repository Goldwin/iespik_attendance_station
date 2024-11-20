import 'package:iespik_attendance_station/core/domains/attendance/index.dart';
import 'package:iespik_attendance_station/core/domains/people/commands/person_commands.dart';

abstract class PeopleComponent {
  HouseholdQueries getHouseholdQueries();

  PersonCommands getPersonCommands();
}
