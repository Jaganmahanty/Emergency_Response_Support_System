// ignore_for_file: depend_on_referenced_packages, non_constant_identifier_names, deprecated_member_use

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fff/Utils/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'admin_open_feedback_details_screen.dart';

// ignore: camel_case_types
class Admin_Request_Details_Screen extends StatefulWidget {
  final DocumentSnapshot<Object?> documentSnapshot;

  const Admin_Request_Details_Screen({
    super.key,
    required this.documentSnapshot,
  });

  @override
  State<Admin_Request_Details_Screen> createState() => _Admin_Request_Details_ScreenState();
}

// ignore: camel_case_types
class _Admin_Request_Details_ScreenState extends State<Admin_Request_Details_Screen> {
  bool isLoading = true;
  bool isNGOExpanded = false;

  //ngo
  bool hasNGOResponded = false;
  String fetchedNid = '';
  String fetchedNGOFid = '';
  bool hasNGOFeedbackSent = false;
  String fetchedNGOName = '';
  String fetchedNGORegNo = '';
  String fetchedNGOAddress = '';
  String fetchedNGOContact = '';
  String fetchedNGOEmail = '';
  String fetchedNGOWebsite = '';
  String fetchedNGORespondTime = '';

  //govt
  bool hasGovtResponded = false;
  String fetchedGid = '';
  String fetchedGovtFid = '';
  bool hasGovtFeedbackSent = false;
  String fetchedGovtName = '';
  String fetchedGovtRegNo = '';
  String fetchedGovtAddress = '';
  String fetchedGovtContact = '';
  String fetchedGovtEmail = '';
  String fetchedGovtWebsite = '';
  String fetchedGovtRespondTime = '';

