// ignore_for_file: use_build_context_synchronously, non_constant_identifier_names
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fff/Citizen%20Related/Screens/citizen_home_screen/home_screen_citizen.dart';
import 'package:fff/Utils/Utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../citizen_signUp_screen/citizen_signup.dart';

// ignore: must_be_immutable
class OtpScreen extends StatefulWidget {
  bool _isInit = true; // Flag to track the initialization state
  var _contact = ''; // Variable to store the contact number
  //bool isUserRegOrNot = false;

  OtpScreen({super.key}); // Constructor

  @override
  // ignore: library_private_types_in_public_api
  _OtpScreenState createState() => _OtpScreenState(); // Create state object
}

class _OtpScreenState extends State<OtpScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  late String phoneNo; // Variable to store phone number
  late String smsOTP = ''; // Variable to store OTP
  late String onChnaged_input_OTPField; // Variable to store changed OTP
  late String verificationId; // Variable to store verification ID
  String errorMessage = ''; // Variable to store error message

  bool isUserRegOrNot = false; // Firebase authentication instance

  // Method to initialize data
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Load data only once after screen load
    if (widget._isInit) {
      final arguments = ModalRoute.of(context)?.settings.arguments;
      if (arguments != null && arguments is String) {
        widget._contact = arguments; // Store contact number
        generateOtp(widget._contact); // Generate OTP
        widget._isInit = false; // Update initialization flag
      } else {
        if (kDebugMode) {
          print("!!! Mobile number isn't correctly passed to this screen !!!");
        }
      }
    }
  }

  // Dispose controllers
  @override
  void dispose() {
    super.dispose();
  }

  // Build method for UI
  @override
  Widget build(BuildContext context) {
    // Getting screen height
    final screenHeight = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(16.0),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: screenHeight * 0.01,
                  ),
                  const Text("Check Your Inbox",
                      style:
                          TextStyle(fontSize: 34, fontWeight: FontWeight.w600)),
                  const SizedBox(
                    height: 0,
                  ),
                  Lottie.asset("assets/json/otp_lottie.json",
                      width: 300, height: 300, fit: BoxFit.fitWidth),
                  const Text(
                    'Verification process : ',
                    style: TextStyle(fontSize: 26),
                  ),
                  SizedBox(
                    height: screenHeight * 0.01,
                  ),
                  Text(
                    'Enter 6 digit OTP that was \nsent to : ${widget._contact}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 17,
                    ),
                  ),
                  SizedBox(
                    height: screenHeight * 0.01,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 15),
                    padding: const EdgeInsets.all(5.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        OtpTextField(
                          numberOfFields: 6,
                          fillColor: Colors.deepPurple.withOpacity(0.1),
                          filled: true,
                          onSubmit: (code) {
                            smsOTP = code; // Store entered OTP
                          },
                          onCodeChanged: (value) {
                            smsOTP = value; // Store changed OTP
                            onChnaged_input_OTPField =
                                value; // Store changed OTP
                          },
                        ),
                        SizedBox(
                          height: screenHeight * 0.03,
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context); // Pop the current screen
                            },
                            child: const Text(
                              "Didn't get an OTP ? \n Resend Code ",
                              textAlign: TextAlign.center,
                            )),
                        SizedBox(
                          height: screenHeight * 0.05,
                        ),
                        Container(
                          padding: const EdgeInsets.only(bottom: 20),
                          width: double.infinity,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: ElevatedButton(
                                  onPressed: () {
                                    verifyOtp(); // Verify OTP
                                  },
                                  child: const Text("Verify .."))),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Method to generate OTP from Firebase
  Future<void> generateOtp(String contact) async {
    smsOTPSent(verId, forceResendingToken) {
      verificationId = verId;
    }

    try {
      // Check if the mobile number exists in the citizen collection
      final DocumentReference citizenRef =
          FirebaseFirestore.instance.collection('clc_citizen').doc(contact);
      // Get the document snapshot
      final DocumentSnapshot citizenSnapshot = await citizenRef.get();

      if (citizenSnapshot.exists) {
        isUserRegOrNot = true;
        // Mobile number not found in the citizen collection
        // You can handle this case accordingly, for example, show an error message
        //showAlertDialog(context, 'Mobile number not registered');
        //return;
      }

      await _auth.verifyPhoneNumber(
        phoneNumber: contact,
        codeAutoRetrievalTimeout: (String verId) {
          verificationId = verId;
        },
        codeSent: smsOTPSent,
        timeout: const Duration(seconds: 60),
        verificationCompleted: (AuthCredential phoneAuthCredential) {},
        verificationFailed: (error) {
          if (kDebugMode) {
            print(error);
          }
        },
      );
    } catch (e) {
      handleError(e as PlatformException);
    }
  }

  // Method to verify OTP entered by user
  Future<void> verifyOtp() async {
    if (smsOTP.isEmpty || smsOTP.length < 6) {
      showAlertDialog(context,
          smsOTP.isEmpty ? 'Code is Empty ..' : 'Enter 6 digits OTP ..');
      return; // Exit the method if OTP is empty or less than 6 digits
    }
    try {
      final AuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: smsOTP,
      );
      final UserCredential user = await _auth.signInWithCredential(credential);
      //SharedPreferences
      final SharedPreferences sharedPref =
          await SharedPreferences.getInstance();
      sharedPref.setString("userType", "Citizen");

      final User? currentUser = _auth.currentUser;
      assert(user.user?.uid == currentUser?.uid);

      // Show circular progress indicator for 1 second
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const Center(
            child: CircularProgressIndicator(color: Colors.white),
          );
        },
      );

      // Delay for 1 second before navigating to the next screen
      await Future.delayed(const Duration(seconds: 1));

      //if its not empty
      if (isUserRegOrNot) {
        showToastMsg("Citizen logged in successfully..");

        Get.offAll(() => const CitizenHomeScreen());
      } else {
        showToastMsg("Complete your profile first ..");
        Get.offAll(
          () => CitizenSignupPageScreen(contactNumber: widget._contact),
        );
      }
    } on PlatformException catch (e) {
      handleError(e);
    } catch (e) {
      // Handle other exceptions
      if (kDebugMode) {
        print('Error: $e');
      }
      showAlertDialog(context, 'Invalid OTP ');
    }
  }

  // Method to handle errors
  void handleError(PlatformException error) {
    switch (error.code) {
      case 'ERROR_INVALID_VERIFICATION_CODE':
        FocusScope.of(context).requestFocus(FocusNode());
        setState(() {
          errorMessage = 'Invalid Code';
        });
        showAlertDialog(context, 'Invalid Code');
        break;
      default:
        showAlertDialog(context, error.message ?? 'Error');
        break;
    }
  }

  // Method to show an alert dialog
  void showAlertDialog(BuildContext context, String message) {
    final CupertinoAlertDialog alert = CupertinoAlertDialog(
      title: const Text('Error : '),
      content: Text('\n$message'),
      actions: <Widget>[
        CupertinoDialogAction(
          isDefaultAction: true,
          child: const Text('Ok'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        )
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
