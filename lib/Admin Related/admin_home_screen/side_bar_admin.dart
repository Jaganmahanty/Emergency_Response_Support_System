// ignore_for_file: camel_case_types, use_build_context_synchronously

import 'package:fff/Admin%20Related/admin_home_screen/menu_admin.dart';
import 'package:fff/Admin%20Related/admin_home_screen/side_menu_admin.dart';
import 'package:fff/Utils/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../_Root/type of user/select_user_type_screen.dart';
import '../../../Components/info_card.dart';
import '../../Utils/common_files/about_us/about_us_screen.dart';
import '../admin_donation_screen/admin_donation_history_screen.dart';
import '../admin_faq_screen/admin_faq_screen.dart';
import '../admin_manage_alerts_screen/admin_manage_alert_screen.dart';
import '../admin_manage_citizen_screen/admin_view_citizen_screen.dart';
import '../admin_manage_govt_screen/admin_manage_govt_agency_screen.dart';
import '../admin_manage_media_screen/admin_manage_media_screen.dart';
import '../admin_manage_ngo_screen/admin_manage_ngo_screen.dart';
import '../admin_request_history_screen/admin_request_history_screen.dart';

class SideBar_Admin extends StatefulWidget {
  const SideBar_Admin({super.key});

  @override
  State<SideBar_Admin> createState() => _SideBar_AdminState();
}

class _SideBar_AdminState extends State<SideBar_Admin> {
  Menu_admin selectedSideMenu = sidebarMenus.first;
  String citizenName = "";
  String citizenMobile = "";

  @override
  void initState() {
    super.initState();
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
                  child: const InfoCard(
                    name: "ADMIN",
                    mail: "INDIA",
                  ),
                ),
                const SizedBox(height: 25),
                ...sidebarMenus
                    .map((menuAdmin) => SideMenu_admin(
                          menu: menuAdmin,
                          selectedMenu: selectedSideMenu,

                          //on tap routes ..
                          press: () async {
                            //RiveUtils.changeSMIBoolState(menu.rive.status!);
                            setState(() {
                              selectedSideMenu = menuAdmin;
                            });
                            //extra (for testing only)
                            await Future.delayed(
                                const Duration(milliseconds: 500));

                            if (menuAdmin.title.contains("Home")) {
                            } else if (menuAdmin.title.contains("Citizen")) {
                              Navigator.of(context).push(
                                PageRouteBuilder(
                                  pageBuilder: (context, animation,
                                          secondaryAnimation) =>
                                      const Admin_View_Citizen_Screen(),
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
                            } else if (menuAdmin.title.contains("NGO")) {
                              Navigator.of(context).push(
                                PageRouteBuilder(
                                  pageBuilder: (context, animation,
                                          secondaryAnimation) =>
                                      const Admin_Manage_NGO_Screen(),
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
                            } else if (menuAdmin.title.contains("Govt")) {
                              Navigator.of(context).push(
                                PageRouteBuilder(
                                  pageBuilder: (context, animation,
                                          secondaryAnimation) =>
                                      const Admin_Manage_Govt_Agency_Screen(),
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
                            } else if (menuAdmin.title.contains("Request")) {
                              Navigator.of(context).push(
                                PageRouteBuilder(
                                  pageBuilder: (context, animation,
                                          secondaryAnimation) =>
                                      const Admin_Request_History_Screen(),
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
                            } else if (menuAdmin.title.contains("Donation")) {
                              Navigator.of(context).push(
                                PageRouteBuilder(
                                  pageBuilder: (context, animation,
                                          secondaryAnimation) =>
                                      const Admin_Donation_History_Screen(),
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
                            } else if (menuAdmin.title.contains("Alert")) {
                              Navigator.of(context).push(
                                PageRouteBuilder(
                                  pageBuilder: (context, animation,
                                          secondaryAnimation) =>
                                      const Admin_Manage_Alert_Screen(),
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
                            } else if (menuAdmin.title.contains("Media")) {
                              Navigator.of(context).push(
                                PageRouteBuilder(
                                  pageBuilder: (context, animation,
                                          secondaryAnimation) =>
                                      const Admin_Manage_Media_Screen(),
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
                    .map((menu) => SideMenu_admin(
                          menu: menu,
                          selectedMenu: selectedSideMenu,
                          press: () async {
                            setState(() {
                              selectedSideMenu = menu;
                            });
                            await Future.delayed(
                                const Duration(milliseconds: 500));

                            if (menu.title.contains("FAQ")) {
                              Navigator.of(context).push(
                                PageRouteBuilder(
                                  pageBuilder: (context, animation,
                                          secondaryAnimation) =>
                                      const Admin_FAQ_Screen(),
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
                            } else if (menu.title.contains("About")) {
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
                            } else if (menu.title.contains("Logout")) {
                              //To logs out the current user ..
                              final SharedPreferences sharedPref =
                                  await SharedPreferences.getInstance();
                              sharedPref.remove("userType");
                              await FirebaseAuth.instance.signOut();
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const SelectOptionPageScreen()),
                              );
                            }
                          },
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
}
