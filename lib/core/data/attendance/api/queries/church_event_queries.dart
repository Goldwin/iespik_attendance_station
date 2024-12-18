import '../../../../domains/attendance/entities/events/church_event.dart';
import '../../../../domains/attendance/queries/event_queries.dart';
import '../../../../infra/api/attendance/attendance_client.dart';

class APIChurchEventQueriesImpl implements ChurchEventQueries {
  final AttendanceService _attendanceService;

  APIChurchEventQueriesImpl(this._attendanceService);

  @override
  Future<ChurchEvent> getActiveEvent({String? id, DateTime? date}) {
    if (id == null) {
      throw Exception('Schedule id must be provided');
    }

    date = (date ?? DateTime.now());
    String eventId =
        '$id.${date.year}${date.month.toString().padLeft(2, '0')}${date.day.toString().padLeft(2, '0')}';

    return _attendanceService.getEvent(scheduleId: id, eventId: eventId);
  }
}
