// ignore_for_file: depend_on_referenced_packages, camel_case_types, library_private_types_in_public_api, use_build_context_synchronously

import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../Utils/Utils.dart';
import '../../Utils/common_files/request/declined_req_details.dart';
import '../../Utils/common_files/response/response_details_screen.dart';
import '../../Utils/constants.dart';

class NGO_Response_History_Screen extends StatefulWidget {
  const NGO_Response_History_Screen({super.key});

  @override
  State<NGO_Response_History_Screen> createState() =>
      _NGO_Response_History_ScreenState();
}

class _NGO_Response_History_ScreenState
    extends State<NGO_Response_History_Screen> {
  List<String> documentIds = [];
  String fetchedNid = "";

  List<Map<String, dynamic>> responseHistoryData = [];

  @override
  void initState() {
    super.initState();
    _fetchResponseHistoryData();
    _fetchNid();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          elevation: 50,
          backgroundColor: color_AppBar,
          centerTitle: true,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(25),
                  bottomLeft: Radius.circular(25))),
          title: const Text("History"),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Response history'),
              Tab(text: 'Declined History'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Column(
              children: [
                response_history_list_widget(
                  responseHistoryData: responseHistoryData,
                )
              ],
            ),
            Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: RefreshIndicator(
                      onRefresh: _refreshData,
                      child: StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection("clc_declined_request")
                              .where("Authority_Id", isEqualTo: fetchedNid)
                              .orderBy('DeclineTime', descending: true)
                              .limit(25)
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
                                            'No declined requests found !',
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
                                                    ['DeclineTime'];
                                                return GestureDetector(
                                                  onTap: () {
                                                    Navigator.of(context).push(
                                                      PageRouteBuilder(
                                                        pageBuilder: (context,
                                                                animation,
                                                                secondaryAnimation) =>
                                                            Declined_Request_Details_Screen(
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
                                                                        "The reason of declination : ",
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
                                                                            .docs[index]['Decline_Reason'],
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
                                                                      "Citizen : ",
                                                                      style: TextStyle(
                                                                          color:
                                                                              Colors.black),
                                                                    ),
                                                                    Text(
                                                                        snapshot.data!.docs[index]
                                                                            [
                                                                            'Username'],
                                                                        style: const TextStyle(
                                                                            color:
                                                                                Colors.black,
                                                                            fontWeight: FontWeight.bold)),
                                                                  ],
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                  height: 4),
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
                                                                            'DeclineTime'])),
                                                                        style: const TextStyle(
                                                                            color:
                                                                                Colors.black38,
                                                                            fontSize: 12)),
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
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Future<void> _fetchResponseHistoryData() async {
    try {
      FirebaseAuth auth = FirebaseAuth.instance;
      User? user = auth.currentUser;
      String? email = user!.email;

      final responseQuerySnapshot = await FirebaseFirestore.instance
          .collection("clc_response")
          .doc(email)
          .collection("ngo")
          .where("ResponderNGOEmail", isEqualTo: email)
          .orderBy('RespondNGOTime', descending: true)
          .get();

      List<String> requestIds = responseQuerySnapshot.docs
          .map((doc) => doc['RequestId'] as String)
          .toList();

      List<Map<String, dynamic>> responseData = [];
      for (String requestId in requestIds) {
        final requestQuerySnapshot = await FirebaseFirestore.instance
            .collection("clc_request")
            .where("RequestId", isEqualTo: requestId)
            //.orderBy('reqTime', descending: true)
            .get();

        responseData.addAll(
            requestQuerySnapshot.docs.map((doc) => doc.data()).toList());
      }

      setState(() {
        responseHistoryData = responseData;
      });
    } catch (error) {
      if (kDebugMode) {
        print("Error fetching response history data: $error");
      }
    }
  }

  Future<void> _refreshData() async {
    await Future.delayed(const Duration(milliseconds: 1200));
    setState(() {});
  }

  Future<void> _fetchNid() async {
    User? user = FirebaseAuth.instance.currentUser;

    DocumentSnapshot govtSnapshot = await FirebaseFirestore.instance
        .collection('clc_ngo')
        .doc(user?.email)
        .get();

    if (govtSnapshot.exists) {
      setState(() {
        fetchedNid = govtSnapshot.get('nid');
      });
    }
  }
}

