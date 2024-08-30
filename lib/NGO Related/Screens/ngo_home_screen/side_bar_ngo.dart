// ignore_for_file: camel_case_types, non_constant_identifier_names
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fff/NGO%20Related/Screens/ngo_home_screen/side_menu_ngo.dart';
import 'package:fff/Utils/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../Utils/common_files/alerts/alert_history_screen.dart';
import '../../../Utils/common_files/about_us/about_us_screen.dart';
import '../../../Utils/common_files/grant/apply_grant_screen.dart';
import '../../../Utils/common_files/media/media_history_screen.dart';
import '../../../Components/info_card.dart';
import '../../../_Root/type of user/select_user_type_screen.dart';
import '../NGO_list/NGO_list.dart';
import '../ngo_donation_screen/ngo_donation_history_screen.dart';
import '../ngo_faq_screen/ngo_faq_screen.dart';
import '../ngo_profile_screen.dart';
import '../ngo_respond_history.dart';
import 'menu_ngo.dart';

class SideBar_ngo extends StatefulWidget {
  const SideBar_ngo({super.key});

  @override
  State<SideBar_ngo> createState() => _SideBar_ngoState();
}

class _SideBar_ngoState extends State<SideBar_ngo> {
  Menu_ngo selectedSideMenu = sidebarMenus.first;
  String NGOName = "";
  String NGOEmail = "";

