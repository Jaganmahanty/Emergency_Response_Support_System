// ignore_for_file: library_private_types_in_public_api, depend_on_referenced_packages, camel_case_types, use_build_context_synchronously, non_constant_identifier_names

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import '../../Utils.dart';
import 'active_requests_details_screen.dart';

class Active_Req_Screen extends StatefulWidget {
  const Active_Req_Screen({super.key});

  @override
  _Active_Req_ScreenState createState() => _Active_Req_ScreenState();
}

class _Active_Req_ScreenState extends State<Active_Req_Screen> {
  String? finalUserType = "";
  String iAmNGO = '';
  String iAmGovt = '';
  late SharedPreferences prefs;
  List<String> readRequestIds = [];
  final ScrollController _scrollController = ScrollController();

  String authority_id = '';
  String fetchedNid = "";
  String authority_state = "";
  String authority_city = "";

  String fetchedGid = "";
  String fetchedGovtState = "";

  @override
  void initState() {
    super.initState();
    _initSharedPreferences();
    //check if its NGO or Govt
    getUserType();
  }

  Future<void> _initSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
    readRequestIds = prefs.getStringList('readRequests') ?? [];
    setState(() {});
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
          title: const Text("Requests"),
        ),
        body: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: RefreshIndicator(
                  onRefresh: _refreshData,
                  child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection("clc_request")
                          .where("city", isEqualTo: authority_city)
                          .orderBy('reqTime', descending: true)
                          // .limit(25)
                          .snapshots(),
                      builder: (context, snapshot) {
                        //.where("city", isEqualTo: widget.selectedCity)
                        if (snapshot.connectionState ==
                            ConnectionState.active) {
                          if (snapshot.hasData) {
                            return Padding(
                              padding: const EdgeInsets.only(
                                  left: 7, right: 7, top: 10),
                              child: snapshot.data!.docs.isEmpty
                                  ? const Center(
                                      child: Text(
                                        'No records found for your requests !',
                                        style: TextStyle(
                                          fontSize: 19,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    )
                                  : ListView.builder(
                                      controller: _scrollController,
                                      itemCount: snapshot.data!.docs.length,
                                      itemBuilder: (context, index) {
                                        final requestId = snapshot
                                            .data!.docs[index]['reqTime'];
                                        final isRead =
                                            readRequestIds.contains(requestId);

                                        final reqTimeStr = snapshot.data!
                                            .docs[index]['reqTime'] as String;
                                        final reqTime =
                                            DateTime.parse(reqTimeStr);

                                        // final request_Id = reqTime.toDate();

                                        final currentTime = DateTime.now();

                                        final differenceInHours = currentTime
                                            .difference(reqTime)
                                            .inHours;

                                        if (differenceInHours <= 24) {
                                          return GestureDetector(
                                            onTap: () async {
                                              QuerySnapshot querySnap =
                                                  await FirebaseFirestore
                                                      .instance
                                                      .collection("clc_citizen")
                                                      .where("cid",
                                                          isEqualTo: snapshot
                                                                  .data!
                                                                  .docs[index]
                                                              ['cid'])
                                                      .get();

                                              String userName =
                                                  "${querySnap.docs.first['firstName']} ${querySnap.docs.first['lastName']}";

                                              Navigator.of(context).push(
                                                PageRouteBuilder(
                                                  pageBuilder: (context,
                                                          animation,
                                                          secondaryAnimation) =>
                                                      Active_Req_Details_Screen(
                                                    pin: snapshot.data!
                                                        .docs[index]['pinCode'],
                                                    title: snapshot
                                                            .data!.docs[index]
                                                        ['neededService'],
                                                    add: snapshot
                                                            .data!.docs[index]
                                                        ['fullAddress'],
                                                    city: snapshot.data!
                                                        .docs[index]['city'],
                                                    contactNo: snapshot
                                                            .data!.docs[index]
                                                        ['contactNumber'],
                                                    userName: userName,
                                                    rid: snapshot
                                                            .data!.docs[index]
                                                        ['RequestId'],
                                                  ),
                                                  transitionsBuilder: (context,
                                                      animation,
                                                      secondaryAnimation,
                                                      child) {
                                                    var begin =
                                                        const Offset(1.0, 0.0);
                                                    var end = Offset.zero;
                                                    var curve = Curves.ease;

                                                    var tween = Tween(
                                                            begin: begin,
                                                            end: end)
                                                        .chain(CurveTween(
                                                            curve: curve));
                                                    var offsetAnimation =
                                                        animation.drive(tween);

                                                    return SlideTransition(
                                                      position: offsetAnimation,
                                                      child: child,
                                                    );
                                                  },
                                                ),
                                              );

                                              if (!isRead) {
                                                await _markRequestAsRead(
                                                    requestId);
                                              }
                                            },
                                            child: Card(
                                              color: isRead
                                                  ? Colors.white
                                                  : Colors.yellow[100],
                                              margin: const EdgeInsets.only(
                                                  bottom: 13,
                                                  left: 7,
                                                  right: 7),
                                              // Set margin to zero to remove white spaces
                                              elevation: 3,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                              ),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        vertical: 5,
                                                        horizontal: 7),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        ListTile(
                                                          //tileColor: isRead ? null : Colors.yellow[100],
                                                          leading: CircleAvatar(
                                                            maxRadius: 14,
                                                            backgroundColor:
                                                                Colors.grey,
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
                                                                  "Requested service : ",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                      fontSize:
                                                                          13)),
                                                              const SizedBox(
                                                                  height: 3),
                                                              Text(
                                                                  snapshot.data!
                                                                              .docs[
                                                                          index]
                                                                      [
                                                                      'neededService'],
                                                                  style:
                                                                      const TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                        15,
                                                                  )),
                                                              // Text(
                                                              //   snapshot.data!.docs[index]
                                                              //       ['userName'],
                                                              //   style: TextStyle(
                                                              //
                                                              //     fontWeight: FontWeight.w700,
                                                              //     color: Colors.black
                                                              //         .withOpacity(0.6),
                                                              //   ),
                                                              // ),
                                                            ],
                                                          ),
                                                        ),
                                                        //const SizedBox(height: 4),
                                                        // Padding(
                                                        //   padding:
                                                        //       const EdgeInsets.symmetric(
                                                        //           horizontal: 3),
                                                        //   child: Row(
                                                        //     children: [
                                                        //       const Text("Request type : ",
                                                        //           style: TextStyle(
                                                        //               fontWeight:
                                                        //                   FontWeight.bold)),
                                                        //       Text(
                                                        //           snapshot.data!.docs[index]
                                                        //               ['neededService'],
                                                        //           style: const TextStyle(
                                                        //               color: Colors.black)),
                                                        //     ],
                                                        //   ),
                                                        // ),
                                                        const SizedBox(
                                                            height: 2),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  left: 15,
                                                                  top: 5),
                                                          child: Row(
                                                            children: [
                                                              const Text(
                                                                "City : ",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .black),
                                                              ),
                                                              Text(
                                                                  snapshot.data!
                                                                              .docs[
                                                                          index]
                                                                      ['city'],
                                                                  style: const TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold)),
                                                            ],
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                            height: 2),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  right: 10,
                                                                  bottom: 3),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .end,
                                                            children: [
                                                              const Icon(
                                                                  Icons
                                                                      .watch_later_outlined,
                                                                  size: 16,
                                                                  color: Colors
                                                                      .black54),
                                                              const SizedBox(
                                                                  width: 3),
                                                              Text(
                                                                  DateFormat('dd-MM-yyyy , HH:mm').format(DateTime.parse(snapshot
                                                                          .data!
                                                                          .docs[index]
                                                                      [
                                                                      'reqTime'])),
                                                                  style: const TextStyle(
                                                                      color: Colors
                                                                          .black38,
                                                                      fontSize:
                                                                          12)),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        } else {
                                          // If the request is older than 24 hours, return an empty container
                                          return Container();
                                        }
                                      }),
                            );
                          }
                        } else if (snapshot.hasError) {
                          showToastMsg(snapshot.hasError.toString());
                        } else {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                        return const Center(child: CircularProgressIndicator());
                      }),
                ),
              ),
            ),
          ],
        ));
  }

  Future<void> _markRequestAsRead(String requestId) async {
    // Update readRequestIds list and save it to SharedPreferences
    readRequestIds.add(requestId);
    await prefs.setStringList('readRequests', readRequestIds);
    setState(() {}); // Update the UI
  }

  Future<void> _removeFromSharedPreferences(String requestId) async {
    // Get the list of read requests from SharedPreferences
    List<String> readRequestIds = prefs.getStringList('readRequests') ?? [];

    // Remove the current requestId from the list
    readRequestIds.remove(requestId);

    // Save the updated list back to SharedPreferences
    await prefs.setStringList('readRequests', readRequestIds);
  }

  Future<void> _refreshData() async {
    await Future.delayed(const Duration(milliseconds: 1200));
    setState(() {});
  }

  //to check usertype
  Future<void> getUserType() async {
    final SharedPreferences sharedPref = await SharedPreferences.getInstance();
    var obtainedUserType = sharedPref.getString("userType");
    setState(() {
      finalUserType = obtainedUserType;
      if (finalUserType == "NGO") {
        iAmNGO = 'true';
        fetchNGOData();
      } else if (finalUserType == "Govt") {
        iAmGovt = 'true';
        fetchGovtData();
      }
    });
  }

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
          authority_state = NGOSnapshot.get('state');
          authority_city = NGOSnapshot.get('city');
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
          authority_state = GovtSnapshot.get('state');
          authority_city = GovtSnapshot.get('city');
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
}
