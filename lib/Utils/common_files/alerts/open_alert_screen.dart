// ignore_for_file: camel_case_types, non_constant_identifier_names, depend_on_referenced_packages

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fff/Models/alert_opened_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class Open_Alert_Screen extends StatefulWidget {
  final String alertId;
  final String title;
  final String desc;
  final String level;
  final String dos;
  final String donts;

  const Open_Alert_Screen({
    super.key,
    required this.alertId,
    required this.title,
    required this.desc,
    required this.level,
    required this.dos,
    required this.donts,
  });

  @override
  State<Open_Alert_Screen> createState() => _Open_Alert_ScreenState();
}

class _Open_Alert_ScreenState extends State<Open_Alert_Screen> {
  String? finalUserType = "";
  String user_id = "";
  bool isLoading = true;
  String fetchedDid = '';
  String fetchedState = '';

  String fetchedCity = '';

  String fetchedSentTime = '';

  String fetchedDos1 = '';
  String fetchedDonts1 = '';
  String fetchedDos2 = '';
  String fetchedDonts2 = '';
  String fetchedDos3 = '';
  String fetchedDonts3 = '';

  String fetchedBefore1 = "";
  String fetchedBefore2 = "";
  String fetchedBefore3 = "";
  String fetchedBefore4 = "";
  String fetchedBefore5 = "";

  String fetchedAfter1 = "";
  String fetchedAfter2 = "";
  String fetchedAfter3 = "";
  String fetchedAfter4 = "";
  String fetchedAfter5 = "";

  String fetchedDuring1 = "";
  String fetchedDuring2 = "";
  String fetchedDuring3 = "";

