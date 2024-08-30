// ignore_for_file: non_constant_identifier_names, camel_case_types

import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../../Models/citizen_donation_model.dart';
import '../../../Utils/Utils.dart';

class Citizen_Donate_Screen extends StatefulWidget {
  final String authority_name;
  final String authority_id;
  final String authority_email;
  final String authority_upi;

  const Citizen_Donate_Screen(
      {super.key,
      required this.authority_name,
      required this.authority_id,
      required this.authority_email,
      required this.authority_upi});

  @override
  State<Citizen_Donate_Screen> createState() => _Citizen_Donate_ScreenState();
}

class _Citizen_Donate_ScreenState extends State<Citizen_Donate_Screen> {
  bool isLoading = true;
  bool _isProcessing = false;
  int? type = 1;

  bool showGPayTextField = false;
  bool showPaytmTextField = false;
  bool showPhonePeTextField = false;
  String uniqueTxnId = '';
  String Mode = "GPay";

  final TextEditingController _controllerPay = TextEditingController();
  final TextEditingController _gPayController = TextEditingController();
  final TextEditingController _paytmController = TextEditingController();
  final TextEditingController _phonePeController = TextEditingController();
  TextEditingController uploadUpiController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final _GpayformKey = GlobalKey<FormState>();
  final _PatymformKey = GlobalKey<FormState>();
  final _PhonePeformKey = GlobalKey<FormState>();
  GlobalKey<FormState> _selectedFormkey = GlobalKey<FormState>();

  String fetchedCid = '';
  String fetchedFname = '';

