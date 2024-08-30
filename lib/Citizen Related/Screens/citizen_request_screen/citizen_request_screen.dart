// ignore_for_file: non_constant_identifier_names, use_build_context_synchronously, camel_case_types

import 'dart:async';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fff/Utils/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../../Models/citizen_request_model.dart';
import '../../../Utils/Utils.dart';
import '../../../Utils/dropdown_Items.dart';
import '../../../Components/Notification_related/notification_services.dart';
import 'package:http/http.dart' as http;

class userRequest_Screen extends StatefulWidget {
  const userRequest_Screen({super.key});

  @override
  State<userRequest_Screen> createState() => _userRequest_ScreenState();
}

class _userRequest_ScreenState extends State<userRequest_Screen> {
  NotificationServices notificationServices = NotificationServices();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  //profile fields
  String fetchedCid = "";
  String fetchedFname = "";
  String? fetchedPhone = "";
  String fetchedState = "";
  String fetchedCity = "";
  String fetchedPinCode = "";
  String fetchedFullAddress = "";
  String selectedService = "";
  String senderDeviceToken = "";
  int? selectedRadioAddress = 1;
  bool showTextField = false;
  bool isExpanded = false;
  bool isFetched = false;

  bool notificationSent = false;

  TextEditingController addressController = TextEditingController();
  TextEditingController pincodeController = TextEditingController();

