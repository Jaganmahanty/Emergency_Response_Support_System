// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import '../../../Utils/common_files/faq_screen/faq_model.dart';
import '../../../Utils/constants.dart';

class NGO_FAQ_Screen extends StatefulWidget {
  const NGO_FAQ_Screen({super.key});

  @override
  State<NGO_FAQ_Screen> createState() => _NGO_FAQ_ScreenState();
}

class _NGO_FAQ_ScreenState extends State<NGO_FAQ_Screen> {
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
                  answer:
                      "A Registered email and NGO Registration number is required for Login. After Entering these both field you need enter your password then after you can Login to the Application."),
              FAQ(
                  question:
                      "How can I Response someone who has requested for help?",
                  answer:
                      "Whenever someone is in the situation of emergency or in need of help they will request you through the Application and you will be notified immediately and will get the full information of person who has requested."),
              FAQ(
                  question: "How do I get alerts for my area or city?",
                  answer:
                      "By selecting you're current city, You will get all Alerts related to your city."),
              FAQ(
                  question:
                      "Where is my previous Responses information is saved?",
                  answer:
                      "You can find you're previous Response Information in side menu named \"Response History\"."),
              FAQ(
                  question: "How will I know the Level of alerts?",
                  answer:
                      "All alerts are color coded to indicate their severity level. \nRed is high/critical, \nOrange is medium, \nYellow is low, \nGreen is advisory"),
              FAQ(
                  question:
                      "Can I get request for help from another location/city?",
                  answer:
                      "NO, you will get requests only from the your registered city or area."),
              FAQ(
                  question: "How can I contact to a Citizen/requester?",
                  answer:
                      "You will get contact number as well as address of the person who is requesting for the help. You can also find it in \"Response History\" from the side menu."),
              FAQ(
                  question:
                      "Where can I find Feedbacks i got from the citizens?",
                  answer:
                      "You can find you're feedbacks from the \"Response History\" click on the response you want to see the feedback; if citizen have given feedback  then it will be appeared there or otherwise it will show \"Waiting for the feedback\"."),
              FAQ(
                  question: "How can I get details of the alert?",
                  answer:
                      "Details of the alert can be viewed under 'Alerts' from the homepage and also form the side menu."),
              FAQ(
                  question: "How can I  help near my location?",
                  answer:
                      "you can contact the NGO or Government bodies, numbers are provided in the NGO section You can also dial the emergency number 112."),
              FAQ(
                  question: "Will I get Pre-Alerts of any upcoming disaster?",
                  answer:
                      "Yes, You'll get the alerts for the disaster to prevent loss and to be ready to help people. All Alerts details can be seen in the 'Alerts' section of the app."),
              FAQ(
                  question:
                      "How do I get to know what to do at the time of disaster?",
                  answer:
                      "For every alert visible on the homepage, do's and don'ts are provided for reference. You can also catch the Digital survival guide in which you will find what to do at the time of disaster"),
              FAQ(
                  question: "How will my data be used?",
                  answer:
                      "Your data will be kept in encrypted format and will only be used for delivering disaster and relief related information."),
              FAQ(
                  question: "What is Credit Points?",
                  answer:
                      "Whenever any NGO or Government Agency Helps citizens in emergency and citizens gives the rating under 5 star you will get Score point according the feedback."),
              FAQ(
                  question: "How do I submit my details?",
                  answer:
                      "Go to the 'User Profile' section. Here you can update your profile with your personal details and details of emergency contact who can be contacted in case of any emergency or disaster."),
              FAQ(
                  question: "How do I know if these warnings are authentic?",
                  answer:
                      "Each and every warning published on the app is from recognized Government agencies, like the India Meteorological Department (IMD), Central Water Commission (CWC). Indian National Centre for Ocean Information Services (INCOIS). Defence Geoinformatics Research Establishment (GRE). Forest Survey of India (FSI) & various State Disaster Management Authorities (SDMAs') which are apex bodies responsible in case of any disaster."),
              FAQ(
                  question: "Where can I see my previous Responses history?",
                  answer:
                      "You can find your all previous Responses history under the \"Responses History\" section."),
              FAQ(
                  question: "What is Notice section?",
                  answer:
                      "You will get new News that is issued by Government officials or news about the disaster happens in our Nation."),
              FAQ(
                  question: "How can I Log out from the application?",
                  answer:
                      "You can find Log out button in bottom of the side menu ."),
              FAQ(
                  question: "What to do in critical situation?",
                  answer: "It's advisory to dial 112 in critical situation."),
            ],
          ),
        ),
      ),
    );
  }
}
