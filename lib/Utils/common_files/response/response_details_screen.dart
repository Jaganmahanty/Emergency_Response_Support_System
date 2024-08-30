// ignore_for_file: depend_on_referenced_packages, non_constant_identifier_names, deprecated_member_use

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fff/Utils/common_files/response/view_feedback_screen.dart';
import 'package:fff/Utils/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore: camel_case_types
class Response_Details_Screen extends StatefulWidget {
  final DocumentSnapshot<Object?> documentSnapshot;

  const Response_Details_Screen({
    super.key,
    required this.documentSnapshot,
  });

  @override
  State<Response_Details_Screen> createState() =>
      _Response_Details_ScreenState();
}

// ignore: camel_case_types
class _Response_Details_ScreenState extends State<Response_Details_Screen> {
  String? finalUserType = "";
  bool isLoading = true;
  bool isNGOExpanded = false;
  bool isNGO = false;
  bool isGovt = false;

  //for Request
  String fetchedRid = "";
  String fetchedHasNGOResponded = "";
  String fetchedHasGovtResponded = "";
  String fetchedService = "";
  String fetchedUsername = "";
  String fetchedCitizenContactNo = "";
  String fetchedCitizenState = "";
  String fetchedCitizenCity = "";
  String fetchedReqAddress = "";
  String fetchedPincode = '';
  String fetchedReqTime = "";

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
    fetchReqData();
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
          backgroundColor: color_AppBar,
          centerTitle: true,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(25),
                  bottomLeft: Radius.circular(25))),
          title: const Text("Response details"),
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

                        const Text(" Request Details : ",
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
                                // Row(
                                //   children: [
                                //     const Icon(Iconsax.card),
                                //     const SizedBox(width: 12),
                                //     Column(
                                //       crossAxisAlignment:
                                //       CrossAxisAlignment.start,
                                //       children: [
                                //         const Text("Request Id  :",
                                //             style: TextStyle(fontSize: 13)),
                                //         const SizedBox(height: 4),
                                //         Text(
                                //             fetchedRid,
                                //             style:
                                //             const TextStyle(fontSize: 16)),
                                //       ],
                                //     ),
                                //   ],
                                // ),
                                // const SizedBox(height: 8),
                                // const Divider(height: 2),
                                // const SizedBox(height: 8),
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
                                        Text(fetchedService,
                                            style:
                                                const TextStyle(fontSize: 16)),
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
                                        Text(fetchedCitizenContactNo,
                                            style:
                                                const TextStyle(fontSize: 16)),
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
                                              0.67,
                                          child: Text(fetchedReqAddress,
                                              maxLines: 3,
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
                                        Text(fetchedPincode,
                                            style:
                                                const TextStyle(fontSize: 16)),
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
                                        Text(fetchedCitizenCity,
                                            style:
                                                const TextStyle(fontSize: 16)),
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
                                        Text(fetchedReqTime,
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

                        isNGO
                            ? Column(
                                children: [
                                  const Text("Response Details : ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 17)),
                                  const SizedBox(height: 20),
                                  Container(
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
                                              style: const TextStyle(
                                                  fontSize: 16)),
                                          const SizedBox(height: 8),
                                          const Divider(height: 2),
                                          const SizedBox(height: 8),
                                          const Text("Address :",
                                              style: TextStyle(fontSize: 13)),
                                          const SizedBox(height: 4),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.67,
                                            child: Text(fetchedNGOAddress,
                                                maxLines: 3,
                                                style: const TextStyle(
                                                    fontSize: 16)),
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
                                                  const Text("Contact no :",
                                                      style: TextStyle(
                                                          fontSize: 13)),
                                                  const SizedBox(height: 4),
                                                  Text(fetchedNGOContact,
                                                      style: const TextStyle(
                                                          fontSize: 16)),
                                                ],
                                              ),
                                              IconButton(
                                                  icon: const Icon(
                                                      Iconsax.call5,
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
                                                      style: TextStyle(
                                                          fontSize: 13)),
                                                  const SizedBox(height: 4),
                                                  Text(fetchedNGOWebsite,
                                                      style: const TextStyle(
                                                          fontSize: 16)),
                                                ],
                                              ),
                                              IconButton(
                                                icon: const Icon(
                                                    Iconsax.global5,
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
                                          Text(fetchedNGOEmail,
                                              style: const TextStyle(
                                                  fontSize: 16)),
                                          const SizedBox(height: 5),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              hasNGOFeedbackSent
                                                  ? Row(
                                                      children: [
                                                        const Icon(Iconsax
                                                            .tick_circle4),
                                                        const SizedBox(
                                                            width: 5),
                                                        TextButton(
                                                          onPressed: () {
                                                            Navigator.of(
                                                                    context)
                                                                .push(
                                                              PageRouteBuilder(
                                                                pageBuilder: (context,
                                                                        animation,
                                                                        secondaryAnimation) =>
                                                                    View_Feedback_Details_Screen(
                                                                        fid:
                                                                            fetchedNGOFid),
                                                                transitionsBuilder:
                                                                    (context,
                                                                        animation,
                                                                        secondaryAnimation,
                                                                        child) {
                                                                  var begin =
                                                                      const Offset(
                                                                          1.0,
                                                                          0.0);
                                                                  var end =
                                                                      Offset
                                                                          .zero;
                                                                  var curve =
                                                                      Curves
                                                                          .ease;

                                                                  var tween = Tween(
                                                                          begin:
                                                                              begin,
                                                                          end:
                                                                              end)
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
                                                                    child:
                                                                        child,
                                                                  );
                                                                },
                                                              ),
                                                            );
                                                          },
                                                          child: const Text(
                                                              "View Feedback",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .teal,
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
                                                            "Waiting for Feedback !",
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
                                  ),
                                ],
                              )
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text("Response Details : ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 17)),
                                  const SizedBox(height: 20),
                                  Container(
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
                                              style: const TextStyle(
                                                  fontSize: 16)),
                                          const SizedBox(height: 8),
                                          const Divider(height: 2),
                                          const SizedBox(height: 8),
                                          const Text("Address :",
                                              style: TextStyle(fontSize: 13)),
                                          const SizedBox(height: 4),
                                          Text(fetchedGovtAddress,
                                              style: const TextStyle(
                                                  fontSize: 16)),
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
                                                      style: TextStyle(
                                                          fontSize: 13)),
                                                  const SizedBox(height: 4),
                                                  Text(fetchedGovtContact,
                                                      style: const TextStyle(
                                                          fontSize: 16)),
                                                ],
                                              ),
                                              IconButton(
                                                  icon: const Icon(
                                                      Iconsax.call5,
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
                                                      style: TextStyle(
                                                          fontSize: 13)),
                                                  const SizedBox(height: 4),
                                                  Text(fetchedGovtWebsite,
                                                      style: const TextStyle(
                                                          fontSize: 16)),
                                                ],
                                              ),
                                              IconButton(
                                                icon: const Icon(
                                                    Iconsax.global5,
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
                                          Text(fetchedGovtEmail,
                                              style: const TextStyle(
                                                  fontSize: 16)),
                                          const SizedBox(height: 5),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              hasGovtFeedbackSent
                                                  ? Row(
                                                      children: [
                                                        const Icon(Iconsax
                                                            .tick_circle4),
                                                        const SizedBox(
                                                            width: 5),
                                                        TextButton(
                                                          onPressed: () {
                                                            Navigator.of(
                                                                    context)
                                                                .push(
                                                              PageRouteBuilder(
                                                                pageBuilder: (context,
                                                                        animation,
                                                                        secondaryAnimation) =>
                                                                    View_Feedback_Details_Screen(
                                                                        fid:
                                                                            fetchedGovtFid),
                                                                transitionsBuilder:
                                                                    (context,
                                                                        animation,
                                                                        secondaryAnimation,
                                                                        child) {
                                                                  var begin =
                                                                      const Offset(
                                                                          1.0,
                                                                          0.0);
                                                                  var end =
                                                                      Offset
                                                                          .zero;
                                                                  var curve =
                                                                      Curves
                                                                          .ease;

                                                                  var tween = Tween(
                                                                          begin:
                                                                              begin,
                                                                          end:
                                                                              end)
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
                                                                    child:
                                                                        child,
                                                                  );
                                                                },
                                                              ),
                                                            );
                                                          },
                                                          child: const Text(
                                                              "View Feedback",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .teal,
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
                                                            "Waiting for feedback !",
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
                                  ),
                                ],
                              ),
                        //Govt

                        // //Govt respond
                        // isGovt
                        //     ? Container(
                        //         width: double.infinity,
                        //         decoration: BoxDecoration(
                        //           borderRadius: BorderRadius.circular(15),
                        //           color: Colors.green.withOpacity(0.1),
                        //         ),
                        //         child: Padding(
                        //           padding: const EdgeInsets.symmetric(
                        //               horizontal: 25, vertical: 15),
                        //           child: Column(
                        //             crossAxisAlignment:
                        //                 CrossAxisAlignment.start,
                        //             children: [
                        //               // const Text("NGO Id  :",
                        //               //     style: TextStyle(fontSize: 13)),
                        //               // const SizedBox(height: 4),
                        //               // Text(fetchedNid,
                        //               //     style: const TextStyle(fontSize: 16)),
                        //               // const SizedBox(height: 8),
                        //               // const Divider(height: 2),
                        //               // const SizedBox(height: 8),
                        //               const Text("Govt Agency Name :",
                        //                   style: TextStyle(fontSize: 13)),
                        //               const SizedBox(height: 4),
                        //               Text(fetchedGovtName,
                        //                   style: const TextStyle(fontSize: 16)),
                        //               const SizedBox(height: 8),
                        //               const Divider(height: 2),
                        //               const SizedBox(height: 8),
                        //               // const Text("NGO register no :",
                        //               //     style: TextStyle(fontSize: 13)),
                        //               // const SizedBox(height: 4),
                        //               // Text(fetchedNGORegNo,
                        //               //     style: const TextStyle(fontSize: 16)),
                        //               // const SizedBox(height: 8),
                        //               // const Divider(height: 2),
                        //               // const SizedBox(height: 8),
                        //               const Text("Address :",
                        //                   style: TextStyle(fontSize: 13)),
                        //               const SizedBox(height: 4),
                        //               Text(fetchedGovtAddress,
                        //                   style: const TextStyle(fontSize: 16)),
                        //               const SizedBox(height: 8),
                        //               const Divider(height: 2),
                        //               const SizedBox(height: 8),
                        //               Row(
                        //                 mainAxisAlignment:
                        //                     MainAxisAlignment.spaceBetween,
                        //                 crossAxisAlignment:
                        //                     CrossAxisAlignment.center,
                        //                 children: [
                        //                   Column(
                        //                     crossAxisAlignment:
                        //                         CrossAxisAlignment.start,
                        //                     mainAxisAlignment:
                        //                         MainAxisAlignment.start,
                        //                     children: [
                        //                       const Text("Contact no :",
                        //                           style:
                        //                               TextStyle(fontSize: 13)),
                        //                       const SizedBox(height: 4),
                        //                       Text(fetchedGovtContact,
                        //                           style: const TextStyle(
                        //                               fontSize: 16)),
                        //                     ],
                        //                   ),
                        //                   IconButton(
                        //                       icon: const Icon(Iconsax.call5,
                        //                           color: Colors.green),
                        //                       onPressed: () {
                        //                         launch(
                        //                           'tel:$fetchedGovtContact',
                        //                         );
                        //                       })
                        //                 ],
                        //               ),
                        //               const SizedBox(height: 8),
                        //               const Divider(height: 2),
                        //               const SizedBox(height: 8),
                        //
                        //               Row(
                        //                 mainAxisAlignment:
                        //                     MainAxisAlignment.spaceBetween,
                        //                 crossAxisAlignment:
                        //                     CrossAxisAlignment.center,
                        //                 children: [
                        //                   Column(
                        //                     crossAxisAlignment:
                        //                         CrossAxisAlignment.start,
                        //                     mainAxisAlignment:
                        //                         MainAxisAlignment.start,
                        //                     children: [
                        //                       const Text("Website :",
                        //                           style:
                        //                               TextStyle(fontSize: 13)),
                        //                       const SizedBox(height: 4),
                        //                       Text(fetchedGovtWebsite,
                        //                           style: const TextStyle(
                        //                               fontSize: 16)),
                        //                     ],
                        //                   ),
                        //                   IconButton(
                        //                     icon: const Icon(Iconsax.global5,
                        //                         color: Colors.green),
                        //                     onPressed: () {
                        //                       _launchWebURL(
                        //                           "https://$fetchedGovtWebsite");
                        //                     },
                        //                   )
                        //                 ],
                        //               ),
                        //               const SizedBox(height: 8),
                        //               const Divider(height: 2),
                        //               const SizedBox(height: 8),
                        //               const Text("Mail Address :",
                        //                   style: TextStyle(fontSize: 13)),
                        //               const SizedBox(height: 4),
                        //               Text(fetchedGovtEmail,
                        //                   style: const TextStyle(fontSize: 16)),
                        //               const SizedBox(height: 5),
                        //               Row(
                        //                 mainAxisAlignment:
                        //                     MainAxisAlignment.spaceBetween,
                        //                 children: [
                        //                   hasGovtFeedbackSent
                        //                       ? Row(
                        //                           children: [
                        //                             const Icon(
                        //                                 Iconsax.tick_circle4),
                        //                             const SizedBox(width: 5),
                        //                             TextButton(
                        //                               onPressed: () {
                        //                                 Navigator.of(context)
                        //                                     .push(
                        //                                   PageRouteBuilder(
                        //                                     pageBuilder: (context,
                        //                                             animation,
                        //                                             secondaryAnimation) =>
                        //                                         Open_Feedback_Details_Screen(
                        //                                             fid:
                        //                                                 fetchedGovtFid),
                        //                                     transitionsBuilder:
                        //                                         (context,
                        //                                             animation,
                        //                                             secondaryAnimation,
                        //                                             child) {
                        //                                       var begin =
                        //                                           const Offset(
                        //                                               1.0, 0.0);
                        //                                       var end =
                        //                                           Offset.zero;
                        //                                       var curve =
                        //                                           Curves.ease;
                        //
                        //                                       var tween = Tween(
                        //                                               begin:
                        //                                                   begin,
                        //                                               end: end)
                        //                                           .chain(CurveTween(
                        //                                               curve:
                        //                                                   curve));
                        //                                       var offsetAnimation =
                        //                                           animation
                        //                                               .drive(
                        //                                                   tween);
                        //
                        //                                       return SlideTransition(
                        //                                         position:
                        //                                             offsetAnimation,
                        //                                         child: child,
                        //                                       );
                        //                                     },
                        //                                   ),
                        //                                 );
                        //                               },
                        //                               child: const Text(
                        //                                   "Feedback submitted",
                        //                                   style: TextStyle(
                        //                                       color:
                        //                                           Colors.teal,
                        //                                       fontSize: 15,
                        //                                       fontWeight:
                        //                                           FontWeight
                        //                                               .bold)),
                        //                             ),
                        //                           ],
                        //                         )
                        //                       : Row(
                        //                           children: [
                        //                             const Icon(Iconsax.receipt),
                        //                             const SizedBox(width: 5),
                        //                             TextButton(
                        //                               child: const Text(
                        //                                   "Give Feedback !",
                        //                                   style: TextStyle(
                        //                                       color: Colors
                        //                                           .deepOrangeAccent,
                        //                                       fontSize: 15,
                        //                                       fontWeight:
                        //                                           FontWeight
                        //                                               .bold)),
                        //                               onPressed: () {
                        //                                 Navigator.of(context)
                        //                                     .push(
                        //                                   PageRouteBuilder(
                        //                                     pageBuilder: (context,
                        //                                             animation,
                        //                                             secondaryAnimation) =>
                        //                                         User_Feedback_Screen(
                        //                                             authority_name:
                        //                                                 fetchedGovtName,
                        //                                             authority_id:
                        //                                                 fetchedGid,
                        //                                             respond_id:
                        //                                                 widget.documentSnapshot[
                        //                                                     'RespondId']),
                        //                                     transitionsBuilder:
                        //                                         (context,
                        //                                             animation,
                        //                                             secondaryAnimation,
                        //                                             child) {
                        //                                       var begin =
                        //                                           const Offset(
                        //                                               1.0, 0.0);
                        //                                       var end =
                        //                                           Offset.zero;
                        //                                       var curve =
                        //                                           Curves.ease;
                        //
                        //                                       var tween = Tween(
                        //                                               begin:
                        //                                                   begin,
                        //                                               end: end)
                        //                                           .chain(CurveTween(
                        //                                               curve:
                        //                                                   curve));
                        //                                       var offsetAnimation =
                        //                                           animation
                        //                                               .drive(
                        //                                                   tween);
                        //
                        //                                       return SlideTransition(
                        //                                         position:
                        //                                             offsetAnimation,
                        //                                         child: child,
                        //                                       );
                        //                                     },
                        //                                   ),
                        //                                 );
                        //                               },
                        //                             )
                        //                           ],
                        //                         ),
                        //                   Column(
                        //                     mainAxisAlignment:
                        //                         MainAxisAlignment.start,
                        //                     crossAxisAlignment:
                        //                         CrossAxisAlignment.start,
                        //                     children: [
                        //                       const Text("Respond time :",
                        //                           style: TextStyle(
                        //                               fontSize: 11,
                        //                               color: Colors.grey)),
                        //                       const SizedBox(width: 4),
                        //                       Text(
                        //                           DateFormat(
                        //                                   'dd-MM-yyyy , HH:mm')
                        //                               .format(DateTime.parse(
                        //                                   fetchedGovtRespondTime)),
                        //                           style: const TextStyle(
                        //                               fontSize: 11,
                        //                               color: Colors.grey)),
                        //                     ],
                        //                   ),
                        //                 ],
                        //               )
                        //             ],
                        //           ),
                        //         ),
                        //       )
                        //     : Container(
                        //         width: double.infinity,
                        //         decoration: BoxDecoration(
                        //             borderRadius: BorderRadius.circular(15),
                        //             color: Colors.red.withOpacity(0.1)),
                        //         child: Padding(
                        //           padding: const EdgeInsets.symmetric(
                        //               horizontal: 20, vertical: 15),
                        //           child: Row(
                        //             children: [
                        //               Expanded(
                        //                 child: Row(
                        //                   mainAxisAlignment:
                        //                       MainAxisAlignment.center,
                        //                   children: [
                        //                     const Icon(Iconsax.shield_cross),
                        //                     const SizedBox(width: 5),
                        //                     SizedBox(
                        //                       width: MediaQuery.of(context)
                        //                               .size
                        //                               .width *
                        //                           0.7, // Adjust the width as needed
                        //                       child: const Text(
                        //                         "No response found from Govt agency !!",
                        //                         maxLines: 1,
                        //                         overflow: TextOverflow.ellipsis,
                        //                       ),
                        //                     ),
                        //                   ],
                        //                 ),
                        //               ),
                        //             ],
                        //           ),
                        //         ),
                        //       ),
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

  void toggleContainerVisibility() {
    setState(() {
      isNGOExpanded = !isNGOExpanded;
    });
  }

  //to fetch requested citizen details
  Future<void> fetchReqData() async {
    final SharedPreferences sharedPref = await SharedPreferences.getInstance();
    var obtainedUserType = sharedPref.getString("userType");
    setState(() {
      finalUserType = obtainedUserType;
      if (finalUserType == "NGO") {
        isNGO = true;
      } else {
        isGovt = true;
      }
    });
    try {
      // Fetch data from Firestore
      DocumentSnapshot ReqSnapshot = await FirebaseFirestore.instance
          .collection('clc_request')
          .doc(widget.documentSnapshot['RequestId'])
          .get();

      // Check if the document exists
      if (ReqSnapshot.exists) {
        // Access the fields from the document
        setState(() {
          fetchedRid = ReqSnapshot.get('RequestId');
          fetchedService = ReqSnapshot.get('neededService');
          fetchedUsername = ReqSnapshot.get('userName');
          fetchedCitizenContactNo = ReqSnapshot.get('contactNumber');
          fetchedCitizenState = ReqSnapshot.get('state');
          fetchedCitizenCity = ReqSnapshot.get('city');
          fetchedReqAddress = ReqSnapshot.get('fullAddress');
          fetchedPincode = ReqSnapshot.get('pinCode');
          fetchedReqTime =
              ReqSnapshot.get('reqTime').toString().substring(0, 16);
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
}
