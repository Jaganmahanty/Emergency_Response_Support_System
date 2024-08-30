// ignore_for_file: file_names
class UserRegistration {
  final String cid;
  final String firstName;
  final String lastName;
  final String profilePic;
  final String gender;
  final String phoneNumber;
  final DateTime birthDate;
  final String state;
  final String city;
  final String pinCode;
  final String fullAddress;
  final DateTime registrationTime;
  final String deviceToken;

  UserRegistration({
    required this.cid,
    required this.firstName,
    required this.lastName,
    required this.profilePic,
    required this.gender,
    required this.phoneNumber,
    required this.birthDate,
    required this.state,
    required this.city,
    required this.pinCode,
    required this.fullAddress,
    required this.deviceToken,
    DateTime? registrationTime,
  }) : registrationTime = registrationTime ?? DateTime.now();

  Map<String, dynamic> toJsonCitizen() {
    return {
      'cid': cid,
      'firstName': firstName,
      'lastName': lastName,
      'profilePic': profilePic,
      'gender': gender,
      'phoneNumber': phoneNumber,
      'birthDate': birthDate,
      'state': state,
      'city': city,
      'pinCode': pinCode,
      'fullAddress': fullAddress,
      'registrationTime': registrationTime.toString(),
      'deviceToken': deviceToken,
    };
  }
}
