import 'package:iespik_attendance_station/core/domains/attendance/entities/people/household.dart';

import '../../attendance/entities/people/person.dart';

abstract class PersonCommands {
  Future<Household> addPerson(Person person, Household household);
}
