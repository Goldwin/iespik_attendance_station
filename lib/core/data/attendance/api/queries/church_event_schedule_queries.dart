import '../../../../domains/attendance/entities/events/church_event_schedule.dart';
import '../../../../domains/attendance/queries/event_schedule_queries.dart';
import '../../../../infra/api/attendance/attendance_client.dart';

class APIChurchEventScheduleQueriesImpl extends ChurchEventScheduleQueries {
  final AttendanceService _attendanceService;

  APIChurchEventScheduleQueriesImpl(this._attendanceService);

  @override
  Future<List<ChurchEventSchedule>> listSchedules(
      {int limit = 100, String lastId = ""}) {
    return _attendanceService.listSchedules(limit: limit, lastId: lastId);
  }
}
