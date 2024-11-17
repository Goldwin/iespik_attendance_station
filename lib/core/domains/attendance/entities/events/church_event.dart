import 'church_event_activity.dart';

class ChurchEvent {
  final String id;
  final String name;
  final List<ChurchEventActivity> activities;
  final String eventScheduleId;
  final DateTime startDate;
  final DateTime endDate;
  final List<String> labels;

  ChurchEvent(
      {required this.id,
      required this.name,
      required this.eventScheduleId,
      required this.startDate,
      required this.endDate,
      required this.activities,
      this.labels = const []});

  factory ChurchEvent.fromJson(Map<String, dynamic> json) {
    List<dynamic> jsonActivities = json['activities'];

    List<ChurchEventActivity> activities = jsonActivities
        .map((activityJson) => ChurchEventActivity.fromJson(activityJson))
        .toList();
    return ChurchEvent(
        id: json['id'],
        name: json['name'],
        eventScheduleId: json['scheduleId'],
        startDate: DateTime.parse(json['startDate']),
        endDate: DateTime.parse(json['endDate']),
        labels: json['labels']?.toList() ?? [],
        activities: activities);
  }
}
