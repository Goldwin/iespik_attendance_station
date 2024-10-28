import 'package:iespik_attendance_station/app/attendance/domain/entities/events/church_event_schedule.dart';

abstract class ChurchEventScheduleQueries {
  Future<List<ChurchEventSchedule>> listSchedules(
      {int limit = 0, String lastId = ""});
}
