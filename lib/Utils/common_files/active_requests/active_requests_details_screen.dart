// ignore_for_file: camel_case_types, use_build_context_synchronously, non_constant_identifier_names, unrelated_type_equality_checks

import 'dart:async';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../../Models/authority_response_model.dart';
import '../../../Models/declined_request_model.dart';
import '../../Utils.dart';
import '../../constants.dart';

class Active_Req_Details_Screen extends StatefulWidget {
  final String title;
  final String add;
  final String pin;
  final String userName;
  final String city;
  final String rid;
  final String contactNo;

  const Active_Req_Details_Screen(
      {super.key,
      required this.title,
      required this.add,
      required this.pin,
      required this.userName,
      required this.contactNo,
      required this.city,
      required this.rid});

  @override
  State<Active_Req_Details_Screen> createState() =>
      _Active_Req_Details_ScreenState();
}

class _Active_Req_Details_ScreenState extends State<Active_Req_Details_Screen> {
  //to get userType
  String? finalUserType = "";
  String iAmNGO = '';
  String iAmGovt = '';
  String authority_id = '';
  String authority_name = '';
  String newRid = '';

  //for Request
  String fetchedRid = "";
  String fetchedHasNGOResponded = "";
  String fetchedHasGovtResponded = "";
  String? fetchedService = "";
  String fetchedUsername = "";
  String fetchedCitizenContactNo = "";
  String fetchedCitizenState = "";
  String fetchedCitizenCity = "";
  String fetchedReqAddress = "";
  String fetchedIsTnxComplete = "";
  int? selectedRadioAddress = 1;

  //NGO
  String fetchedNid = "";
  String fetchedNGOFid = "";
  String fetchedNGOName = "";
  String fetchedNGORegNo = "";
  String? fetchedNGOPhone = "";
  String fetchedNGOState = "";
  String fetchedNGOCity = "";
  String fetchedNGOAddress = "";
  String fetchedNGOEmail = "";
  String fetchedNGOWebsite = "";

  //Govt
  String fetchedGid = "";
  String fetchedGovtFid = "";
  String fetchedGovtName = "";
  String fetchedGovtRegNo = "";
  String? fetchedGovtPhone = "";
  String fetchedGovtState = "";
  String fetchedGovtCity = "";
  String fetchedGovtAddress = "";
  String fetchedGovtEmail = "";
  String fetchedGovtWebsite = "";

  bool notificationSent = false;
  TextEditingController reasonController = TextEditingController();

  late SharedPreferences _prefs;
  bool isAcceptPressed = false;
  bool isDeclinePressed = false;

