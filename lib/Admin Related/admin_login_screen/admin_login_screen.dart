// ignore_for_file: use_build_context_synchronously, camel_case_types
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../Utils/Utils.dart';
import '../admin_home_screen/home_screen_admin.dart';

class Admin_Login_Screen extends StatefulWidget {
  const Admin_Login_Screen({Key? key})
      : super(
          key: key,
        );

  @override
  State<Admin_Login_Screen> createState() => _Admin_Login_ScreenState();
}

class _Admin_Login_ScreenState extends State<Admin_Login_Screen> {
  TextEditingController pinTextController = TextEditingController();
  TextEditingController loginPwdNGOTextController = TextEditingController();
  TextEditingController loginEmailNGOTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  bool _obscurePwdText = true;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final _pinFocusNode = FocusNode();

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
                const SizedBox(height: 10),
                Expanded(
                  child: SingleChildScrollView(
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 5),
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom,
                          left: 16,
                          right: 16),
                      child: Column(
                        children: [
                          const SizedBox(height: 30),
                          const Text(
                            "Log In as an admin : ",
                            style: TextStyle(fontSize: 24),
                          ),
                          const SizedBox(height: 60),
                          SvgPicture.asset("assets/svg/admin_login.svg",
                              height: 280, width: 240),
                          const SizedBox(height: 100),
                          //pin field
                          Padding(
                            padding: const EdgeInsets.only(right: 5, left: 5),
                            child: TextFormField(
                              focusNode: _pinFocusNode,
                              controller: pinTextController,
                              obscureText: _obscurePwdText,
                              decoration: InputDecoration(
                                prefixIcon: const Icon(
                                  Icons.app_registration,
                                  color: Colors.deepPurple,
                                ),
                                hintText: "Enter 14 digit pin",
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
                              maxLength: 14,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Enter Admin pin to login';
                                }
                                if (value.isNotEmpty && value.length < 14) {
                                  return "Enter 14 digit pin";
                                }
                                return null;
                              },
                              onEditingComplete: () {
                                FocusScope.of(context).nextFocus();
                              },
                            ),
                          ),
                          const SizedBox(height: 25),
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
                      child: ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            String enteredPin = pinTextController.text;

                            // Check if the entered PIN is "Bharat@22/1/24"
                            if (enteredPin == "Bharat@22/1/24") {
                              // Show progress indicator
                              showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (BuildContext context) {
                                  return const Center(
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                    ),
                                  );
                                },
                              );

                              await Future.delayed(
                                  const Duration(milliseconds: 1200));
                              final SharedPreferences sharedPref =
                                  await SharedPreferences.getInstance();
                              sharedPref.setString("userType", "ADMIN");
                              //success
                              showToastMsg("Admin Logged in successfully ..");
                              Get.offAll(() => const AdminHomeScreen());
                            } else {
                              showToastMsg("Invalid PIN found..");
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
                        child: const Text("Log in"),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
