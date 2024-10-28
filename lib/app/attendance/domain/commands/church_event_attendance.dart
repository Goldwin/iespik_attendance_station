import 'package:iespik_attendance_station/app/attendance/domain/entities/attendance/church_event_attendance.dart';

class AttendeeData {
  final String personId;
  final String eventActivityId;
  final String attendanceType;

  AttendeeData(
      {required this.personId,
      required this.eventActivityId,
      required this.attendanceType});
}

abstract class ChurchEventAttendanceCommands {
  Future<List<ChurchEventAttendance>> checkIn(
      {required String scheduleId,
      required String eventId,
      required List<AttendeeData> attendees,
      required String checkInBy});
}
