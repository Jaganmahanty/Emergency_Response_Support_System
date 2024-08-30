// ignore_for_file: non_constant_identifier_names, camel_case_types

import 'package:flutter/material.dart';
import '../../../Utils/constants.dart';
import 'citizen_guide_list.dart';

class DisasterList {
  final String disaster;

  DisasterList(this.disaster);
}

class Digital_Guide_Screen extends StatefulWidget {
  const Digital_Guide_Screen({super.key});

  @override
  State<Digital_Guide_Screen> createState() => _Digital_Guide_ScreenState();
}

class _Digital_Guide_ScreenState extends State<Digital_Guide_Screen> {
  static List<String> DisasterName = [
    'Flood',
    'Cyclone',
    'Tsunami',
    'Earthquake',
    'Avalanche',
    'Fire',
    'Gas and Chemical Leakages',
    'Cold Wave',
    'Thunderstorm',
    'Heat Wave',
    'Lightning',
    'Urban Floods',
    'Drought',
    'Forest Fire',
    'Landslide',
    'Air Pollution',
    'Biological Emergencies',
    'Nuclear Radiological Emergencies'
  ];
  final List<DisasterList> DisasterData = List.generate(
      DisasterName.length, (index) => DisasterList(DisasterName[index]));

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
        title: const Text("Digital Survival Guide"),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 3,left: 8,right: 8),
        child: ListView.builder(
          itemCount: DisasterData.length,
          itemBuilder: (context, index) {
            return Hero(
              tag: DisasterData[index].disaster,
              child: Card(
                child: ListTile(
                  title: Text(DisasterData[index].disaster),
                  onTap: () {
                    Navigator.of(context).push(
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            Display(
                          disasterList: DisasterData[index],
                        ),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                          var begin = const Offset(1.0, 0.0);
                          var end = Offset.zero;
                          var curve = Curves.ease;

                          var tween = Tween(begin: begin, end: end)
                              .chain(CurveTween(curve: curve));
                          var offsetAnimation = animation.drive(tween);

                          return SlideTransition(
                            position: offsetAnimation,
                            child: child,
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