class response_history_list_widget extends StatefulWidget {
  final List<Map<String, dynamic>> responseHistoryData;

  const response_history_list_widget({
    Key? key,
    required this.responseHistoryData,
  }) : super(key: key);

  @override
  _response_history_list_widgetState createState() =>
      _response_history_list_widgetState();
}

class _response_history_list_widgetState
    extends State<response_history_list_widget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: RefreshIndicator(
          onRefresh: _refreshData,
          child: widget.responseHistoryData.isEmpty
              ? const Center(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Loading responses ...",
                            style: TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                            )),
                        SizedBox(
                          height: 30,
                        ),
                        CircularProgressIndicator()
                      ]),
                ) // Show progress indicator if data is empty
              : ListView.builder(
                  itemCount: widget.responseHistoryData.length,
                  itemBuilder: (context, index) {
                    final responseData = widget.responseHistoryData[index];
                    return GestureDetector(
                      onTap: () async {
                        String passReq = responseData['RequestId'];

                        DocumentSnapshot<Map<String, dynamic>> passSnapshot =
                            await FirebaseFirestore.instance
                                .collection('clc_request')
                                .doc(passReq)
                                .get();

                        Navigator.of(context).push(
                          PageRouteBuilder(
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                    Response_Details_Screen(
                              documentSnapshot: passSnapshot,
                            ),
                            transitionsBuilder: (context, animation,
                                secondaryAnimation, child) {
                              var begin = const Offset(1.0, 0.0);
                              var end = Offset.zero;
                              var curve = Curves.ease;

                              var tween = Tween(begin: begin, end: end)
                                  .chain(CurveTween(curve: curve));
                              var offsetAnimation = animation.drive(tween);

                              return SlideTransition(
                                position: offsetAnimation,
                                child: child,
                              );
                            },
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Card(
                          color: Colors.white,
                          margin: const EdgeInsets.only(
                              bottom: 6, left: 7, right: 7),
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 7),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ListTile(
                                      leading: CircleAvatar(
                                        maxRadius: 14,
                                        backgroundColor: Colors.grey,
                                        child: Text("${index + 1}"),
                                      ),
                                      title: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            "Requested service : ",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 13,
                                            ),
                                          ),
                                          const SizedBox(height: 3),
                                          Text(
                                            '${responseData['neededService']}',
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 15,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    const SizedBox(height: 2),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 15, top: 5),
                                      child: Row(
                                        children: [
                                          const Text(
                                            "Citizen : ",
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                          Text(
                                            '${responseData['userName']}',
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 15,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    // const SizedBox(height: 2),
                                    // Padding(
                                    //   padding: const EdgeInsets.only(
                                    //       left: 15, top: 5),
                                    //   child: Row(
                                    //     children: [
                                    //       const Text(
                                    //         "City : ",
                                    //         style:
                                    //             TextStyle(color: Colors.black),
                                    //       ),
                                    //       Text(
                                    //         '${responseData['city']}',
                                    //         style: const TextStyle(
                                    //           color: Colors.black,
                                    //           fontSize: 15,
                                    //         ),
                                    //       ),
                                    //     ],
                                    //   ),
                                    // ),
                                    const SizedBox(height: 2),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          right: 10, bottom: 3),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          const Icon(Icons.watch_later_outlined,
                                              size: 16, color: Colors.black54),
                                          const SizedBox(width: 3),
                                          Text(
                                              DateFormat('dd-MM-yyyy , HH:mm')
                                                  .format(DateTime.parse(
                                                      responseData['reqTime'])),
                                              style: const TextStyle(
                                                  color: Colors.black38,
                                                  fontSize: 12)),
                                        ],
                                      ),
                                    ),
                                    // Other parts of your UI
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
        ),
      ),
    );
  }

  Future<void> _refreshData() async {
    await Future.delayed(const Duration(milliseconds: 1200));
    setState(() {});
  }
}
