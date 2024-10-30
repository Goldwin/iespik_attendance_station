class ChurchEventActivity {
  final String id;
  final String name;
  final DateTime time;
  final Map<String, String>? labels;

  factory ChurchEventActivity.fromJson(Map<String, dynamic> json) {
    return ChurchEventActivity(
      id: json['id'],
      name: json['name'],
      time: DateTime.parse(json['time']),
      labels: json['labels'],
    );
  }

  ChurchEventActivity(
      {required this.id,
      required this.name,
      required this.time,
      this.labels = const {}});
}
