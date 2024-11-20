import 'package:iespik_attendance_station/core/domains/attendance/entities/events/activity_label.dart';

class ChurchEventActivity {
  final String id;
  final String name;
  final DateTime time;
  final List<ActivityLabel> labels;

  factory ChurchEventActivity.fromJson(Map<String, dynamic> json) {
    List<ActivityLabel> activityLabel = [];
    final labels = json['labels'] ?? [];
    if (labels.isNotEmpty) {
      activityLabel = labels
          .map((label) {
            return ActivityLabel.fromJson(label as Map<String, dynamic>);
          })
          .toList()
          .cast<ActivityLabel>();
    }

    return ChurchEventActivity(
      id: json['id'],
      name: json['name'],
      time: DateTime.parse(json['time']),
      labels: activityLabel,
    );
  }

  ChurchEventActivity(
      {required this.id,
      required this.name,
      required this.time,
      this.labels = const []});
}
