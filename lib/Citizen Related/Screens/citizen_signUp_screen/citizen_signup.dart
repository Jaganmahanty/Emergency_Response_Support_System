// ignore_for_file: use_build_context_synchronously, depend_on_referenced_packages, non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fff/Citizen%20Related/Screens/citizen_home_screen/home_screen_citizen.dart';
import 'package:fff/Utils/Utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../Components/Notification_related/notification_services.dart';
import '../../../Models/user_registration_model.dart';
import '../../../Utils/constants.dart';
import '../../../Utils/dropdown_Items.dart';
import 'custom_checkbox_button.dart';
import 'custom_radio_button.dart';

class CitizenSignupPageScreen extends StatefulWidget {
  final String contactNumber;

  const CitizenSignupPageScreen({Key? key, required this.contactNumber})
      : super(
          key: key,
        );

  @override
  State<CitizenSignupPageScreen> createState() =>
      _CitizenSignupPageScreenState();
}

class _CitizenSignupPageScreenState extends State<CitizenSignupPageScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FocusNode _fnameFocusNode = FocusNode();
  final FocusNode _lnameFocusNode = FocusNode();

  TextEditingController fnameTextController = TextEditingController();
  TextEditingController lnameTextController = TextEditingController();
  TextEditingController pinCodeTextController = TextEditingController();
  TextEditingController fullAddressTextController = TextEditingController();
  TextEditingController birthDateTextController = TextEditingController();

  String? genderRadio;
  bool showErrorTnC = false;

  List<String> genderList = ["Male", "Female", "Others"];

  String selectedState = '';
  String selectedCity = '';

  List<String> dropdownItemCity = [];

  bool CitizenTnC = false;

  NotificationServices notificationServices = NotificationServices();
  String deviceTokenFound = "";

  @override
  void initState() {
    super.initState();
    selectedState = DropdownItems.dropdownItemState.first;
    updateCityList(selectedState);
    //status bar color
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.white12,
        // Change this color to the desired color
        statusBarIconBrightness: Brightness.light,
      ),
    );

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
                const SizedBox(height: 30),
                Expanded(
                  child: SingleChildScrollView(
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 25),
                      padding: EdgeInsets.only(
                          //for fields that are covered under keyboard
                          bottom: MediaQuery.of(context).viewInsets.bottom,
                          left: 16,
                          right: 16),
                      child: Column(
                        children: [
                          const Text(
                            "Create your account here : ",
                            style: TextStyle(fontSize: 24),
                          ),
                          const SizedBox(height: 9),
                          // const Text("Connect with your city now !",),
                          const SizedBox(height: 50),
                          SvgPicture.asset(svg_for_login),
                          const SizedBox(height: 36),
                          //fname lname
                          Padding(
                            padding: const EdgeInsets.only(left: 5, right: 5),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 5),
                                    child: TextFormField(
                                      focusNode: _fnameFocusNode,
                                      textCapitalization:
                                          TextCapitalization.sentences,
                                      controller: fnameTextController,
                                      decoration: const InputDecoration(
                                        hintText: "First Name",
                                        contentPadding: EdgeInsets.symmetric(
                                          horizontal: 20,
                                          vertical: 18,
                                        ),
                                        filled: true,
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          _fnameFocusNode.requestFocus();
                                          return 'Enter first name';
                                        }
                                        if (value.isNotEmpty &&
                                            value.length < 3) {
                                          _fnameFocusNode.requestFocus();
                                          return "Minimum 3 Characters required";
                                        }
                                        return null; // Return null if the input is valid
                                      },
                                      onEditingComplete: () {
                                        // Move focus to the next field when "Enter" is pressed
                                        FocusScope.of(context).nextFocus();
                                      },
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 5),
                                    child: TextFormField(
                                      focusNode: _lnameFocusNode,
                                      textCapitalization:
                                          TextCapitalization.sentences,
                                      controller: lnameTextController,
                                      decoration: const InputDecoration(
                                        hintText: "Last Name",
                                        contentPadding: EdgeInsets.symmetric(
                                          horizontal: 20,
                                          vertical: 18,
                                        ),
                                        filled: true,
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          _lnameFocusNode.requestFocus();
                                          return 'Enter last name';
                                        }
                                        if (value.isNotEmpty &&
                                            value.length < 3) {
                                          _lnameFocusNode.requestFocus();
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
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 13),
                          //gender
                          Padding(
                            padding: const EdgeInsets.only(left: 8, right: 11),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 2),
                                  child: CustomRadioButton(
                                    text: "Male",
                                    value: genderList[0],
                                    groupValue: genderRadio,
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 1),
                                    onChange: (value) {
                                      // Update the state when a radio button is selected
                                      setState(() {
                                        genderRadio = value;
                                      });
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 24, bottom: 2),
                                  child: CustomRadioButton(
                                    text: "Female",
                                    value: genderList[1],
                                    groupValue: genderRadio,
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 1),
                                    onChange: (value) {
                                      // Update the state when a radio button is selected
                                      setState(() {
                                        genderRadio = value;
                                      });
                                    },
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 28, top: 0),
                                  child: CustomRadioButton(
                                    text: "Others",
                                    value: genderList[2],
                                    groupValue: genderRadio,
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 1),
                                    onChange: (value) {
                                      // Update the state when a radio button is selected
                                      setState(() {
                                        genderRadio = value;
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // ignore: unnecessary_null_comparison
                          if (showErrorTnC)
                            const Padding(
                              padding: EdgeInsets.only(left: 22),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  'Please select your gender',
                                  style: TextStyle(
                                      color: Color(0xFFB71C1C),
                                      fontSize: 10,
                                      fontStyle: FontStyle.normal),
                                ),
                              ),
                            ),
                          const SizedBox(height: 11),
                          //phone
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 5,
                              right: 5,
                            ),
                            child: TextFormField(
                              initialValue: widget.contactNumber,
                              enabled: false,
                              maxLength: 13,
                              //controller: phoneTextController,
                              decoration: InputDecoration(
                                //prefixText: "+91 ",
                                hintText: "Enter your Mobile number",
                                prefixIcon: Container(
                                  margin:
                                      const EdgeInsets.fromLTRB(20, 16, 12, 16),
                                  child: SvgPicture.asset(svg_for_call),
                                ),
                                prefixIconConstraints: const BoxConstraints(
                                  maxHeight: 56,
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Enter mobile no';
                                }
                                if (value.length < 10) {
                                  return 'Mobile no should be of 10 digits';
                                }
                                return null; // Return null if the input is valid
                              },
                              onEditingComplete: () {
                                // Move focus to the next field when "Enter" is pressed
                                FocusScope.of(context).nextFocus();
                              },
                              keyboardType: TextInputType.phone,
                            ),
                          ),
                          const SizedBox(height: 8),
                          //date
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 5,
                              right: 5,
                            ),
                            child: GestureDetector(
                              onTap: () {
                                _selectDate(context);
                              },
                              child: AbsorbPointer(
                                child: TextFormField(
                                  controller: birthDateTextController,
                                  readOnly: true,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    hintText: "Select your Birthdate",
                                    prefixIcon: const Icon(
                                        CupertinoIcons.calendar_today,
                                        color: Colors.deepPurple),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Select Birth date';
                                    }
                                    return null; // Return null if the input is valid
                                  },
                                  onEditingComplete: () {
                                    // Move focus to the next field when "Enter" is pressed
                                    FocusScope.of(context).nextFocus();
                                  },
                                ),
                              ),
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
                                        // border: OutlineInputBorder(),
                                        hintText: "Select your State",
                                        prefixIcon: Icon(
                                            CupertinoIcons.map_pin_ellipse,
                                            color: Colors.deepPurple),
                                      ),
                                      //hint: const Text("Select your State"), // Hint text displayed initially
                                      validator: (value) {
                                        if (value == "Select your state") {
                                          return 'Select your State';
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
                                  hintText: "Select your City",
                                  prefixIcon: Icon(Icons.location_city_rounded,
                                      color: Colors.deepPurple),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Select your City';
                                  }
                                  return null; // Return null if the input is valid
                                },
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          //pin
                          Padding(
                            padding: const EdgeInsets.only(left: 5, right: 5),
                            child: TextFormField(
                              maxLength: 6,
                              controller: pinCodeTextController,
                              decoration: const InputDecoration(
                                hintText: "Enter your Pin Code",
                                prefixIcon: Icon(Icons.pin_rounded,
                                    color: Colors.deepPurple),
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 18,
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Enter pin code';
                                }
                                if (value.length < 6) {
                                  return 'Enter 6 digits Pin code';
                                }
                                return null; // Return null if the input is valid
                              },
                              onEditingComplete: () {
                                // Move focus to the next field when "Enter" is pressed
                                FocusScope.of(context).nextFocus();
                              },
                              keyboardType: TextInputType.phone,
                            ),
                          ),
                          const SizedBox(height: 12),
                          //address
                          Padding(
                            padding: const EdgeInsets.only(left: 5, right: 5),
                            child: TextFormField(
                              textCapitalization: TextCapitalization.sentences,
                              controller: fullAddressTextController,
                              decoration: const InputDecoration(
                                hintText: "Enter your full address",
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
                                  return 'Enter your full address';
                                }
                                if (value.length < 10) {
                                  return 'Too short address';
                                }
                                return null; // Return null if the input is valid
                              },
                              onEditingComplete: () {
                                // Move focus to the next field when "Enter" is pressed
                                FocusScope.of(context).nextFocus();
                              },
                            ),
                          ),
                          const SizedBox(height: 15),
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
                                    value: CitizenTnC,
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 1),
                                    onChange: (value) {
                                      setState(() {
                                        CitizenTnC = value;
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
                //Out of scrollview
                const SizedBox(height: 9),
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

                              if (!CitizenTnC) {
                                final tnCError = TsnakeBar(
                                    context,
                                    "Please accept terms & conditions..",
                                    "Hide");
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(tnCError);
                              }

                              if (_formKey.currentState!.validate()) {
                                setState(() {
                                  showErrorTnC = genderRadio == null;
                                });
                                if (!CitizenTnC) {
                                  return;
                                } else {
                                  String dateString =
                                      birthDateTextController.text;
                                  DateTime birthDate = DateFormat('MMM d, yyyy')
                                      .parse(dateString);
                                  // final now = DateTime.now();
                                  // int userAge = now.year - birthDate.year;
                                  // if (now.month < birthDate.month ||
                                  //     (now.month == birthDate.month &&
                                  //         now.day < birthDate.day)) {
                                  //   userAge--;
                                  // }
                                  // if (kDebugMode) {
                                  //   print(userAge);
                                  // }
                                  //for id
                                  int totalDocCount = 0;
                                  await FirebaseFirestore.instance.runTransaction((transaction) async {
                                    // Get the current count of requests
                                    DocumentSnapshot snapshot = await transaction.get(FirebaseFirestore
                                        .instance
                                        .collection("clc_citizen")
                                        .doc("citizen_count"));
                                    totalDocCount = (snapshot.exists) ? snapshot.get('count') : 0;
                                    totalDocCount++;

                                    transaction.set(
                                        FirebaseFirestore.instance.collection("clc_citizen").doc("citizen_count"),
                                        {'count': totalDocCount});
                                  });

                                  //Storing data to database
                                  UserRegistration userData = UserRegistration(
                                      cid: "c$totalDocCount",
                                      firstName: fnameTextController.text,
                                      lastName: lnameTextController.text,
                                      profilePic: "",
                                      gender: genderRadio ?? "",
                                      // Assuming genderRadio is nullable String
                                      phoneNumber: widget.contactNumber,
                                      birthDate: birthDate,
                                      //userAge: userAge.toString(),
                                      state: selectedState,
                                      city: selectedCity,
                                      pinCode: pinCodeTextController.text,
                                      fullAddress:
                                          fullAddressTextController.text,
                                      //termsAccepted: CitizenTnC,
                                      deviceToken: deviceTokenFound);

                                  // Convert the object to JSON
                                  Map<String, dynamic> userDataJson =
                                      userData.toJsonCitizen();

                                  // Store data in Firestore
                                  try {
                                    await FirebaseFirestore.instance
                                        .collection("clc_citizen")
                                        .doc(widget.contactNumber)
                                        .set(userDataJson);
                                    // .add(userDataJson);

                                    // Document successfully added
                                    if (kDebugMode) {
                                      print(
                                          "Document added with ID : ${widget.contactNumber}");
                                    }
                                    // Show a toast message upon success
                                    showToastMsg(
                                        "Citizen registered successfully..");

                                    // Navigate to a new page upon success
                                    Navigator.of(context).push(
                                      PageRouteBuilder(
                                        pageBuilder: (context, animation,
                                                secondaryAnimation) =>
                                            const CitizenHomeScreen(),
                                        transitionsBuilder: (context, animation,
                                            secondaryAnimation, child) {
                                          var begin = const Offset(1.0, 0.0);
                                          var end = Offset.zero;
                                          var curve = Curves.ease;

                                          var tween = Tween(
                                                  begin: begin, end: end)
                                              .chain(CurveTween(curve: curve));
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
                                  } catch (e) {
                                    // An error occurred
                                    if (kDebugMode) {
                                      print(
                                          'Error adding citizen document: $e');
                                    }
                                  }

                                  if (kDebugMode) {
                                    print(
                                        "Citizen Stored and Registered successfully [(:-==-:)]");
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
                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 30),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //     children: [
                //       const Text(
                //         "Already have an account  ? ",
                //       ),
                //       SizedBox(
                //         height: 35,
                //         width: 89,
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
                //                                 const CitizenLoginScreen(),
                //                           ));
                //                     },
                //                     // style: TextButton.styleFrom(backgroundColor: Colors.white.withOpacity(0.25)),
                //                     child: const Text(
                //                       "Login ..",
                //                       // selectionColor: Colors.blueGrey,
                //                     ))),
                //             SvgPicture.asset(svg_for_line, width: 65),
                //           ],
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                const SizedBox(height: 15),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(
              primary: Colors.blue, // Header background color
              onPrimary: Colors.white, // Header text color
              onSurface: Colors.black, // Body text color
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Colors.blue, // Button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    // ignore: unrelated_type_equality_checks
    if (pickedDate != null && pickedDate != birthDateTextController.text) {
      final formattedDate = DateFormat.yMMMd()
          .format(pickedDate); // Format date to show day, month, year
      setState(() {
        birthDateTextController.text = formattedDate;
      });
    }
  }

  void updateCityList(String state) {
    setState(() {
      dropdownItemCity = DropdownItems.cityMap[state] ?? [];
    });
  }
}
