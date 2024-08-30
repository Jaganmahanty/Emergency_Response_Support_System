// ignore_for_file: camel_case_types, depend_on_referenced_packages, deprecated_member_use
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iconsax/iconsax.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../Utils/common_files/alerts/alert_history_screen.dart';
import '../../../Components/Notification_related/notification_services.dart';
import '../../../Utils/Utils.dart';
import 'package:intl/intl.dart';
import '../../../Utils/common_files/alerts/alert_screen.dart';
import '../../../Utils/common_files/media/media_history_screen.dart';
import '../../../Utils/constants.dart';
import '../citizen_DSG/citizen_disaster_list.dart';
import '../citizen_helipline_screen.dart';
import '../citizen_request_screen/citizen_request_screen.dart';

class commonbg extends StatefulWidget {
  const commonbg({super.key});

  @override
  State<commonbg> createState() => _commonbgState();
}

class _commonbgState extends State<commonbg> {
  NotificationServices notificationServices = NotificationServices();
  String fetchedState = "";
  String fetchedCity = "";
  bool isFetched = false;

  final bool _showWelcomeDialog = true;
  bool _welcomeDialogShown = false;

  String info = '';
  String state = '';
  String city = '';
  String level = '';
  String c1 = '';
  String c2 = '';
  String c3 = '';
  String c4 = '';
  String c5 = '';
  String c6 = '';

  @override
  void initState() {
    super.initState();
    fetchCitizenData();
    Future.delayed(const Duration(milliseconds: 1600), () {
      setState(() {
        isFetched = true;
      });
    });
    //for notification permission pop up
    notificationServices.requestNotificationPermission();
    //listen to  incoming msg...
    // notificationServices.firebaseInit(context);

    //for  notification when background and terminated case of application
    notificationServices.setupInteractMessage(context);
  }

