import 'package:iespik_attendance_station/core/domains/attendance/attendance_component.dart';
import 'package:iespik_attendance_station/core/data/attendance/api/queries/church_event_queries.dart';

import '../../../domains/attendance/commands/church_event_attendance.dart';
import '../../../domains/attendance/queries/event_queries.dart';
import '../../../domains/attendance/queries/event_schedule_queries.dart';
import '../../../domains/attendance/queries/household_queries.dart';
import '../../../domains/attendance/queries/label_queries.dart';
import '../../../infra/api/attendance/attendance_client.dart';
import '../../../infra/api/people/people_client.dart';
import 'commands/church_event_attendance.dart';
import 'queries/church_event_schedule_queries.dart';
import 'queries/household_queries.dart';

class AttendanceComponentImpl extends AttendanceComponent {
  final PeopleService _peopleService = PeopleService();
  final AttendanceService _attendanceService = AttendanceService();

  late final HouseholdQueries _householdQueries;
  late final ChurchEventQueries _churchEventQueries;
  late final ChurchEventScheduleQueries _churchEventScheduleQueries;

  late final ChurchEventAttendanceCommands _churchEventAttendanceCommands;

  AttendanceComponentImpl() {
    _householdQueries = HouseholdQueriesImpl(_peopleService);

    _churchEventQueries = APIChurchEventQueriesImpl(_attendanceService);
    _churchEventScheduleQueries =
        APIChurchEventScheduleQueriesImpl(_attendanceService);
    _churchEventAttendanceCommands =
        APIChurchEventAttendanceCommandsImpl(_attendanceService);
  }

  @override
  ChurchEventQueries getChurchEventQueries() {
    return _churchEventQueries;
  }

  @override
  HouseholdQueries getHouseholdQueries() {
    return _householdQueries;
  }

  @override
  LabelQueries labelQueries() {
    // TODO: implement labelQueries
    throw UnimplementedError();
  }

  @override
  ChurchEventScheduleQueries getChurchEventScheduleQueries() {
    return _churchEventScheduleQueries;
  }

  @override
  ChurchEventAttendanceCommands getChurchEventAttendanceCommands() {
    return _churchEventAttendanceCommands;
  }
}