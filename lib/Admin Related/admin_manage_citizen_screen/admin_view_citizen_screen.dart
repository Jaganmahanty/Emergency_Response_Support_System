// ignore_for_file: camel_case_types, library_private_types_in_public_api, deprecated_member_use, depend_on_referenced_packages

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../../Utils/Utils.dart';
import '../../../Utils/constants.dart';
import 'package:intl/intl.dart';
import 'admin_citizen_details_screen.dart';

class Admin_View_Citizen_Screen extends StatefulWidget {
  const Admin_View_Citizen_Screen({super.key});

  @override
  State<Admin_View_Citizen_Screen> createState() =>
      _Admin_View_Citizen_ScreenState();
}

class _Admin_View_Citizen_ScreenState extends State<Admin_View_Citizen_Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 50,
        backgroundColor: color_AppBar,
        centerTitle: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(25),
                bottomLeft: Radius.circular(25))),
        title: const Text("Registered Citizen"),
      ),
      body: const Column(
        children: [citizen_history_list_widget()],
      ),
    );
  }
}

class citizen_history_list_widget extends StatefulWidget {
  const citizen_history_list_widget({Key? key}) : super(key: key);

  @override
  _citizen_history_list_widgetState createState() =>
      _citizen_history_list_widgetState();
}

class _citizen_history_list_widgetState
    extends State<citizen_history_list_widget> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: RefreshIndicator(
          onRefresh: _refreshData,
          child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("clc_citizen")
                  .orderBy('registrationTime', descending: true)
                  // .limit(25)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.active) {
                  if (snapshot.hasData) {
                    return Padding(
                      padding:
                          const EdgeInsets.only(left: 7, right: 7, top: 10),
                      child: snapshot.data!.docs.isEmpty
                          ? const Center(
                              child: Text(
                                'No citizen record found !',
                                style: TextStyle(
                                  fontSize: 19,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey,
                                ),
                              ),
                            )
                          : Scrollbar(
                              child: ListView.builder(
                                  itemCount: snapshot.data!.docs.length,
                                  itemBuilder: (context, index) {
                                    snapshot.data!.docs[index]
                                        ['registrationTime'];
                                    return GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).push(
                                          PageRouteBuilder(
                                            pageBuilder: (context, animation,
                                                    secondaryAnimation) =>
                                                Citizen_Details_Screen(
                                              documentSnapshot:
                                                  snapshot.data!.docs[index],
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
                                                      begin: begin, end: end)
                                                  .chain(
                                                      CurveTween(curve: curve));
                                              var offsetAnimation =
                                                  animation.drive(tween);

                                              return SlideTransition(
                                                position: offsetAnimation,
                                                child: child,
                                              );
                                            },
                                          ),
                                        );
                                      },
                                      child: Card(
                                        color: Colors.white,
                                        margin: const EdgeInsets.only(
                                            bottom: 13, left: 7, right: 7),
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
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 5,
                                                      horizontal: 7),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  ListTile(
                                                    leading: CircleAvatar(
                                                      maxRadius: 14,
                                                      backgroundColor:
                                                          Colors.grey,
                                                      child:
                                                          Text("${index + 1}"),
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
                                                            "Citizen name : ",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 13)),
                                                        const SizedBox(
                                                            height: 3),
                                                        Text(
                                                            snapshot.data!
                                                                    .docs[index]
                                                                ['firstName'],
                                                            style:
                                                                const TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 15,
                                                            )),
                                                      ],
                                                    ),
                                                  ),

                                                  const SizedBox(height: 2),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 15, top: 5),
                                                    child: Row(
                                                      children: [
                                                        const Text(
                                                          "Phone no : ",style: TextStyle(color: Colors.black),
                                                        ),
                                                        Text(
                                                            snapshot.data!
                                                                    .docs[index]
                                                                ['phoneNumber'],
                                                            style: const TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold)),
                                                      ],
                                                    ),
                                                  ),
                                                  const SizedBox(height: 2),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 15, top: 5),
                                                    child: Row(
                                                      children: [
                                                        const Text(
                                                          "City : ",style: TextStyle(color: Colors.black),
                                                        ),
                                                        Text(
                                                            snapshot.data!
                                                                    .docs[index]
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
                                                  const SizedBox(height: 2),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 10,
                                                            bottom: 3),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      children: [
                                                        const Icon(
                                                            Icons
                                                                .watch_later_outlined,
                                                            size: 16,
                                                            color:
                                                                Colors.black54),
                                                        const SizedBox(
                                                            width: 3),
                                                        Text(
                                                            DateFormat(
                                                                    'dd-MM-yyyy , HH:mm')
                                                                .format(DateTime.parse(snapshot
                                                                            .data!
                                                                            .docs[
                                                                        index]
                                                                    [
                                                                    'registrationTime'])),
                                                            style:
                                                                const TextStyle(
                                                                    color: Colors
                                                                        .black38,
                                                                    fontSize:
                                                                        12)),
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
                  return const Center(child: CircularProgressIndicator());
                }
                return const Center(child: CircularProgressIndicator());
              }),
        ),
      ),
    );
  }

  Future<void> _refreshData() async {
    await Future.delayed(const Duration(milliseconds: 1200));
    setState(() {});
  }
}
