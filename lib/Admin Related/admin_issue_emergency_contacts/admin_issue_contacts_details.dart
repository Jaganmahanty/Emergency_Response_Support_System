// ignore_for_file: depend_on_referenced_packages, non_constant_identifier_names, deprecated_member_use, use_build_context_synchronously, camel_case_types, avoid_print

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../Utils/Utils.dart';
import '../../Utils/constants.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class Admin_Issue_Contact_Details_Screen extends StatefulWidget {
  final DocumentSnapshot<Object?> documentSnapshot;

  const Admin_Issue_Contact_Details_Screen({
    super.key,
    required this.documentSnapshot,
  });

  @override
  State<Admin_Issue_Contact_Details_Screen> createState() =>
      _Admin_Issue_Contact_Details_ScreenState();
}

class _Admin_Issue_Contact_Details_ScreenState
    extends State<Admin_Issue_Contact_Details_Screen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool isLoading = true;

  String selectedState = '';
  String selectedCity = '';

  String info = '';
  String state = '';
  String city = '';
  String level = '';
  String c1 = '';
  String c2 = '';
  String c3 = '';
  String c4 = '';
  String c5 = '';
  String c6 = '';

  @override
  void initState() {
    super.initState();
    info = widget.documentSnapshot['info'];
    selectedState = widget.documentSnapshot['state'];
    selectedCity = widget.documentSnapshot['city'];
    c1 = widget.documentSnapshot['Contact_1'];
    c2 = widget.documentSnapshot['Contact_2'];
    c3 = widget.documentSnapshot['Contact_3'];
    c4 = widget.documentSnapshot['Contact_4'];
    c5 = widget.documentSnapshot['Contact_5'];
    c6 = widget.documentSnapshot['Contact_6'];
    // Start loading
    Future.delayed(const Duration(milliseconds: 1100), () {
      setState(() {
        setState(() {
          isLoading = false;
        });
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
        title: const Text("Emergency contact details"),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            StreamBuilder(
                              stream: FirebaseFirestore.instance
                                  .collection("clc_emergency_numbers")
                                  .orderBy('sentTime', descending: true)
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.active) {
                                  if (snapshot.hasData) {
                                    var documents = snapshot.data!.docs;
                                    if (documents.isNotEmpty) {
                                      List<DataRow> rows = [
                                        buildSingleRow("1. $c1"),
                                      ];

                                      if (c2.isNotEmpty) {
                                        rows.add(buildSingleRow("2. $c2"));
                                      }
                                      if (c3.isNotEmpty) {
                                        rows.add(buildSingleRow("3. $c3"));
                                      }
                                      if (c4.isNotEmpty) {
                                        rows.add(buildSingleRow("4. $c4"));
                                      }
                                      if (c5.isNotEmpty) {
                                        rows.add(buildSingleRow("5. $c5"));
                                      }
                                      if (c6.isNotEmpty) {
                                        rows.add(buildSingleRow("6. $c6"));
                                      }

                                      return Padding(
                                        padding: const EdgeInsets.only(
                                            left: 15, right: 15, top: 8),
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10),
                                              child: Center(
                                                child: Text(info,
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 20)),
                                              ),
                                            ),
                                            const SizedBox(height: 20),
                                            const Image(
                                              image: AssetImage(
                                                  "assets/images/emergency_contact.png"),
                                              width: 80,
                                              height: 80,
                                            ),
                                            const SizedBox(height: 20),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10),
                                              child: Center(
                                                child: Text(
                                                    " ${widget.documentSnapshot['state']} , ${widget.documentSnapshot['city']}",
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 16)),
                                              ),
                                            ),
                                            const SizedBox(height: 10),
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 20,
                                                      vertical: 8),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(19.0),
                                                border: Border.all(
                                                  color: Colors.grey,
                                                  width: 1.0,
                                                ),
                                              ),
                                              child: DataTable(
                                                columnSpacing: 10.0,
                                                columns: const [
                                                  DataColumn(
                                                      label: Text('Contacts',
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  colorPrimary))),
                                                ],
                                                rows: rows,
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    } else {
                                      return const Center(
                                        child: Text(
                                          'No emergency contact details found !',
                                          style: TextStyle(
                                            fontSize: 19,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      );
                                    }
                                  }
                                } else if (snapshot.hasError) {
                                  showToastMsg(snapshot.error.toString());
                                }
                                return const Center(
                                    child: CircularProgressIndicator());
                              },
                            ),
                            const SizedBox(height: 20),
                            //extra details
                            Align(
                              alignment: AlignmentDirectional.bottomEnd,
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.85,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    const SizedBox(height: 10),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 10),
                                      child: Text(
                                        "Contacts issued at : \t${widget.documentSnapshot['sentTime'].toString().substring(0, 16)}",
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 13),
                                      ),
                                    ),
                                    const SizedBox(height: 15),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 9),
                  Padding(
                    padding:
                        const EdgeInsets.only(right: 5, left: 5, bottom: 0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: ElevatedButton(
                              onPressed: () async {
                                final CupertinoAlertDialog alert =
                                    CupertinoAlertDialog(
                                  title: const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text('Confirm : ',
                                        style: TextStyle(fontSize: 16)),
                                  ),
                                  content: const Text('Delete this Contacts ?'),
                                  actions: <Widget>[
                                    CupertinoDialogAction(
                                      isDefaultAction: true,
                                      child: const Text('Cancel'),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    CupertinoDialogAction(
                                      isDefaultAction: true,
                                      child: const Text('Delete'),
                                      onPressed: () async {
                                        //delete user
                                        deleteContact();
                                        Navigator.pop(context, true);
                                        showDialog(
                                          context: context,
                                          barrierDismissible: false,
                                          builder: (BuildContext context) {
                                            return const Center(
                                              child: CircularProgressIndicator(
                                                  color: Colors.white),
                                            );
                                          },
                                        );
                                        await Future.delayed(
                                            const Duration(milliseconds: 1100));
                                        Navigator.pop(context);
                                        Navigator.pop(context, true);
                                      },
                                    )
                                  ],
                                );
                                // Show the dialog
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return alert;
                                  },
                                );
                              },
                              style: ButtonStyle(
                                backgroundColor: MaterialStatePropertyAll(
                                    Colors.red.shade400),
                                shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18),
                                )),
                              ),
                              child: const Text("Delete"),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
    );
  }

  void deleteContact() async {
    try {
      Map<String, dynamic> updatedData = {'isVisible': "false"};
      // Delete user
      DocumentReference userRef = FirebaseFirestore.instance
          .collection('clc_emergency_numbers')
          .doc(widget.documentSnapshot['ContactId']);
      await userRef
          .update(updatedData)
          .then((value) => showToastMsg("Contact deleted successfully"));
    } catch (error) {
      if (kDebugMode) {
        print("Error deleting contact: $error");
      }
      showToastMsg("Failed to delete contact");
    }
  }

  Future<String?> uploadImageToStorage(File imageFile) async {
    try {
      firebase_storage.Reference storageRef = firebase_storage
          .FirebaseStorage.instance
          .ref()
          .child('citizen')
          .child(widget.documentSnapshot["phoneNumber"])
          .child('${DateTime.now().microsecondsSinceEpoch}.jpg');

      firebase_storage.UploadTask uploadTask = storageRef.putFile(imageFile);
      await uploadTask
          .whenComplete(() => print("Profile picture uploaded to Storage"));
      String imageURL = await storageRef.getDownloadURL();
      return imageURL;
    } catch (e) {
      if (kDebugMode) {
        print("Error while uploading profile picture : $e");
      }
    }
    return null;
  }

  uploadDataToFirestore(String imageUrl) async {
    try {
      await FirebaseFirestore.instance
          .collection("clc_citizen")
          .doc(widget.documentSnapshot["phoneNumber"])
          .update({"profilePic": imageUrl});
    } catch (e) {
      // An error occurred
      if (kDebugMode) {
        print('Error adding picture data to firestore : $e');
      }
    }
  }
}
