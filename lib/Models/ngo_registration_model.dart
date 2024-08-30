// ignore_for_file: file_names
class NGORegistration {
  final String nid;
  final String ngoName;
  final String ngoRegNo;
  final String profilePic;
  final String services;
  final String contactNumber;
  final String email;
  final String website;
  final int creditScore;
  final String state;
  final String city;
  final String pinCode;
  final String fullAddress;
  final String password;
  final DateTime registrationTime;
  final String deviceToken;
  final String aboutNGO;
  final String upiId;

  NGORegistration(
      {required this.nid,
      required this.ngoName,
      required this.ngoRegNo,
      required this.profilePic,
      required this.services,
      required this.contactNumber,
      required this.email,
      required this.website,
      required this.creditScore,
      required this.state,
      required this.city,
      required this.pinCode,
      required this.fullAddress,
      required this.password,
      required this.deviceToken,
      required this.aboutNGO,
      required this.upiId,
      DateTime? registrationTime})
      : registrationTime = registrationTime ?? DateTime.now();

  Map<String, dynamic> toJsonNGO() {
    return {
      'nid': nid,
      'nameOfNGO': ngoName,
      'NGORegNo': ngoRegNo,
      'aboutNGO': aboutNGO,
      "upiId": upiId,
      'profilePic': profilePic,
      'services': services,
      'contactNumber': "+91$contactNumber",
      'website': website,
      'email': email,
      'creditScore': creditScore,
      'state': state,
      'city': city,
      'pinCode': pinCode,
      'fullAddress': fullAddress,
      'password': password,
      'registrationTime': registrationTime.toString(),
      'deviceToken': deviceToken,
    };
  }
}
