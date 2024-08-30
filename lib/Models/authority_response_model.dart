// ignore_for_file: file_names, camel_case_types

class NGO_Response_Registration {
  final String respondId;
  final String requestId;
  final String nid;
  final String fid;
  final String responderNGOName;
  final String responderNGORegNo;
  final String responderNGOAddress;
  final String? responderNGOContactNo;
  final String responderNGOEmail;
  final String responderNGOWebsite;
  final DateTime respondNGOTime;

  NGO_Response_Registration({
    required this.respondId,
    required this.requestId,
    required this.fid,
    required this.nid,
    required this.responderNGOName,
    required this.responderNGORegNo,
    required this.responderNGOAddress,
    required this.responderNGOContactNo,
    required this.responderNGOEmail,
    required this.responderNGOWebsite,
    DateTime? respondNGOTime,
  }) : respondNGOTime = respondNGOTime ?? DateTime.now();

  Map<String, dynamic> toNGORespondJson() {
    return {
      'RespondId': respondId,
      'RequestId': requestId,
      'nid': nid,
      'fid': fid,
      'ResponderNGOName': responderNGOName,
      'ResponderNGORegNo': responderNGORegNo,
      'ResponderNGOAddress': responderNGOAddress,
      'ResponderNGOContactNumber': responderNGOContactNo,
      'ResponderNGOEmail': responderNGOEmail,
      'ResponderNGOWebsite': responderNGOWebsite,
      'RespondNGOTime': respondNGOTime.toString(),
    };
  }
}

class Govt_Response_Registration {
  final String respondId;
  final String requestId;
  final String gid;
  final String fid;
  final String responderGovtName;
  final String responderGovtRegNo;
  final String responderGovtAddress;
  final String? responderGovtContactNo;
  final String responderGovtEmail;
  final String responderGovtWebsite;
  final DateTime respondGovtTime;

  // final String deviceToken;

  Govt_Response_Registration({
    required this.respondId,
    required this.requestId,
    required this.gid,
    required this.fid,
    required this.responderGovtName,
    required this.responderGovtRegNo,
    required this.responderGovtAddress,
    required this.responderGovtContactNo,
    required this.responderGovtEmail,
    required this.responderGovtWebsite,
    // required this.deviceToken,
    DateTime? respondGovtTime,
  }) : respondGovtTime = respondGovtTime ?? DateTime.now();

  Map<String, dynamic> toGovtRespondJson() {
    return {
      'RespondId': respondId,
      'RequestId': requestId,
      'gid': gid,
      'fid': fid,
      'ResponderGovtName': responderGovtName,
      'ResponderGovtRegNo': responderGovtRegNo,
      'ResponderGovtAddress': responderGovtAddress,
      'ResponderGovtContactNumber': responderGovtContactNo,
      'ResponderGovtEmail': responderGovtEmail,
      'ResponderGovtWebsite': responderGovtWebsite,
      'RespondGovtTime': respondGovtTime.toString(),
    };
  }
}
