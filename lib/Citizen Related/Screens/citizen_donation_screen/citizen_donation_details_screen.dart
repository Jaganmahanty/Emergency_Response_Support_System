// ignore_for_file: depend_on_referenced_packages, non_constant_identifier_names, deprecated_member_use, use_build_context_synchronously, camel_case_types

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Citizen_Donation_Details_Screen extends StatefulWidget {
  final DocumentSnapshot<Object?> documentSnapshot;

  const Citizen_Donation_Details_Screen({
    super.key,
    required this.documentSnapshot,
  });

  @override
  State<Citizen_Donation_Details_Screen> createState() =>
      _Citizen_Donation_Details_ScreenState();
}

class _Citizen_Donation_Details_ScreenState
    extends State<Citizen_Donation_Details_Screen> {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
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
        title: const Text("Donation details"),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          const SizedBox(height: 10),
                          const Align(
                            alignment: AlignmentDirectional.topStart,
                            child: Text("Donation Details : ",
                                style: TextStyle(
                                    fontWeight: FontWeight.w900,
                                    fontSize: 18,
                                    color: Colors.blueGrey)),
                          ),
                          const SizedBox(height: 20),
                          Card(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 25, vertical: 15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      const Icon(Icons.description),
                                      const SizedBox(width: 12),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text("Name of NGO :",
                                              style: TextStyle(fontSize: 13)),
                                          const SizedBox(height: 4),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.65,
                                            child: Row(
                                              children: [
                                                Flexible(
                                                  child: Text(
                                                      widget.documentSnapshot[
                                                          'NGOName'],
                                                      overflow:
                                                          TextOverflow.ellipsis,
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
                                      const ImageIcon(
                                        AssetImage(
                                            'assets/images/upi_icon.png'),
                                      ),
                                      const SizedBox(width: 12),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text("NGO UPI id:",
                                              style: TextStyle(fontSize: 13)),
                                          const SizedBox(height: 4),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.65,
                                            child: Row(
                                              children: [
                                                Flexible(
                                                  child: Text(
                                                      widget.documentSnapshot[
                                                          'ngo_upiId'],
                                                      overflow:
                                                          TextOverflow.ellipsis,
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
                                      const Icon(Icons.payment_sharp),
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
                                            child: const Text("Payment Mode :",
                                                style: TextStyle(fontSize: 13)),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(widget.documentSnapshot['mode'],
                                              style: const TextStyle(
                                                  fontSize: 16)),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  const Divider(height: 2),
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      const ImageIcon(
                                        AssetImage(
                                            'assets/images/upi_icon.png'),
                                      ),
                                      const SizedBox(width: 12),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text("Your UPI id :",
                                              style: TextStyle(fontSize: 13)),
                                          const SizedBox(height: 4),
                                          Text(widget.documentSnapshot['upiId'],
                                              style: const TextStyle(
                                                  fontSize: 16)),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  const Divider(height: 2),
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      const Icon(Icons.currency_rupee),
                                      const SizedBox(width: 12),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text("Amount :",
                                              style: TextStyle(fontSize: 13)),
                                          const SizedBox(height: 4),
                                          Text(
                                              "${widget.documentSnapshot['amount']} /-",
                                              style: const TextStyle(
                                                  fontSize: 16)),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  const Divider(height: 2),
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      const ImageIcon(
                                        AssetImage(
                                            'assets/images/transaction_icon.png'),
                                      ),
                                      const SizedBox(width: 12),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text("Transaction id :",
                                              style: TextStyle(fontSize: 13)),
                                          const SizedBox(height: 4),
                                          Text(widget.documentSnapshot['txnId'],
                                              style: const TextStyle(
                                                  fontSize: 16)),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  const Divider(height: 2),
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      const Icon(Icons.watch_later_outlined),
                                      const SizedBox(width: 12),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text("Transaction time :",
                                              style: TextStyle(fontSize: 13)),
                                          const SizedBox(height: 4),
                                          Text(
                                              DateFormat('dd-MM-yyyy , HH:mm')
                                                  .format(DateTime.parse(
                                                      widget.documentSnapshot[
                                                          'txnTime'])),
                                              style: const TextStyle(
                                                  fontSize: 15)),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 5),
                                  // Row(
                                  //   mainAxisAlignment: MainAxisAlignment.end,
                                  //   children: [
                                  //     Column(
                                  //       mainAxisAlignment:
                                  //           MainAxisAlignment.start,
                                  //       crossAxisAlignment:
                                  //           CrossAxisAlignment.start,
                                  //       children: [
                                  //         const Text("Transaction time :",
                                  //             style: TextStyle(
                                  //                 fontSize: 11,
                                  //                 color: Colors.grey)),
                                  //         const SizedBox(width: 4),
                                  //         Text(
                                  //             DateFormat('dd-MM-yyyy , HH:mm')
                                  //                 .format(DateTime.parse(
                                  //                     widget.documentSnapshot[
                                  //                         'txnTime'])),
                                  //             style: const TextStyle(
                                  //                 fontSize: 11,
                                  //                 color: Colors.grey)),
                                  //       ],
                                  //     ),
                                  //   ],
                                  // )
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
    );
  }
}
