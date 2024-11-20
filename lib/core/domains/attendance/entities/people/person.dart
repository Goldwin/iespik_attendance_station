class Person {
  final String id;
  final String firstName;
  final String? middleName;
  final String lastName;
  final String? profilePictureUrl;
  final String? emailAddress;
  final String? address;
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
      this.address});

  factory Person.fromJson(Map<String, dynamic> json) {
    return Person(
      id: json['id'],
      firstName: json['firstName'],
      middleName: json['middleName'],
      lastName: json['lastName'],
      profilePictureUrl: json['profilePictureUrl'],
      emailAddress: json['emailAddress'],
      phoneNumber: json['phoneNumber'],
      maritalStatus: json['maritalStatus'],
      birthday: json['birthday'],
      gender: json['gender'],
      anniversary: json['anniversary'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['firstName'] = firstName;
    data['middleName'] = middleName;
    data['lastName'] = lastName;
    data['profilePictureUrl'] = profilePictureUrl;
    data['emailAddress'] = emailAddress;
    data['phoneNumber'] = phoneNumber;
    data['maritalStatus'] = maritalStatus;
    data['birthday'] = birthday;
    data['gender'] = gender;
    data['anniversary'] = anniversary;
    return data;
  }
}
