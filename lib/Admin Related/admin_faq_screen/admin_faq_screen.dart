// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import '../../Utils/common_files/faq_screen/faq_model.dart';
import '../../Utils/constants.dart';

class Admin_FAQ_Screen extends StatefulWidget {
  const Admin_FAQ_Screen({super.key});

  @override
  State<Admin_FAQ_Screen> createState() => _Admin_FAQ_ScreenState();
}

class _Admin_FAQ_ScreenState extends State<Admin_FAQ_Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 50,
        backgroundColor: color_AppBar,
        centerTitle: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(25),
                bottomLeft: Radius.circular(25))),
        title: const Text("FAQ"),
      ),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
              FAQ(
                  showDivider: false,
                  question: "How to login?",
                  answer: "A 14 digit pin is required for login."),
              FAQ(
                  question: "How can I add a new Alert?",
                  answer:
                      "You can find option to add a new Alert in side menu namely \"Manage Alerts\"."),
              FAQ(
                  question: "How can I add a new Media?",
                  answer:
                      "You can find option to add a new Media in side menu namely \"Manage Media\" or you can also add it by clicking on \bMEDIA button from Home Page."),
              FAQ(
                  question: "Where can I delete or update profile of citizens?",
                  answer:
                      "You can Manage the citizen's profile like deleting it or updating the profile in side menu called \"Manage Citizen\". Here you can easily find list of citizens by city wise which helps you to manage citizen profile. "),
              FAQ(
                  question: "How can I manage the NGO profile?",
                  answer:
                      "You can Manage the NGO's profile in side menu called \"Manage Citizen\". Here you can easily find list of NGO by city wise which helps you to delete or updating NGO profile. "),
              FAQ(
                  question: "Where can I find Government Agencies list?",
                  answer:
                      "You can find the Government Agencies in side menu called \"Manage Govt Agencies\". Here you can easily find list of Govt Agencies by city wise which helps you to manage citizen profile. "),
              FAQ(
                  question: "How can I set the Level of the Alert?",
                  answer: "While Publishing n"
                      "ew Alert, You can set level of Alert in sliding bar which indicates different color and different color shows different Alert leve."),
              FAQ(
                  question: "How can I delete a Alert?",
                  answer: "You can delete a Alert from \"Manage Alerts\"."),
              FAQ(
                  question: "Where can I find the all the requests?",
                  answer:
                      "You can get the all the request made up by the citizen in the side menu called \"Request History\"."),
              FAQ(
                  question: "How can I add new Media?",
                  answer:
                      "You can add a new Media from  the side menu called \"Manage Media\" or you can also find the Media button in the bottom of the homepage of the Admin."),
              FAQ(
                  question: "How many pictures can I attach with the media?",
                  answer:
                      "For Now you can attach 1 picture with media but after sometime the picture limit will be increased to 4 ."),
              FAQ(
                  question: "Where can I find the all the requests?",
                  answer:
                      "You can get the all the request made up by the citizen in the side menu called \"Request History\"."),
              FAQ(
                  question: "How to delete published media?",
                  answer:
                      "You can delete the published media from the side menu called \"Manage Media\"."),
            ],
          ),
        ),
      ),
    );
  }
}
