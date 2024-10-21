import 'package:iespik_attendance_station/app/attendance/domain/entities/events/church_event_activity.dart';

class ChurchEvent {
  final String id;
  final String name;
  final List<ChurchEventActivity> activities;
  final String eventScheduleId;
  final DateTime startDate;
  final DateTime endDate;

  ChurchEvent(
      {required this.id,
      required this.name,
      required this.eventScheduleId,
      required this.startDate,
      required this.endDate,
      required this.activities});

  factory ChurchEvent.fromJson(Map<String, dynamic> json) {
    List<Map<String, dynamic>> jsonActivities = json['activities'];

    List<ChurchEventActivity> activities = jsonActivities
        .map((activityJson) => ChurchEventActivity.fromJson(activityJson))
        .toList();
    return ChurchEvent(
        id: json['id'],
        name: json['name'],
        eventScheduleId: json['eventScheduleId'],
        startDate: DateTime.parse(json['startDate']),
        endDate: DateTime.parse(json['endDate']),
        activities: activities);
  }
}
