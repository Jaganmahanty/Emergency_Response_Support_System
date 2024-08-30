// ignore_for_file: use_build_context_synchronously, non_constant_identifier_names
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../Citizen Related/Screens/citizen_signUp_screen/custom_checkbox_button.dart';
import '../../../Components/Notification_related/notification_services.dart';
import '../../../Models/govt_registration_model.dart';
import '../../../Utils/Utils.dart';
import '../../../Utils/constants.dart';
import '../../../Utils/dropdown_Items.dart';
import '../govt_login_screen/govt_login.dart';

// ignore: must_be_immutable
class GovtSignupPageScreen extends StatefulWidget {
  const GovtSignupPageScreen({Key? key})
      : super(
          key: key,
        );

  @override
  State<GovtSignupPageScreen> createState() => _GovtSignupPageScreenState();
}

class _GovtSignupPageScreenState extends State<GovtSignupPageScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FocusNode _nameFocusNode = FocusNode();
  final FocusNode _regNoFocusNode = FocusNode();
  final FocusNode _servicesFocusNode = FocusNode();
  final FocusNode _contactNoFocusNode = FocusNode();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _websiteFocusNode = FocusNode();

  TextEditingController nameOfGovtTextController = TextEditingController();
  TextEditingController regNoGovtTextController = TextEditingController();
  TextEditingController serviceGovtTextController = TextEditingController();
  TextEditingController contactNoGovtTextController = TextEditingController();
  TextEditingController emailIdGovtTextController = TextEditingController();
  TextEditingController websiteURLGovtTextController = TextEditingController();
  TextEditingController pinCodeGovtTextController = TextEditingController();
  TextEditingController fullAddressGovtTextController = TextEditingController();
  TextEditingController pwdGovtTextController = TextEditingController();
  TextEditingController confirmPwdGovtTextController = TextEditingController();

  String selectedState = '';
  String selectedCity = '';
  String selectedPincode = '';

  List<String> dropdownItemCity = [];

  List<String> dropdownItemPincode = [];

  bool GovtTnC = false;
  bool _obscurePwdText = true;
  bool _obscureConfirmPwdText = true;
  NotificationServices notificationServices = NotificationServices();
  String deviceTokenFound = "";

  @override
  void initState() {
    super.initState();
    selectedState = DropdownItems.dropdownItemState.first;
    updateCityList(selectedState);

    notificationServices.getDeviceToken().then((value) {
      if (kDebugMode) {
        print('Device token signup : $value');
      }
      // Store the device token in the global variable
      deviceTokenFound = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Form(
          key: _formKey,
          child: SizedBox(
            width: double.maxFinite,
            child: Column(
              children: [
                const SizedBox(height: 25),
                Expanded(
                  child: SingleChildScrollView(
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 30),
                      padding: EdgeInsets.only(
                          //for fields that are covered under keyboard
                          bottom: MediaQuery.of(context).viewInsets.bottom,
                          left: 16,
                          right: 16),
                      //padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        children: [
                          const Text(
                            "Create your Account here : ",
                            style: TextStyle(fontSize: 24),
                          ),
                          const SizedBox(height: 9),
                          // const Text("Connect with your city now !",),
                          const SizedBox(height: 50),
                          SvgPicture.asset(svg_for_signup),
                          const SizedBox(height: 30),
                          //govt name
                          Padding(
                            padding: const EdgeInsets.only(right: 5, left: 5),
                            child: TextFormField(
                              focusNode: _nameFocusNode,
                              textCapitalization: TextCapitalization.sentences,
                              controller: nameOfGovtTextController,
                              decoration: const InputDecoration(
                                prefixIcon: Icon(Icons.account_box_outlined,
                                    color: Colors.deepPurple),
                                hintText: "Enter name of Government Agency",
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 18,
                                ),
                                filled: true,
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  _nameFocusNode.requestFocus();
                                  return 'Enter Govt Agency name';
                                }
                                if (value.isNotEmpty && value.length < 3) {
                                  _nameFocusNode.requestFocus();
                                  return 'Minimum 3 Characters required';
                                }
                                return null;
                              },
                              onEditingComplete: () {
                                FocusScope.of(context).nextFocus();
                              },
                            ),
                          ),
                          const SizedBox(height: 12),
                          //govt reg no
                          Padding(
                            padding: const EdgeInsets.only(right: 5, left: 5),
                            child: TextFormField(
                              focusNode: _regNoFocusNode,
                              controller: regNoGovtTextController,
                              maxLength: 10,
                              decoration: const InputDecoration(
                                prefixIcon: Icon(Icons.app_registration,
                                    color: Colors.deepPurple),
                                hintText:
                                    "Enter registration no. of Govt. Agency",
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 18,
                                ),
                                filled: true,
                                // fillColor: Colors.deepPurple,
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  _regNoFocusNode.requestFocus();
                                  return 'Enter Registration No';
                                }

                                RegExp regExp = RegExp(r'^[a-zA-Z]{3}/\d{6}$');

                                // Check if the value matches the pattern
                                if (!regExp.hasMatch(value)) {
                                  _regNoFocusNode.requestFocus();
                                  return 'Invalid registration number';
                                }

                                return null;
                              },
                              onEditingComplete: () {
                                FocusScope.of(context).nextFocus();
                              },
                            ),
                          ),
                          const SizedBox(height: 12),
                          //govt services
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 5,
                              right: 5,
                            ),
                            child: TextFormField(
                              focusNode: _servicesFocusNode,
                              onTap: () {
                                _showCupertinoDialog(
                                  context,
                                );
                              },
                              controller: serviceGovtTextController,
                              readOnly: true,
                              decoration: const InputDecoration(
                                hintText: "Select Services Govt. can provide",
                                prefixIcon: Icon(
                                    CupertinoIcons.square_list_fill,
                                    color: Colors.deepPurple),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Select your serving Services from list';
                                }
                                return null;
                              },
                              onEditingComplete: () {
                                FocusScope.of(context).nextFocus();
                              },
                            ),
                          ),
                          const SizedBox(height: 12),
                          //govt contact
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 5,
                              right: 5,
                            ),
                            child: TextFormField(
                              focusNode: _contactNoFocusNode,
                              maxLength: 10,
                              controller: contactNoGovtTextController,
                              decoration: const InputDecoration(
                                //prefixText: "+91 ",
                                hintText:
                                    "Enter contact number of Govt. Agency",
                                prefixIcon: Icon(CupertinoIcons.phone,
                                    color: Colors.deepPurple),
                              ),
                              keyboardType: TextInputType.phone,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  _contactNoFocusNode.requestFocus();
                                  return 'Enter Contact number';
                                }
                                if (value.isNotEmpty && value.length < 10) {
                                  _contactNoFocusNode.requestFocus();
                                  return 'Contact no should be of 10 digits';
                                }
                                return null;
                              },
                              onEditingComplete: () {
                                FocusScope.of(context).nextFocus();
                              },
                            ),
                          ),
                          const SizedBox(height: 8),
                          //govt email
                          Padding(
                            padding: const EdgeInsets.only(right: 5, left: 5),
                            child: TextFormField(
                              focusNode: _emailFocusNode,
                              controller: emailIdGovtTextController,
                              decoration: const InputDecoration(
                                prefixIcon: Icon(Icons.email_outlined,
                                    color: Colors.deepPurple),
                                hintText:
                                    "Enter authorized mail id of Govt. Agency",
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 18,
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  _emailFocusNode.requestFocus();
                                  return 'Enter an email address';
                                }
                                // Regular expression for validating an email address
                                final emailRegex =
                                    RegExp(r'^[\w.-]+@([\w-]+\.)+[\w-]{2,4}$');
                                if (!emailRegex.hasMatch(value)) {
                                  _emailFocusNode.requestFocus();
                                  return 'Enter valid email address';
                                }
                                return null;
                              },
                              onEditingComplete: () {
                                FocusScope.of(context).nextFocus();
                              },
                            ),
                          ),
                          const SizedBox(height: 12),
                          //govt website
                          Padding(
                            padding: const EdgeInsets.only(right: 5, left: 5),
                            child: TextFormField(
                              focusNode: _websiteFocusNode,
                              controller: websiteURLGovtTextController,
                              decoration: const InputDecoration(
                                prefixIcon: Icon(Icons.dataset_linked_outlined,
                                    color: Colors.deepPurple),
                                hintText: "Enter website URL of Govt. Agency",
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 18,
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  _websiteFocusNode.requestFocus();
                                  return 'Enter website URL';
                                }
                                // Regular expression for validating a URL
                                final urlRegex = RegExp(
                                  r'^(https?://)?'
                                  r'([a-z0-9-]+\.)*[a-z0-9-]+'
                                  r'\.[a-z]{2,}(\/\S*)?$',
                                  caseSensitive: false,
                                );
                                if (!urlRegex.hasMatch(value)) {
                                  _websiteFocusNode.requestFocus();
                                  return 'Enter valid URL';
                                }
                                return null;
                              },
                              onEditingComplete: () {
                                FocusScope.of(context).nextFocus();
                              },
                            ),
                          ),
                          const SizedBox(height: 12),
                          //state
                          Flex(
                            direction: Axis.horizontal,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    left: 5,
                                    right: 5,
                                  ),
                                  child: SizedBox(
                                    //height: 60,
                                    child: DropdownButtonFormField<String>(
                                      value: selectedState,
                                      items: DropdownItems.dropdownItemState
                                          .map((String state) {
                                        return DropdownMenuItem<String>(
                                          value: state,
                                          child: Text(state),
                                        );
                                      }).toList(),
                                      onChanged: (value) {
                                        setState(() {
                                          selectedState = value!;
                                          // Update city list based on the selected state
                                          updateCityList(selectedState);
                                          // Reset selected city when state changes
                                          selectedCity = '';
                                        });
                                      },
                                      decoration: const InputDecoration(
                                        // border: OutlineInputBorder(),
                                        hintText: "Select Govt Agency State",
                                        prefixIcon: Icon(
                                            CupertinoIcons.map_pin_ellipse,
                                            color: Colors.deepPurple),
                                      ),
                                      validator: (value) {
                                        if (value ==
                                            "Select Govt Agency State") {
                                          return 'Select Govt Agency State';
                                        }
                                        return null; // Return null if the input is valid
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          //city
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 5,
                              right: 5,
                            ),
                            child: SizedBox(
                              //height: 60,
                              child: DropdownButtonFormField<String>(
                                value: selectedCity.isNotEmpty
                                    ? selectedCity
                                    : null,
                                items: dropdownItemCity.map((String city) {
                                  return DropdownMenuItem<String>(
                                    value: city,
                                    child: Text(city),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    selectedCity = value!;
                                  });
                                },
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: "Select Govt Agency City",
                                  prefixIcon: Icon(Icons.location_city_rounded,
                                      color: Colors.deepPurple),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Select Govt Agency City';
                                  }
                                  return null; // Return null if the input is valid
                                },
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          Padding(
                            padding: const EdgeInsets.only(right: 5, left: 5),
                            child: TextFormField(
                              maxLength: 6,
                              controller: pinCodeGovtTextController,
                              decoration: const InputDecoration(
                                hintText: "Enter Pin code",
                                prefixIcon: Icon(Icons.pin_rounded,
                                    color: Colors.deepPurple),
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 18,
                                ),
                              ),
                              keyboardType: TextInputType.phone,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Enter Pin code';
                                }
                                if (value.isNotEmpty && value.length < 6) {
                                  return 'Enter 6 digits Pin code';
                                }
                                return null;
                              },
                              onEditingComplete: () {
                                FocusScope.of(context).nextFocus();
                              },
                            ),
                          ),
                          const SizedBox(height: 12),
                          //address
                          Padding(
                            padding: const EdgeInsets.only(right: 5, left: 5),
                            child: TextFormField(
                              textCapitalization: TextCapitalization.sentences,
                              controller: fullAddressGovtTextController,
                              decoration: const InputDecoration(
                                hintText: "Enter full address",
                                prefixIcon: Icon(
                                    CupertinoIcons.pencil_ellipsis_rectangle,
                                    color: Colors.deepPurple),
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 18,
                                ),
                              ),
                              keyboardType: TextInputType.text,
                              maxLength: 150,
                              maxLines: 4,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Enter full address';
                                }
                                if (value.isNotEmpty && value.length < 10) {
                                  return "Too short address";
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(height: 31),
                          //pwd
                          Padding(
                            padding: const EdgeInsets.only(right: 5, left: 5),
                            child: TextFormField(
                              controller: pwdGovtTextController,
                              obscureText: _obscurePwdText,
                              keyboardType: TextInputType.visiblePassword,
                              decoration: InputDecoration(
                                prefixIcon: const Icon(
                                  Icons.lock,
                                  color: Colors.deepPurple,
                                ),
                                hintText: "Create password",
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 18,
                                ),
                                suffixIcon: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _obscurePwdText = !_obscurePwdText;
                                    });
                                  },
                                  child: Icon(
                                    _obscurePwdText
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                              validator: validatePassword,
                              onEditingComplete: () {
                                // Move focus to the next field when "Enter" is pressed
                                FocusScope.of(context).nextFocus();
                              },
                            ),
                          ),
                          const SizedBox(height: 12),
                          // Confirm pwd
                          Padding(
                            padding: const EdgeInsets.only(right: 5, left: 5),
                            child: TextFormField(
                              controller: confirmPwdGovtTextController,
                              obscureText: _obscureConfirmPwdText,
                              keyboardType: TextInputType.visiblePassword,
                              decoration: InputDecoration(
                                prefixIcon: const Icon(
                                  Icons.lock,
                                  color: Colors.deepPurple,
                                ),
                                hintText: "Confirm password",
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 18,
                                ),
                                suffixIcon: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _obscureConfirmPwdText =
                                          !_obscureConfirmPwdText;
                                    });
                                  },
                                  child: Icon(
                                    _obscureConfirmPwdText
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Enter confirm password';
                                }
                                if (value != pwdGovtTextController.text) {
                                  return "Confirm password doesn't matches";
                                }
                                return null; // Return null if the input is valid
                              },
                              onEditingComplete: () {
                                // Move focus to the next field when "Enter" is pressed
                                FocusScope.of(context).nextFocus();
                              },
                            ),
                          ),
                          const SizedBox(height: 12),
                          //t&c
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 3,
                                    right: 100,
                                  ),
                                  child: CustomCheckboxButton(
                                    alignment: Alignment.centerLeft,
                                    text: "I accept term & conditions",
                                    value: GovtTnC,
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 1),
                                    onChange: (value) {
                                      setState(() {
                                        GovtTnC = value;
                                      });
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: GestureDetector(
                                    child: const Row(
                                      children: [
                                        Icon(
                                          Icons.open_in_new,
                                          color: Colors.deepPurple,
                                          size: 18,
                                        ),
                                        Text("  Read our T&C",
                                            style: TextStyle(
                                              color: Colors.deepPurple,
                                              fontWeight: FontWeight.w600,
                                            )),
                                      ],
                                    ),
                                    onTap: () {
                                      const link =
                                          "https://docs.google.com/document/d/17rpPn_I1rACn5KMSikjpuLlaw1mnlDUXF7G7XIlCR5Q/edit?usp=sharing";
                                      launchUrl(Uri.parse(link),
                                          mode: LaunchMode.inAppWebView);
                                    },
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                //out of scrollbar
                const SizedBox(height: 3),
                Padding(
                  padding: const EdgeInsets.only(right: 20, left: 20),
                  child: Container(
                    padding: const EdgeInsets.only(bottom: 8),
                    width: double.infinity,
                    child: ClipRRect(
                        child: ElevatedButton(
                            onPressed: () async {
                              //Circular Progress Bar
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
                                  const Duration(milliseconds: 1200));
                              Navigator.pop(context);

                              if (!GovtTnC) {
                                final tnCError = TsnakeBar(
                                    context,
                                    "Please accept terms & conditions..",
                                    "Hide");
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(tnCError);
                              }

                              if (_formKey.currentState!.validate()) {
                                if (!GovtTnC) {
                                  return;
                                } else {
                                  CollectionReference citizenRequestCollection =
                                      FirebaseFirestore.instance
                                          .collection("clc_govt");
                                  //for id
                                  QuerySnapshot snapshot =
                                      await citizenRequestCollection.get();
                                  int totalDocCount = snapshot.size;
                                  totalDocCount++;
                                  //Storing data to database
                                  GovtRegistration GovtData = GovtRegistration(
                                      gid: "g$totalDocCount",
                                      GovtAgencyName:
                                          nameOfGovtTextController.text.trim(),
                                      GovtAgencyARegNo:
                                          regNoGovtTextController.text.trim(),
                                      profilePic: "",
                                      aboutGovt: "",
                                      services:
                                          serviceGovtTextController.text.trim(),
                                      contactNumber: contactNoGovtTextController
                                          .text
                                          .trim(),
                                      creditScore: 0,
                                      email:
                                          emailIdGovtTextController.text.trim(),
                                      website: websiteURLGovtTextController.text
                                          .trim(),
                                      state: selectedState.trim(),
                                      city: selectedCity.trim(),
                                      pinCode:
                                          pinCodeGovtTextController.text.trim(),
                                      fullAddress: fullAddressGovtTextController
                                          .text
                                          .trim(),
                                      password:
                                          pwdGovtTextController.text.trim(),
                                      // confirmPassword: confirmPwdGovtTextController.text.trim(),
                                      // termsAccepted: GovtTnC,
                                      deviceToken: deviceTokenFound);

                                  // Convert the object to JSON
                                  Map<String, dynamic> GovtDataJson =
                                      GovtData.toJsonGovt();

                                  // Store data in Firestore
                                  try {
                                    String emailId =
                                        emailIdGovtTextController.text;

                                    // Check if a document with the same email ID exists
                                    var existingDoc = await FirebaseFirestore
                                        .instance
                                        .collection("clc_govt")
                                        .doc(emailId)
                                        .get();

                                    if (existingDoc.exists) {
                                      // Document already exists, do not add user to the database
                                      showToastMsg(
                                          "Account with the same email id already exists ..");
                                      return; // Exit the function
                                    } else {
                                      // DocumentReference docRef =await FirebaseFirestore.instance.collection("Govt").add(GovtDataJson);
                                      await FirebaseFirestore.instance
                                          .collection("clc_govt")
                                          .doc(emailIdGovtTextController.text)
                                          .set(GovtDataJson)
                                          .whenComplete(() {
                                        // Show a toast message upon success
                                        showToastMsg(
                                            "Government Agency registered successfully ..");
                                      }).onError((error, stackTrace) {
                                        showToastMsg(
                                            "Something went wrong, try again later ");
                                      });

                                      FirebaseAuth.instance
                                          .createUserWithEmailAndPassword(
                                        email: emailIdGovtTextController.text,
                                        password: pwdGovtTextController.text,
                                      );

                                      // Document successfully added
                                      if (kDebugMode) {
                                        print(
                                            'Document added with ID: ${emailIdGovtTextController.text}');
                                      }

                                      // Navigate to a new page upon success
                                      Navigator.of(context).push(
                                        PageRouteBuilder(
                                          pageBuilder: (context, animation,
                                                  secondaryAnimation) =>
                                              const GovtLoginPageScreen(),
                                          transitionsBuilder: (context,
                                              animation,
                                              secondaryAnimation,
                                              child) {
                                            var begin = const Offset(1.0, 0.0);
                                            var end = Offset.zero;
                                            var curve = Curves.ease;
                                            var tween = Tween(
                                                    begin: begin, end: end)
                                                .chain(
                                                    CurveTween(curve: curve));
                                            var offsetAnimation =
                                                animation.drive(tween);
                                            //slight fade effect
                                            //var opacityAnimation = animation.drive(tween);
                                            return SlideTransition(
                                              position: offsetAnimation,
                                              child: child,
                                            );
                                          },
                                        ),
                                      );
                                    }
                                  } catch (e) {
                                    // An error occurred
                                    if (kDebugMode) {
                                      print('Error adding Govt document: $e');
                                    }
                                  }
                                  if (kDebugMode) {
                                    print(
                                        "Govt Agency Stored and Registered successfully [(:-==-:)]");
                                  }
                                }
                              } else {
                                // Focus on the first invalid field
                                // if (!_nameFocusNode.hasFocus && !_regNoFocusNode.hasFocus) {
                                //   _nameFocusNode.requestFocus();
                                // } else if (!_regNoFocusNode.hasFocus) {
                                //   _regNoFocusNode.requestFocus();
                                // }
                              }
                            },
                            style: ButtonStyle(
                                shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(18)))),
                            child: const Text("Continue"))),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text(
                        "Already have an account? ",
                      ),
                      SizedBox(
                        height: 35,
                        width: 89,
                        child: Stack(
                          alignment: Alignment.bottomLeft,
                          children: [
                            Align(
                                alignment: Alignment.topLeft,
                                child: TextButton(
                                    onPressed: () {
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const GovtLoginPageScreen(),
                                          ));
                                    },
                                    child: const Text(
                                      "Login ..",
                                      // selectionColor: Colors.blueGrey,
                                    ))),
                            SvgPicture.asset(svg_for_line, width: 65),
                          ],
                        ),
                      ),
                    ],
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

  final List<bool> _checked =
      List.filled(DropdownItems.dropdownItemListofServices.length, false);

  void _showCupertinoDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('Select your services from the list :'),
              content: SizedBox(
                width: double.maxFinite,
                height: 300, // Adjust the height as needed
                child: ListView.builder(
                  itemCount: DropdownItems.dropdownItemListofServices.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title:
                          Text(DropdownItems.dropdownItemListofServices[index]),
                      trailing: CupertinoSwitch(
                        value: _checked[index],
                        onChanged: (bool value) {
                          setState(() {
                            _checked[index] = value;
                          });

                          // Update the text field whenever a toggle is changed
                          _updateTextField(_checked);
                        },
                      ),
                    );
                  },
                ),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancel',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                TextButton(
                  onPressed: () {
                    // Dismiss the dialog
                    Navigator.of(context).pop();
                  },
                  child: const Text('OK',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ],
            );
          },
        );
      },
    ).then((value) {
      _updateTextField(_checked);
    });
  }

  void _updateTextField(List<bool> checked) {
    String selectedOptions = '';
    for (int i = 0; i < DropdownItems.dropdownItemListofServices.length; i++) {
      if (checked[i]) {
        selectedOptions += '${DropdownItems.dropdownItemListofServices[i]}, ';
      }
    }
    if (selectedOptions.isNotEmpty) {
      selectedOptions =
          selectedOptions.substring(0, selectedOptions.length - 2);
    }
    serviceGovtTextController.text = selectedOptions;
  }

  void updateCityList(String state) {
    setState(() {
      dropdownItemCity = DropdownItems.cityMap[state] ?? [];
    });
  }
}
