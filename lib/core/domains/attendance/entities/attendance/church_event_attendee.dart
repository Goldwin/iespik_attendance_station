class ChurchEventAttendee {
  final String id;
  final String firstName;
  final String? middleName;
  final String lastName;
  final String? profilePicture;

  ChurchEventAttendee(
      {required this.id,
      required this.firstName,
      required this.middleName,
      required this.lastName,
      required this.profilePicture});

  factory ChurchEventAttendee.fromJson(Map<String, dynamic> json) {
    return ChurchEventAttendee(
      id: json['id'],
      firstName: json['firstName'],
      middleName: json['middleName'],
      lastName: json['lastName'],
      profilePicture: json['profilePicture'],
    );
  }
}
