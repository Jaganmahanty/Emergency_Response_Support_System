// ignore_for_file: non_constant_identifier_names, depend_on_referenced_packages, use_build_context_synchronously, avoid_print, camel_case_types

import 'dart:async';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../Components/Notification_related/notification_services.dart';
import '../../Models/emergency_contact-model.dart';
import '../../Utils/Utils.dart';
import '../../Utils/dropdown_Items.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'admin_issue_contacts_details.dart';

class Admin_Issue_Emergency_Numbers_Screen extends StatefulWidget {
  const Admin_Issue_Emergency_Numbers_Screen({super.key});

  @override
  State<Admin_Issue_Emergency_Numbers_Screen> createState() =>
      _Admin_Issue_Emergency_Numbers_ScreenState();
}

class _Admin_Issue_Emergency_Numbers_ScreenState
    extends State<Admin_Issue_Emergency_Numbers_Screen> {
  NotificationServices notificationServices = NotificationServices();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  //String selectedDisaster = "";
  String selectedState = '';
  String selectedCity = '';
  bool numbersSent = false;
  String? fetchedDid = '';
  String? did = '';
  String? fetchedDos = '';
  String? fetchedDonts = '';

  TextEditingController descController = TextEditingController();

  List<String> dropdownItemCity = [];
  List<TextEditingController> listController = [TextEditingController()];

  @override
  void initState() {
    super.initState();
    selectedState = DropdownItems.dropdownItemState.first;
    updateCityList(selectedState);
    //listen to  incoming msg...
    notificationServices.firebaseInit(context);

    //for notification when background and terminated case of application
    notificationServices.setupInteractMessage(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Number of tabs
      child: Scaffold(
        appBar: AppBar(
          elevation: 50,
          backgroundColor: Colors.black12,
          centerTitle: true,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(25),
                  bottomLeft: Radius.circular(25))),
          title: const Text("Emergency Contacts"),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Issue Contacts '), // First tab
              Tab(text: 'Manage Contacts'), // Second tab
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // Content of the first tab add media
            SizedBox(
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
                            child: Form(
                              key: _formKey,
                              child: Column(
                                children: [
                                  const SizedBox(height: 20),
                                  //state
                                  Flex(
                                    direction: Axis.horizontal,
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                            left: 10,
                                            right: 10,
                                          ),
                                          child: SizedBox(
                                            //height: 60,
                                            child:
                                                DropdownButtonFormField<String>(
                                              value: selectedState,
                                              items: DropdownItems
                                                  .dropdownItemState
                                                  .map((String state) {
                                                return DropdownMenuItem<String>(
                                                  // alignment: AlignmentDirectional.topStart,
                                                  value: state,
                                                  child: Text(state),
                                                );
                                              }).toList(),
                                              onChanged: (value) {
                                                setState(() {
                                                  selectedState = value!;
                                                  // Update city list based on the selected state
                                                  updateCityList(selectedState);
                                                  // Reset selected city when state changes
                                                  selectedCity = '';
                                                });
                                              },
                                              decoration: const InputDecoration(
                                                // border: OutlineInputBorder(),
                                                hintText: "Select State",
                                              ),
                                              validator: (value) {
                                                if (value ==
                                                    "Select your state") {
                                                  return 'Select State';
                                                }
                                                return null;
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 15),
                                  // city
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      left: 10,
                                      right: 10,
                                    ),
                                    child: SizedBox(
                                      //height: 60,
                                      child: DropdownButtonFormField<String>(
                                        value: selectedCity.isNotEmpty
                                            ? selectedCity
                                            : null,
                                        items:
                                            dropdownItemCity.map((String city) {
                                          return DropdownMenuItem<String>(
                                            value: city,
                                            child: Text(city),
                                          );
                                        }).toList(),
                                        onChanged: (value) {
                                          setState(() {
                                            selectedCity = value!;
                                          });
                                        },
                                        decoration: const InputDecoration(
                                          border: OutlineInputBorder(),
                                          hintText: "Select your City",
                                        ),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Select City';
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 15),
                                  // if (selectedRadioAddress == 1)
                                  //   isFetched
                                  //       ? Container(
                                  //     padding: const EdgeInsets.symmetric(
                                  //         horizontal: 20, vertical: 8),
                                  //     decoration: BoxDecoration(
                                  //       borderRadius: BorderRadius.circular(19.0),
                                  //       border: Border.all(
                                  //         color: Colors.grey,
                                  //         width: 1.0,
                                  //       ),
                                  //     ),
                                  //     child: DataTable(
                                  //       columnSpacing: 10.0,
                                  //       columns: const [
                                  //         DataColumn(
                                  //             label: Text('Field',
                                  //                 style: TextStyle(
                                  //                     fontWeight: FontWeight.bold,
                                  //                     color: colorPrimary))),
                                  //         DataColumn(
                                  //             label: Text('Data',
                                  //                 style: TextStyle(
                                  //                     fontWeight: FontWeight.bold,
                                  //                     color: colorPrimary))),
                                  //       ],
                                  //       rows: [
                                  //         buildDataRow('Name', fetchedFname),
                                  //         buildDataRow(
                                  //             'Address', fetchedFullAddress),
                                  //         buildDataRow(
                                  //             'Pin Code', fetchedPinCode),
                                  //         buildDataRow('City', fetchedCity),
                                  //         buildDataRow('State', fetchedState),
                                  //       ],
                                  //     ),
                                  //   )
                                  //   // Text(
                                  //   //         "$fetchedFname \n $fetchedFullAddress \n $fetchedPinCode \n $fetchedCity \n $fetchedState ",
                                  //   //         style: const TextStyle(fontSize: 14),
                                  //   //       )
                                  //       : const SpinKitThreeBounce(
                                  //     color: Colors.blueGrey,
                                  //     size: 20,
                                  //   ),
                                  // if (selectedRadioAddress == 2)
                                  const SizedBox(height: 18),
                                  //info
                                  SizedBox(
                                    child: Column(
                                      children: [
                                        const Text(
                                            "About what the emergency contacts are : ",
                                            style: TextStyle(fontSize: 15)),
                                        const SizedBox(height: 20),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child: TextFormField(
                                            controller: descController,
                                            minLines: 2,
                                            maxLines: 4,
                                            decoration: const InputDecoration(
                                                hintText: 'Brief information',
                                                prefixIcon:
                                                    Icon(Icons.description),
                                                labelText: 'Information'),
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                //_fnameFocusNode.requestFocus();
                                                return 'Information required';
                                              }
                                              if (value.isNotEmpty &&
                                                  value.length < 10) {
                                                return "Too short Information";
                                              }
                                              return null;
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 18),
                                  ListView.builder(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    shrinkWrap: true,
                                    itemCount: listController.length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.only(top: 7),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 0),
                                                alignment: Alignment.center,
                                                height: 68,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                child: TextFormField(
                                                  controller:
                                                      listController[index],
                                                  autofocus: false,
                                                  decoration:
                                                      const InputDecoration(
                                                    border: InputBorder.none,
                                                    hintText:
                                                        "Enter emergency number details",
                                                    hintStyle: TextStyle(
                                                        color: Color.fromARGB(
                                                            255,
                                                            132,
                                                            140,
                                                            155)),
                                                  ),
                                                  validator: (value) {
                                                    if (index <
                                                            listController
                                                                .length &&
                                                        listController[index]
                                                            .text
                                                            .isEmpty) {
                                                      return 'Value is required';
                                                    }
                                                    return null;
                                                  },
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 7,
                                            ),
                                            index != 0
                                                ? GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        listController[index]
                                                            .clear();
                                                        listController[index]
                                                            .dispose();
                                                        listController
                                                            .removeAt(index);
                                                      });
                                                    },
                                                    child: const Icon(
                                                      Icons.delete,
                                                      color: Color(0xFF6B74D6),
                                                      size: 20,
                                                    ),
                                                  )
                                                : const SizedBox()
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                  const SizedBox(height: 25),
                                  if (listController.length < 6)
                                    GestureDetector(
                                      onTap: () {
                                        print(listController.length.toString());
                                        setState(() {
                                          listController
                                              .add(TextEditingController());
                                        });
                                      },
                                      child: Center(
                                        child: Align(
                                          alignment:
                                              AlignmentDirectional.bottomEnd,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                right: 20),
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 20,
                                                      vertical: 15),
                                              decoration: BoxDecoration(
                                                  color:
                                                      const Color(0xFF444C60),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          50)),
                                              child: const Text("+",
                                                  style: TextStyle(
                                                      color:
                                                          Color(0xFFF8F8FF))),
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
                      ),
                      const SizedBox(height: 7),
                      Padding(
                        padding: const EdgeInsets.only(right: 20, left: 20),
                        child: Container(
                          padding: const EdgeInsets.only(bottom: 15),
                          width: double.infinity,
                          child: ClipRRect(
                              child: ElevatedButton(
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
                                    // Navigator.pop(context);
                                    //For Rid
                                    if (_formKey.currentState!.validate()) {
                                      if (!numbersSent) {
                                        try {
                                          // });
                                          int totalDocCount = 0;
                                          await FirebaseFirestore.instance
                                              .runTransaction(
                                                  (transaction) async {
                                            // Get the current count of requests
                                            DocumentSnapshot snapshot =
                                                await transaction.get(
                                                    FirebaseFirestore.instance
                                                        .collection(
                                                            "clc_emergency_numbers")
                                                        .doc("number_count"));
                                            totalDocCount = (snapshot.exists)
                                                ? snapshot.get('count')
                                                : 0;
                                            totalDocCount++;

                                            transaction.set(
                                                FirebaseFirestore.instance
                                                    .collection(
                                                        "clc_emergency_numbers")
                                                    .doc("number_count"),
                                                {'count': totalDocCount});
                                          });

                                          addAlertToDatabase(totalDocCount);
                                        } catch (e) {
                                          if (kDebugMode) {
                                            print(
                                                'Error while adding contacts : $e');
                                          }
                                        } finally {
                                          Navigator.pop(context);
                                        }
                                      } else {
                                        //Navigator.pop(context);
                                        showMsgDialog(
                                            context,
                                            'You have already issued emergency contact '
                                            '\n numbers in a while !');
                                      }
                                    } else {
                                      Navigator.pop(context);
                                    }
                                  },
                                  style: ButtonStyle(
                                      shape: MaterialStateProperty.all(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(18)))),
                                  child: const Text("Issue contact"))),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Content of the second tab View media history
            Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: RefreshIndicator(
                      onRefresh: _refreshData,
                      child: StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection("clc_emergency_numbers")
                              .orderBy('sentTime', descending: true)
                              // .limit(25)
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.active) {
                              if (snapshot.hasData) {
                                return Padding(
                                  padding: const EdgeInsets.only(
                                      left: 7, right: 7, top: 10),
                                  child: snapshot.data!.docs.isEmpty
                                      ? const Center(
                                          child: Text(
                                            'No record found !',
                                            style: TextStyle(
                                              fontSize: 19,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.grey,
                                            ),
                                          ),
                                        )
                                      : Scrollbar(
                                          child: ListView.builder(
                                              itemCount:
                                                  snapshot.data!.docs.length,
                                              itemBuilder: (context, index) {
                                                snapshot.data!.docs[index]
                                                    ['sentTime'];
                                                return GestureDetector(
                                                  onTap: () {
                                                    Navigator.of(context).push(
                                                      PageRouteBuilder(
                                                        pageBuilder: (context,
                                                                animation,
                                                                secondaryAnimation) =>
                                                            Admin_Issue_Contact_Details_Screen(
                                                          documentSnapshot:
                                                              snapshot.data!
                                                                  .docs[index],
                                                        ),
                                                        transitionsBuilder:
                                                            (context,
                                                                animation,
                                                                secondaryAnimation,
                                                                child) {
                                                          var begin =
                                                              const Offset(
                                                                  1.0, 0.0);
                                                          var end = Offset.zero;
                                                          var curve =
                                                              Curves.ease;

                                                          var tween = Tween(
                                                                  begin: begin,
                                                                  end: end)
                                                              .chain(CurveTween(
                                                                  curve:
                                                                      curve));
                                                          var offsetAnimation =
                                                              animation
                                                                  .drive(tween);

                                                          return SlideTransition(
                                                            position:
                                                                offsetAnimation,
                                                            child: child,
                                                          );
                                                        },
                                                      ),
                                                    );
                                                  },
                                                  child: Card(
                                                    color: Colors.white,
                                                    margin:
                                                        const EdgeInsets.only(
                                                            bottom: 13,
                                                            left: 7,
                                                            right: 7),
                                                    // Set margin to zero to remove white spaces
                                                    elevation: 3,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15),
                                                    ),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  vertical: 5,
                                                                  horizontal:
                                                                      7),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              ListTile(
                                                                leading:
                                                                    CircleAvatar(
                                                                  maxRadius: 14,
                                                                  backgroundColor:
                                                                      Colors
                                                                          .grey,
                                                                  child: Text(
                                                                      "${index + 1}"),
                                                                ),
                                                                //textColor: Colors.white,
                                                                title: Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    const Text(
                                                                        "Emergency contact for : ",
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.black,
                                                                            fontSize: 13)),
                                                                    const SizedBox(
                                                                        height:
                                                                            3),
                                                                    Text(
                                                                        snapshot
                                                                            .data!
                                                                            .docs[index]['info'],
                                                                        style: const TextStyle(
                                                                          color:
                                                                              Colors.black,
                                                                          fontSize:
                                                                              15,
                                                                        )),
                                                                  ],
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                  height: 2),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .only(
                                                                        left:
                                                                            15,
                                                                        top: 5),
                                                                child: Row(
                                                                  children: [
                                                                    const Text(
                                                                      "City : ",
                                                                      style: TextStyle(
                                                                          color:
                                                                              Colors.black),
                                                                    ),
                                                                    Text(
                                                                        "${snapshot.data!.docs[index]['state']} ,"
                                                                            " ${snapshot.data!.docs[index]['city']}",
                                                                        style: const TextStyle(
                                                                            color:
                                                                                Colors.black,
                                                                            fontWeight: FontWeight.bold)),
                                                                  ],
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                  height: 2),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .only(
                                                                        right:
                                                                            10,
                                                                        bottom:
                                                                            3),
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .end,
                                                                  children: [
                                                                    const Icon(
                                                                        Icons
                                                                            .watch_later_outlined,
                                                                        size:
                                                                            16,
                                                                        color: Colors
                                                                            .black54),
                                                                    const SizedBox(
                                                                        width:
                                                                            3),
                                                                    Text(
                                                                        DateFormat('dd-MM-yyyy , HH:mm').format(DateTime.parse(snapshot.data!.docs[index]
                                                                            [
                                                                            'sentTime'])),
                                                                        style: const TextStyle(
                                                                            color:
                                                                                Colors.black38,
                                                                            fontSize: 12)),
                                                                  ],
                                                                ),
                                                              ),
                                                              // Padding(
                                                              //   padding:
                                                              //       const EdgeInsets.symmetric(
                                                              //           horizontal: 0),
                                                              //   child: Row(
                                                              //     children: [
                                                              //       Text(
                                                              //           snapshot.data!.docs[index]
                                                              //               ['fullAddress'],
                                                              //           style: const TextStyle(
                                                              //               color: Colors.black)),
                                                              //       TextButton(
                                                              //         onPressed: () {
                                                              //           launch(
                                                              //             'tel:',
                                                              //           );
                                                              //         },
                                                              //         child: Icon(Icons.call,
                                                              //             size: 14,
                                                              //             color: Colors
                                                              //                 .green.shade800),
                                                              //       ),
                                                              //     ],
                                                              //   ),
                                                              // ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              }),
                                        ),
                                );
                              }
                            } else if (snapshot.hasError) {
                              showToastMsg(snapshot.hasError.toString());
                            } else {
                              return const Center(
                                  child: CircularProgressIndicator());
                            }
                            return const Center(
                                child: CircularProgressIndicator());
                          }),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  void fetchDid(String typeOfDisaster, int totalCount) async {
    try {
      // Reference to the Firestore collection
      CollectionReference clcDosDontsCollection =
          FirebaseFirestore.instance.collection('clc_dos_donts');

      // Query for documents where typeOfDisaster matches with selected disaster
      QuerySnapshot queryClcSnap = await clcDosDontsCollection
          .where('typeOfDisaster', isEqualTo: typeOfDisaster)
          .get();

      // If there's at least one document retrieved
      if (queryClcSnap.docs.isNotEmpty) {
        did = queryClcSnap.docs.first.id;
        fetchedDid = queryClcSnap.docs.first.id;
        clcDosDontsCollection.doc(fetchedDid).get();

        DocumentSnapshot dosSnap =
            await clcDosDontsCollection.doc(fetchedDid).get();
        try {
          if (dosSnap.exists) {
            fetchedDos = dosSnap.get("dos");
            fetchedDonts = dosSnap.get("donts");

            await FirebaseFirestore.instance
                .collection("clc_alert")
                .doc("Alert_$totalCount")
                .update({
              'did': "Dos_$totalCount",
            });
          } else {
            if (kDebugMode) {
              print('Dos document does not exist');
            }
          }
        } catch (e) {
          // Handle any errors that occur during the process
          if (kDebugMode) {
            print('Error fetching dos/donts: $e');
          }
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching did : $e');
      }
    }
    return null;
  }

  void broadcastAlert(String deviceToken, int totalDocCount) async {
    var data = {
      'to': deviceToken,
      'priority': 'high',
      'notification': {'title': "a", 'body': descController.text},
      'android': {
        'notification': {'notification_count': 23},
      },
      'data': {
        'type': 'alert',
        'title': "a",
        'desc': descController.text,
        'level': "a",
        'dos': fetchedDos,
        'donts': fetchedDonts,
        'AlertId': totalDocCount.toString(),
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

  void addAlertToDatabase(int totalDocCount) async {
    //Storing data to database

    try {
      EmergencyContactRegistration alertData = EmergencyContactRegistration(
        ContactId: "Contact_${totalDocCount.toString()}",
        state: selectedState,
        city: selectedCity,
        info: descController.text,
        Contact_1: listController.isNotEmpty ? listController[0].text : "",
        Contact_2: listController.length > 1 ? listController[1].text : "",
        Contact_3: listController.length > 2 ? listController[2].text : "",
        Contact_4: listController.length > 3 ? listController[3].text : "",
        Contact_5: listController.length > 4 ? listController[4].text : "",
        Contact_6: listController.length > 5 ? listController[5].text : "",
        isVisible: 'true',
      );

      Map<String, dynamic> adminEmergencyJson = alertData.toJsonEmergency();
      await FirebaseFirestore.instance
          .collection("clc_emergency_numbers")
          .doc("Contact_${totalDocCount.toString()}")
          .set(adminEmergencyJson);

      Timer(const Duration(milliseconds: 300), () {
        showMsgDialog(context, 'emergency contacts publish success ..');
        numbersSent = true;
      });
    } catch (e) {
      // An error occurred
      if (kDebugMode) {
        print('Error adding admin alert : $e');
      }
    }
  }

  Future<void> _refreshData() async {
    // Simulate a delay for refreshing data
    await Future.delayed(const Duration(milliseconds: 1200));
    setState(() {
      selectedState = DropdownItems.dropdownItemState.first;
      descController.clear();
      numbersSent = false;
    });
  }

  void updateCityList(String state) {
    setState(() {
      dropdownItemCity = DropdownItems.cityMap[state] ?? [];
    });
  }
}