  @override
  Widget build(BuildContext context) {
    if (_showWelcomeDialog && !_welcomeDialogShown) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _showEmergencyContactsPopUp(context);
      });
    }
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white12,
        body: Stack(
          children: [
            // Positioned(
            //     width: MediaQuery.of(context).size.width * 1.7,
            //     bottom: 200,
            //     left: 100,
            //     child: Image.asset("assets/Backgrounds/Spline.png")),
            // Positioned.fill(
            //   child: BackdropFilter(
            //     filter: ImageFilter.blur(sigmaX: 78, sigmaY: 78),
            //   ),
            // ),
            // const Rive Animation.asset("assets/RiveAssets/shapes.riv"),
            Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
                child: const SizedBox(),
              ),
            ),

            //home design
            SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 80, top: 20),
                    //location
                    child: Row(
                      children: [
                        const Icon(Icons.location_on_outlined,
                            color: Colors.redAccent, size: 18),
                        const SizedBox(width: 8),
                        isFetched
                            ? Text(
                                "$fetchedCity, $fetchedState",
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              )
                            : const SpinKitThreeBounce(
                                color: Colors.blueGrey,
                                size: 20,
                              ),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: SvgPicture.asset("assets/images/logo_svg.svg",
                              height: 33, width: 33),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  //latest alert
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    child: Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const SizedBox(width: 3),
                                const Text(
                                  "Latest alerts :",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                                const Spacer(),
                                TextButton(
                                    child: const Row(
                                      children: [
                                        Text("View More",
                                            style: TextStyle(
                                              color: Colors.teal,
                                              fontSize: 11,
                                              fontWeight: FontWeight.w600,
                                            )),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Icon(Icons.arrow_forward,
                                            color: Colors.teal),
                                      ],
                                    ),
                                    onPressed: () {
                                      Navigator.of(context).push(
                                        PageRouteBuilder(
                                          pageBuilder: (context, animation,
                                                  secondaryAnimation) =>
                                              const Alert_History_Screen(),
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
                                    }),
                              ],
                            ),
                            //Spacer(),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection("clc_alert")
                            //.where("contactNumber", isEqualTo: mobileNo)
                            .orderBy('sentTime', descending: true)
                            .limit(5)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.active) {
                            if (snapshot.hasData) {
                              return Padding(
                                  padding: const EdgeInsets.only(
                                      left: 7, right: 7, top: 10),
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
                                      : SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.33,
                                          width: double.infinity,
                                          child: ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            itemCount:
                                                snapshot.data!.docs.length,
                                            itemBuilder: (context, index) {
                                              String level = snapshot
                                                  .data!.docs[index]['level'];
                                              Color cardColor =
                                                  getColorForLevel(level);
                                              //snapshot.data!.docs[index]['sentTime'];
                                              return GestureDetector(
                                                onTap: () {
                                                  Navigator.of(context).push(
                                                    PageRouteBuilder(
                                                      pageBuilder: (context,
                                                              animation,
                                                              secondaryAnimation) =>
                                                          Alert_Details_Screen(
                                                        documentSnapshot:
                                                            snapshot.data!
                                                                .docs[index],
                                                      ),
                                                      transitionsBuilder:
                                                          (context,
                                                              animation,
                                                              secondaryAnimation,
                                                              child) {
                                                        var begin =
                                                            const Offset(
                                                                1.0, 0.0);
                                                        var end = Offset.zero;
                                                        var curve = Curves.ease;

                                                        var tween = Tween(
                                                                begin: begin,
                                                                end: end)
                                                            .chain(CurveTween(
                                                                curve: curve));
                                                        var offsetAnimation =
                                                            animation
                                                                .drive(tween);

                                                        return SlideTransition(
                                                          position:
                                                              offsetAnimation,
                                                          child: child,
                                                        );
                                                      },
                                                    ),
                                                  );
                                                },
                                                child: SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.75,
                                                  child: Card(
                                                    color: cardColor,
                                                    margin:
                                                        const EdgeInsets.only(
                                                            bottom: 13,
                                                            left: 7,
                                                            right: 7),
                                                    // Set margin to zero to remove white spaces
                                                    elevation: 3,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15),
                                                    ),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  vertical: 5,
                                                                  horizontal:
                                                                      7),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              ListTile(
                                                                leading:
                                                                    CircleAvatar(
                                                                  maxRadius: 14,
                                                                  backgroundColor:
                                                                      Colors
                                                                          .grey,
                                                                  child: Text(
                                                                      "${index + 1}"),
                                                                ),
                                                                title: Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Text(
                                                                        snapshot
                                                                            .data!
                                                                            .docs[index]['typeofDisaster'],
                                                                        style: const TextStyle(
                                                                          fontSize:
                                                                              15,
                                                                          color:
                                                                              Colors.black,
                                                                        )),
                                                                    const SizedBox(
                                                                        height:
                                                                            3),
                                                                    Text(
                                                                        "${snapshot.data!.docs[index]['state']} \t"
                                                                        " ${snapshot.data!.docs[index]['city']}",
                                                                        style:
                                                                            const TextStyle(
                                                                          color:
                                                                              Colors.black,
                                                                          fontSize:
                                                                              13,
                                                                        )),
                                                                  ],
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                  height: 10),
                                                              const Divider(
                                                                  height: 2,
                                                                  color: Colors
                                                                      .black54),
                                                              const SizedBox(
                                                                  height: 10),
                                                              Padding(
                                                                padding: const EdgeInsets
                                                                    .symmetric(
                                                                    horizontal:
                                                                        10),
                                                                child: SizedBox(
                                                                  width: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width *
                                                                      0.65,
                                                                  child: Text(
                                                                      snapshot.data!.docs[
                                                                              index]
                                                                          [
                                                                          'description'],
                                                                      maxLines:
                                                                          4,
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                      textAlign:
                                                                          TextAlign
                                                                              .justify,
                                                                      style: const TextStyle(
                                                                          color: Colors
                                                                              .black,
                                                                          fontSize:
                                                                              15)),
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                  height: 5),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .only(
                                                                        left:
                                                                            15,
                                                                        top: 5),
                                                                child: Row(
                                                                  children: [
                                                                    const Text(
                                                                      "Level : ",
                                                                      style:
                                                                          TextStyle(
                                                                        color: Colors
                                                                            .black,
                                                                      ),
                                                                    ),
                                                                    Text(
                                                                        snapshot.data!.docs[index]
                                                                            [
                                                                            'level'],
                                                                        style: const TextStyle(
                                                                            color:
                                                                                Colors.black,
                                                                            fontWeight: FontWeight.bold)),
                                                                  ],
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                  height: 4),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .only(
                                                                        right:
                                                                            10,
                                                                        bottom:
                                                                            3),
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .end,
                                                                  children: [
                                                                    const Icon(
                                                                        Icons
                                                                            .watch_later_outlined,
                                                                        size:
                                                                            16,
                                                                        color: Colors
                                                                            .black54),
                                                                    const SizedBox(
                                                                        width:
                                                                            3),
                                                                    Text(
                                                                        DateFormat('dd-MM-yyyy , HH:mm').format(DateTime.parse(snapshot.data!.docs[index]
                                                                            [
                                                                            'sentTime'])),
                                                                        style: const TextStyle(
                                                                            color:
                                                                                Colors.black54,
                                                                            fontSize: 12)),
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ));
                            }
                          } else if (snapshot.hasError) {
                            showToastMsg(snapshot.hasError.toString());
                          } else {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                          return const Center(
                              child: CircularProgressIndicator());
                        }),
                  ),

                  //emergency btn
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                    child: Container(
                      // height: 150,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        color: Colors.black12,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text("Need any help?",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w900,
                                    fontSize: 19)),
                            const SizedBox(height: 8),
                            OutlinedButton(
                              style: const ButtonStyle(
                                  enableFeedback: true,
                                  backgroundColor:
                                      MaterialStatePropertyAll(Colors.red),
                                  foregroundColor:
                                      MaterialStatePropertyAll(Colors.white)),
                              child: const Text("Request for any Emergency"),
                              onPressed: () {
                                Navigator.of(context).push(
                                  PageRouteBuilder(
                                    pageBuilder: (context, animation,
                                            secondaryAnimation) =>
                                        const userRequest_Screen(),
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
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  //112
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    child: Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Text(
                              "Dial 112 if you didn't get any "
                              "\n response from Agency :",
                              maxLines: 3,
                              textAlign: TextAlign.justify,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                            ),
                            const Spacer(),
                            IconButton(
                                style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all(Colors.red)),
                                icon: const Icon(Iconsax.call5,
                                    color: Colors.white),
                                onPressed: () {
                                  launch(
                                    'tel:112',
                                  );
                                }),
                            const SizedBox(width: 5),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  //3 box
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 2),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        //1st
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                PageRouteBuilder(
                                  pageBuilder: (context, animation,
                                          secondaryAnimation) =>
                                      const Digital_Guide_Screen(),
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
                            },
                            child: Padding(
                                padding: const EdgeInsets.only(right: 8),
                                child: Card(
                                  color: Colors.white,
                                  elevation: 4,
                                  child: Container(
                                    // height: 80,
                                    decoration: const BoxDecoration(
                                        color: Colors.white12,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15))),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10),
                                      child: Column(
                                        children: [
                                          Image.asset("assets/images/news.png",
                                              height: 30, width: 30),
                                          const SizedBox(height: 10),
                                          const Text("DSG",
                                              style: TextStyle(
                                                  color: Colors.black)),
                                        ],
                                      ),
                                    ),
                                  ),
                                )),
                          ),
                        ),
                        //2nd
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
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
                            },
                            child: Padding(
                                padding: const EdgeInsets.only(right: 8),
                                child: Card(
                                  color: Colors.white,
                                  elevation: 4,
                                  child: Container(
                                    // height: 80,
                                    decoration: const BoxDecoration(
                                        color: Colors.white12,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15))),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10),
                                      child: Column(
                                        children: [
                                          Image.asset("assets/images/guide.png",
                                              height: 30, width: 30),
                                          const SizedBox(height: 10),
                                          const Text("Media",
                                              style: TextStyle(
                                                  color: Colors.black)),
                                        ],
                                      ),
                                    ),
                                  ),
                                )),
                          ),
                        ),
                        //3rd
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                PageRouteBuilder(
                                  pageBuilder: (context, animation,
                                          secondaryAnimation) =>
                                      const Citizen_HelpLines(),
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
                            },
                            child: Padding(
                                padding: const EdgeInsets.only(right: 8),
                                child: Card(
                                  color: Colors.white,
                                  elevation: 4,
                                  child: Container(
                                    // height: 80,
                                    decoration: const BoxDecoration(
                                        color: Colors.white12,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15))),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10),
                                      child: Column(
                                        children: [
                                          Image.asset(
                                              "assets/images/helpline.png",
                                              height: 30,
                                              width: 30),
                                          const SizedBox(height: 10),
                                          const Text("Helpline",
                                              style: TextStyle(
                                                  color: Colors.black)),
                                        ],
                                      ),
                                    ),
                                  ),
                                )),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showEmergencyContactsPopUp(BuildContext context) {
    _welcomeDialogShown = true;
    if (_showWelcomeDialog) {
      fetchCitizenData().then((value) => showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (BuildContext context) {
              return Stack(
                children: [
                  Container(
                    padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom,
                    ),
                    height: MediaQuery.of(context).size.height * 0.8,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          StreamBuilder(
                            stream: FirebaseFirestore.instance
                                .collection("clc_emergency_numbers")
                                .where("city", isEqualTo: fetchedCity)
                                .where("isVisible", isEqualTo: "true")
                                .orderBy('sentTime', descending: true)
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.active) {
                                if (snapshot.hasData) {
                                  var documents = snapshot.data!.docs;
                                  if (documents.isNotEmpty) {
                                    // Extracting values from the first document
                                    var firstDoc = documents[0];
                                    // typeofDisaster = firstDoc['info'];
                                    state = firstDoc['state'];
                                    city = firstDoc['city'];
                                    info = firstDoc['info'];
                                    c1 = firstDoc['Contact_1'];
                                    c2 = firstDoc['Contact_2'];
                                    c3 = firstDoc['Contact_3'];
                                    c4 = firstDoc['Contact_4'];
                                    c5 = firstDoc['Contact_5'];
                                    c6 = firstDoc['Contact_6'];

                                    List<DataRow> rows = [
                                      buildSingleRow("1. $c1"),
                                    ];

                                    if (c2.isNotEmpty) {
                                      rows.add(buildSingleRow("2. $c2"));
                                    }
                                    if (c3.isNotEmpty) {
                                      rows.add(buildSingleRow("3. $c3"));
                                    }
                                    if (c4.isNotEmpty) {
                                      rows.add(buildSingleRow("4. $c4"));
                                    }
                                    if (c5.isNotEmpty) {
                                      rows.add(buildSingleRow("5. $c5"));
                                    }
                                    if (c6.isNotEmpty) {
                                      rows.add(buildSingleRow("6. $c6"));
                                    }

                                    return Padding(
                                      padding: const EdgeInsets.only(
                                          left: 15, right: 15, top: 8),
                                      child: Column(
                                        children: [
                                          const SizedBox(height: 15),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10),
                                            child: Center(
                                              child: Text(info,
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 20)),
                                            ),
                                          ),
                                          const SizedBox(height: 15),
                                          const Image(
                                            image: AssetImage(
                                                "assets/images/emergency_contact.png"),
                                            width: 100,
                                            height: 100,
                                          ),
                                          const SizedBox(height: 15),
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 20, vertical: 8),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(19.0),
                                              border: Border.all(
                                                color: Colors.grey,
                                                width: 1.0,
                                              ),
                                            ),
                                            child: DataTable(
                                              columnSpacing: 10.0,
                                              columns: const [
                                                DataColumn(
                                                    label: Text('Contacts',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                colorPrimary))),
                                              ],
                                              rows: rows,
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  } else {
                                    return  Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        const SizedBox(height: 160),
                                        Image.asset("assets/images/not_found.png",height: 100,width: 100),
                                        const SizedBox(height: 70),
                                        const Center(
                                          child: Text(
                                            'No emergency contact details found !',
                                            style: TextStyle(
                                              fontSize: 19,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  }
                                }
                              } else if (snapshot.hasError) {
                                showToastMsg(snapshot.error.toString());
                              }
                              return const Center(
                                  child: CircularProgressIndicator());
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: -25,
                    right: 0,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                  ),
                ],
              );
            },
          ));
    }
  }

  Future<void> fetchCitizenData() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      // Fetch data from Firestore
      DocumentSnapshot citizenSnapshot = await FirebaseFirestore.instance
          .collection('clc_citizen')
          .doc(user?.phoneNumber)
          .get();

      // Check if the document exists
      if (citizenSnapshot.exists) {
        // Access the fields from the document
        setState(() {
          fetchedState = citizenSnapshot.get('state');
          fetchedCity = citizenSnapshot.get('city');
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
