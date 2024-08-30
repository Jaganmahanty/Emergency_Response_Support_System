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
import '../../../Models/ngo_registration_model.dart';
import '../../../Utils/Utils.dart';
import '../../../Utils/constants.dart';
import '../../../Utils/dropdown_Items.dart';
import '../ngo_login_screen/ngo_login.dart';

// ignore: must_be_immutable
class NGOSignupPageScreen extends StatefulWidget {
  const NGOSignupPageScreen({Key? key})
      : super(
          key: key,
        );

  @override
  State<NGOSignupPageScreen> createState() => _NGOSignupPageScreenState();
}

class _NGOSignupPageScreenState extends State<NGOSignupPageScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FocusNode _nameFocusNode = FocusNode();
  final FocusNode _regNoFocusNode = FocusNode();

  // final FocusNode _servicesFocusNode = FocusNode();
  final FocusNode _contactNoFocusNode = FocusNode();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _websiteFocusNode = FocusNode();

  TextEditingController nameOfNGOTextController = TextEditingController();
  TextEditingController regNoTextController = TextEditingController();
  TextEditingController servicesTextController = TextEditingController();
  TextEditingController contactNoTextController = TextEditingController();
  TextEditingController emailIdTextController = TextEditingController();
  TextEditingController websiteURLTextController = TextEditingController();
  TextEditingController pinCodeTextController = TextEditingController();
  TextEditingController fullAddressTextController = TextEditingController();
  TextEditingController pwdTextController = TextEditingController();
  TextEditingController confirmPwdTextController = TextEditingController();

  String selectedState = '';
  String selectedCity = ''; // Variable to hold the selected city value

  List<String> dropdownItemCity = [];

  bool NGOTnC = false;
  bool _obscurePwdText = true;
  bool _obscureConfirmPwdText = true;
  NotificationServices notificationServices = NotificationServices();
  String deviceTokenFound = ""; // Global variable to store device token

  @override
  void initState() {
    super.initState();
    selectedState = DropdownItems.dropdownItemState.first;
    updateCityList(selectedState);

    // Inside a method or initState() or wherever appropriate
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
                      child: Column(
                        children: [
                          const Text(
                            "Create Account for an NGO : ",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 23),
                          ),
                          const SizedBox(height: 9),
                          // const Text("Connect with your city now !",),
                          const SizedBox(height: 50),
                          SvgPicture.asset(svg_for_signup),
                          const SizedBox(height: 30),
                          //ngo name
                          Padding(
                            padding: const EdgeInsets.only(right: 5, left: 5),
                            child: TextFormField(
                              focusNode: _nameFocusNode,
                              textCapitalization: TextCapitalization.sentences,
                              controller: nameOfNGOTextController,
                              decoration: const InputDecoration(
                                prefixIcon: Icon(Icons.account_box_outlined,
                                    color: Colors.deepPurple),
                                hintText: "Enter name of the NGO",
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 18,
                                ),
                                filled: true,
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  _nameFocusNode.requestFocus();
                                  return 'Enter name of NGO';
                                }
                                if (value.isNotEmpty && value.length < 3) {
                                  _nameFocusNode.requestFocus();
                                  return 'Minimum 3 Characters required';
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
                          //ngo reg no
                          Padding(
                            padding: const EdgeInsets.only(right: 5, left: 5),
                            child: TextFormField(
                              focusNode: _regNoFocusNode,
                              controller: regNoTextController,
                              maxLength: 10,
                              decoration: const InputDecoration(
                                prefixIcon: Icon(Icons.app_registration,
                                    color: Colors.deepPurple),
                                hintText: "Enter Registration no. of the NGO",
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
                          //services
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 5,
                              right: 5,
                            ),
                            child: TextFormField(
                              onTap: () {
                                _showCupertinoDialog(
                                  context,
                                );
                              },
                              controller: servicesTextController,
                              readOnly: true,
                              decoration: InputDecoration(
                                hintText:
                                    "Select Services your NGO can provide",
                                prefixIcon: Container(
                                  margin:
                                      const EdgeInsets.fromLTRB(20, 16, 12, 16),
                                  child: SvgPicture.asset(svg_for_calendar),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Select your serving Services from list';
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
                          //contact
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 5,
                              right: 5,
                            ),
                            child: TextFormField(
                              focusNode: _contactNoFocusNode,
                              maxLength: 10,
                              controller: contactNoTextController,
                              decoration: InputDecoration(
                                //prefixText: "+91 ",
                                hintText: "Enter contact number of NGO",
                                prefixIcon: Container(
                                  decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30)),
                                  ),
                                  margin:
                                      const EdgeInsets.fromLTRB(20, 16, 12, 16),
                                  child: SvgPicture.asset(svg_for_call),
                                ),
                                prefixIconConstraints: const BoxConstraints(
                                  maxHeight: 56,
                                ),
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
                                return null; // Return null if the input is valid
                              },
                              onEditingComplete: () {
                                // Move focus to the next field when "Enter" is pressed
                                FocusScope.of(context).nextFocus();
                              },
                            ),
                          ),
                          const SizedBox(height: 8),
                          //email
                          Padding(
                            padding: const EdgeInsets.only(right: 5, left: 5),
                            child: TextFormField(
                              focusNode: _emailFocusNode,
                              controller: emailIdTextController,
                              decoration: const InputDecoration(
                                prefixIcon: Icon(Icons.email_outlined,
                                    color: Colors.deepPurple),
                                hintText:
                                    "Enter authorized mail address of an NGO",
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
                                return null; // Return null if the input is valid
                              },
                              onEditingComplete: () {
                                // Move focus to the next field when "Enter" is pressed
                                FocusScope.of(context).nextFocus();
                              },
                            ),
                          ),
                          const SizedBox(height: 12),
                          //website
                          Padding(
                            padding: const EdgeInsets.only(right: 5, left: 5),
                            child: TextFormField(
                              focusNode: _websiteFocusNode,
                              controller: websiteURLTextController,
                              decoration: const InputDecoration(
                                prefixIcon:
                                    Icon(Icons.web, color: Colors.deepPurple),
                                hintText: "Enter website URL of an NGO",
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
                                return null; // Return null if the input is valid
                              },
                              onEditingComplete: () {
                                // Move focus to the next field when "Enter" is pressed
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
                                          // alignment: AlignmentDirectional.topStart,
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
                                        hintText: "Select NGO State",
                                        prefixIcon: Icon(
                                            CupertinoIcons.map_pin_ellipse,
                                            color: Colors.deepPurple),
                                      ),
                                      validator: (value) {
                                        if (value == "Select NGO state") {
                                          return 'Select NGO State';
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
                              //height: 58,
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
                                  hintText: "Select your City",
                                  prefixIcon: Icon(Icons.location_city_rounded,
                                      color: Colors.deepPurple),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Select NGO City';
                                  }
                                  return null; // Return null if the input is valid
                                },
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          //pin
                          Padding(
                            padding: const EdgeInsets.only(right: 5, left: 5),
                            child: TextFormField(
                              maxLength: 6,
                              controller: pinCodeTextController,
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
                                  return 'Enter pin code ';
                                }
                                if (value.isNotEmpty && value.length < 6) {
                                  return 'Enter 6 digits Pin code';
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
                          //address
                          Padding(
                            padding: const EdgeInsets.only(right: 5, left: 5),
                            child: TextFormField(
                              textCapitalization: TextCapitalization.sentences,
                              controller: fullAddressTextController,
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
                                  return 'Too short address';
                                }
                                return null; // Return null if the input is valid
                              },
                            ),
                          ),
                          const SizedBox(height: 31),
                          //pwd
                          Padding(
                            padding: const EdgeInsets.only(right: 5, left: 5),
                            child: TextFormField(
                              controller: pwdTextController,
                              obscureText: _obscurePwdText,
                              decoration: InputDecoration(
                                prefixIcon: const Icon(
                                  Icons.lock,
                                  color: Colors.deepPurple,
                                ),
                                hintText: "Create Password",
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
                              controller: confirmPwdTextController,
                              obscureText: _obscureConfirmPwdText,
                              decoration: InputDecoration(
                                prefixIcon: const Icon(
                                  Icons.lock,
                                  color: Colors.deepPurple,
                                ),
                                hintText: "Confirm Password",
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
                                if (value != pwdTextController.text) {
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
                          const SizedBox(height: 20),
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
                                    value: NGOTnC,
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 1),
                                    onChange: (value) {
                                      setState(() {
                                        NGOTnC = value;
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
                        // borderRadius: BorderRadius.circular(50),
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

                              if (!NGOTnC) {
                                final tnCError = TsnakeBar(
                                    context,
                                    "Please accept terms & conditions..",
                                    "Hide");
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(tnCError);
                              }

                              if (_formKey.currentState!.validate()) {
                                if (!NGOTnC) {
                                  return;
                                } else {
                                  CollectionReference citizenRequestCollection =
                                      FirebaseFirestore.instance
                                          .collection("clc_ngo");
                                  //for id
                                  QuerySnapshot snapshot =
                                      await citizenRequestCollection.get();
                                  int totalDocCount = snapshot.size;
                                  totalDocCount++;
                                  //Storing data to database
                                  NGORegistration NGOData = NGORegistration(
                                      nid: "n$totalDocCount",
                                      ngoName:
                                          nameOfNGOTextController.text.trim(),
                                      ngoRegNo: regNoTextController.text.trim(),
                                      profilePic: "",
                                      aboutNGO: "",
                                      upiId: "",
                                      services:
                                          servicesTextController.text.trim(),
                                      contactNumber:
                                          contactNoTextController.text.trim(),
                                      email: emailIdTextController.text.trim(),
                                      website:
                                          websiteURLTextController.text.trim(),
                                      creditScore: 0,
                                      state: selectedState,
                                      city: selectedCity,
                                      pinCode:
                                          pinCodeTextController.text.trim(),
                                      fullAddress:
                                          fullAddressTextController.text.trim(),
                                      password: pwdTextController.text.trim(),
                                      // confirmPassword: confirmPwdTextController.text,
                                      // termsAccepted: NGOTnC,
                                      deviceToken: deviceTokenFound);

                                  // Convert the object to JSON
                                  Map<String, dynamic> NGODataJson =
                                      NGOData.toJsonNGO();

                                  // Store data in Firestore
                                  try {
                                    String emailId = emailIdTextController.text;

                                    // Check if a document with the same email ID exists
                                    var existingDoc = await FirebaseFirestore
                                        .instance
                                        .collection("clc_ngo")
                                        .doc(emailId)
                                        .get();

                                    if (existingDoc.exists) {
                                      // Document already exists, do not add user to the database
                                      showToastMsg(
                                          "Account with the same email id already exists ..");
                                      return; // Exit the function
                                    } else {
                                      await FirebaseFirestore.instance
                                          .collection("clc_ngo")
                                          .doc(
                                              emailIdTextController.text.trim())
                                          .set(NGODataJson);

                                      FirebaseAuth.instance
                                          .createUserWithEmailAndPassword(
                                        email: emailIdTextController.text,
                                        password: pwdTextController.text,
                                      );

                                      // Document successfully added
                                      if (kDebugMode) {
                                        print(
                                            'Document added with ID: ${emailIdTextController.text}');
                                      }
                                      // Show a toast message upon success
                                      showToastMsg(
                                          "NGO registered successfully..");

                                      // Navigate to a new page upon success
                                      Navigator.of(context).push(
                                        PageRouteBuilder(
                                          pageBuilder: (context, animation,
                                                  secondaryAnimation) =>
                                              const NGOLoginPageScreen(),
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
                                      print('Error adding NGO document: $e');
                                    }
                                  }

                                  if (kDebugMode) {
                                    print(
                                        "NGO Stored and Registered successfully [(:-==-:)]");
                                  }
                                }
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
                                                const NGOLoginPageScreen(),
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
      // This code block executes after the dialog is dismissed
      // You can use this to update the text field when the dialog is dismissed
      _updateTextField(_checked);
    });
  }

  void updateCityList(String state) {
    setState(() {
      dropdownItemCity = DropdownItems.cityMap[state] ?? [];
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
    servicesTextController.text = selectedOptions;
  }
}
