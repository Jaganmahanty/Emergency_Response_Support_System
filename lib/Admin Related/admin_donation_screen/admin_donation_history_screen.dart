// ignore_for_file: camel_case_types

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../Utils/Utils.dart';
import 'admin_donation_details_screen.dart';

class Admin_Donation_History_Screen extends StatefulWidget {
  const Admin_Donation_History_Screen({super.key});

  @override
  State<Admin_Donation_History_Screen> createState() =>
      _Admin_Donation_History_ScreenState();
}

class _Admin_Donation_History_ScreenState
    extends State<Admin_Donation_History_Screen> {
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
        title: const Text("Donation History"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: RefreshIndicator(
          onRefresh: _refreshData,
          child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("clc_donation")
                  .orderBy('txnTime', descending: true)
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
                                'No donation data found !',
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
                                    snapshot.data!.docs[index]['txnTime'];
                                    return GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).push(
                                          PageRouteBuilder(
                                            pageBuilder: (context, animation,
                                                    secondaryAnimation) =>
                                                Admin_Donation_Details_Screen(
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
                                                    title: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        const Text(
                                                            "Doner name : ",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 13)),
                                                        const SizedBox(
                                                            height: 3),
                                                        Text(
                                                            snapshot.data!
                                                                    .docs[index]
                                                                ['donerName'],
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
                                                          "NGO Name : ",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black),
                                                        ),
                                                        Text(
                                                            snapshot.data!
                                                                    .docs[index]
                                                                ['NGOName'],
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
                                                          "Amount : ",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black),
                                                        ),
                                                        Text(
                                                            "${snapshot.data!
                                                                .docs[index]
                                                            ['amount']} /-",
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
                                                          "Payment Mode : ",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black),
                                                        ),
                                                        Text(
                                                            snapshot.data!
                                                                    .docs[index]
                                                                ['mode'],
                                                            style: const TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold)),
                                                      ],
                                                    ),
                                                  ),
                                                  const SizedBox(height: 4),
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
                                                            snapshot
                                                                .data!
                                                                .docs[index]
                                                                    ['txnTime']
                                                                .toString()
                                                                .substring(
                                                                    0, 16),
                                                            style:
                                                                const TextStyle(
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
