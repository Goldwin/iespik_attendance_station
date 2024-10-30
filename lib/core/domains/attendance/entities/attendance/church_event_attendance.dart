import '../events/church_event.dart';
import '../events/church_event_activity.dart';
import 'church_event_attendee.dart';

class ChurchEventAttendance {
  final String id;
  final ChurchEvent event;
  final ChurchEventActivity activity;
  final ChurchEventAttendee attendee;
  final ChurchEventAttendee checkinBy;
  final String securityCode;
  final int securityNumber;

  final DateTime checkinTime;
  final String attendanceType;

  ChurchEventAttendance(
      {required this.id,
      required this.event,
      required this.activity,
      required this.attendee,
      required this.checkinBy,
      required this.securityCode,
      required this.securityNumber,
      required this.checkinTime,
      required this.attendanceType});

  factory ChurchEventAttendance.fromJson(Map<String, dynamic> json) {
    return ChurchEventAttendance(
        id: json['id'],
        event: ChurchEvent.fromJson(json['event']),
        activity: ChurchEventActivity.fromJson(json['activity']),
        attendee: ChurchEventAttendee.fromJson(json['attendee']),
        checkinBy: ChurchEventAttendee.fromJson(json['checkedInBy']),
        securityCode: json['securityCode'],
        securityNumber: json['securityNumber'],
        checkinTime: DateTime.parse(json['checkinTime']),
        attendanceType: json['attendanceType']);
  }
}
