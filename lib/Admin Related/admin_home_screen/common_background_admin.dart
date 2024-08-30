// ignore_for_file: camel_case_types, depend_on_referenced_packages, deprecated_member_use, avoid_function_literals_in_foreach_calls
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../admin_issue_emergency_contacts/admin_issue_emergency_contacts_screen.dart';
import '../admin_manage_alerts_screen/admin_alert_details_screen.dart';
import '../../Utils/common_files/alerts/alert_history_screen.dart';
import '../../../Components/Notification_related/notification_services.dart';
import '../../../Utils/Utils.dart';
import 'package:intl/intl.dart';
import '../admin_manage_citizen_screen/admin_view_citizen_screen.dart';
import '../admin_manage_govt_screen/admin_manage_govt_agency_screen.dart';
import '../admin_manage_media_screen/admin_manage_media_screen.dart';
import '../admin_manage_ngo_screen/admin_manage_ngo_screen.dart';
import '../admin_request_history_screen/admin_request_history_screen.dart';

class commonbg_admin extends StatefulWidget {
  const commonbg_admin({super.key});

  @override
  State<commonbg_admin> createState() => _commonbg_adminState();
}

class _commonbg_adminState extends State<commonbg_admin> {
  NotificationServices notificationServices = NotificationServices();
  String fetchedState = "";
  String fetchedCity = "";
  bool isFetched = false;

  int numberOfCitizen = 0;
  int numberOfNGO = 0;
  int numberOfGovt = 0;
  int numberOfReq = 0;
  int numberOfResponse = 0;

