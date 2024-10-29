import 'package:iespik_attendance_station/app/attendance/domain/entities/attendance/church_event_attendance.dart';

class AttendeeData {
  final String personId;
  final String eventActivityId;
  final String attendanceType;

  AttendeeData(
      {required this.personId,
      required this.eventActivityId,
      required this.attendanceType});

  factory AttendeeData.fromJson(Map<String, dynamic> json) {
    return AttendeeData(
      personId: json['personId'],
      eventActivityId: json['eventActivityId'],
      attendanceType: json['attendanceType'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['personId'] = personId;
    data['eventActivityId'] = eventActivityId;
    data['attendanceType'] = attendanceType;
    return data;
  }
}

abstract class ChurchEventAttendanceCommands {
  Future<List<ChurchEventAttendance>> checkIn(
      {required String scheduleId,
      required String eventId,
      required List<AttendeeData> attendees,
      required String checkedInBy});
}
