//for menu items in drawer
// ignore_for_file: camel_case_types

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class Menu_govt {
  final String title;
  final IconData icon;

  Menu_govt({required this.title, required this.icon});
}

List<Menu_govt> sidebarMenus = [
  Menu_govt(
    title: "Home",
    icon: Icons.home,
  ),
  Menu_govt(
    title: "Profile",
    icon: Icons.person_2,
  ),
  Menu_govt(
    title: "Other Serving Government Agency ",
    icon: CupertinoIcons.house_alt_fill,
  ),
  Menu_govt(
    title: "Response History",
    icon: Icons.history,
  ),
  Menu_govt(
    title: "Alerts",
    icon: Icons.crisis_alert,
  ),
  Menu_govt(
    title: "Apply for Grant",
    icon: Icons.currency_rupee,
  ),
  Menu_govt(
    title: "Media",
    icon: Icons.circle_notifications,
  ),
];

List<Menu_govt> sidebarMenus2 = [
  Menu_govt(
    title: "FAQ",
    icon: Icons.question_answer_outlined,
  ),
  Menu_govt(
    title: "About Us",
    icon: Icons.info_rounded,
  ),
  Menu_govt(
    title: "Logout",
    icon: Iconsax.logout5,
  ),
];
