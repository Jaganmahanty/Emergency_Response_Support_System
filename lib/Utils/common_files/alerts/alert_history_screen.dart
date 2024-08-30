// ignore_for_file: camel_case_types, library_private_types_in_public_api, deprecated_member_use, depend_on_referenced_packages

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../Utils.dart';
import 'alert_screen.dart';
import '../../constants.dart';
import 'package:intl/intl.dart';

class Alert_History_Screen extends StatefulWidget {
  const Alert_History_Screen({super.key});

  @override
  State<Alert_History_Screen> createState() => _Alert_History_ScreenState();
}

class _Alert_History_ScreenState extends State<Alert_History_Screen> {
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
        title: const Text("Alerts"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 25,
                            height: 25,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.red,
                            ),
                          ),
                          const SizedBox(width: 5),
                          const Text(
                            'Critical',
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 25,
                            height: 25,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.orange,
                            ),
                          ),
                          const SizedBox(width: 5),
                          const Text(
                            'Severe',
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 25,
                            height: 25,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.yellow,
                            ),
                          ),
                          const SizedBox(width: 5),
                          const Text(
                            'Low',
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // const SizedBox(height: 4),
          const alert_history_list_widget()
        ],
      ),
    );
  }
}

class alert_history_list_widget extends StatefulWidget {
  const alert_history_list_widget({Key? key}) : super(key: key);

  @override
  _alert_history_list_widgetState createState() =>
      _alert_history_list_widgetState();
}

class _alert_history_list_widgetState extends State<alert_history_list_widget> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: RefreshIndicator(
          onRefresh: _refreshData,
          child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("clc_alert")
                  //.where("contactNumber", isEqualTo: mobileNo)
                  .orderBy('sentTime', descending: true)
                  // .limit(25)
                  .snapshots(),
              builder: (context, snapshot) {
                //.where("city", isEqualTo: widget.selectedCity)
                if (snapshot.connectionState == ConnectionState.active) {
                  if (snapshot.hasData) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 7, right: 7, top: 3),
                      child: snapshot.data!.docs.isEmpty
                          ? const Center(
                              child: Text(
                                'No records found for an alert !',
                                style: TextStyle(
                                  fontSize: 19,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey,
                                ),
                              ),
                            )
                          : ListView.builder(
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (context, index) {
                                String level =
                                    snapshot.data!.docs[index]['level'];
                                Color cardColor = getColorForLevel(level);

                                final alertTimeStr = snapshot.data!.docs[index]
                                    ['sentTime'] as String;
                                final alertTime = DateTime.parse(alertTimeStr);

                                final currentTime = DateTime.now();

                                final differenceInHours =
                                    currentTime.difference(alertTime).inHours;

                                //snapshot.data!.docs[index]['sentTime'];

                                if (differenceInHours <= 168) {
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).push(
                                        PageRouteBuilder(
                                          pageBuilder: (context, animation,
                                                  secondaryAnimation) =>
                                              Alert_Details_Screen(
                                            documentSnapshot:
                                                snapshot.data!.docs[index],
                                          ),
                                          transitionsBuilder: (context,
                                              animation,
                                              secondaryAnimation,
                                              child) {
                                            var begin = const Offset(1.0, 0.0);
                                            var end = Offset.zero;
                                            var curve = Curves.ease;

                                            var tween = Tween(
                                                    begin: begin, end: end)
                                                .chain(
                                                    CurveTween(curve: curve));
                                            var offsetAnimation =
                                                animation.drive(tween);

                                            return SlideTransition(
                                              position: offsetAnimation,
                                              child: child,
                                            );
                                          },
                                        ),
                                      );
                                    },
                                    child: Card(
                                      color: cardColor,
                                      margin: const EdgeInsets.only(
                                          bottom: 13, left: 7, right: 7),
                                      // Set margin to zero to remove white spaces
                                      elevation: 3,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 5, horizontal: 7),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                ListTile(
                                                  leading: CircleAvatar(
                                                    maxRadius: 14,
                                                    backgroundColor:
                                                        Colors.grey,
                                                    child: Text("${index + 1}"),
                                                  ),
                                                  //textColor: Colors.white,
                                                  title: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                          snapshot.data!
                                                                  .docs[index][
                                                              'typeofDisaster'],
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 15,
                                                            color: Colors.black,
                                                          )),
                                                      const SizedBox(height: 3),
                                                      Text(
                                                          "${snapshot.data!.docs[index]['state']} , ${snapshot.data!.docs[index]['city']}",
                                                          style:
                                                              const TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 15,
                                                          )),
                                                    ],
                                                  ),
                                                ),
                                                const SizedBox(height: 2),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 15, top: 5),
                                                  child: Row(
                                                    children: [
                                                      const Text(
                                                        "Level : ",
                                                      ),
                                                      Text(
                                                          snapshot.data!
                                                                  .docs[index]
                                                              ['level'],
                                                          style: const TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold)),
                                                    ],
                                                  ),
                                                ),
                                                const SizedBox(height: 2),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 10, bottom: 3),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      //const Text("City : ",style: TextStyle(fontWeight: FontWeight.bold)),
                                                      const Icon(
                                                          Icons
                                                              .watch_later_outlined,
                                                          size: 16,
                                                          color:
                                                              Colors.black54),
                                                      const SizedBox(width: 3),
                                                      Text(
                                                          DateFormat(
                                                                  'dd-MM-yyyy , HH:mm')
                                                              .format(DateTime
                                                                  .parse(snapshot
                                                                          .data!
                                                                          .docs[index][
                                                                      'sentTime'])),
                                                          style:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .black38,
                                                                  fontSize:
                                                                      12)),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }else{
                                  return Container();
                                }
                              }),
                    );
                  }
                } else if (snapshot.hasError) {
                  showToastMsg(snapshot.hasError.toString());
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
                return const Center(child: CircularProgressIndicator());
              }),
        ),
      ),
    );
  }

  Color getColorForLevel(String level) {
    switch (level) {
      case 'Low':
        return Colors.yellow.shade400;
      case 'Severe':
        return Colors.orange.shade700;
      case 'Critical':
        return Colors.red.shade500;
      default:
        return Colors.orange;
    }
  }

  Future<void> _refreshData() async {
    // Simulate a delay for refreshing data
    await Future.delayed(const Duration(milliseconds: 1200));
    setState(() {
      // Update your data here
    });
  }
}
