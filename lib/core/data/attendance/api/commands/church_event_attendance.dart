import '../../../../domains/attendance/commands/church_event_attendance.dart';
import '../../../../domains/attendance/entities/attendance/church_event_attendance.dart';
import '../../../../infra/api/attendance/attendance_client.dart';

class APIChurchEventAttendanceCommandsImpl
    extends ChurchEventAttendanceCommands {
  final AttendanceService _attendanceService;

  APIChurchEventAttendanceCommandsImpl(this._attendanceService);

  @override
  Future<List<ChurchEventAttendance>> checkIn(
      {required String scheduleId,
      required String eventId,
      required List<AttendeeData> attendees,
      required String checkedInBy}) async {
    return _attendanceService.checkin(
        scheduleId: scheduleId,
        eventId: eventId,
        data: attendees,
        checkedInBy: checkedInBy);
  }
}
