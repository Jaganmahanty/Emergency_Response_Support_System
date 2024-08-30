// ignore_for_file: file_names, non_constant_identifier_names, camel_case_types

class Request_Opened_Registration {
  final String req_open_Id;
  final String req_Id;
  final String authority_id;
  final DateTime openTime;

  Request_Opened_Registration(
      {required this.req_open_Id,
        required this.req_Id,
      required this.authority_id,
      DateTime? openTime})
      : openTime = openTime ?? DateTime.now();

  Map<String, dynamic> toJsonOpenReq() {
    return {
      'request_open_id': req_open_Id,
      'request_id': req_Id,
      'authority_id': authority_id,
      'openTime': openTime.toString(),
    };
  }
}
