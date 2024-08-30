import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../../Utils/constants.dart';
import 'citizen_disaster_list.dart';

class Display extends StatefulWidget {
  final DisasterList disasterList;

  const Display({Key? key, required this.disasterList}) : super(key: key);

  @override
  State<Display> createState() => _DisplayState();
}

class _DisplayState extends State<Display> {
  String fetchedDid = "";
  String fetchedType = "";

  String fetchedDos1 = "";
  String fetchedDos2 = "";
  String fetchedDos3 = "";

  String fetchedDonts1 = "";
  String fetchedDonts2 = "";
  String fetchedDonts3 = "";

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

  bool isLoading = true;

  @override
  void initState() {
    fetchGuideData().then((value) => setState(() {
          isLoading = false;
        }));
    super.initState();
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
        title: const Text("Digital Survival Guide"),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 15, bottom: 20, left: 15, right: 15),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              fetchedType,
                              style: const TextStyle(
                                  color: Color((0xff7871db)),
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600),
                            ),
                            const Divider(height: 14),
                            const SizedBox(height: 20),
                            const Text(
                              'Do\'s',
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                  color: Colors.green,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500),
                            ),
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
                                                    0.64,
                                                // Adjust the width as needed
                                                child: Text(
                                                  textAlign: TextAlign.justify,
                                                  fetchedDos1,
                                                  maxLines: 3,
                                                  overflow:
                                                      TextOverflow.ellipsis,
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
                                                    0.64,
                                                // Adjust the width as needed
                                                child: Text(
                                                  fetchedDos2,
                                                  textAlign: TextAlign.justify,
                                                  maxLines: 3,
                                                  overflow:
                                                      TextOverflow.ellipsis,
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
                                                    0.64,
                                                // Adjust the width as needed
                                                child: Text(
                                                  fetchedDos3,
                                                  textAlign: TextAlign.justify,
                                                  maxLines: 3,
                                                  overflow:
                                                      TextOverflow.ellipsis,
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
                              'Don\'ts',
                              style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(height: 20),
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
                                                    0.64,
                                                // Adjust the width as needed
                                                child: Text(
                                                  fetchedDonts1,
                                                  textAlign: TextAlign.justify,
                                                  maxLines: 3,
                                                  overflow:
                                                      TextOverflow.ellipsis,
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
                                                    0.64,
                                                // Adjust the width as needed
                                                child: Text(
                                                  fetchedDonts2,
                                                  textAlign: TextAlign.justify,
                                                  maxLines: 3,
                                                  overflow:
                                                      TextOverflow.ellipsis,
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
                                                    0.64,
                                                // Adjust the width as needed
                                                child: Text(
                                                  fetchedDonts3,
                                                  textAlign: TextAlign.justify,
                                                  maxLines: 3,
                                                  overflow:
                                                      TextOverflow.ellipsis,
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
                                  fontSize: 18, fontWeight: FontWeight.w500),
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
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 16,
                                                        color:
                                                            Colors.deepPurple)),
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
                                              const Icon(
                                                  Iconsax.arrow_circle_right),
                                              const SizedBox(width: 5),
                                              SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.64,
                                                // Adjust the width as needed
                                                child: Text(
                                                  fetchedDuring1,
                                                  textAlign: TextAlign.justify,
                                                  maxLines: 5,
                                                  overflow:
                                                      TextOverflow.ellipsis,
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
                                              const Icon(
                                                  Iconsax.arrow_circle_right),
                                              const SizedBox(width: 5),
                                              SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.64,
                                                // Adjust the width as needed
                                                child: Text(
                                                  fetchedDuring2,
                                                  textAlign: TextAlign.justify,
                                                  maxLines: 5,
                                                  overflow:
                                                      TextOverflow.ellipsis,
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
                                              const Icon(
                                                  Iconsax.arrow_circle_right),
                                              const SizedBox(width: 5),
                                              SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.64,
                                                // Adjust the width as needed
                                                child: Text(
                                                  fetchedDuring3,
                                                  textAlign: TextAlign.justify,
                                                  maxLines: 5,
                                                  overflow:
                                                      TextOverflow.ellipsis,
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
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 16,
                                                        color:
                                                            Colors.deepPurple)),
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
                                              const Icon(
                                                  Iconsax.arrow_circle_right),
                                              const SizedBox(width: 5),
                                              SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.64,
                                                // Adjust the width as needed
                                                child: Text(
                                                  fetchedBefore1,
                                                  textAlign: TextAlign.justify,
                                                  maxLines: 5,
                                                  overflow:
                                                      TextOverflow.ellipsis,
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
                                              const Icon(
                                                  Iconsax.arrow_circle_right),
                                              const SizedBox(width: 5),
                                              SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.64,
                                                // Adjust the width as needed
                                                child: Text(
                                                  fetchedBefore2,
                                                  textAlign: TextAlign.justify,
                                                  maxLines: 5,
                                                  overflow:
                                                      TextOverflow.ellipsis,
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
                                              const Icon(
                                                  Iconsax.arrow_circle_right),
                                              const SizedBox(width: 5),
                                              SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.64,
                                                // Adjust the width as needed
                                                child: Text(
                                                  fetchedBefore3,
                                                  textAlign: TextAlign.justify,
                                                  maxLines: 5,
                                                  overflow:
                                                      TextOverflow.ellipsis,
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
                                              const Icon(
                                                  Iconsax.arrow_circle_right),
                                              const SizedBox(width: 5),
                                              SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.64,
                                                // Adjust the width as needed
                                                child: Text(
                                                  fetchedBefore4,
                                                  textAlign: TextAlign.justify,
                                                  maxLines: 5,
                                                  overflow:
                                                      TextOverflow.ellipsis,
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
                                              const Icon(
                                                  Iconsax.arrow_circle_right),
                                              const SizedBox(width: 5),
                                              SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.64,
                                                // Adjust the width as needed
                                                child: Text(
                                                  fetchedBefore5,
                                                  textAlign: TextAlign.justify,
                                                  maxLines: 5,
                                                  overflow:
                                                      TextOverflow.ellipsis,
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
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 16,
                                                        color:
                                                            Colors.deepPurple)),
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
                                              const Icon(
                                                  Iconsax.arrow_circle_right),
                                              const SizedBox(width: 5),
                                              SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.64,
                                                // Adjust the width as needed
                                                child: Text(
                                                  fetchedAfter1,
                                                  textAlign: TextAlign.justify,
                                                  maxLines: 5,
                                                  overflow:
                                                      TextOverflow.ellipsis,
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
                                              const Icon(
                                                  Iconsax.arrow_circle_right),
                                              const SizedBox(width: 5),
                                              SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.64,
                                                // Adjust the width as needed
                                                child: Text(
                                                  fetchedAfter2,
                                                  textAlign: TextAlign.justify,
                                                  maxLines: 5,
                                                  overflow:
                                                      TextOverflow.ellipsis,
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
                                              const Icon(
                                                  Iconsax.arrow_circle_right),
                                              const SizedBox(width: 5),
                                              SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.64,
                                                // Adjust the width as needed
                                                child: Text(
                                                  fetchedAfter3,
                                                  textAlign: TextAlign.justify,
                                                  maxLines: 5,
                                                  overflow:
                                                      TextOverflow.ellipsis,
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
                                              const Icon(
                                                  Iconsax.arrow_circle_right),
                                              const SizedBox(width: 5),
                                              SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.64,
                                                // Adjust the width as needed
                                                child: Text(
                                                  fetchedAfter4,
                                                  textAlign: TextAlign.justify,
                                                  maxLines: 5,
                                                  overflow:
                                                      TextOverflow.ellipsis,
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
                                              const Icon(
                                                  Iconsax.arrow_circle_right),
                                              const SizedBox(width: 5),
                                              SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.64,
                                                // Adjust the width as needed
                                                child: Text(
                                                  fetchedAfter5,
                                                  textAlign: TextAlign.justify,
                                                  maxLines: 5,
                                                  overflow:
                                                      TextOverflow.ellipsis,
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
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Future<void> fetchGuideData() async {
    try {
      // Fetch data from Firestore
      QuerySnapshot guideQuery = await FirebaseFirestore.instance
          .collection('clc_dos_donts')
          .where('typeOfDisaster', isEqualTo: widget.disasterList.disaster)
          .get();

      // Check if the document exists
      if (guideQuery.docs.isNotEmpty) {
        DocumentSnapshot guideSnap = guideQuery.docs.first;
        // Access the fields from the document
        setState(() {
          fetchedDid = guideSnap.get('did');
          fetchedType = guideSnap.get('typeOfDisaster');
          fetchedDos1 = guideSnap.get('dos_1');
          fetchedDos2 = guideSnap.get('dos_2');
          fetchedDos3 = guideSnap.get('dos_3');
          fetchedDonts1 = guideSnap.get('donts_1');
          fetchedDonts2 = guideSnap.get('donts_2');
          fetchedDonts3 = guideSnap.get('donts_3');

          fetchedBefore1 = guideSnap.get('Before_1');
          fetchedBefore2 = guideSnap.get('Before_2');
          fetchedBefore3 = guideSnap.get('Before_3');
          fetchedBefore4 = guideSnap.get('Before_4');
          fetchedBefore5 = guideSnap.get('Before_5');

          fetchedAfter1 = guideSnap.get('After_1');
          fetchedAfter2 = guideSnap.get('After_2');
          fetchedAfter3 = guideSnap.get('After_3');
          fetchedAfter4 = guideSnap.get('After_4');
          fetchedAfter5 = guideSnap.get('After_5');

          fetchedDuring1 = guideSnap.get('During_1');
          fetchedDuring2 = guideSnap.get('During_2');
          fetchedDuring3 = guideSnap.get('During_3');
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
