class Person {
  final String id;
  final String firstName;
  final String? middleName;
  final String lastName;
  final String? profilePictureUrl;
  final String? emailAddress;
  final String? phoneNumber;
  final String? maritalStatus;
  final String? birthday;
  final String? gender;
  final String? anniversary;

  Person({
    required this.id,
    required this.firstName,
    required this.lastName,
    this.birthday,
    this.gender,
    this.emailAddress,
    this.middleName,
    this.profilePictureUrl,
    this.phoneNumber,
    this.maritalStatus,
    this.anniversary,
  });
}
