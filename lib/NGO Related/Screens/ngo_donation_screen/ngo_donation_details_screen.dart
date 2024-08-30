// ignore_for_file: depend_on_referenced_packages, non_constant_identifier_names, deprecated_member_use, use_build_context_synchronously, camel_case_types

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NGO_Donation_Details_Screen extends StatefulWidget {
  final DocumentSnapshot<Object?> documentSnapshot;

  const NGO_Donation_Details_Screen({
    super.key,
    required this.documentSnapshot,
  });

  @override
  State<NGO_Donation_Details_Screen> createState() =>
      _NGO_Donation_Details_ScreenState();
}

class _NGO_Donation_Details_ScreenState
    extends State<NGO_Donation_Details_Screen> {
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
                                    const Icon(CupertinoIcons.person_alt),
                                    const SizedBox(width: 12),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text("Doner Name :",
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
                                                        'donerName'],
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
                                    const ImageIcon(
                                      AssetImage('assets/images/upi_icon.png'),
                                    ),
                                    const SizedBox(width: 12),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text("Citizen UPI id :",
                                            style: TextStyle(fontSize: 13)),
                                        const SizedBox(height: 4),
                                        Text(widget.documentSnapshot['upiId'],
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
                              ],
                            ),
                          ),
                        ),
                      ],
                    )),
                  ),
                ],
              ),
            ),
    );
  }
}
