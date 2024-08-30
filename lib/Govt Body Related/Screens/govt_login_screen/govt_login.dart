// ignore_for_file: use_build_context_synchronously, unnecessary_const
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../govt_home_screen/home_screen_govt.dart';
import '../../../Utils/Utils.dart';
import '../../../Utils/constants.dart';
import '../govt_signUp_screen/govt_signup.dart';

// ignore: must_be_immutable
class GovtLoginPageScreen extends StatefulWidget {
  const GovtLoginPageScreen({Key? key})
      : super(
          key: key,
        );

  @override
  State<GovtLoginPageScreen> createState() => _GovtLoginPageScreenState();
}

class _GovtLoginPageScreenState extends State<GovtLoginPageScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController loginRegNoGovtTextController = TextEditingController();
  TextEditingController loginPwdGovtTextController = TextEditingController();
  TextEditingController loginEmailGovtTextController = TextEditingController();

  bool _obscurePwdText = true;

  @override
  void initState() {
    super.initState();
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
                      margin: const EdgeInsets.only(bottom: 5),
                      padding: EdgeInsets.only(
                          //for fields that are covered under keyboard
                          bottom: MediaQuery.of(context).viewInsets.bottom,
                          left: 16,
                          right: 16),
                      child: Column(
                        children: [
                          const Text(
                            "Log In to Continue : ",
                            style: TextStyle(fontSize: 24),
                          ),
                          // const SizedBox(height: 30),
                          // const Text("By logging In First !"),
                          const SizedBox(height: 30),
                          SvgPicture.asset(svg_for_login,
                              height: 200, width: 200),
                          const SizedBox(height: 45),
                          //ngo reg no
                          Padding(
                            padding: const EdgeInsets.only(right: 5, left: 5),
                            child: TextFormField(
                              controller: loginRegNoGovtTextController,
                              maxLength: 10,
                              decoration: const InputDecoration(
                                prefixIcon: Icon(Icons.app_registration,
                                    color: Colors.deepPurple),
                                hintText:
                                    "Enter registration no of Govt. Agency",
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 18,
                                ),
                                filled: true,
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Enter Registration No';
                                }
                                if (value.isNotEmpty && value.length < 3) {
                                  return 'Registration number did not matched';
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(height: 25),
                          //govt email
                          Padding(
                            padding: const EdgeInsets.only(right: 5, left: 5),
                            child: TextFormField(
                              controller: loginEmailGovtTextController,
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
                                  return 'Enter an email address';
                                }
                                // Regular expression for validating an email address
                                final emailRegex =
                                    RegExp(r'^[\w.-]+@([\w-]+\.)+[\w-]{2,4}$');
                                if (!emailRegex.hasMatch(value)) {
                                  return 'Email address did not matched';
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(height: 25),
                          //pwd
                          Padding(
                            padding: const EdgeInsets.only(right: 5, left: 5),
                            child: TextFormField(
                              controller: loginPwdGovtTextController,
                              obscureText: _obscurePwdText,
                              decoration: InputDecoration(
                                prefixIcon: const Icon(
                                  Icons.lock,
                                  color: Colors.deepPurple,
                                ),
                                hintText: "Enter Password",
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
                            ),
                          ),
                          //forgot pwd
                          Align(
                            alignment: Alignment.topRight,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 5, left: 5),
                              child: TextButton(
                                  onPressed: () {
                                    showForgotPasswordDialog(context);
                                  },
                                  child: const Text(
                                    "Forget password ? ",
                                    style: TextStyle(fontSize: 14),
                                  )),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 9),
                Padding(
                  padding: const EdgeInsets.only(right: 20, left: 20),
                  child: Container(
                    padding: const EdgeInsets.only(bottom: 28),
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
                                  const Duration(milliseconds: 800));
                              Navigator.pop(context);

                              if (_formKey.currentState!.validate()) {
                                String emailValue =
                                    loginEmailGovtTextController.text.trim();

                                try {
                                  DocumentReference govtRef = FirebaseFirestore
                                      .instance
                                      .collection("clc_govt")
                                      .doc(emailValue);
                                  final DocumentSnapshot govtSnapshot =
                                      await govtRef.get();

                                  if (govtSnapshot.exists) {
                                    try {
                                      // Sign in the user with email and password
                                      FirebaseAuth.instance
                                          .signInWithEmailAndPassword(
                                        email: loginEmailGovtTextController.text
                                            .trim(),
                                        password: loginPwdGovtTextController
                                            .text
                                            .trim(),
                                      )
                                          .then((value) async {
                                        //SharedPreferences
                                        final SharedPreferences sharedPref =
                                            await SharedPreferences
                                                .getInstance();
                                        sharedPref.setString(
                                            "userType", "Govt");
                                        //success
                                        showToastMsg(
                                            "Govt Agency Logged in successfully ..");
                                        // Navigate to a new page upon success
                                        Navigator.of(context).push(
                                          PageRouteBuilder(
                                            pageBuilder: (context, animation,
                                                    secondaryAnimation) =>
                                                const GovtHomeScreen(),
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
                                              //slight fade effect
                                              //var opacityAnimation = animation.drive(tween);
                                              return SlideTransition(
                                                position: offsetAnimation,
                                                child: child,
                                              );
                                            },
                                          ),
                                        );
                                      }).onError((error, stackTrace) {
                                        debugPrint(error.toString());
                                        showToastMsg(error.toString());
                                      });
                                    } catch (e) {
                                      debugPrint("Error signing in : $e");
                                    }
                                    // try{
                                    //   FirebaseAuth.instance.sendPasswordResetEmail(email: loginEmailGovtTextController.text.trim());
                                    // } on FirebaseAuthException catch(e){
                                    //   showToastMsg(e);
                                    // }

                                    // Document(s) found with the field value matching the text field's value
                                    // You can perform further actions here
                                    // Document with the specified ID exists
                                    // var data = govtSnapshot.data();
                                    //
                                    // if (data != null &&
                                    //     data is Map<String, dynamic>) {
                                    //   // Retrieve the password and regNo from the document data
                                    //   String? regNoFromDatabase =
                                    //       data["GovtAgencyRegNo"] as String?;
                                    //   String? passwordFromDatabase =
                                    //       data["password"] as String?;
                                    //
                                    //   // Check if the inputted password and regno match the values from the database
                                    //   //both true
                                    //   if (regNoFromDatabase == regNoValue && passwordFromDatabase == pwdValue) {
                                    //
                                    //     //success
                                    //
                                    //     //one of them false
                                    //   } else if ((regNoFromDatabase == regNoValue && passwordFromDatabase != pwdValue)
                                    //       ||  (passwordFromDatabase == pwdValue && regNoFromDatabase != regNoValue)) {
                                    //     showToastMsg("Incorrect reg no or password");
                                    //     return;
                                    //   } else {
                                    //     showToastMsg("Invalid credentials");
                                    //     return;
                                    //   }
                                    // }
                                  } else {
                                    // No document found with the matching field value
                                    showToastMsg("Invalid credentials ..");
                                  }
                                } catch (e) {
                                  // Handle any errors
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
                        "Don't have an Account ? ",
                      ),
                      SizedBox(
                        height: 35,
                        width: 120,
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
                                                const GovtSignupPageScreen(),
                                          ));
                                    },
                                    child: const Text(
                                      "Sign Up First ! ..",
                                      // selectionColor: Colors.blueGrey,
                                    ))),
                            SvgPicture.asset(svg_for_line, width: 100),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