  @override
  void initState() {
    super.initState();
    //check if its NGO or Govt
    getUserType();
    fetchAlertDetails().then((value) => fetchDos());
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
        title: const Text("Alert details"),
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
                      const Text("Alert Details : ",
                          style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 18,
                              color: Colors.blueGrey)),
                      const SizedBox(height: 20),
                      //show alert details
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
                                      const Text("type of Disaster :",
                                          style: TextStyle(fontSize: 13)),
                                      const SizedBox(height: 4),
                                      Text(widget.title,
                                          style: const TextStyle(fontSize: 16)),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              const Divider(height: 2),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  const Icon(Iconsax.firstline),
                                  const SizedBox(width: 12),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text("Description :",
                                          style: TextStyle(fontSize: 13)),
                                      const SizedBox(height: 4),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.65,
                                        child: Row(
                                          children: [
                                            Flexible(
                                              child: Text(widget.desc,
                                                  maxLines: 5,
                                                  overflow: TextOverflow.ellipsis,
                                                  style: const TextStyle(
                                                      fontSize: 16)),
                                            ),
                                          ],
                                        ),
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
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.6,
                                        child: const Text("Alert Level :",
                                            style: TextStyle(fontSize: 13)),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(widget.level,
                                          style: const TextStyle(fontSize: 16)),
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
                                      Text(fetchedCity,
                                          style: const TextStyle(fontSize: 16)),
                                    ],
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text("Alert time :",
                                          style: TextStyle(
                                              fontSize: 11,
                                              color: Colors.grey)),
                                      const SizedBox(width: 4),
                                      Text(
                                          DateFormat('dd-MM-yyyy , HH:mm')
                                              .format(DateTime.parse(
                                                  fetchedSentTime)),
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

                      //dos
                      const Text("Dos & Dont's  : ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 17)),
                      const SizedBox(height: 20),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.green.withOpacity(0.3),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 15),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Icon(Iconsax.tick_circle4),
                                        const SizedBox(width: 5),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.7, // Adjust the width as needed
                                          child: Text(
                                            fetchedDos1,
                                            maxLines: 3,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 15),
                              Row(
                                children: [
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Icon(Iconsax.tick_circle4),
                                        const SizedBox(width: 5),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.7, // Adjust the width as needed
                                          child: Text(
                                            fetchedDos2,
                                            maxLines: 3,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 15),
                              Row(
                                children: [
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Icon(Iconsax.tick_circle4),
                                        const SizedBox(width: 5),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.7, // Adjust the width as needed
                                          child: Text(
                                            fetchedDos3,
                                            maxLines: 3,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),

                      //donts
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.red.withOpacity(0.3)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 15),
                          child: Column(
                            children: [
                              Row(
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
                                          child: Text(
                                            fetchedDonts1,
                                            maxLines: 3,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 15),
                              Row(
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
                                          child: Text(
                                            fetchedDonts2,
                                            maxLines: 3,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 15),
                              Row(
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
                                          child: Text(
                                            fetchedDonts3,
                                            maxLines: 3,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Additional Info',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.grey.withOpacity(0.3)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 15),
                          child: Column(
                            children: [
                              //during
                              Row(
                                children: [
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.64,
                                          child: const Text("During :",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 16,
                                                  color: Colors.deepPurple)),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              Row(
                                children: [
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Icon(Iconsax.arrow_circle_right),
                                        const SizedBox(width: 5),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.64,
                                          // Adjust the width as needed
                                          child: Text(fetchedDuring1,
                                              textAlign: TextAlign.justify,
                                              maxLines: 5,
                                              overflow: TextOverflow.ellipsis,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 15),
                              Row(
                                children: [
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Icon(Iconsax.arrow_circle_right),
                                        const SizedBox(width: 5),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.64,
                                          // Adjust the width as needed
                                          child: Text(fetchedDuring2,
                                              textAlign: TextAlign.justify,
                                              maxLines: 5,
                                              overflow: TextOverflow.ellipsis,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 15),
                              Row(
                                children: [
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Icon(Iconsax.arrow_circle_right),
                                        const SizedBox(width: 5),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.64,
                                          // Adjust the width as needed
                                          child: Text(fetchedDuring3,
                                              textAlign: TextAlign.justify,
                                              maxLines: 5,
                                              overflow: TextOverflow.ellipsis,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 25),

                              //before
                              Row(
                                children: [
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.64,
                                          child: const Text("Before :",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 16,
                                                  color: Colors.deepPurple)),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              Row(
                                children: [
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Icon(Iconsax.arrow_circle_right),
                                        const SizedBox(width: 5),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.64,
                                          // Adjust the width as needed
                                          child: Text(fetchedBefore1,
                                              textAlign: TextAlign.justify,
                                              maxLines: 5,
                                              overflow: TextOverflow.ellipsis,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 15),
                              Row(
                                children: [
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Icon(Iconsax.arrow_circle_right),
                                        const SizedBox(width: 5),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.64,
                                          // Adjust the width as needed
                                          child: Text(fetchedBefore2,
                                              textAlign: TextAlign.justify,
                                              maxLines: 5,
                                              overflow: TextOverflow.ellipsis,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 15),
                              Row(
                                children: [
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Icon(Iconsax.arrow_circle_right),
                                        const SizedBox(width: 5),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.64,
                                          // Adjust the width as needed
                                          child: Text(fetchedBefore3,
                                              textAlign: TextAlign.justify,
                                              maxLines: 5,
                                              overflow: TextOverflow.ellipsis,
                                             ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 15),
                              Row(
                                children: [
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Icon(Iconsax.arrow_circle_right),
                                        const SizedBox(width: 5),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.64,
                                          // Adjust the width as needed
                                          child: Text(fetchedBefore4,
                                              textAlign: TextAlign.justify,
                                              maxLines: 5,
                                              overflow: TextOverflow.ellipsis,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 15),
                              Row(
                                children: [
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Icon(Iconsax.arrow_circle_right),
                                        const SizedBox(width: 5),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.64,
                                          // Adjust the width as needed
                                          child: Text(fetchedBefore5,
                                              textAlign: TextAlign.justify,
                                              maxLines: 5,
                                              overflow: TextOverflow.ellipsis,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 25),

                              //after
                              Row(
                                children: [
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.64,
                                          child: const Text("After :",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 16,
                                                  color: Colors.deepPurple)),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              Row(
                                children: [
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Icon(Iconsax.arrow_circle_right),
                                        const SizedBox(width: 5),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.64,
                                          // Adjust the width as needed
                                          child: Text(fetchedAfter1,
                                              textAlign: TextAlign.justify,
                                              maxLines: 5,
                                              overflow: TextOverflow.ellipsis,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 15),
                              Row(
                                children: [
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Icon(Iconsax.arrow_circle_right),
                                        const SizedBox(width: 5),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.64,
                                          // Adjust the width as needed
                                          child: Text(fetchedAfter2,
                                              textAlign: TextAlign.justify,
                                              maxLines: 5,
                                              overflow: TextOverflow.ellipsis,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 15),
                              Row(
                                children: [
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Icon(Iconsax.arrow_circle_right),
                                        const SizedBox(width: 5),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.64,
                                          // Adjust the width as needed
                                          child: Text(fetchedAfter3,
                                              textAlign: TextAlign.justify,
                                              maxLines: 5,
                                              overflow: TextOverflow.ellipsis,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 15),
                              Row(
                                children: [
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Icon(Iconsax.arrow_circle_right),
                                        const SizedBox(width: 5),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.64,
                                          // Adjust the width as needed
                                          child: Text(fetchedAfter4,
                                              textAlign: TextAlign.justify,
                                              maxLines: 5,
                                              overflow: TextOverflow.ellipsis,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 15),
                              Row(
                                children: [
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Icon(Iconsax.arrow_circle_right),
                                        const SizedBox(width: 5),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.64,
                                          // Adjust the width as needed
                                          child: Text(fetchedAfter5,
                                              textAlign: TextAlign.justify,
                                              maxLines: 5,
                                              overflow: TextOverflow.ellipsis,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  //to check usertype
  Future<void> getUserType() async {
    final SharedPreferences sharedPref = await SharedPreferences.getInstance();
    var obtainedUserType = sharedPref.getString("userType");
    setState(() {
      finalUserType = obtainedUserType;
      if (finalUserType == "Citizen") {
        fetchCitizenData().then((value) => addAlertOpenedToDatabase());
      } else if (finalUserType == "NGO") {
        //iAmNGO = 'true';
        fetchNGOData().then((value) => addAlertOpenedToDatabase());
      } else if (finalUserType == "Govt") {
        //iAmGovt = 'true';
        fetchGovtData().then((value) => addAlertOpenedToDatabase());
      }
    });
  }

  //gets data if current user is Citizen
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
          user_id = citizenSnapshot.get('cid');
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
          user_id = NGOSnapshot.get('nid');
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
          user_id = GovtSnapshot.get('gid');
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

//Storing alert open data to database
  void addAlertOpenedToDatabase() async {
    //for unique doc numbering
    int totalDocCount = 0;
    await FirebaseFirestore.instance.runTransaction((transaction) async {
      // Get the current count of requests
      DocumentSnapshot snapshot = await transaction.get(FirebaseFirestore
          .instance
          .collection("clc_opened_alerts")
          .doc("alert_opened_count"));
      totalDocCount = (snapshot.exists) ? snapshot.get('count') : 0;
      totalDocCount++;

      transaction.set(
          FirebaseFirestore.instance.collection("clc_opened_alerts").doc("alert_opened_count"),
          {'count': totalDocCount});
    });

    var AlertOpenDocRef = FirebaseFirestore.instance
        .collection("clc_opened_alerts")
        .doc("Alert_Open_$totalDocCount");

    Alert_Opened_Registration AlertOpenData = Alert_Opened_Registration(
      alert_open_Id: "Alert_Open_$totalDocCount",
      alert_id: "Alert_${widget.alertId}",
      user_id: user_id,
    );

    Map<String, dynamic> AlertOpenJson = AlertOpenData.toJsonOpenAlert();

    try {
      await AlertOpenDocRef.set(AlertOpenJson);
    } catch (e) {
      // An error occurred
      if (kDebugMode) {
        print('Error adding alert open document : $e');
      }
    }
  }

  void fetchDos() async {
    try {
      DocumentSnapshot dosSnap = await FirebaseFirestore.instance
          .collection('clc_dos_donts')
          .doc(fetchedDid)
          .get();
      try {
        if (dosSnap.exists) {
          fetchedDos1 = dosSnap.get("dos_1");
          fetchedDonts1 = dosSnap.get("donts_1");
          fetchedDos2 = dosSnap.get("dos_2");
          fetchedDonts2 = dosSnap.get("donts_2");
          fetchedDos3 = dosSnap.get("dos_3");
          fetchedDonts3 = dosSnap.get("donts_3");

          fetchedBefore1 = dosSnap.get('Before_1');
          fetchedBefore2 = dosSnap.get('Before_2');
          fetchedBefore3 = dosSnap.get('Before_3');
          fetchedBefore4 = dosSnap.get('Before_4');
          fetchedBefore5 = dosSnap.get('Before_5');

          fetchedAfter1 = dosSnap.get('After_1');
          fetchedAfter2 = dosSnap.get('After_2');
          fetchedAfter3 = dosSnap.get('After_3');
          fetchedAfter4 = dosSnap.get('After_4');
          fetchedAfter5 = dosSnap.get('After_5');

          fetchedDuring1 = dosSnap.get('During_1');
          fetchedDuring2 = dosSnap.get('During_2');
          fetchedDuring3 = dosSnap.get('During_3');
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
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching did : $e');
      }
    }
    return null;
  }

  Future<void> fetchAlertDetails() async {
    try {
      DocumentSnapshot alertSnap = await FirebaseFirestore.instance
          .collection('clc_alert')
          .doc("Alert_${widget.alertId}")
          .get();
      try {
        if (alertSnap.exists) {
          fetchedDid = alertSnap.get("did");
          fetchedState = alertSnap.get("state");
          fetchedCity = alertSnap.get("city");
          fetchedSentTime = alertSnap.get("sentTime");
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
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching did : $e');
      }
    }
    return;
  }
}
