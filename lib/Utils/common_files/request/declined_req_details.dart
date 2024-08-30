// ignore_for_file: camel_case_types, non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class Declined_Request_Details_Screen extends StatefulWidget {
  final DocumentSnapshot<Object?> documentSnapshot;

  const Declined_Request_Details_Screen({
    super.key,
    required this.documentSnapshot,
  });

  @override
  State<Declined_Request_Details_Screen> createState() =>
      _Declined_Request_Details_ScreenState();
}

class _Declined_Request_Details_ScreenState
    extends State<Declined_Request_Details_Screen> {
  String fetchedRid = "";
  String fetchedHasNGOResponded = "";
  String fetchedHasGovtResponded = "";
  String fetchedService = "";
  String fetchedUsername = "";
  String fetchedCitizenContactNo = "";
  String fetchedCitizenState = "";
  String fetchedCitizenCity = "";
  String fetchedCitizenPinCode = "";
  String fetchedReqAddress = "";
  String fetchedIsTnxComplete = "";
  int? selectedRadioAddress = 1;
  String fetchedReqTime = "";

  bool isLoading = true;

  @override
  void initState() {
    fetchReqData();
    super.initState();
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
          title: const Text("Declined Details"),
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
                                Row(
                                  children: [
                                    const Icon(Iconsax.hierarchy_square),
                                    const SizedBox(width: 12),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text("Citizen Needed Service :",
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
                                        const Text("Citizen Phone no :",
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
                                        Text(fetchedCitizenCity,
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
                                                fontSize: 10,
                                                color: Colors.grey)),
                                      ],
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),

                        const Text(" The reason of declination : ",
                            style: TextStyle(
                                fontWeight: FontWeight.w900,
                                fontSize: 18,
                                color: Colors.blueGrey)),
                        const SizedBox(height: 15),
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.red.withOpacity(0.1)),
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
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.65,
                                          child: Text(
                                              widget.documentSnapshot[
                                                  'Decline_Reason'],
                                              maxLines: 7,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                  fontSize: 16)),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text("Declined at :",
                                            style: TextStyle(
                                                fontSize: 11,
                                                color: Colors.grey)),
                                        const SizedBox(width: 4),
                                        Text(
                                            widget
                                                .documentSnapshot['DeclineTime']
                                                .toString()
                                                .substring(0, 16),
                                            style: const TextStyle(
                                                fontSize: 10,
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
                  ),
                ),
              ));
  }

  Future<void> fetchReqData() async {
    try {
      // Fetch data from Firestore
      DocumentSnapshot ReqSnapshot = await FirebaseFirestore.instance
          .collection('clc_request')
          .doc("${widget.documentSnapshot['RequestId']}")
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
          fetchedCitizenPinCode = ReqSnapshot.get('pinCode');
          fetchedReqAddress = ReqSnapshot.get('fullAddress');
          fetchedIsTnxComplete = ReqSnapshot.get('isTransactionCompleted');
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
