import 'package:iespik_attendance_station/app/attendance/domain/entities/events/church_event_schedule.dart';
import 'package:iespik_attendance_station/app/attendance/domain/queries/event_schedule_queries.dart';
import 'package:iespik_attendance_station/infra/api/attendance/attendance_client.dart';

class APIChurchEventScheduleQueriesImpl extends ChurchEventScheduleQueries {
  final AttendanceService _attendanceService;

  APIChurchEventScheduleQueriesImpl(this._attendanceService);

  @override
  Future<List<ChurchEventSchedule>> listSchedules(
      {int limit = 100, String lastId = ""}) {
    return _attendanceService.listSchedules(limit: limit, lastId: lastId);
  }
}
