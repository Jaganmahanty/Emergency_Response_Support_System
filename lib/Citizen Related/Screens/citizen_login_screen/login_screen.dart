import 'package:fff/Citizen%20Related/Screens/citizen_login_screen/widget/SignUp_header_widget.dart';
import 'package:fff/Citizen%20Related/Screens/citizen_login_screen/widget/country_picker.dart';
import 'package:fff/Citizen%20Related/Screens/citizen_login_screen/widget/custom_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../Components/Notification_related/notification_services.dart';
import '../../../Utils/constants.dart';

class CitizenLoginScreen extends StatefulWidget {
  const CitizenLoginScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CitizenLoginScreenState createState() => _CitizenLoginScreenState();
}

class _CitizenLoginScreenState extends State<CitizenLoginScreen> {
  NotificationServices notificationServices = NotificationServices();

  final _contactEditingController = TextEditingController();
  var _dialCode = '';

  @override
  //initState method
  void initState() {
    super.initState();

    //for token mechanism
    notificationServices.getDeviceToken().then((value) {
      if (kDebugMode) {
        print('Device token signup : $value');
      }
    });
  }

  // Build method for UI Representation
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.all(15.0),
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 16),
                          child: FormHeaderWidget(
                            image: splash_shape,
                            title: "Get on \nBoard !",
                            subTitle:
                                "Create Your Profile \nwith Mobile no ... ",
                          ),
                        ),
                        SizedBox(
                          height: screenHeight * 0.03,
                        ),
                        Container(
                          padding: const EdgeInsets.all(7.0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16.0)),
                          child: Column(
                            children: [
                              Container(
                                margin: const EdgeInsets.all(8),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15.0),
                                height: 52,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.deepPurple.shade400,
                                  ),
                                  borderRadius: BorderRadius.circular(27),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    // Country picker widget
                                    CountryPicker(
                                      callBackFunction: _callBackFunction,
                                      headerText: 'Select Country',
                                      headerBackgroundColor:
                                          Theme.of(context).primaryColor,
                                      headerTextColor: Colors.white,
                                    ),
                                    SizedBox(
                                      width: screenWidth * 0.02,
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.only(bottom: 10),
                                        child: TextField(
                                          style: const TextStyle(fontSize: 15),
                                          cursorRadius: const Radius.circular(50),
                                          cursorWidth: 3,
                                          onChanged: (String value){
                                            if(value.length == 10){
                                              FocusScope.of(context).unfocus();
                                            }
                                          },
                                          // Close keyboard on editing completed
                                          onEditingComplete: () {
                                            FocusScope.of(context).unfocus();
                                          },
                                          decoration: const InputDecoration(
                                            focusColor: Colors.grey,
                                            hintText: 'Mobile Number',
                                            border: InputBorder.none,
                                            enabledBorder: InputBorder.none,
                                            focusedBorder: InputBorder.none,
                                            contentPadding: EdgeInsets.symmetric(
                                                vertical: 10),
                                          ),
                                          controller: _contactEditingController,
                                          keyboardType: TextInputType.phone,
                                          inputFormatters: [
                                            LengthLimitingTextInputFormatter(10)
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 9),
              // Custom login button
              CustomButton(clickOnLogin),
              // const SizedBox(height: 0),
              // Padding(
              //   padding: const EdgeInsets.only(right: 12,left: 12,bottom: 15),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //     children: [
              //       const Text(
              //         "Don't have an Account ? ",
              //       ),
              //       SizedBox(
              //         height: 35,
              //         width: 120,
              //         child: Stack(
              //           alignment: Alignment.bottomLeft,
              //           children: [
              //             Align(
              //                 alignment: Alignment.topLeft,
              //                 child: TextButton(
              //                     onPressed: () {
              //                       Navigator.pushReplacement(
              //                           context,
              //                           MaterialPageRoute(
              //                             builder: (context) =>
              //                             const CitizenSignupPageScreen(contactNumber: "123"),
              //                           ));
              //                     },
              //                     child: const Text(
              //                       "Sign Up First ! ..",
              //                       // selectionColor: Colors.blueGrey,
              //                     ))),
              //             SvgPicture.asset(svg_for_line, width: 108),
              //           ],
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  // Method called when user clicks on Login button
  Future<void> clickOnLogin(BuildContext context) async {
    // Validate if the mobile number is empty
    if (_contactEditingController.text.isEmpty) {
      showErrorDialog(context, 'Mobile number can\'t be empty.');
    }
    // Validate if the mobile number length is less than 10 digits
    else if (_contactEditingController.text.length < 10) {
      showErrorDialog(
          context, 'Mobile number must have \n  to be of 10 digits.');
    } else {
      // Navigate to OTP screen with the concatenated dial code and mobile number
      final responseMessage = await Navigator.pushNamed(context, '/otpScreen',
          arguments: '$_dialCode${_contactEditingController.text}');
      // Show error dialog if response message is not null
      if (responseMessage != null) {
        // ignore: use_build_context_synchronously
        showErrorDialog(context, responseMessage as String);
      }
    }
  }

  // Callback function of country picker
  void _callBackFunction(String name, String dialCode, String flag) {
    _dialCode = dialCode;
  }

  // Alert dialogue to show error and response
  void showErrorDialog(BuildContext context, String message) {
    // Set up the AlertDialog
    final CupertinoAlertDialog alert = CupertinoAlertDialog(
      title: const Text('Error : '),
      content: Text('\n$message'),
      actions: <Widget>[
        CupertinoDialogAction(
          isDefaultAction: true,
          child: const Text('Okay'),
          onPressed: () {
            Navigator.of(context).pop();
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
  }
}
