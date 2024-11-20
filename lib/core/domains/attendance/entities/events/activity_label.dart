class ActivityLabel {
  final String labelId;
  final String labelName;
  final String type;
  final List<String> attendanceTypes;
  final int quantity;

  ActivityLabel(this.labelId, this.labelName, this.type, this.attendanceTypes,
      this.quantity);

  factory ActivityLabel.fromJson(Map<String, dynamic> json) {
    return ActivityLabel(
      json['labelId'],
      json['labelName'],
      json['type'],
      List<String>.from(json['attendanceTypes']),
      json['quantity'],
    );
  }
}
