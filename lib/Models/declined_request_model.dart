// ignore_for_file: file_names, camel_case_types, non_constant_identifier_names

class Declined_Req_Registration {
  final String decId;
  final String requestId;
  final String auth_id;
  final String auth_name;
  final String decline_reason;
  final String username;
  final DateTime DeclineTime;

  Declined_Req_Registration({
    required this.decId,
    required this.requestId,
    required this.auth_id,
    required this.auth_name,
    required this.username,
    required this.decline_reason,
    DateTime? DeclineTime,
  }) : DeclineTime = DeclineTime ?? DateTime.now();

  Map<String, dynamic> toDeclineReqJson() {
    return {
      'DecId': decId,
      'RequestId': requestId,
      'Authority_Id': auth_id,
      'Authority_Name': auth_name,
      'Username':username,
      'Decline_Reason': decline_reason,
      'DeclineTime': DeclineTime.toString(),
    };
  }
}
