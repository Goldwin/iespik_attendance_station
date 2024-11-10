import 'package:iespik_attendance_station/core/domains/attendance/index.dart';
import 'package:iespik_attendance_station/core/domains/people/commands/household_commands.dart';
import 'package:iespik_attendance_station/core/domains/people/commands/person_commands.dart';

abstract class PeopleComponent {
  HouseholdQueries getHouseholdQueries();

  HouseholdCommands getHouseholdCommands();

  PersonCommands getPersonCommands();
}