  @override
  void initState() {
    super.initState();
    //check if its NGO or Govt
    getUserType();
    //get request information from database
    fetchReqData();
    //print(widget.rid);
    newRid = widget.rid.toString().substring(4);
    _initPrefs();

    //print(newRid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 50,
        backgroundColor: Colors.black12,
        centerTitle: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(25),
                bottomLeft: Radius.circular(25))),
        title: const Text("Request Details"),
      ),
      body: SizedBox(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      //table
                      const SizedBox(height: 100),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          border: Border.all(
                            color: Colors.grey,
                            width: 1.5,
                          ),
                        ),
                        child: DataTable(
                          columnSpacing: 10.0,
                          columns: const [
                            DataColumn(
                                label: Text('Field',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: colorPrimary))),
                            DataColumn(
                                label: Text('Data',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: colorPrimary))),
                          ],
                          rows: [
                            buildDataRow('Name : ', widget.userName),
                            buildDataRow('Request type : ', widget.title),
                            buildDataRow('Address :', widget.add),
                            buildDataRow('Pin Code :', widget.pin),
                            buildDataRow('City :', widget.city),
                            buildDataRow('Contact No : ', widget.contactNo),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 15, left: 15),
                child:
                    // fetchedIsTnxComplete == "false"  ?
                    Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  // Align buttons to the sides
                  children: [
                    //Decline
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 5),
                        child: Container(
                          padding: const EdgeInsets.only(bottom: 15, top: 10),
                          width: double.infinity,
                          child: ClipRRect(
                              child: isDeclinePressed
                                  ? ElevatedButton(
                                      onPressed: () async {
                                        showDialogAlert(context,
                                            "You have already reacted to the request");
                                      },
                                      style: ButtonStyle(
                                          backgroundColor: MaterialStatePropertyAll(
                                              Colors.deepOrange.shade300),
                                          shape: MaterialStateProperty.all(
                                              RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          18)))),
                                      child: const Text("Decline"))
                                  : ElevatedButton(
                                      onPressed: () async {
                                        showDialog(
                                          context: context,
                                          barrierDismissible: false,
                                          builder: (BuildContext context) {
                                            return const Center(
                                              child: CircularProgressIndicator(
                                                  color: Colors.red),
                                            );
                                          },
                                        );
                                        await Future.delayed(
                                            const Duration(milliseconds: 1200));
                                        Navigator.pop(context);

                                        showDeclinedPopUp(context);
                                        // showToastMsg(
                                        //     "You've chosen not to respond the emergency ..");
                                        // Navigator.pop(context);
                                      },
                                      style: ButtonStyle(
                                          backgroundColor:
                                              const MaterialStatePropertyAll(
                                                  Colors.deepOrangeAccent),
                                          shape: MaterialStateProperty.all(
                                              RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(18)))),
                                      child: const Text("Decline"))),
                        ),
                      ),
                    ),
                    //Accept
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Container(
                          padding: const EdgeInsets.only(bottom: 15, top: 10),
                          width: double.infinity,
                          child: ClipRRect(
                            child: isAcceptPressed
                                ? ElevatedButton(
                                    onPressed: () async {
                                      showDialogAlert(context,
                                          "You have already reacted to the request");
                                    },
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStatePropertyAll(
                                                Colors.green.shade200),
                                        shape: MaterialStateProperty.all(
                                            RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        18)))),
                                    child: const Text("Accept"))
                                : ElevatedButton(
                                    onPressed: () async {
                                      //progress
                                      showDialog(
                                        context: context,
                                        barrierDismissible: false,
                                        builder: (BuildContext context) {
                                          return const Dialog(
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                  top: 35,
                                                  bottom: 25,
                                                  left: 20,
                                                  right: 20),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  SizedBox(height: 15),
                                                  CircularProgressIndicator(
                                                      color: Colors.blue),
                                                  SizedBox(height: 30),
                                                  Text('Processing ...')
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                      await Future.delayed(
                                          const Duration(milliseconds: 1300));
                                      Navigator.pop(context);
                                      //if user is NGO and isResponded
                                      if (iAmNGO == 'true' &&
                                          fetchedHasNGOResponded == 'true') {
                                        showMsgDialog(context,
                                            'Other NGO has responded to this request ..');
                                      }
                                      //if user is Govt and isResponded
                                      else if (iAmGovt == 'true' &&
                                          fetchedHasGovtResponded == 'true') {
                                        showMsgDialog(context,
                                            'Other Govt department has responded to this request ..');
                                      }
                                      //else Responded to req
                                      else {
                                        if (!notificationSent) {
                                          //search and get token of request sender
                                          FirebaseFirestore.instance
                                              .collection('clc_request')
                                              .where('RequestId',
                                                  isEqualTo: 'Req_$newRid')
                                              .get()
                                              .then((querySnapshot) {
                                            //add response data into database
                                            addResponseToDatabase();
                                            setState(() {
                                              fetchReqData();
                                            });
                                            for (var doc
                                                in querySnapshot.docs) {
                                              String deviceToken =
                                                  doc.data()['senderToken'];
                                              //send response to  req sender
                                              sendNotificationToDevice(
                                                  deviceToken, widget.rid);
                                              _saveDeclineState(widget.rid);
                                              _saveAcceptState(widget.rid);
                                            }
                                          });
                                          notificationSent = true;
                                        } else {
                                          showDialogAlert(
                                              context,
                                              'You have already responded to this request '
                                              '\n Kindly reach to desired location immediately..');
                                        }
                                      }
                                    },
                                    style: ButtonStyle(
                                        backgroundColor:
                                            const MaterialStatePropertyAll(
                                                Colors.green),
                                        shape: MaterialStateProperty.all(
                                            RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        18)))),
                                    child: const Text("Accept"),
                                  ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //to check usertype
  Future<void> getUserType() async {
    //to remove shared pref
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // await prefs.setBool('${widget.rid}_accept', false);
    // await prefs.setBool('${widget.rid}_decline', false);
    final SharedPreferences sharedPref = await SharedPreferences.getInstance();
    var obtainedUserType = sharedPref.getString("userType");
    setState(() {
      finalUserType = obtainedUserType;
      if (finalUserType == "NGO") {
        iAmNGO = 'true';
        fetchNGOData();
        // .then((value) => addReqOpenedToDatabase());
      } else if (finalUserType == "Govt") {
        iAmGovt = 'true';
        fetchGovtData();
        // .then((value) => addReqOpenedToDatabase());
      }
    });
  }

  //to fetch requested citizen details
  Future<void> fetchReqData() async {
    try {
      // Fetch data from Firestore
      DocumentSnapshot ReqSnapshot = await FirebaseFirestore.instance
          .collection('clc_request')
          .doc(widget.rid)
          .get();

      // Check if the document exists
      if (ReqSnapshot.exists) {
        // Access the fields from the document
        setState(() {
          fetchedRid = ReqSnapshot.get('RequestId');
          fetchedHasNGOResponded = ReqSnapshot.get('isNGOResponded');
          fetchedHasGovtResponded = ReqSnapshot.get('isGovtResponded');
          fetchedService = ReqSnapshot.get('neededService');
          fetchedUsername = ReqSnapshot.get('userName');
          fetchedCitizenContactNo = ReqSnapshot.get('contactNumber');
          fetchedCitizenState = ReqSnapshot.get('state');
          fetchedCitizenCity = ReqSnapshot.get('city');
          fetchedReqAddress = ReqSnapshot.get('fullAddress');
          fetchedIsTnxComplete = ReqSnapshot.get('isTransactionCompleted');
        });
      } else {
        if (kDebugMode) {
          print('Document does not exist c');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching user data: $e');
      }
    }
  }

  //gets data if current user is NGO
  Future<void> fetchNGOData() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      // Fetch data from Firestore
      DocumentSnapshot NGOSnapshot = await FirebaseFirestore.instance
          .collection('clc_ngo')
          .doc(user?.email)
          .get();

      // Check if the document exists
      if (NGOSnapshot.exists) {
        // Access the fields from the document
        setState(() {
          authority_id = fetchedNid = NGOSnapshot.get('nid');
//          authority_id = NGOSnapshot.get('nid');
          authority_name = fetchedNGOName = NGOSnapshot.get('nameOfNGO');
          fetchedNGORegNo = NGOSnapshot.get('NGORegNo');
          fetchedNGOPhone = NGOSnapshot.get('contactNumber');
          fetchedNGOState = NGOSnapshot.get('state');
          fetchedNGOCity = NGOSnapshot.get('city');
          fetchedNGOAddress = NGOSnapshot.get('fullAddress');
          fetchedNGOEmail = NGOSnapshot.get('email');
          fetchedNGOWebsite = NGOSnapshot.get('website');
        });
      } else {
        if (kDebugMode) {
          print('Document does not exist');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching NGO data: $e');
      }
    }
  }

  //gets data if current user is Govt
  Future<void> fetchGovtData() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      // Fetch data from Firestore
      DocumentSnapshot GovtSnapshot = await FirebaseFirestore.instance
          .collection('clc_govt')
          .doc(user?.email)
          .get();
      //print(user!.email);
      //print(GovtSnapshot.get('GovtAgencyRegNo'));

      // Check if the document exists
      if (GovtSnapshot.exists) {
        // Access the fields from the document
        setState(() {
          authority_id = fetchedGid = GovtSnapshot.get('gid');
          // authority_id = GovtSnapshot.get('gid');
          authority_name = fetchedGovtName = GovtSnapshot.get('GovtAgencyName');
          fetchedGovtRegNo = GovtSnapshot.get('GovtAgencyRegNo');
          fetchedGovtPhone = GovtSnapshot.get('contactNumber');
          fetchedGovtState = GovtSnapshot.get('state');
          fetchedGovtCity = GovtSnapshot.get('city');
          fetchedGovtAddress = GovtSnapshot.get('fullAddress');
          fetchedGovtEmail = GovtSnapshot.get('email');
          fetchedGovtWebsite = GovtSnapshot.get('website');
        });
      } else {
        if (kDebugMode) {
          print('Document does not exist');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching NGO data: $e');
      }
    }
  }

  //to send response notification to user
  void sendNotificationToDevice(
      String deviceToken, String totalDocCount) async {
    var data = {
      'to': deviceToken,
      'priority': 'high',
      'notification': {
        'title': "Respond from your emergency !!!",
        'body': "An authority has responded to your request .."
      },
      'android': {
        'notification': {'notification_count': 23},
      },
      'data': {
        'type': 'response',
        'service': fetchedService,
        'authorityName': iAmNGO == 'true' ? fetchedNGOName : fetchedGovtName,
        'regNo': iAmNGO == 'true' ? fetchedNGORegNo : fetchedGovtRegNo,
        'address': iAmNGO == 'true' ? fetchedNGOAddress : fetchedGovtAddress,
        'phone': iAmNGO == 'true' ? fetchedNGOPhone : fetchedGovtPhone,
        'email': iAmNGO == 'true' ? fetchedNGOEmail : fetchedGovtEmail,
        'city': fetchedCitizenCity,
        'website': iAmNGO == 'true' ? fetchedNGOWebsite : fetchedGovtWebsite,
        'ResponseId': totalDocCount.toString(),
      }
    };

    // Send the notification to the device
    await http.post(
      Uri.parse('https://fcm.googleapis.com/fcm/send'),
      body: jsonEncode(data),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization':
            'key=AAAAqhgqKGQ:APA91bEi_iwrEhn8BbQOG7pfFwUikl3Kp0K1sKAoOadF9Evb8Off1U5EqwljkoMprm5uO-aS_wctndIRoJum30YbvyJIBA5W4TF-EBmL8DRTrY1kHTTsDXaW8wWPLBSrbcgPobzzm8No'
      },
    );
  }

  // to add response data in DB
  void addResponseToDatabase() async {
    var responseDocRef = FirebaseFirestore.instance
        .collection("clc_response")
        .doc("Response_$newRid");

    //Storing data to database
    NGO_Response_Registration ResponseNGOData = NGO_Response_Registration(
        respondId: "Response_$newRid",
        requestId: fetchedRid,
        nid: fetchedNid,
        fid: '',
        responderNGOName: fetchedNGOName,
        responderNGORegNo: fetchedNGORegNo,
        responderNGOAddress: fetchedNGOAddress,
        responderNGOContactNo: fetchedNGOPhone,
        responderNGOEmail: fetchedNGOEmail,
        responderNGOWebsite: fetchedNGOWebsite);

    Govt_Response_Registration ResponseGovtData = Govt_Response_Registration(
        respondId: "Response_$newRid",
        requestId: fetchedRid,
        gid: fetchedGid,
        fid: '',
        responderGovtName: fetchedGovtName,
        responderGovtRegNo: fetchedGovtRegNo,
        responderGovtAddress: fetchedGovtAddress,
        responderGovtContactNo: fetchedGovtPhone,
        responderGovtEmail: fetchedGovtEmail,
        responderGovtWebsite: fetchedGovtWebsite);

    Map<String, dynamic> respondNGOJson = ResponseNGOData.toNGORespondJson();
    Map<String, dynamic> respondGovtJson = ResponseGovtData.toGovtRespondJson();

    try {
      //add respond Id into request doc
      await FirebaseFirestore.instance
          .collection("clc_request")
          .doc("Req_$newRid")
          .update({
        'RespondId': "Response_$newRid",
      });

      if (iAmNGO == 'true') {
        //update responded state to true
        await FirebaseFirestore.instance
            .collection("clc_request")
            .doc("Req_$newRid")
            .update({
          'isNGOResponded': 'true',
        });

        //sets NGO response data
        await responseDocRef
            .collection('ngo')
            .doc("ngo_details")
            .set(respondNGOJson);

        //*** 2nd level ***
        var responseNGODocRef = FirebaseFirestore.instance
            .collection("clc_response")
            .doc(fetchedNGOEmail);

        await responseNGODocRef
            .collection('ngo')
            .doc("Response_$newRid")
            .set(respondNGOJson);

        // await FirebaseFirestore.instance
        //     .collection("clc_response")
        //     .doc("Response_${widget.rid}")
        //     .set(respondNGOJson);
      }
      //update responded state to true
      else if (iAmGovt == 'true') {
        await FirebaseFirestore.instance
            .collection("clc_request")
            .doc("Req_$newRid")
            .update({
          'isGovtResponded': 'true',
        });

        //sets Govt response data
        await responseDocRef
            .collection('govt')
            .doc("govt_details")
            .set(respondGovtJson);

        //*** 2nd level ***
        var responseGovtDocRef = FirebaseFirestore.instance
            .collection("clc_response")
            .doc(fetchedGovtEmail);

        await responseGovtDocRef
            .collection('govt')
            .doc("Response_$newRid")
            .set(respondGovtJson);
      }

      Timer(const Duration(milliseconds: 300), () {
        showDialogAlert(context,
            'You are requested to reach emergency place as soon as possible ..');
        showToastMsg("Responded successfully ..");
      });
    } catch (e) {
      // An error occurred
      if (kDebugMode) {
        print('Error adding citizen request  : $e');
      }
    }
  }

  Future<void> showDeclinedPopUp(BuildContext context) async {
    bool isValidReason = false;

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: const Text("Request decline :"),
          content: Column(
            children: [
              const SizedBox(height: 15),
              const Text("Kindly enter reason for decline :"),
              const SizedBox(height: 15),
              CupertinoTextField(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  color: Colors.black12,
                ),
                controller: reasonController,
                placeholder: ' Enter Reason',
                onChanged: (value) {
                  if (value.length >= 10) {
                    isValidReason = true;
                  } else {
                    isValidReason = false;
                  }
                },
              ),
            ],
          ),
          actions: <Widget>[
            CupertinoDialogAction(
              onPressed: () async {
                if (isValidReason) {
                  // Show loading dialog
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext context) {
                      return const Center(
                        child: CircularProgressIndicator(color: Colors.white),
                      );
                    },
                  );

                  await Future.delayed(const Duration(milliseconds: 800));
                  Navigator.pop(context); // Close loading dialog
                  addDeclineReqToDatabase();
                  try {
                    // Show success message dialog
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return CupertinoAlertDialog(
                          title: const Text("Request Declined"),
                          content: const Text(
                              "Your have declined to this request.."),
                          actions: <Widget>[
                            CupertinoDialogAction(
                              onPressed: () {
                                //saves declined pref
                                _saveDeclineState(widget.rid);
                                _saveAcceptState(widget.rid);
                                Navigator.of(context)
                                    .pop(); // Close success message dialog
                                Navigator.of(context)
                                    .pop(); // Close main dialog
                                Navigator.of(context).pop();
                              },
                              child: const Text("OKAY"),
                            ),
                          ],
                        );
                      },
                    );
                  } catch (e) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return CupertinoAlertDialog(
                          title: const Text("Error"),
                          content: const Text(
                              "An error occurred while processing your request."),
                          actions: <Widget>[
                            CupertinoDialogAction(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text("OKAY"),
                            ),
                          ],
                        );
                      },
                    );
                  }
                } else {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return CupertinoAlertDialog(
                        title: const Text("Invalid Reason :"),
                        content: const Text("Too short reason .."),
                        actions: <Widget>[
                          CupertinoDialogAction(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text("OKAY"),
                          ),
                        ],
                      );
                    },
                  );
                }
              },
              child: const Text("Decline"),
            ),
            CupertinoDialogAction(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Cancel"),
            ),
          ],
        );
      },
    );
  }

  void addDeclineReqToDatabase() async {
    CollectionReference declineCollection =
        FirebaseFirestore.instance.collection("clc_declined_request");
    //for id
    QuerySnapshot snapshot = await declineCollection.get();
    int totalDocCount = snapshot.size;
    totalDocCount++;
    //Storing data to database
    Declined_Req_Registration ResponseNGOData = Declined_Req_Registration(
        requestId: fetchedRid,
        decId: 'Dec_$totalDocCount',
        username: widget.userName,
        auth_id: authority_id,
        decline_reason: reasonController.text.trim(),
        auth_name: authority_name);

    Map<String, dynamic> DeclineReqJson = ResponseNGOData.toDeclineReqJson();

    try {
      await FirebaseFirestore.instance
          .collection("clc_declined_request")
          .doc("Dec_$totalDocCount")
          .set(DeclineReqJson);
    } catch (e) {
      // An error occurred
      if (kDebugMode) {
        print('Error adding decline req : $e');
      }
    }
  }

  Future<void> _initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      isAcceptPressed = _prefs.getBool('${widget.rid}_accept') ?? false;
      isDeclinePressed = _prefs.getBool('${widget.rid}_decline') ?? false;
    });
  }

  Future<void> _saveAcceptState(String documentId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('${documentId}_accept', true);
    // Add any other logic you need after saving the state
  }

  Future<void> _saveDeclineState(String documentId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('${documentId}_decline', true);
    // Add any other logic you need after saving the state
  }
}