  @override
  void initState() {
    super.initState();
    fetchGovtData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: 288,
        height: double.infinity,
        decoration: const BoxDecoration(
          //color: Colors.blueGrey,
          //light purple
          //color: Color(0xFF9999db),
          //dark bluish
          color: Sidebar_BG,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(25), bottomRight: Radius.circular(25)),
        ),
        child: DefaultTextStyle(
          style: const TextStyle(color: Colors.white),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () => {},
                  child: InfoCard(
                    name: NGOName,
                    mail: NGOEmail,
                  ),
                ),
                const SizedBox(height: 25),
                ...sidebarMenus
                    .map((menu_ngo) => SideMenu_ngo(
                          menu: menu_ngo,
                          selectedMenu: selectedSideMenu,

                          //on tap routes ..
                          press: () async {
                            setState(() {
                              selectedSideMenu = menu_ngo;
                            });
                            //extra (for testing only)
                            await Future.delayed(
                                const Duration(milliseconds: 500));

                            if (menu_ngo.title.contains("Home")) {
                            } else if (menu_ngo.title.contains("Profile")) {
                              //ignore: use_build_context_synchronously
                              Navigator.of(context).push(
                                PageRouteBuilder(
                                  pageBuilder: (context, animation,
                                          secondaryAnimation) =>
                                      const NGO_Profile(),
                                  transitionsBuilder: (context, animation,
                                      secondaryAnimation, child) {
                                    var begin = const Offset(1.0, 0.0);
                                    var end = Offset.zero;
                                    var curve = Curves.ease;

                                    var tween = Tween(begin: begin, end: end)
                                        .chain(CurveTween(curve: curve));
                                    var offsetAnimation =
                                        animation.drive(tween);

                                    return SlideTransition(
                                      position: offsetAnimation,
                                      child: child,
                                    );
                                  },
                                ),
                              );
                            } else if (menu_ngo.title.contains("Other")) {
                              // ignore: use_build_context_synchronously
                              Navigator.of(context).push(
                                PageRouteBuilder(
                                  pageBuilder: (context, animation,
                                          secondaryAnimation) =>
                                      const NGO_List(),
                                  transitionsBuilder: (context, animation,
                                      secondaryAnimation, child) {
                                    var begin = const Offset(1.0, 0.0);
                                    var end = Offset.zero;
                                    var curve = Curves.ease;

                                    var tween = Tween(begin: begin, end: end)
                                        .chain(CurveTween(curve: curve));
                                    var offsetAnimation =
                                        animation.drive(tween);

                                    return SlideTransition(
                                      position: offsetAnimation,
                                      child: child,
                                    );
                                  },
                                ),
                              );
                            } else if (menu_ngo.title.contains("Response")) {
                              // ignore: use_build_context_synchronously
                              Navigator.of(context).push(
                                PageRouteBuilder(
                                  pageBuilder: (context, animation,
                                          secondaryAnimation) =>
                                      const NGO_Response_History_Screen(),
                                  transitionsBuilder: (context, animation,
                                      secondaryAnimation, child) {
                                    var begin = const Offset(1.0, 0.0);
                                    var end = Offset.zero;
                                    var curve = Curves.ease;

                                    var tween = Tween(begin: begin, end: end)
                                        .chain(CurveTween(curve: curve));
                                    var offsetAnimation =
                                        animation.drive(tween);

                                    return SlideTransition(
                                      position: offsetAnimation,
                                      child: child,
                                    );
                                  },
                                ),
                              );
                            } else if (menu_ngo.title.contains("Donation")) {
                              // ignore: use_build_context_synchronously
                              Navigator.of(context).push(
                                PageRouteBuilder(
                                  pageBuilder: (context, animation,
                                          secondaryAnimation) =>
                                      const NGO_Donation_History_Screen(),
                                  transitionsBuilder: (context, animation,
                                      secondaryAnimation, child) {
                                    var begin = const Offset(1.0, 0.0);
                                    var end = Offset.zero;
                                    var curve = Curves.ease;

                                    var tween = Tween(begin: begin, end: end)
                                        .chain(CurveTween(curve: curve));
                                    var offsetAnimation =
                                        animation.drive(tween);

                                    return SlideTransition(
                                      position: offsetAnimation,
                                      child: child,
                                    );
                                  },
                                ),
                              );
                            } else if (menu_ngo.title.contains("Alert")) {
                              //ignore: use_build_context_synchronously
                              Navigator.of(context).push(
                                PageRouteBuilder(
                                  pageBuilder: (context, animation,
                                          secondaryAnimation) =>
                                      const Alert_History_Screen(),
                                  transitionsBuilder: (context, animation,
                                      secondaryAnimation, child) {
                                    var begin = const Offset(1.0, 0.0);
                                    var end = Offset.zero;
                                    var curve = Curves.ease;

                                    var tween = Tween(begin: begin, end: end)
                                        .chain(CurveTween(curve: curve));
                                    var offsetAnimation =
                                        animation.drive(tween);

                                    return SlideTransition(
                                      position: offsetAnimation,
                                      child: child,
                                    );
                                  },
                                ),
                              );
                            } else if (menu_ngo.title.contains("Grant")) {
                              // ignore: use_build_context_synchronously
                              Navigator.of(context).push(
                                PageRouteBuilder(
                                  pageBuilder: (context, animation,
                                          secondaryAnimation) =>
                                      const ApplyForGrant(),
                                  transitionsBuilder: (context, animation,
                                      secondaryAnimation, child) {
                                    var begin = const Offset(1.0, 0.0);
                                    var end = Offset.zero;
                                    var curve = Curves.ease;

                                    var tween = Tween(begin: begin, end: end)
                                        .chain(CurveTween(curve: curve));
                                    var offsetAnimation =
                                        animation.drive(tween);

                                    return SlideTransition(
                                      position: offsetAnimation,
                                      child: child,
                                    );
                                  },
                                ),
                              );
                            } else if (menu_ngo.title.contains("Media")) {
                              // ignore: use_build_context_synchronously
                              Navigator.of(context).push(
                                PageRouteBuilder(
                                  pageBuilder: (context, animation,
                                          secondaryAnimation) =>
                                      const Media_History_Screen(),
                                  transitionsBuilder: (context, animation,
                                      secondaryAnimation, child) {
                                    var begin = const Offset(1.0, 0.0);
                                    var end = Offset.zero;
                                    var curve = Curves.ease;

                                    var tween = Tween(begin: begin, end: end)
                                        .chain(CurveTween(curve: curve));
                                    var offsetAnimation =
                                        animation.drive(tween);

                                    return SlideTransition(
                                      position: offsetAnimation,
                                      child: child,
                                    );
                                  },
                                ),
                              );
                            }
                            //till above
                          },
                          // riveOnInit: (artboard) {
                          //   menu_ngo.rive.status = RiveUtils.getRiveInput(artboard,
                          //       stateMachineName: menu_ngo.rive.stateMachineName);
                          // },
                        ))
                    .toList(),
                Padding(
                  padding: const EdgeInsets.only(left: 24, top: 40, bottom: 16),
                  child: Text(
                    "Others".toUpperCase(),
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(color: Colors.white70),
                  ),
                ),
                ...sidebarMenus2
                    .map((menu_ngo) => SideMenu_ngo(
                          menu: menu_ngo,
                          selectedMenu: selectedSideMenu,
                          press: () async {
                            setState(() {
                              selectedSideMenu = menu_ngo;
                            });
                            await Future.delayed(
                                const Duration(milliseconds: 500));

                            if (menu_ngo.title.contains("FAQ")) {
                              // ignore: use_build_context_synchronously
                              Navigator.of(context).push(
                                PageRouteBuilder(
                                  pageBuilder: (context, animation,
                                          secondaryAnimation) =>
                                      const NGO_FAQ_Screen(),
                                  transitionsBuilder: (context, animation,
                                      secondaryAnimation, child) {
                                    var begin = const Offset(1.0, 0.0);
                                    var end = Offset.zero;
                                    var curve = Curves.ease;

                                    var tween = Tween(begin: begin, end: end)
                                        .chain(CurveTween(curve: curve));
                                    var offsetAnimation =
                                        animation.drive(tween);

                                    return SlideTransition(
                                      position: offsetAnimation,
                                      child: child,
                                    );
                                  },
                                ),
                              );
                            } else if (menu_ngo.title.contains("About")) {
                              // ignore: use_build_context_synchronously
                              Navigator.of(context).push(
                                PageRouteBuilder(
                                  pageBuilder: (context, animation,
                                          secondaryAnimation) =>
                                      const AboutUsScreen(),
                                  transitionsBuilder: (context, animation,
                                      secondaryAnimation, child) {
                                    var begin = const Offset(1.0, 0.0);
                                    var end = Offset.zero;
                                    var curve = Curves.ease;

                                    var tween = Tween(begin: begin, end: end)
                                        .chain(CurveTween(curve: curve));
                                    var offsetAnimation =
                                        animation.drive(tween);

                                    return SlideTransition(
                                      position: offsetAnimation,
                                      child: child,
                                    );
                                  },
                                ),
                              );
                            } else if (menu_ngo.title.contains("Logout")) {
                              // ignore: use_build_context_synchronously
                              //To logs out the current user ..
                              final SharedPreferences sharedPref =
                                  await SharedPreferences.getInstance();
                              sharedPref.remove("userType");
                              await FirebaseAuth.instance.signOut();
                              // ignore: use_build_context_synchronously
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const SelectOptionPageScreen()),
                              );
                            }
                          },
                          // riveOnInit: (artboard) {
                          //   menu_ngo.rive.status = RiveUtils.getRiveInput(artboard,
                          //       stateMachineName: menu_ngo.rive.stateMachineName);
                          // },
                        ))
                    .toList(),
                const SizedBox(height: 50)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> fetchGovtData() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      // Fetch data from Firestore
      DocumentSnapshot GovtSnapshot = await FirebaseFirestore.instance
          .collection('clc_ngo')
          .doc(user?.email)
          .get();

      // Check if the document exists
      if (GovtSnapshot.exists) {
        // Access the fields from the document
        setState(() {
          NGOName = GovtSnapshot.get('nameOfNGO');
          NGOEmail = GovtSnapshot.get('email');
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
