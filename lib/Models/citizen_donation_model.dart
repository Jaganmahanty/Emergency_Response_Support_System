// ignore_for_file: file_names, non_constant_identifier_names, camel_case_types

class Donation_Registration {
  final String Donation_id;
  final String cid;
  final String authority_id;
  final String auth_email;
  final String donerName;
  final String NGOName;
  final String Mode;
  final String upiId;
  final String upiId_ngo;
  final String Amount;
  final String TxnId;
  final DateTime TxnTime;

  Donation_Registration(
      {required this.Donation_id,
      required this.cid,
      required this.authority_id,
      required this.auth_email,
      required this.donerName,
      required this.NGOName,
      required this.Mode,
      required this.upiId,
      required this.upiId_ngo,
      required this.Amount,
      required this.TxnId,
      DateTime? TxnTime})
      : TxnTime = TxnTime ?? DateTime.now();

  Map<String, dynamic> toJsonDonation() {
    return {
      'Donation_id': Donation_id,
      'cid': cid,
      'authorityId': authority_id,
      'authEmail': auth_email,
      'donerName': donerName,
      'NGOName': NGOName,
      'mode': Mode,
      'upiId': upiId,
      'ngo_upiId': upiId_ngo,
      'amount': Amount,
      'txnId': TxnId,
      'txnTime': TxnTime.toString(),
    };
  }
}
