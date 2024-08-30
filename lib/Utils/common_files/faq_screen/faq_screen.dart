//import 'package:fff/Utils/constants.dart';
import 'package:fff/Utils/constants.dart';
import 'package:flutter/material.dart';

import 'faq_model.dart';

class FAQScreen extends StatefulWidget {
  const FAQScreen({super.key});

  @override
  State<FAQScreen> createState() => _FAQScreenState();
}

class _FAQScreenState extends State<FAQScreen> {
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
        title: const Text("  FAQ "),
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
                      "A phone number or is required for login. An OTP will be sent to your phone number for login."),
              FAQ(
                  question: "How can I request for the help in emergency?",
                  answer:
                      "You can request  for the help to the NGO and Government Agencies from the app by clicking under the 'Need any help' section. After that any near by NGO or Government Agency will contact you soon"),
              FAQ(
                  question: "How do I get alerts for my area or city?",
                  answer:
                      "BY selecting you're current city, You will get all Alerts related to your city."),
              FAQ(
                  question: "How will I know the Level of alerts?",
                  answer:
                      "All alerts are color coded to indicate their severity level. \nRed is high/critical, \nOrange is medium, \nYellow is low, \nGreen is advisory"),
              FAQ(
                  question:
                      "Can I get request for help from another location/city?",
                  answer:
                      "Yes, this can be done by changing your current city from the 'User profile' section so you can requests from another city or location. You can change your city by the 'User profile' then click on the top right icon then you can change city as well as state."),
              FAQ(
                  question: "How can I contact to a NGO?",
                  answer:
                      "Go to serving NGO/ Government Body section then select the state and city then you will get the list of all the registered NGO and Government bodies in which you can get a contact number and Email and also full address of them."),
              FAQ(
                  question: "How can I get details of the alert?",
                  answer:
                      "Details of the alert can be viewed under 'Alerts' from the homepage and also form the side menu."),
              FAQ(
                  question: "How can I get help near my location?",
                  answer:
                      "you can contact the NGO or Government bodies, numbers are provided in the NGO section You can also dial the emergency number 112."),
              FAQ(
                  question: "Can I get Air pollution information?",
                  answer:
                      "We are working upon this mechanism , an app will get an update regarding this functionality soon ."),
              FAQ(
                  question:
                      "How do I get to know what to do at the time of disaster?",
                  answer:
                      "For every alert visible on the homepage, do's and don'ts are provided for reference. You can also catch the Digital survival guide in which you will find what to do at the time of disaster"),
              FAQ(
                  question: "How my data will be used?",
                  answer:
                      "Your data will be kept in encrypted format and will only be used for delivering disaster and relief related information."),
              FAQ(
                  question:
                      "How I can know that any NGO or Government Agency is coming to help me in the situation of emergency?",
                  answer:
                      "Whenever any NGO or Government Agency accepts your requests; you will be get notified by all the details of that particular NGO or Government agency."),
              FAQ(
                  question: "How do I submit my details?",
                  answer:
                      "Go to the 'User Profile' section. Here you can update your profile with your personal details and details of emergency contact who can be contacted in case of any emergency or disaster."),
              FAQ(
                  question: "How do I know if these warnings are authentic?",
                  answer:
                      "Each and every warning published on the app is from recognized Government agencies, like the India Meteorological Department (IMD), Central Water Commission (CWC). Indian National Centre for Ocean Information Services (INCOIS). Defence Geoinformatics Research Establishment (GRE). Forest Survey of India (FSI) & various State Disaster Management Authorities (SDMAs') which are apex bodies responsible in case of any disaster."),
              FAQ(
                  question: "Where can I see my previous requests history?",
                  answer:
                      "You can find your all previous requests history under the 'Request history' section."),
              FAQ(
                  question: "What is Notice section?",
                  answer:
                      "You will get new News that is issued by Government officials or news about the disaster happens in our Nation."),
              FAQ(
                  question: "How can I Log out from the application?",
                  answer:
                      "You can find Log out button in bottom of the drawer ."),
              FAQ(
                  question: "What to do in critical situation?",
                  answer:
                      "You can request for the help and it's advisory to dial 112 in critical situation, You can directly dial 112 from the application."),
            ],
          ),
        ),
      ),
    );
  }
}