  @override
  void initState() {
    fetchCitizenData().then((value) => setState(() {
          isFetched = true;
        }));
    super.initState();
    selectedService = DropdownItems.dropdownItemRequestTypes.first;
    //listen to  incoming msg...
    notificationServices.firebaseInit(context);

    //for notification when background and terminated case of application
    notificationServices.setupInteractMessage(context);
    notificationServices.getDeviceToken().then((value) {
      if (kDebugMode) {
        print("token : ${value.toString()}");
      }
      senderDeviceToken = value.toString();
    });
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
        title: const Text("Request for an emergency"),
      ),
      body: SizedBox(
        width: double.infinity,
        child: RefreshIndicator(
          onRefresh: _refreshData,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 25),
                      padding: const EdgeInsets.only(
                          //for fields that are covered under keyboard ..
                          // bottom: MediaQuery.of(context).viewInsets.bottom,
                          left: 2,
                          right: 2),
                      child: Column(
                        children: [
                          const SizedBox(height: 25),
                          const Text("Request by filling up your details : ",
                              style: TextStyle(fontSize: 17)),
                          const SizedBox(height: 25),
                          //service list
                          Flex(
                            direction: Axis.horizontal,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    left: 20,
                                    right: 20,
                                  ),
                                  child: SizedBox(
                                    height: 60,
                                    child: DropdownButtonFormField<String>(
                                      value: selectedService,
                                      items: DropdownItems
                                          .dropdownItemRequestTypes
                                          .map((String state) {
                                        return DropdownMenuItem<String>(
                                          // alignment: AlignmentDirectional.topStart,
                                          value: state,
                                          child: Text(state),
                                        );
                                      }).toList(),
                                      onChanged: (value) {
                                        setState(() {
                                          selectedService = value!;
                                          // Update city list based on the selected state
                                        });
                                      },
                                      decoration: const InputDecoration(
                                        // border: OutlineInputBorder(),
                                        hintText: "Select your service",
                                      ),
                                      // validator: (value) {
                                      //   if (value ==
                                      //       "Select Govt Agency State") {
                                      //     return 'Select Govt Agency State';
                                      //   }
                                      //   return null; // Return null if the input is valid
                                      // },
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          //Home address
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 18),
                            child: Row(
                              children: [
                                Radio(
                                  value: 1,
                                  groupValue: selectedRadioAddress,
                                  onChanged: (value) {
                                    setState(() {
                                      selectedRadioAddress = value;
                                      showTextField = false;
                                      //_controller.forward();
                                      // isExpanded = false;
                                    });
                                  },
                                ),
                                const Text('Registered Address'),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                          //new address
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Row(
                              children: [
                                Radio(
                                  value: 2,
                                  groupValue: selectedRadioAddress,
                                  onChanged: (value) {
                                    setState(() {
                                      selectedRadioAddress = value;
                                      showTextField = true;
                                      isExpanded = true;
                                      // _controller.reverse();
                                    });
                                  },
                                ),
                                const Text('New Address'),
                              ],
                            ),
                          ),
                          const SizedBox(height: 15),
                          if (selectedRadioAddress == 1)
                            isFetched
                                ? Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 8),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(19.0),
                                      border: Border.all(
                                        color: Colors.grey,
                                        width: 1.0,
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
                                        buildDataRow('Name', fetchedFname),
                                        buildDataRow(
                                            'Address', fetchedFullAddress),
                                        buildDataRow(
                                            'Pin Code', fetchedPinCode),
                                        buildDataRow('City', fetchedCity),
                                        buildDataRow('State', fetchedState),
                                      ],
                                    ),
                                  )
                                : const SpinKitThreeBounce(
                                    color: Colors.blueGrey,
                                    size: 20,
                                  ),
                          if (selectedRadioAddress == 2)
                            AnimatedSize(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                              //vsync: this,
                              child: Form(
                                key: _formKey,
                                child: SizedBox(
                                  child: AnimatedOpacity(
                                    opacity: showTextField ? 1.0 : 0.0,
                                    duration: const Duration(milliseconds: 300),
                                    child: Column(
                                      children: [
                                        const Text(
                                            "Enter your new address location : ",
                                            style: TextStyle(fontSize: 15)),
                                        const SizedBox(height: 20),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 15.0),
                                          child: TextFormField(
                                            controller: addressController,
                                            decoration: const InputDecoration(
                                                hintText: 'Enter full Address',
                                                prefixIcon: Icon(CupertinoIcons
                                                    .pencil_ellipsis_rectangle),
                                                labelText: 'Address'),
                                            validator: selectedRadioAddress != 1
                                                ? addressValidator
                                                : null,
                                          ),
                                        ),
                                        const SizedBox(height: 20),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 15.0),
                                          child: TextFormField(
                                            controller: pincodeController,
                                            keyboardType: TextInputType.number,
                                            maxLength: 6,
                                            decoration: const InputDecoration(
                                                prefixIcon:
                                                    Icon(Icons.pin_rounded),
                                                hintText: 'Enter Pincode',
                                                labelText: "Pincode"),
                                            validator: selectedRadioAddress != 1
                                                ? pincodeValidator
                                                : null,
                                          ),
                                        ),
                                        const SizedBox(height: 20),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Padding(
                  padding: const EdgeInsets.only(right: 20, left: 20),
                  child: Container(
                    padding: const EdgeInsets.only(bottom: 15),
                    width: double.infinity,
                    child: ClipRRect(
                        child: ElevatedButton(
                            onPressed: () async {
                              int totalDocCount = 0;
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
                              //For Rid

                              if (selectedRadioAddress == 1) {
                                if (!notificationSent) {
                                  try {
                                    await FirebaseFirestore.instance
                                        .runTransaction((transaction) async {
                                      // Get the current count of requests
                                      DocumentSnapshot snapshot =
                                          await transaction.get(
                                              FirebaseFirestore.instance
                                                  .collection("clc_request")
                                                  .doc("request_count"));
                                      totalDocCount = (snapshot.exists)
                                          ? snapshot.get('count')
                                          : 0;
                                      totalDocCount++;

                                      transaction.set(
                                          FirebaseFirestore.instance
                                              .collection("clc_request")
                                              .doc("request_count"),
                                          {'count': totalDocCount});
                                    });
                                    //sends request/alert to only NGO which are of the currents user's city
                                    var ngoQuerySnapshot = await FirebaseFirestore
                                        .instance
                                        .collection('clc_ngo')
                                        //added new ***
                                        // .where('services', whereIn: selectedServiceWords)
                                        .where('city', isEqualTo: fetchedCity)
                                        .get();

                                    for (var ngoDoc in ngoQuerySnapshot.docs) {
                                      String deviceToken =
                                          ngoDoc.data()['deviceToken'];
                                      sendNotificationToDevice(
                                          deviceToken, totalDocCount);
                                    }

                                    var govtQuerySnapshot =
                                        await FirebaseFirestore.instance
                                            .collection('clc_govt')
                                            .where('city',
                                                isEqualTo: fetchedCity)
                                            .get();

                                    for (var doc in govtQuerySnapshot.docs) {
                                      String deviceToken =
                                          doc.data()['deviceToken'];
                                      sendNotificationToDevice(
                                          deviceToken, totalDocCount);
                                    }
                                    // });
                                    addReqToDatabase(totalDocCount);
                                  } catch (e) {
                                    if (kDebugMode) {
                                      print(
                                          'Error while sending citizen request : $e');
                                    }
                                  } finally {
                                    Navigator.pop(context);
                                  }
                                  notificationSent = true;
                                } else {
                                  Navigator.pop(context);
                                  showMsgDialog(
                                      context,
                                      'You have already requested for your request ,'
                                      '\n Nearby authority will contact you soon ');
                                }
                              } else {
                                if (_formKey.currentState!.validate()) {
                                  if (!notificationSent) {
                                    CollectionReference
                                        citizenRequestCollection =
                                        FirebaseFirestore.instance
                                            .collection("clc_request");
                                    try {
                                      QuerySnapshot snapshot =
                                          await citizenRequestCollection.get();
                                      int totalDocCount = snapshot.size;
                                      totalDocCount++;
                                      //sends request/alert to only NGO which are of the currents user's city
                                      var ngoQuerySnapshot = await FirebaseFirestore
                                          .instance
                                          .collection('clc_ngo')
                                          //added new ***
                                          // .where('services', whereIn: selectedServiceWords)
                                          .where('city', isEqualTo: fetchedCity)
                                          .get();

                                      for (var ngoDoc
                                          in ngoQuerySnapshot.docs) {
                                        String deviceToken =
                                            ngoDoc.data()['deviceToken'];
                                        sendNotificationToDevice(
                                            deviceToken, totalDocCount);
                                      }

                                      var govtQuerySnapshot =
                                          await FirebaseFirestore.instance
                                              .collection('clc_govt')
                                              .where('city',
                                                  isEqualTo: fetchedCity)
                                              .get();

                                      for (var doc in govtQuerySnapshot.docs) {
                                        String deviceToken =
                                            doc.data()['deviceToken'];
                                        sendNotificationToDevice(
                                            deviceToken, totalDocCount);
                                      }
                                      // });
                                      addReqToDatabase(totalDocCount);
                                    } catch (e) {
                                      if (kDebugMode) {
                                        print(
                                            'Error while sending citizen request : $e');
                                      }
                                    } finally {
                                      Navigator.pop(context);
                                    }
                                    notificationSent = true;
                                  } else {
                                    Navigator.pop(context);
                                    showMsgDialog(
                                        context,
                                        'You have already requested for your request ,'
                                        '\n Nearby authority will contact you soon ');
                                  }
                                } else {
                                  Navigator.pop(context);
                                }
                              }
                            },
                            style: ButtonStyle(
                                shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(18)))),
                            child: const Text("Request now"))),
                  ),
                ),
                // scanning ? SpinKitThreeBounce(color: myColor, size: 20) : Text(coordinates, style: const TextStyle(fontSize: 16)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> fetchCitizenData() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      // Fetch data from Firestore
      DocumentSnapshot citizenSnapshot = await FirebaseFirestore.instance
          .collection('clc_citizen')
          .doc(user?.phoneNumber)
          .get();

      // Check if the document exists
      if (citizenSnapshot.exists) {
        // Access the fields from the document
        setState(() {
          fetchedCid = citizenSnapshot.get('cid');
          fetchedFname = citizenSnapshot.get('firstName') +
              " " +
              citizenSnapshot.get('lastName');
          //fetchedLname = citizenSnapshot.get('lastName');
          fetchedPhone = user!.phoneNumber;
          fetchedState = citizenSnapshot.get('state');
          fetchedCity = citizenSnapshot.get('city');
          fetchedPinCode = citizenSnapshot.get('pinCode');
          fetchedFullAddress = citizenSnapshot.get('fullAddress');
          //fetchedRegTime = citizenSnapshot.get('registrationTime');
          //fetchedRegTime = fetchedRegTime.substring(0, 10);
          // String? fetchedBirthDate = citizenSnapshot.get('birthDate');
          // if (fetchedBirthDate != null) {
          //   birthDate = DateTime.parse(fetchedBirthDate);
          //   //fetchedAge = calculateAge(birthDate).toString();
          // }
        });
      } else {
        if (kDebugMode) {
          print('Document does not exist');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching user data: $e');
      }
    }
  }

  void sendNotificationToDevice(String deviceToken, int totalDocCount) async {
    var data = {
      'to': deviceToken,
      'priority': 'high',
      'notification': {
        'title': selectedService,
        'body': "${selectedRadioAddress == 1 ? fetchedFullAddress : addressController.text} , "
            "${selectedRadioAddress == 1 ? fetchedPinCode : pincodeController.text}"
      },
      'android': {
        'notification': {'notification_count': 23},
      },
      'data': {
        'type': 'request',
        'title': selectedService,
        'address': selectedRadioAddress == 1
            ? fetchedFullAddress
            : addressController.text,
        'pincode':
            selectedRadioAddress == 1 ? fetchedPinCode : pincodeController.text,
        'username': fetchedFname,
        'city': fetchedCity,
        'phoneNumber': fetchedPhone,
        'ReqId': totalDocCount.toString(),
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

  void addReqToDatabase(int totalDocCount) async {
    //Storing data to database
    CitizenReqRegistration citizenReqData = CitizenReqRegistration(
        Rid: "Req_${totalDocCount.toString()}",
        RespondId: '',
        cid: fetchedCid,
        hasNGOResponded: 'false',
        hasGovtResponded: 'false',
        neededService: selectedService,
        userName: fetchedFname,
        contactNumber: fetchedPhone,
        state: fetchedState,
        city: fetchedCity,
        pinCode:
            selectedRadioAddress == 1 ? fetchedPinCode : pincodeController.text,
        fullAddress: selectedRadioAddress == 1
            ? fetchedFullAddress
            : addressController.text,
        isTransactionCompleted: "false",
        senderToken: senderDeviceToken);

    Map<String, dynamic> UserReqJson = citizenReqData.toJsonReq();

    try {
      await FirebaseFirestore.instance
          .collection("clc_request")
          .doc("Req_${totalDocCount.toString()}")
          .set(UserReqJson);

      Timer(const Duration(milliseconds: 800), () {
        showMsgDialog(
            context, 'Nearby NGOs or Govt Agency will contact you shortly ..');
        showToastMsg("Citizen Requested successfully..");
      });
    } catch (e) {
      // An error occurred
      if (kDebugMode) {
        print('Error adding citizen request : $e');
      }
    }
  }

  Future<void> _refreshData() async {
    // Simulate a delay for refreshing data
    await Future.delayed(const Duration(milliseconds: 1200));
    setState(() {
      selectedService = DropdownItems.dropdownItemRequestTypes.first;
      addressController.clear();
      pincodeController.clear();
      notificationSent = false;
    });
  }
}

String? addressValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'Enter full address';
  }
  if (value.isNotEmpty && value.length < 3) {
    return 'Entered too short address';
  }
  return null; // Return null if the input is valid
}

String? pincodeValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'Enter pin code';
  }
  if (value.isNotEmpty && value.length < 6) {
    return 'Enter 6 digit pin code';
  }
  return null; // Return null if the input is valid
}
