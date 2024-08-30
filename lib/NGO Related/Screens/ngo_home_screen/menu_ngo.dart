//for menu items in drawer
// ignore_for_file: camel_case_types
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class Menu_ngo {
  final String title;
  final IconData icon;

  Menu_ngo({required this.title, required this.icon});
}

List<Menu_ngo> sidebarMenus = [
  Menu_ngo(
    title: "Home",
    icon: Icons.home,
  ),
  Menu_ngo(
    title: "Profile",
    icon: CupertinoIcons.profile_circled,
  ),
  Menu_ngo(
    title: "Other serving NGOs",
    icon: Icons.add_business_rounded,
  ),
  Menu_ngo(
    title: "Response History",
    icon: Icons.history_rounded,
  ),
  Menu_ngo(
    title: "Donation History",
    icon: Icons.currency_rupee_sharp,
  ),
  Menu_ngo(
    title: "Alerts",
    icon: Icons.crisis_alert,
  ),
  Menu_ngo(
    title: "Apply for Grant",
    icon: Icons.currency_rupee,
  ),
  Menu_ngo(
    title: "Media",
    icon: Iconsax.stickynote4,
  ),
];

List<Menu_ngo> sidebarMenus2 = [
  Menu_ngo(
    title: "FAQ",
    icon: Icons.question_answer_outlined,
  ),
  Menu_ngo(
    title: "About Us",
    icon: Icons.info_rounded,
  ),
  Menu_ngo(
    title: "Logout",
    icon: Iconsax.logout5,
  ),
];
