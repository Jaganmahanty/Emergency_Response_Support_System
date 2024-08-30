// ignore_for_file: file_names, non_constant_identifier_names, camel_case_types

class Alert_Opened_Registration {
  final String alert_open_Id;
  final String? alert_id;
  final String user_id;
  final DateTime openTime;

  Alert_Opened_Registration(
      {required this.alert_open_Id,
      required this.alert_id,
      required this.user_id,
      DateTime? openTime})
      : openTime = openTime ?? DateTime.now();

  Map<String, dynamic> toJsonOpenAlert() {
    return {
      'alert_open_id': alert_open_Id,
      'alert_id':alert_id,
      'user_id': user_id,
      'openTime': openTime.toString(),
    };
  }
}