  @override
  void initState() {
    fetchNumbers();
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
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white12,
        body: Stack(
          children: [
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
                    padding: const EdgeInsets.only(left: 80, top: 15),
                    //location
                    child: Row(
                      children: [
                        const Icon(Icons.location_on_outlined,
                            color: Colors.redAccent, size: 18),
                        const SizedBox(width: 8),
                        isFetched
                            ? const Text(
                                "INDIA",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              )
                            : const SpinKitThreeBounce(
                                color: Colors.blueGrey,
                                size: 20,
                              ),
                        const Spacer(),
                        OutlinedButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                PageRouteBuilder(
                                  pageBuilder: (context, animation,
                                          secondaryAnimation) =>
                                      const Admin_Issue_Emergency_Numbers_Screen(),
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
                            child: const Text(
                              "Issue   📞",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.deepPurple),
                            )),
                        const SizedBox(width: 10),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: SvgPicture.asset("assets/images/logo_svg.svg",
                              height: 33, width: 33),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    child: Row(
                      children: [
                        // 1.USER
                        Builder(builder: (context) {
                          return Expanded(
                            child: GestureDetector(
                              onTap: () {
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
                              },
                              child: Container(
                                  //width: MediaQuery.of(context).size.width * 0.46,
                                  height: 80,
                                  decoration: BoxDecoration(
                                    gradient: const LinearGradient(
                                      colors: [Colors.yellow, Colors.teal],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      stops: [0.0, 1.0],
                                      tileMode: TileMode.mirror,
                                    ),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 0.0),
                                          child: numberOfCitizen == 0
                                              ? const SizedBox(
                                                  height: 30,
                                                  width: 30,
                                                  child:
                                                      CircularProgressIndicator(
                                                          color: Colors.white))
                                              : Text(
                                                  '$numberOfCitizen\nCitizen \nconnected',
                                                  textAlign: TextAlign.center,
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    // fontSize: 16,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                        ),
                                        const SizedBox(width: 6),
                                        const Icon(Icons.person,
                                            color: Colors.white, size: 28)
                                      ])),
                            ),
                          );
                        }),
                        const SizedBox(width: 8.0),
                        //2.NGO
                        Builder(builder: (context) {
                          return Expanded(
                            child: GestureDetector(
                              onTap: () {
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
                              },
                              child: Container(
                                  height: 80,
                                  decoration: BoxDecoration(
                                    gradient: const LinearGradient(
                                      colors: [
                                        Colors.orangeAccent,
                                        Colors.lightBlue
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.topRight,
                                      stops: [0.0, 1.0],
                                      tileMode: TileMode.mirror,
                                    ),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 0.0),
                                          child: numberOfNGO == 0
                                              ? const SizedBox(
                                                  height: 30,
                                                  width: 30,
                                                  child:
                                                      CircularProgressIndicator(
                                                          color: Colors.white))
                                              : Text(
                                                  '$numberOfNGO\nNGOs\nJoined',
                                                  textAlign: TextAlign.center,
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    // fontSize: 16,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                        ),
                                        const SizedBox(width: 6),
                                        const Icon(Icons.location_city_outlined,
                                            color: Colors.white, size: 28)
                                      ])),
                            ),
                          );
                        }),
                        const SizedBox(width: 8.0),
                        // 3.Govt
                        Builder(builder: (context) {
                          return Expanded(
                            child: GestureDetector(
                              onTap: () {
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
                              },
                              child: Container(
                                  height: 80,
                                  decoration: BoxDecoration(
                                    gradient: const LinearGradient(
                                      colors: [Colors.teal, Colors.yellow],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      stops: [0.0, 1.0],
                                      tileMode: TileMode.mirror,
                                    ),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 0.0),
                                          child: numberOfGovt == 0
                                              ? const SizedBox(
                                                  height: 30,
                                                  width: 30,
                                                  child:
                                                      CircularProgressIndicator(
                                                          color: Colors.white))
                                              : Text(
                                                  '$numberOfGovt\nGovt.Ags \njoined',
                                                  textAlign: TextAlign.center,
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    // fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                        ),
                                        const SizedBox(width: 6),
                                        const Icon(
                                            CupertinoIcons.building_2_fill,
                                            color: Colors.white,
                                            size: 28)
                                      ])),
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                  const SizedBox(height: 6),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                    child: Row(
                      children: [
                        //4. req
                        Builder(builder: (context) {
                          return Expanded(
                            child: GestureDetector(
                              onTap: () {
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
                              },
                              child: Container(
                                  height: 80,
                                  decoration: BoxDecoration(
                                    gradient: const LinearGradient(
                                      colors: [Colors.teal, Colors.orange],
                                      begin: Alignment.topLeft,
                                      end: Alignment.topRight,
                                      stops: [0.0, 1.0],
                                      tileMode: TileMode.mirror,
                                    ),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 0.0),
                                          child: numberOfReq == 0
                                              ? const SizedBox(
                                                  height: 30,
                                                  width: 30,
                                                  child:
                                                      CircularProgressIndicator(
                                                          color: Colors.white))
                                              : Text(
                                                  '$numberOfReq\nRequests ',
                                                  textAlign: TextAlign.center,
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                        ),
                                        const SizedBox(width: 8),
                                        const ImageIcon(
                                          AssetImage(
                                              'assets/images/request_icon.png'),
                                          color: Colors.white,
                                          // size: 5.0,
                                        ),
                                      ])),
                            ),
                          );
                        }),
                        const SizedBox(width: 12.0),
                        //5. response
                        Builder(builder: (context) {
                          return Expanded(
                            child: GestureDetector(
                              onTap: () {
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
                              },
                              child: Container(
                                  height: 80,
                                  decoration: BoxDecoration(
                                    gradient: const LinearGradient(
                                      colors: [Colors.orange, Colors.teal],
                                      begin: Alignment.topLeft,
                                      end: Alignment.topRight,
                                      stops: [0.0, 1.0],
                                      tileMode: TileMode.mirror,
                                    ),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 0.0),
                                          child: numberOfResponse == 0
                                              ? const SizedBox(
                                                  height: 30,
                                                  width: 30,
                                                  child:
                                                      CircularProgressIndicator(
                                                          color: Colors.white))
                                              : Text(
                                                  '$numberOfResponse\nResponses ',
                                                  textAlign: TextAlign.center,
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                        ),
                                        const SizedBox(width: 6),
                                        const Icon(Icons.restore_page,
                                            color: Colors.white, size: 28)
                                      ])),
                            ),
                          );
                        }),
                        // const SizedBox(width: 12.0),
                      ],
                    ),
                  ),
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
                                                          Admin_Alert_Details_Screen(
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
                  const SizedBox(height: 15),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
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
                            },
                            child: Padding(
                                padding: const EdgeInsets.only(right: 8),
                                child: Card(
                                  color: Colors.white,
                                  elevation: 4,
                                  child: Container(
                                    decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15))),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10),
                                      child: Column(
                                        children: [
                                          Image.asset("assets/images/req.png",
                                              height: 40, width: 40),
                                          const SizedBox(height: 10),
                                          const Text("Requests",
                                              style: TextStyle(
                                                  color: Colors.black)),
                                        ],
                                      ),
                                    ),
                                  ),
                                )),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
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
                            },
                            child: Padding(
                                padding: const EdgeInsets.only(right: 8),
                                child: Card(
                                  elevation: 4,
                                  color: Colors.white,
                                  child: Container(
                                    decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15))),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10),
                                      child: Column(
                                        children: [
                                          Image.asset("assets/images/guide.png",
                                              height: 40, width: 40),
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
                        )
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

  Future<void> fetchNumbers() async {
    try {
      //citizen
      DocumentSnapshot citizenSnap = await FirebaseFirestore.instance
          .collection("clc_citizen")
          .doc("citizen_count")
          .get();

      //ngo
      QuerySnapshot ngoSnap =
          await FirebaseFirestore.instance.collection("clc_ngo").get();

      //govt
      QuerySnapshot govtSnap =
          await FirebaseFirestore.instance.collection("clc_govt").get();

      //req
      QuerySnapshot reqSnap =
      await FirebaseFirestore.instance.collection("clc_request").get();

      //response
      DocumentSnapshot responseSnap = await FirebaseFirestore.instance
          .collection("clc_response")
          .doc("response_count")
          .get();

      setState(() {
        numberOfCitizen = (citizenSnap.exists) ? citizenSnap.get("count") : 0;
        numberOfNGO = ngoSnap.size;
        numberOfGovt = govtSnap.size;
        numberOfReq = reqSnap.size;
        numberOfResponse =
            (responseSnap.exists) ? responseSnap.get("count") : 0;
      });
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching number of documents : $e');
      }
    }
  }
}