  @override
  void initState() {
    super.initState();
    fetchNGOResponseDetails();
    fetchGovtResponseDetails();
    // Start loading
    Future.delayed(const Duration(milliseconds: 1100), () {
      setState(() {
        isLoading = false;
      });
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
          title: const Text("$appbar_display_name Request details"),
        ),
        body: isLoading
            ? const Center(child: CircularProgressIndicator())
            : SizedBox(
          child: Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, top: 10),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),

                  const Text("Your Request Details : ",
                      style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 18,
                          color: Colors.blueGrey)),
                  const SizedBox(height: 20),
                  //show Req details
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.blueGrey.withOpacity(0.1)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 25, vertical: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(Iconsax.hierarchy_square),
                              const SizedBox(width: 12),
                              Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  const Text("Needed Service :",
                                      style: TextStyle(fontSize: 13)),
                                  const SizedBox(height: 4),
                                  SizedBox(
                                    width: MediaQuery.of(context)
                                        .size
                                        .width *
                                        0.65,
                                    child: Text(
                                        widget.documentSnapshot[
                                        'neededService'],
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                            fontSize: 16)),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          const Divider(height: 2),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              const Icon(Icons.person_outline_outlined),
                              const SizedBox(width: 12),
                              Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  const Text("Citizen name :",
                                      style: TextStyle(fontSize: 13)),
                                  const SizedBox(height: 4),
                                  SizedBox(
                                    width: MediaQuery.of(context)
                                        .size
                                        .width *
                                        0.65,
                                    child: Text(
                                        widget.documentSnapshot[
                                        'userName'],
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                            fontSize: 16)),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          const Divider(height: 2),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              const Icon(Iconsax.call),
                              const SizedBox(width: 12),
                              Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  const Text("Phone no :",
                                      style: TextStyle(fontSize: 13)),
                                  const SizedBox(height: 4),
                                  SizedBox(
                                    width: MediaQuery.of(context)
                                        .size
                                        .width *
                                        0.65,
                                    child: Text(
                                        widget.documentSnapshot[
                                        'contactNumber'],
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                            fontSize: 16)),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          const Divider(height: 2),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              const Icon(Iconsax.buildings),
                              const SizedBox(width: 12),
                              Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: MediaQuery.of(context)
                                        .size
                                        .width *
                                        0.6,
                                    child: const Text("Address :",
                                        style: TextStyle(fontSize: 13)),
                                  ),
                                  const SizedBox(height: 4),
                                  SizedBox(
                                    width: MediaQuery.of(context)
                                        .size
                                        .width *
                                        0.65,
                                    child: Text(
                                        widget.documentSnapshot[
                                        'fullAddress'],
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                            fontSize: 16)),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          const Divider(height: 2),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              const Icon(Iconsax.gps),
                              const SizedBox(width: 12),
                              Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  const Text("Pin code :",
                                      style: TextStyle(fontSize: 13)),
                                  const SizedBox(height: 4),
                                  SizedBox(
                                    width: MediaQuery.of(context)
                                        .size
                                        .width *
                                        0.65,
                                    child: Text(
                                        widget.documentSnapshot[
                                        'pinCode'],
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                            fontSize: 16)),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          const Divider(height: 2),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              const Icon(Iconsax.building_3),
                              const SizedBox(width: 12),
                              Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  const Text("City :",
                                      style: TextStyle(fontSize: 13)),
                                  const SizedBox(height: 4),
                                  SizedBox(
                                    width: MediaQuery.of(context)
                                        .size
                                        .width *
                                        0.65,
                                    child: Text(
                                        widget.documentSnapshot[
                                        'city'],
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                            fontSize: 16)),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          //const SizedBox(height: 6),
                          //const Divider(height: 2),
                          //const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Column(
                                mainAxisAlignment:
                                MainAxisAlignment.start,
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  const Text("Request time :",
                                      style: TextStyle(
                                          fontSize: 11,
                                          color: Colors.grey)),
                                  const SizedBox(width: 4),
                                  Text(
                                      DateFormat('dd-MM-yyyy , HH:mm')
                                          .format(DateTime.parse(
                                          widget.documentSnapshot[
                                          'reqTime'])),
                                      style: const TextStyle(
                                          fontSize: 11,
                                          color: Colors.grey)),
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 25),

                  //NGO
                  const Text("Responder NGO : ",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 17)),
                  const SizedBox(height: 20),

                  // hasNGOResponded ?
                  //   Row(
                  //     mainAxisAlignment: MainAxisAlignment.center,
                  //     children: [
                  //       GestureDetector(
                  //         onTap: toggleContainerVisibility,
                  //         child: const Icon(Icons.arrow_drop_down),
                  //       ),
                  //     ],
                  //   ) :
                  // Container(
                  //   width: double.infinity,
                  //   decoration: BoxDecoration(
                  //       borderRadius: BorderRadius.circular(15),
                  //       color: Colors.red.withOpacity(0.1)),
                  //   child: Padding(
                  //     padding: const EdgeInsets.symmetric(
                  //         horizontal: 20, vertical: 15),
                  //     child: Row(
                  //       children: [
                  //         Expanded(
                  //           child: Row(
                  //             mainAxisAlignment:
                  //             MainAxisAlignment.center,
                  //             children: [
                  //               const Icon(Iconsax.shield_cross),
                  //               const SizedBox(width: 5),
                  //               SizedBox(
                  //                 width: MediaQuery.of(context)
                  //                     .size
                  //                     .width *
                  //                     0.7, // Adjust the width as needed
                  //                 child: const Text(
                  //                   "No response found from any NGO !!",
                  //                   maxLines: 1,
                  //                   overflow: TextOverflow.ellipsis,
                  //                 ),
                  //               ),
                  //             ],
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  //
                  // AnimatedContainer(
                  //   duration: const Duration(milliseconds: 300),
                  //   height: isNGOExpanded ? null : 0,
                  //   child: isNGOExpanded
                  //       ?  Container(
                  //     width: double.infinity,
                  //     decoration: BoxDecoration(
                  //       borderRadius: BorderRadius.circular(15),
                  //       color: Colors.green.withOpacity(0.1),
                  //     ),
                  //     child: Padding(
                  //       padding: const EdgeInsets.symmetric(
                  //           horizontal: 25, vertical: 15),
                  //       child: Column(
                  //         crossAxisAlignment:
                  //         CrossAxisAlignment.start,
                  //         children: [
                  //           const Text("NGO Id  :",
                  //               style: TextStyle(fontSize: 13)),
                  //           const SizedBox(height: 4),
                  //           Text(fetchedNid,
                  //               style: const TextStyle(fontSize: 16)),
                  //           const SizedBox(height: 8),
                  //           const Divider(height: 2),
                  //           const SizedBox(height: 8),
                  //           const Text("NGO Name :",
                  //               style: TextStyle(fontSize: 13)),
                  //           const SizedBox(height: 4),
                  //           Text(fetchedNGOName,
                  //               style: const TextStyle(fontSize: 16)),
                  //           const SizedBox(height: 8),
                  //           const Divider(height: 2),
                  //           const SizedBox(height: 8),
                  //           const Text("NGO register no :",
                  //               style: TextStyle(fontSize: 13)),
                  //           const SizedBox(height: 4),
                  //           Text(fetchedNGORegNo,
                  //               style: const TextStyle(fontSize: 16)),
                  //           const SizedBox(height: 8),
                  //           const Divider(height: 2),
                  //           const SizedBox(height: 8),
                  //           const Text("Address :",
                  //               style: TextStyle(fontSize: 13)),
                  //           const SizedBox(height: 4),
                  //           Text(fetchedNGOAddress,
                  //               style: const TextStyle(fontSize: 16)),
                  //           const SizedBox(height: 8),
                  //           const Divider(height: 2),
                  //           const SizedBox(height: 8),
                  //           Row(
                  //             mainAxisAlignment:
                  //             MainAxisAlignment.spaceBetween,
                  //             crossAxisAlignment:
                  //             CrossAxisAlignment.center,
                  //             children: [
                  //               Column(
                  //                 crossAxisAlignment:
                  //                 CrossAxisAlignment.start,
                  //                 mainAxisAlignment:
                  //                 MainAxisAlignment.start,
                  //                 children: [
                  //                   const Text("Contact no :",
                  //                       style:
                  //                       TextStyle(fontSize: 13)),
                  //                   const SizedBox(height: 4),
                  //                   Text(fetchedNGOContact,
                  //                       style: const TextStyle(
                  //                           fontSize: 16)),
                  //                 ],
                  //               ),
                  //               IconButton(
                  //                   icon: const Icon(Iconsax.call,
                  //                       color: Colors.deepPurple),
                  //                   onPressed: () {
                  //                     launch(
                  //                       'tel:$fetchedNGOContact',
                  //                     );
                  //                   })
                  //             ],
                  //           ),
                  //           const SizedBox(height: 8),
                  //           const Divider(height: 2),
                  //           const SizedBox(height: 8),
                  //           const Text("City :",
                  //               style: TextStyle(fontSize: 13)),
                  //           const SizedBox(height: 4),
                  //           Text(fetchedNGOEmail,
                  //               style: const TextStyle(fontSize: 16)),
                  //           const SizedBox(height: 8),
                  //           const Divider(height: 2),
                  //           const SizedBox(height: 8),
                  //           Row(
                  //             mainAxisAlignment:
                  //             MainAxisAlignment.spaceBetween,
                  //             crossAxisAlignment:
                  //             CrossAxisAlignment.center,
                  //             children: [
                  //               Column(
                  //                 crossAxisAlignment:
                  //                 CrossAxisAlignment.start,
                  //                 mainAxisAlignment:
                  //                 MainAxisAlignment.start,
                  //                 children: [
                  //                   const Text("Website :",
                  //                       style:
                  //                       TextStyle(fontSize: 13)),
                  //                   const SizedBox(height: 4),
                  //                   Text(fetchedNGOWebsite,
                  //                       style: const TextStyle(
                  //                           fontSize: 16)),
                  //                 ],
                  //               ),
                  //               IconButton(
                  //                 icon: const Icon(Iconsax.global,
                  //                     color: Colors.deepPurple),
                  //                 onPressed: () {
                  //                   _launchWebURL(
                  //                       "https://$fetchedNGOWebsite");
                  //                 },
                  //               )
                  //             ],
                  //           ),
                  //           const SizedBox(height: 8),
                  //           const Divider(height: 2),
                  //           const SizedBox(height: 8),
                  //           const Text("Response time :",
                  //               style: TextStyle(fontSize: 13)),
                  //           const SizedBox(height: 4),
                  //           Text(
                  //               DateFormat('dd-MM-yyyy , HH:mm')
                  //                   .format(DateTime.parse(
                  //                   fetchedNGORespondTime)),
                  //               style: const TextStyle(fontSize: 16))
                  //         ],
                  //       ),
                  //     ),
                  //   )
                  //       : const Text("no"),
                  // ),
                  // const SizedBox(height: 20),
                  //NGO respond
                  hasNGOResponded
                      ? Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.green.withOpacity(0.1),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 25, vertical: 15),
                      child: Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        children: [
                          const Text("NGO Name :",
                              style: TextStyle(fontSize: 13)),
                          const SizedBox(height: 4),
                          Text(fetchedNGOName,
                              style: const TextStyle(fontSize: 16)),
                          const SizedBox(height: 8),
                          const Divider(height: 2),
                          const SizedBox(height: 8),
                          const Text("Address :",
                              style: TextStyle(fontSize: 13)),
                          const SizedBox(height: 4),
                          Text(fetchedNGOAddress,
                              style: const TextStyle(fontSize: 16)),
                          const SizedBox(height: 8),
                          const Divider(height: 2),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            crossAxisAlignment:
                            CrossAxisAlignment.center,
                            children: [
                              Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                mainAxisAlignment:
                                MainAxisAlignment.start,
                                children: [
                                  const Text("Contact no :",
                                      style:
                                      TextStyle(fontSize: 13)),
                                  const SizedBox(height: 4),
                                  SizedBox(
                                    width: MediaQuery.of(context)
                                        .size
                                        .width *
                                        0.6,
                                    child: Text(
                                        fetchedNGOContact,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                            fontSize: 16)),
                                  ),
                                ],
                              ),
                              IconButton(
                                  icon: const Icon(Iconsax.call5,
                                      color: Colors.green),
                                  onPressed: () {
                                    launch(
                                      'tel:$fetchedNGOContact',
                                    );
                                  })
                            ],
                          ),
                          const SizedBox(height: 8),
                          const Divider(height: 2),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            crossAxisAlignment:
                            CrossAxisAlignment.center,
                            children: [
                              Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                mainAxisAlignment:
                                MainAxisAlignment.start,
                                children: [
                                  const Text("Website :",
                                      style:
                                      TextStyle(fontSize: 13)),
                                  const SizedBox(height: 4),
                                  SizedBox(
                                    width: MediaQuery.of(context)
                                        .size
                                        .width *
                                        0.6,
                                    child: Text(
                                        fetchedNGOWebsite,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                            fontSize: 16)),
                                  ),
                                ],
                              ),
                              IconButton(
                                icon: const Icon(Iconsax.global5,
                                    color: Colors.green),
                                onPressed: () {
                                  _launchWebURL(
                                      "https://$fetchedNGOWebsite");
                                },
                              )
                            ],
                          ),
                          const SizedBox(height: 8),
                          const Divider(height: 2),
                          const SizedBox(height: 8),
                          const Text("Mail Address :",
                              style: TextStyle(fontSize: 13)),
                          const SizedBox(height: 4),
                          SizedBox(
                            width: MediaQuery.of(context)
                                .size
                                .width *
                                0.65,
                            child: Text(
                                fetchedNGOEmail,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontSize: 16)),
                          ),
                          Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              hasNGOFeedbackSent
                                  ? Row(
                                children: [
                                  const Icon(
                                      Iconsax.tick_circle4),
                                  const SizedBox(width: 5),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context)
                                          .push(
                                        PageRouteBuilder(
                                          pageBuilder: (context,
                                              animation,
                                              secondaryAnimation) =>
                                              Admin_Open_Feedback_Details_Screen(
                                                  fid:
                                                  fetchedNGOFid),
                                          transitionsBuilder:
                                              (context,
                                              animation,
                                              secondaryAnimation,
                                              child) {
                                            var begin =
                                            const Offset(
                                                1.0, 0.0);
                                            var end =
                                                Offset.zero;
                                            var curve =
                                                Curves.ease;

                                            var tween = Tween(
                                                begin:
                                                begin,
                                                end: end)
                                                .chain(CurveTween(
                                                curve:
                                                curve));
                                            var offsetAnimation =
                                            animation
                                                .drive(
                                                tween);

                                            return SlideTransition(
                                              position:
                                              offsetAnimation,
                                              child: child,
                                            );
                                          },
                                        ),
                                      );
                                    },
                                    child: const Text(
                                        "View feedback !",
                                        style: TextStyle(
                                            color:
                                            Colors.teal,
                                            fontSize: 15,
                                            fontWeight:
                                            FontWeight
                                                .bold)),
                                  ),
                                ],
                              )
                                  : const Row(
                                children: [
                                  Icon(Iconsax.receipt),
                                  SizedBox(width: 5),
                                  Text(
                                        "No feedback submitted !",
                                        style: TextStyle(
                                            color: Colors
                                                .deepOrangeAccent,
                                            fontSize: 15,
                                            fontWeight:
                                            FontWeight
                                                .bold)),

                                ],
                              ),
                              Column(
                                mainAxisAlignment:
                                MainAxisAlignment.start,
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  const Text("Respond time :",
                                      style: TextStyle(
                                          fontSize: 11,
                                          color: Colors.grey)),
                                  const SizedBox(width: 4),
                                  Text(
                                      DateFormat(
                                          'dd-MM-yyyy , HH:mm')
                                          .format(DateTime.parse(
                                          fetchedNGORespondTime)),
                                      style: const TextStyle(
                                          fontSize: 11,
                                          color: Colors.grey)),
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                      : Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.red.withOpacity(0.1)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 15),
                      child: Row(
                        children: [
                          Expanded(
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.center,
                              children: [
                                const Icon(Iconsax.shield_cross),
                                const SizedBox(width: 5),
                                SizedBox(
                                  width: MediaQuery.of(context)
                                      .size
                                      .width *
                                      0.7, // Adjust the width as needed
                                  child: const Text(
                                    "No response found from any NGO !!",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  //Govt
                  const SizedBox(height: 25),
                  const Text("Responder Govt Agency : ",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 17)),
                  const SizedBox(height: 20),
                  //Govt respond
                  hasGovtResponded
                      ? Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.green.withOpacity(0.1),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 25, vertical: 15),
                      child: Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        children: [
                          const Text("Govt Agency Name :",
                              style: TextStyle(fontSize: 13)),
                          const SizedBox(height: 4),
                          Text(fetchedGovtName,
                              style: const TextStyle(fontSize: 16)),
                          const SizedBox(height: 8),
                          const Divider(height: 2),
                          const SizedBox(height: 8),
                          const Text("Address :",
                              style: TextStyle(fontSize: 13)),
                          const SizedBox(height: 4),
                          Text(fetchedGovtAddress,
                              style: const TextStyle(fontSize: 16)),
                          const SizedBox(height: 8),
                          const Divider(height: 2),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            crossAxisAlignment:
                            CrossAxisAlignment.center,
                            children: [
                              Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                mainAxisAlignment:
                                MainAxisAlignment.start,
                                children: [
                                  const Text("Contact no :",
                                      style:
                                      TextStyle(fontSize: 13)),
                                  const SizedBox(height: 4),
                                  Text(fetchedGovtContact,
                                      style: const TextStyle(
                                          fontSize: 16)),
                                ],
                              ),
                              IconButton(
                                  icon: const Icon(Iconsax.call5,
                                      color: Colors.green),
                                  onPressed: () {
                                    launch(
                                      'tel:$fetchedGovtContact',
                                    );
                                  })
                            ],
                          ),
                          const SizedBox(height: 8),
                          const Divider(height: 2),
                          const SizedBox(height: 8),

                          Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            crossAxisAlignment:
                            CrossAxisAlignment.center,
                            children: [
                              Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                mainAxisAlignment:
                                MainAxisAlignment.start,
                                children: [
                                  const Text("Website :",
                                      style:
                                      TextStyle(fontSize: 13)),
                                  const SizedBox(height: 4),
                                  SizedBox(
                                    width: MediaQuery.of(context)
                                        .size
                                        .width *
                                        0.6,
                                    child: Text(
                                        fetchedGovtWebsite,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                            fontSize: 16)),
                                  ),
                                ],
                              ),
                              IconButton(
                                icon: const Icon(Iconsax.global5,
                                    color: Colors.green),
                                onPressed: () {
                                  _launchWebURL(
                                      "https://$fetchedGovtWebsite");
                                },
                              )
                            ],
                          ),
                          const SizedBox(height: 8),
                          const Divider(height: 2),
                          const SizedBox(height: 8),
                          const Text("Mail Address :",
                              style: TextStyle(fontSize: 13)),
                          const SizedBox(height: 4),
                          SizedBox(
                            width: MediaQuery.of(context)
                                .size
                                .width *
                                0.65,
                            child: Text(
                                fetchedGovtEmail,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontSize: 16)),
                          ),
                          const SizedBox(height: 5),
                          Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              hasGovtFeedbackSent
                                  ? Row(
                                children: [
                                  const Icon(
                                      Iconsax.tick_circle4),
                                  const SizedBox(width: 5),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context)
                                          .push(
                                        PageRouteBuilder(
                                          pageBuilder: (context,
                                              animation,
                                              secondaryAnimation) =>
                                              Admin_Open_Feedback_Details_Screen(
                                                  fid:
                                                  fetchedGovtFid),
                                          transitionsBuilder:
                                              (context,
                                              animation,
                                              secondaryAnimation,
                                              child) {
                                            var begin =
                                            const Offset(
                                                1.0, 0.0);
                                            var end =
                                                Offset.zero;
                                            var curve =
                                                Curves.ease;

                                            var tween = Tween(
                                                begin:
                                                begin,
                                                end: end)
                                                .chain(CurveTween(
                                                curve:
                                                curve));
                                            var offsetAnimation =
                                            animation
                                                .drive(
                                                tween);

                                            return SlideTransition(
                                              position:
                                              offsetAnimation,
                                              child: child,
                                            );
                                          },
                                        ),
                                      );
                                    },
                                    child: const Text(
                                        "View Feedback !",
                                        style: TextStyle(
                                            color:
                                            Colors.teal,
                                            fontSize: 15,
                                            fontWeight:
                                            FontWeight
                                                .bold)),
                                  ),
                                ],
                              )
                                  : const Row(
                                children: [
                                  Icon(Iconsax.receipt),
                                  SizedBox(width: 5),
                                  Text(
                                        "No feedback submitted !",
                                        style: TextStyle(
                                            color: Colors
                                                .deepOrangeAccent,
                                            fontSize: 15,
                                            fontWeight:
                                            FontWeight
                                                .bold)),

                                ],
                              ),
                              Column(
                                mainAxisAlignment:
                                MainAxisAlignment.start,
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  const Text("Respond time :",
                                      style: TextStyle(
                                          fontSize: 11,
                                          color: Colors.grey)),
                                  const SizedBox(width: 4),
                                  Text(
                                      DateFormat(
                                          'dd-MM-yyyy , HH:mm')
                                          .format(DateTime.parse(
                                          fetchedGovtRespondTime)),
                                      style: const TextStyle(
                                          fontSize: 11,
                                          color: Colors.grey)),
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                      : Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.red.withOpacity(0.1)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 15),
                      child: Row(
                        children: [
                          Expanded(
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.center,
                              children: [
                                const Icon(Iconsax.shield_cross),
                                const SizedBox(width: 5),
                                SizedBox(
                                  width: MediaQuery.of(context)
                                      .size
                                      .width *
                                      0.7, // Adjust the width as needed
                                  child: const Text(
                                    "No response found from Govt agency !!",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20)
                ],
              ),
            ),
          ),
        ));
  }

  Future<void> fetchNGOResponseDetails() async {
    try {
      // Fetch data from Firestore
      DocumentSnapshot NGOResponseSnapshot = await FirebaseFirestore.instance
          .collection('clc_response')
          .doc(widget.documentSnapshot['RespondId'])
          .collection("ngo")
          .doc("ngo_details")
          .get();
      //print(user!.email);
      //print(GovtSnapshot.get('GovtAgencyRegNo'));

      // Check if the document exists
      if (NGOResponseSnapshot.exists) {
        // Access the fields from the document
        setState(() {
          hasNGOResponded = true;
          fetchedNid = NGOResponseSnapshot.get('nid');
          fetchedNGOFid = NGOResponseSnapshot.get('fid');
          if (kDebugMode) {
            print(fetchedNGOFid);
          }
          if (fetchedNGOFid.isNotEmpty) {
            hasNGOFeedbackSent = true;
          }
          fetchedNGOName = NGOResponseSnapshot.get('ResponderNGOName');
          fetchedNGORegNo = NGOResponseSnapshot.get('ResponderNGORegNo');
          fetchedNGOAddress = NGOResponseSnapshot.get('ResponderNGOAddress');
          fetchedNGOContact =
              NGOResponseSnapshot.get('ResponderNGOContactNumber');
          fetchedNGOEmail = NGOResponseSnapshot.get('ResponderNGOEmail');
          fetchedNGOWebsite = NGOResponseSnapshot.get('ResponderNGOWebsite');
          fetchedNGORespondTime = NGOResponseSnapshot.get('RespondNGOTime');
        });
      } else {
        if (kDebugMode) {
          print('NGO response Document does not exist');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching NGO response data: $e');
      }
    }
  }

  Future<void> fetchGovtResponseDetails() async {
    try {
      // Fetch data from Firestore
      DocumentSnapshot GovtResponseSnapshot = await FirebaseFirestore.instance
          .collection('clc_response')
          .doc(widget.documentSnapshot['RespondId'])
          .collection("govt")
          .doc("govt_details")
          .get();

      // Check if the document exists
      if (GovtResponseSnapshot.exists) {
        // Access the fields from the document
        setState(() {
          hasGovtResponded = true;
          fetchedGid = GovtResponseSnapshot.get('gid');
          fetchedGovtFid = GovtResponseSnapshot.get('fid');
          if (kDebugMode) {
            print(fetchedGovtFid);
          }
          if (fetchedGovtFid.isNotEmpty) {
            hasGovtFeedbackSent = true;
          }
          fetchedGovtName = GovtResponseSnapshot.get('ResponderGovtName');
          fetchedGovtRegNo = GovtResponseSnapshot.get('ResponderGovtRegNo');
          fetchedGovtAddress = GovtResponseSnapshot.get('ResponderGovtAddress');
          fetchedGovtContact =
              GovtResponseSnapshot.get('ResponderGovtContactNumber');
          fetchedGovtEmail = GovtResponseSnapshot.get('ResponderGovtEmail');
          fetchedGovtWebsite = GovtResponseSnapshot.get('ResponderGovtWebsite');
          fetchedGovtRespondTime = GovtResponseSnapshot.get('RespondGovtTime');
        });
      } else {
        if (kDebugMode) {
          print('Govt response Document does not exist');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching Govt response data: $e');
      }
    }
  }

  void _launchWebURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
