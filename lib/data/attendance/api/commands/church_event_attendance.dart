import 'package:iespik_attendance_station/app/attendance/domain/commands/church_event_attendance.dart';
import 'package:iespik_attendance_station/app/attendance/domain/entities/attendance/church_event_attendance.dart';
import 'package:iespik_attendance_station/infra/api/attendance/attendance_client.dart';

class APIChurchEventAttendanceCommandsImpl
    extends ChurchEventAttendanceCommands {
  final AttendanceService _attendanceService;

  APIChurchEventAttendanceCommandsImpl(this._attendanceService);

  @override
  Future<List<ChurchEventAttendance>> checkIn(
      {required String scheduleId,
      required String eventId,
      required List<AttendeeData> attendees,
      required String checkInBy}) async {
    return _attendanceService.checkin(
        scheduleId: scheduleId,
        eventId: eventId,
        data: attendees,
        checkinBy: checkInBy);
  }
}
