// ignore_for_file: non_constant_identifier_names

class EmergencyContactRegistration {
  final String ContactId;
  final String state;
  final String city;
  final String info;
  final String Contact_1;
  final String Contact_2;
  final String Contact_3;
  final String Contact_4;
  final String Contact_5;
  final String Contact_6;
  final String isVisible;
  final DateTime sentTime;

  EmergencyContactRegistration(
      {required this.ContactId,
      required this.state,
      required this.city,
      required this.info,
      required this.Contact_1,
      required this.Contact_2,
      required this.Contact_3,
      required this.Contact_4,
      required this.Contact_5,
      required this.Contact_6,
      required this.isVisible,
      DateTime? sentTime})
      : sentTime = sentTime ?? DateTime.now();

  Map<String, dynamic> toJsonEmergency() {
    return {
      'ContactId': ContactId,
      'state': state,
      'city': city,
      'info': info,
      'Contact_1': Contact_1,
      'Contact_2': Contact_2,
      'Contact_3': Contact_3,
      'Contact_4': Contact_4,
      'Contact_5': Contact_5,
      'Contact_6': Contact_6,
      'isVisible': isVisible,
      'sentTime': sentTime.toString(),
    };
  }
}
