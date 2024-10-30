class ChurchEventSchedule {
  final String id;
  final String name;
  final int timezoneOffset;

  ChurchEventSchedule(
      {required this.id, required this.name, required this.timezoneOffset});

  factory ChurchEventSchedule.fromJson(Map<String, dynamic> json) {
    return ChurchEventSchedule(
        id: json['id'],
        name: json['name'],
        timezoneOffset: json['timezoneOffset']);
  }
}
