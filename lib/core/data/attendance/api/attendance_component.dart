import 'package:iespik_attendance_station/core/data/attendance/api/queries/church_event_queries.dart';
import 'package:iespik_attendance_station/core/domains/attendance/attendance_component.dart';

import '../../../domains/attendance/commands/church_event_attendance.dart';
import '../../../domains/attendance/queries/event_queries.dart';
import '../../../domains/attendance/queries/event_schedule_queries.dart';
import '../../../domains/attendance/queries/label_queries.dart';
import '../../../infra/api/attendance/attendance_client.dart';
import 'commands/church_event_attendance.dart';
import 'queries/church_event_schedule_queries.dart';

class AttendanceComponentImpl extends AttendanceComponent {
  final AttendanceService _attendanceService = AttendanceService();

  late final ChurchEventQueries _churchEventQueries;
  late final ChurchEventScheduleQueries _churchEventScheduleQueries;

  late final ChurchEventAttendanceCommands _churchEventAttendanceCommands;

  AttendanceComponentImpl() {
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
