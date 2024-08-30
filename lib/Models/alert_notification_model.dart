// ignore_for_file: file_names, non_constant_identifier_names

class AlertNotificationRegistration {
  final String AlertId;
  final String did;
  final String typeofDisaster;
  final String desc;
  final String level;
  final String state;
  final String city;
  final DateTime sentTime;

  AlertNotificationRegistration(
      {required this.AlertId,
      required this.did,
      required this.typeofDisaster,
      required this.desc,
      required this.level,
      required this.state,
      required this.city,
      DateTime? sentTime})
      : sentTime = sentTime ?? DateTime.now();

  Map<String, dynamic> toJsonAlert() {
    return {
      'AlertId': AlertId,
      'did':did,
      'typeofDisaster': typeofDisaster,
      'description': desc,
      'level': level,
      'state': state,
      'city': city,
      'sentTime': sentTime.toString(),
    };
  }
}