  @override
  void initState() {
    super.initState();
    fetchCitizenData();
    Future.delayed(const Duration(milliseconds: 1300))
        .then((value) => setState(() {
              isLoading = false;
              showGPayTextField = true;
              _selectedFormkey = _GpayformKey;
              uploadUpiController = _gPayController;
            }));
    // print(widget.authority_name);
    // print(widget.authority_id);
    // print(widget.authority_email);
    uniqueTxnId = generateTransactionNumber();
    // print(uniqueTxnId);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 50,
        backgroundColor: Colors.black12,
        centerTitle: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(25),
                bottomLeft: Radius.circular(25))),
        title: const Text("Donate to Authority here"),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SizedBox(
              child: widget.authority_upi.isEmpty
                  ? const Center(
                      child: NoUPIFound(),
                    )
                  : Column(
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Column(
                                children: [
                                  const SizedBox(height: 12),
                                  Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: SizedBox(
                                      width: size.width,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Align(
                                            alignment:
                                                AlignmentDirectional.topStart,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10),
                                              child: Text(
                                                'Add Amount to donate : ${widget.authority_name}',
                                                style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 8),
                                          Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Form(
                                              key: _formKey,
                                              child: TextFormField(
                                                controller: _controllerPay,
                                                keyboardType:
                                                    TextInputType.number,
                                                maxLength: 7,
                                                decoration: InputDecoration(
                                                  prefixIcon: const Icon(
                                                      Icons.currency_rupee),
                                                  hintText: 'Enter amount',
                                                  contentPadding:
                                                      const EdgeInsets.all(5.0),
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0),
                                                  ),
                                                ),
                                                onChanged: (value) {
                                                  setState(() {});
                                                },
                                                validator: (value) {
                                                  if (value == null ||
                                                      value.isEmpty) {
                                                    return 'Please enter amount';
                                                  } else if (value.length < 3) {
                                                    return 'Minimum amount is 100 /-';
                                                  }
                                                  return null;
                                                },
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  const Text(
                                      "Choose Payment Method to continue",
                                      style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w600)),
                                  // 3 radio
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: SizedBox(
                                      width: size.width,
                                      child: Column(
                                        children: [
                                          //google pay
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 12),
                                            child: Container(
                                              //margin: EdgeInsets.only(right: 20),
                                              width: size.width,
                                              height: 50,
                                              decoration: BoxDecoration(
                                                border: type == 1
                                                    ? Border.all(
                                                        width: 1,
                                                        color: const Color(
                                                            0xFFDB3022),
                                                      )
                                                    : Border.all(
                                                        width: 0.4,
                                                        color: Colors.grey),
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                color: Colors.transparent,
                                              ),
                                              child: Center(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Radio(
                                                          value: 1,
                                                          groupValue: type,
                                                          onChanged: (value) {
                                                            setState(() {
                                                              type = value;
                                                              showGPayTextField =
                                                                  true;
                                                              _selectedFormkey =
                                                                  _GpayformKey; // isExpanded = false;
                                                            });
                                                          },
                                                          activeColor:
                                                              const Color(
                                                                  0xFFDB3022),
                                                        ),
                                                        Text('Google Pay',
                                                            style: type == 1
                                                                ? const TextStyle(
                                                                    fontSize:
                                                                        15,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    color: Colors
                                                                        .black)
                                                                : const TextStyle(
                                                                    fontSize:
                                                                        15,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    color: Colors
                                                                        .grey)),
                                                      ],
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              right: 15.0),
                                                      child: Image.network(
                                                          'https://1000logos.net/wp-content/uploads/2023/03/Google-Pay-logo.png'),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          //paytm
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 12),
                                            child: Container(
                                              //margin: EdgeInsets.only(right: 20),
                                              width: size.width,
                                              height: 50,
                                              decoration: BoxDecoration(
                                                border: type == 2
                                                    ? Border.all(
                                                        width: 1,
                                                        color: const Color(
                                                            0xFFDB3022),
                                                      )
                                                    : Border.all(
                                                        width: 0.4,
                                                        color: Colors.grey),
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                color: Colors.transparent,
                                              ),
                                              child: Center(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Radio(
                                                          value: 2,
                                                          groupValue: type,
                                                          onChanged: (value) {
                                                            setState(() {
                                                              type = value;
                                                              showPaytmTextField =
                                                                  true;
                                                              _selectedFormkey =
                                                                  _PatymformKey;
                                                              uploadUpiController =
                                                                  _paytmController;
                                                              Mode = "Paytm";
                                                            });
                                                          },
                                                          activeColor:
                                                              const Color(
                                                                  0xFFDB3022),
                                                        ),
                                                        Text('Paytm',
                                                            style: type == 2
                                                                ? const TextStyle(
                                                                    fontSize:
                                                                        15,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    color: Colors
                                                                        .black)
                                                                : const TextStyle(
                                                                    fontSize:
                                                                        15,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    color: Colors
                                                                        .grey)),
                                                      ],
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              right: 15.0),
                                                      child: Image.network(
                                                          'https://upload.wikimedia.org/wikipedia/commons/thumb/2/24/Paytm_Logo_%28standalone%29.svg/2560px-Paytm_Logo_%28standalone%29.svg.png',
                                                          height: 20),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          //phone pe
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 12),
                                            child: Container(
                                              //margin: EdgeInsets.only(right: 20),
                                              width: size.width,
                                              height: 50,
                                              decoration: BoxDecoration(
                                                border: type == 3
                                                    ? Border.all(
                                                        width: 1,
                                                        color: const Color(
                                                            0xFFDB3022),
                                                      )
                                                    : Border.all(
                                                        width: 0.4,
                                                        color: Colors.grey),
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                color: Colors.transparent,
                                              ),
                                              child: Center(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Radio(
                                                          value: 3,
                                                          groupValue: type,
                                                          onChanged: (value) {
                                                            setState(() {
                                                              type = value;
                                                              showPhonePeTextField =
                                                                  true;
                                                              _selectedFormkey =
                                                                  _PhonePeformKey;
                                                              uploadUpiController =
                                                                  _phonePeController;
                                                              Mode = "PhonePe";
                                                            });
                                                          },
                                                          activeColor:
                                                              const Color(
                                                                  0xFFDB3022),
                                                        ),
                                                        Text('Phone pe',
                                                            style: type == 3
                                                                ? const TextStyle(
                                                                    fontSize:
                                                                        15,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    color: Colors
                                                                        .black)
                                                                : const TextStyle(
                                                                    fontSize:
                                                                        15,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    color: Colors
                                                                        .grey)),
                                                      ],
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              right: 15.0),
                                                      child: Image.network(
                                                          'https://upload.wikimedia.org/wikipedia/commons/thumb/7/71/PhonePe_Logo.svg/1280px-PhonePe_Logo.svg.png',
                                                          height: 25),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          //credit card
                                          // Padding(
                                          //   padding: const EdgeInsets.symmetric(
                                          //       horizontal: 10, vertical: 12),
                                          //   child: Container(
                                          //     //margin: EdgeInsets.only(right: 20),
                                          //     width: size.width,
                                          //     height: 50,
                                          //     decoration: BoxDecoration(
                                          //       border: type == 4
                                          //           ? Border.all(
                                          //               width: 1,
                                          //               color:
                                          //                   const Color(0xFFDB3022),
                                          //             )
                                          //           : Border.all(
                                          //               width: 0.4,
                                          //               color: Colors.grey),
                                          //       borderRadius:
                                          //           BorderRadius.circular(15),
                                          //       color: Colors.transparent,
                                          //     ),
                                          //     child: Center(
                                          //       child: Row(
                                          //         mainAxisAlignment:
                                          //             MainAxisAlignment.spaceBetween,
                                          //         children: [
                                          //           Row(
                                          //             children: [
                                          //               Radio(
                                          //                 value: 4,
                                          //                 groupValue: type,
                                          //                 onChanged: handle_radio,
                                          //                 activeColor:
                                          //                     const Color(0xFFDB3022),
                                          //               ),
                                          //               Text('Credit card',
                                          //                   style: type == 4
                                          //                       ? const TextStyle(
                                          //                           fontSize: 15,
                                          //                           fontWeight:
                                          //                               FontWeight
                                          //                                   .w500,
                                          //                           color:
                                          //                               Colors.black)
                                          //                       : const TextStyle(
                                          //                           fontSize: 15,
                                          //                           fontWeight:
                                          //                               FontWeight
                                          //                                   .w500,
                                          //                           color:
                                          //                               Colors.grey)),
                                          //             ],
                                          //           ),
                                          //           Padding(
                                          //             padding: const EdgeInsets.only(
                                          //                 right: 15.0),
                                          //             child: Image.network(
                                          //                 'https://i.pngimg.me/thumb/f/720/comdlpng6953127.jpg',
                                          //                 height: 25),
                                          //           )
                                          //         ],
                                          //       ),
                                          //     ),
                                          //   ),
                                          // ),
                                          const SizedBox(height: 10),
                                          if (type == 1)
                                            AnimatedSize(
                                              duration: const Duration(
                                                  milliseconds: 300),
                                              curve: Curves.easeInOut,
                                              //vsync: this,
                                              child: Form(
                                                key: _GpayformKey,
                                                child: SizedBox(
                                                  //height: isExpanded ? null : 0,
                                                  child: AnimatedOpacity(
                                                    opacity: showGPayTextField
                                                        ? 1.0
                                                        : 0.0,
                                                    duration: const Duration(
                                                        milliseconds: 300),
                                                    child: Column(
                                                      children: [
                                                        const Align(
                                                          alignment:
                                                              AlignmentDirectional
                                                                  .topStart,
                                                          child: Text(
                                                              "Enter your Google Pay UPI id : ",
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      14)),
                                                        ),
                                                        const SizedBox(
                                                            height: 20),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  horizontal:
                                                                      5.0),
                                                          child: TextFormField(
                                                            controller:
                                                                _gPayController,
                                                            decoration:
                                                                InputDecoration(
                                                                    enabledBorder:
                                                                        const OutlineInputBorder()
                                                                            .copyWith(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              24),
                                                                      borderSide: const BorderSide(
                                                                          width:
                                                                              1,
                                                                          color:
                                                                              Colors.green),
                                                                    ),
                                                                    hintText:
                                                                        'Enter your Google Pay id',
                                                                    prefixIcon: const Icon(
                                                                        CupertinoIcons
                                                                            .pencil_ellipsis_rectangle),
                                                                    labelText:
                                                                        'Google Pay id'),
                                                            validator: type == 1
                                                                ? upiIdValidator
                                                                : null,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          if (type == 2)
                                            AnimatedSize(
                                              duration: const Duration(
                                                  milliseconds: 300),
                                              curve: Curves.easeInOut,
                                              //vsync: this,
                                              child: Form(
                                                key: _PatymformKey,
                                                child: SizedBox(
                                                  child: AnimatedOpacity(
                                                    opacity: showPaytmTextField
                                                        ? 1.0
                                                        : 0.0,
                                                    duration: const Duration(
                                                        milliseconds: 300),
                                                    child: Column(
                                                      children: [
                                                        const Align(
                                                          alignment:
                                                              AlignmentDirectional
                                                                  .topStart,
                                                          child: Text(
                                                              "Enter your Paytm upi id : ",
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      15)),
                                                        ),
                                                        const SizedBox(
                                                            height: 20),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  horizontal:
                                                                      5.0),
                                                          child: TextFormField(
                                                            controller:
                                                                _paytmController,
                                                            decoration:
                                                                InputDecoration(
                                                                    enabledBorder:
                                                                        const OutlineInputBorder()
                                                                            .copyWith(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              24),
                                                                      borderSide: const BorderSide(
                                                                          width:
                                                                              1,
                                                                          color:
                                                                              Colors.green),
                                                                    ),
                                                                    hintText:
                                                                        'Enter your Paytm upi',
                                                                    prefixIcon: const Icon(
                                                                        CupertinoIcons
                                                                            .pencil_ellipsis_rectangle),
                                                                    labelText:
                                                                        'Paytm upi'),
                                                            validator: type == 2
                                                                ? paytmUpiIdValidator
                                                                : null,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          if (type == 3)
                                            AnimatedSize(
                                              duration: const Duration(
                                                  milliseconds: 300),
                                              curve: Curves.easeInOut,
                                              //vsync: this,
                                              child: Form(
                                                key: _PhonePeformKey,
                                                child: SizedBox(
                                                  child: AnimatedOpacity(
                                                    opacity:
                                                        showPhonePeTextField
                                                            ? 1.0
                                                            : 0.0,
                                                    duration: const Duration(
                                                        milliseconds: 300),
                                                    child: Column(
                                                      children: [
                                                        const Align(
                                                          alignment:
                                                              AlignmentDirectional
                                                                  .topStart,
                                                          child: Text(
                                                              "Enter your Phone pe upi id : ",
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      15)),
                                                        ),
                                                        const SizedBox(
                                                            height: 20),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  horizontal:
                                                                      5.0),
                                                          child: TextFormField(
                                                            controller:
                                                                _phonePeController,
                                                            decoration:
                                                                InputDecoration(
                                                                    enabledBorder:
                                                                        const OutlineInputBorder()
                                                                            .copyWith(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              24),
                                                                      borderSide: const BorderSide(
                                                                          width:
                                                                              1,
                                                                          color:
                                                                              Colors.green),
                                                                    ),
                                                                    hintText:
                                                                        'Enter your Phone pe id',
                                                                    prefixIcon: const Icon(
                                                                        CupertinoIcons
                                                                            .pencil_ellipsis_rectangle),
                                                                    labelText:
                                                                        'Phone pe id'),
                                                            validator: type == 3
                                                                ? phonePeUpiIdValidator
                                                                : null,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          'Donation amount :',
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.grey,
                                              fontStyle: FontStyle.italic),
                                        ),
                                        Text(
                                          _controllerPay.text.isEmpty
                                              ? "₹ 0 /-"
                                              : '₹ ${_controllerPay.text} /-',
                                          style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600),
                                        )
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.only(right: 20, left: 20),
                          child: Container(
                            padding: const EdgeInsets.only(bottom: 15),
                            width: double.infinity,
                            child: ClipRRect(
                              child: ElevatedButton(
                                onPressed: () async {
                                  // print(uploadUpiController.text);
                                  //showCircularProgressBar(context);
                                  // Future.delayed(const Duration(milliseconds: 800))
                                  //     .then((value) => Navigator.pop(context));

                                  if (_formKey.currentState!.validate()) {
                                    if (_selectedFormkey.currentState!
                                        .validate()) {
                                      if (!_isProcessing) {
                                        saveDonation()
                                            .then((value) => _processPayment());
                                      }
                                    }
                                  }
                                },
                                style: ButtonStyle(
                                  shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18),
                                    ),
                                  ),
                                ),
                                child: _isProcessing
                                    ? const SizedBox(
                                        width: 25,
                                        height: 25,
                                        child: CircularProgressIndicator(
                                            color: Colors.green))
                                    : const Text('Pay'),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
            ),
    );
  }

  String? upiIdValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Enter UPI ID';
    }
    RegExp regExp = RegExp(r'^[\w\d]+@[\w\d]+$');
    if (!regExp.hasMatch(value)) {
      return 'Invalid UPI ID';
    }
    return null;
  }

  String? paytmUpiIdValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Enter Paytm UPI ID';
    }
    RegExp regExp = RegExp(r'^\d{10}@paytm$');
    if (!regExp.hasMatch(value)) {
      return 'Invalid Paytm UPI ID';
    }
    return null;
  }

  String? phonePeUpiIdValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Enter PhonePe UPI ID';
    }
    RegExp regExp = RegExp(r'^\w+@\w+$');
    if (!regExp.hasMatch(value)) {
      return 'Invalid PhonePe UPI ID';
    }
    return null;
  }

  Future<void> saveDonation() async {
    setState(() {
      _isProcessing = true;
    });
    try {
      int totalDocCount = 0;
      await FirebaseFirestore.instance.runTransaction((transaction) async {
        // Get the current count of requests
        DocumentSnapshot snapshot = await transaction.get(FirebaseFirestore
            .instance
            .collection("clc_donation")
            .doc("donation_count"));
        totalDocCount = (snapshot.exists) ? snapshot.get('count') : 0;
        totalDocCount++;

        transaction.set(
            FirebaseFirestore.instance
                .collection("clc_donation")
                .doc("donation_count"),
            {'count': totalDocCount});
      });

      Donation_Registration Citizen_Donate = Donation_Registration(
        Donation_id: "Donation_$totalDocCount",
        cid: fetchedCid,
        authority_id: widget.authority_id,
        auth_email: widget.authority_email,
        donerName: fetchedFname,
        NGOName: widget.authority_name,
        Mode: Mode,
        upiId: uploadUpiController.text,
        upiId_ngo: widget.authority_upi,
        Amount: _controllerPay.text,
        TxnId: uniqueTxnId,
      );

      Map<String, dynamic> DonationJson = Citizen_Donate.toJsonDonation();

      await FirebaseFirestore.instance
          .collection("clc_donation")
          .doc("Donation_$totalDocCount")
          .set(DonationJson)
          .then((value) => showToastMsg('Donation success ..'));
    } catch (e) {
      // An error occurred
      if (kDebugMode) {
        print('Error adding donation to firestore : $e');
      }
    }
  }

  void _processPayment() async {
    await Future.delayed(const Duration(milliseconds: 2100));
    setState(() {
      _isProcessing = false;
    });
    // After successful payment
    _showSuccessDialog();
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Iconsax.tick_circle4,
                // Icons.circle_notifications_sharp,
                size: 40,
                // width: 80
              ),
              const SizedBox(height: 20),
              const Text(
                'Donation Completed Successfully',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Thank you for your donation!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  // Navigator.of(context).pop();
                  Navigator.of(context).pop();
                },
                child: const Text('OK',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String generateTransactionNumber() {
    // Generate random alphanumeric string for alphabets
    String randomAlphabets = _generateRandomString(4, true);

    // Generate random string for digits
    String randomDigits = _generateRandomString(4, false);

    // Generate another random alphanumeric string for alphabets
    String randomAlphabets2 = _generateRandomString(4, true);

    // Generate another random string for digits
    String randomDigits2 = _generateRandomString(4, false);

    // Concatenate all parts to create the transaction number
    String transactionNumber =
        '$randomAlphabets$randomDigits$randomAlphabets2$randomDigits2';

    return transactionNumber;
  }

  String _generateRandomString(int length, bool isAlphabets) {
    const alphaChars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    const digitChars = '0123456789';
    final random = Random();

    String chars = isAlphabets ? alphaChars : digitChars;

    return String.fromCharCodes(Iterable.generate(
        length, (_) => chars.codeUnitAt(random.nextInt(chars.length))));
  }

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
          fetchedCid = citizenSnapshot.get('cid');
          fetchedFname = citizenSnapshot.get('firstName') +
              " " +
              citizenSnapshot.get('lastName');
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

class NoUPIFound extends StatelessWidget {
  const NoUPIFound({super.key});

  @override
  Widget build(BuildContext context) {
    // Call showDialog when authority_upi is empty
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: const Text('Warning : '),
            content: const Text("No upi id found for this NGO ,"
                "\n so can't donate ."),
            actions: <Widget>[
              CupertinoDialogAction(
                isDefaultAction: true,
                child: const Text('Close'),
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        },
      );
    });

    // Return an empty SizedBox
    return const SizedBox();
  }
}
