// ignore_for_file: camel_case_types, non_constant_identifier_names, depend_on_referenced_packages

import 'dart:ui';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import '../../../Utils/common_files/active_requests/active_requests_screen.dart';
import '../../../Utils/common_files/alerts/alert_history_screen.dart';
import '../../../Components/Notification_related/notification_services.dart';
import 'package:intl/intl.dart';
import '../../../Utils/Utils.dart';
import '../../../Utils/common_files/alerts/alert_screen.dart';
import '../../../Utils/common_files/media/media_history_screen.dart';
import '../ngo_respond_history.dart';

class commonbg_ngo extends StatefulWidget {
  const commonbg_ngo({super.key});

  @override
  State<commonbg_ngo> createState() => _commonbg_ngoState();
}

class _commonbg_ngoState extends State<commonbg_ngo> {
  NotificationServices notificationServices = NotificationServices();
  String fetchedState = "";
  String fetchedCity = "";
  bool isFetched = false;

  @override
  void initState() {
    super.initState();
    fetchNGOData();
    //for notification permission pop up
    notificationServices.requestNotificationPermission();
    Future.delayed(const Duration(milliseconds: 1600), () {
      setState(() {
        isFetched = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        //Just remove the 3 Positioned widgets as soon as possible
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
        // const RiveAnimation.asset("assets/RiveAssets/shapes.riv"),
        Positioned.fill(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
            child: const SizedBox(),
          ),
        ),

        //home page starts from here
        SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 80, top: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
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
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          PageRouteBuilder(
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                    const Active_Req_Screen(),
                            transitionsBuilder: (context, animation,
                                secondaryAnimation, child) {
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
                      icon: const Icon(Icons.notifications_active_outlined,
                          size: 30, color: Color(0xFF2c4178)),
                    ),
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
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
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
                                          fontWeight: FontWeight.w500,
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
                                      transitionsBuilder: (context, animation,
                                          secondaryAnimation, child) {
                                        var begin = const Offset(1.0, 0.0);
                                        var end = Offset.zero;
                                        var curve = Curves.ease;

                                        var tween = Tween(
                                                begin: begin, end: end)
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
                      if (snapshot.connectionState == ConnectionState.active) {
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
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.33,
                                      width: double.infinity,
                                      child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: snapshot.data!.docs.length,
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
                                                    documentSnapshot: snapshot
                                                        .data!.docs[index],
                                                  ),
                                                  transitionsBuilder: (context,
                                                      animation,
                                                      secondaryAnimation,
                                                      child) {
                                                    var begin =
                                                        const Offset(1.0, 0.0);
                                                    var end = Offset.zero;
                                                    var curve = Curves.ease;

                                                    var tween = Tween(
                                                            begin: begin,
                                                            end: end)
                                                        .chain(CurveTween(
                                                            curve: curve));
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
                                            child: SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.75,
                                              child: Card(
                                                color: cardColor,
                                                margin: const EdgeInsets.only(
                                                    bottom: 13,
                                                    left: 7,
                                                    right: 7),
                                                elevation: 3,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                ),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          vertical: 5,
                                                          horizontal: 7),
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
                                                                  Colors.grey,
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
                                                                    snapshot.data!
                                                                            .docs[index]
                                                                        [
                                                                        'typeofDisaster'],
                                                                    style:
                                                                        const TextStyle(
                                                                      fontSize:
                                                                          15,
                                                                      color: Colors
                                                                          .black,
                                                                    )),
                                                                const SizedBox(
                                                                    height: 3),
                                                                Text(
                                                                    "${snapshot.data!.docs[index]['state']} \t"
                                                                    " ${snapshot.data!.docs[index]['city']}",
                                                                    style:
                                                                        const TextStyle(
                                                                      color: Colors
                                                                          .black,
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
                                                            padding:
                                                                const EdgeInsets
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
                                                                  snapshot.data!
                                                                              .docs[
                                                                          index]
                                                                      [
                                                                      'description'],
                                                                  maxLines: 4,
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
                                                                    left: 15,
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
                                                                    snapshot.data!
                                                                            .docs[index]
                                                                        [
                                                                        'level'],
                                                                    style: const TextStyle(
                                                                        color: Colors
                                                                            .black,
                                                                        fontWeight:
                                                                            FontWeight.bold)),
                                                              ],
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                              height: 4),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                                    right: 10,
                                                                    bottom: 3),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .end,
                                                              children: [
                                                                const Icon(
                                                                    Icons
                                                                        .watch_later_outlined,
                                                                    size: 16,
                                                                    color: Colors
                                                                        .black54),
                                                                const SizedBox(
                                                                    width: 3),
                                                                Text(
                                                                    DateFormat('dd-MM-yyyy , HH:mm').format(DateTime.parse(snapshot
                                                                            .data!
                                                                            .docs[index]
                                                                        [
                                                                        'sentTime'])),
                                                                    style: const TextStyle(
                                                                        color: Colors
                                                                            .black54,
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
                                            ),
                                          );
                                        },
                                      ),
                                    ));
                        }
                      } else if (snapshot.hasError) {
                        showToastMsg(snapshot.hasError.toString());
                      } else {
                        return const Center(child: CircularProgressIndicator());
                      }
                      return const Center(child: CircularProgressIndicator());
                    }),
              ),
              const SizedBox(height: 15),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            PageRouteBuilder(
                              pageBuilder:
                                  (context, animation, secondaryAnimation) =>
                                      const NGO_Response_History_Screen(),
                              transitionsBuilder: (context, animation,
                                  secondaryAnimation, child) {
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
                        child: Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: Card(
                              elevation: 4,
                              color: Colors.white,
                              child: Container(
                                // height: 80,
                                decoration: const BoxDecoration(
                                    color: Colors.white12,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15))),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: Column(
                                    children: [
                                      Image.asset("assets/images/response.png",
                                          height: 40, width: 40),
                                      const SizedBox(height: 10),
                                      const Text("Responses",
                                          style:
                                              TextStyle(color: Colors.black)),
                                    ],
                                  ),
                                ),
                              ),
                            )),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            PageRouteBuilder(
                              pageBuilder:
                                  (context, animation, secondaryAnimation) =>
                                      const Media_History_Screen(),
                              transitionsBuilder: (context, animation,
                                  secondaryAnimation, child) {
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
                        child: Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: Card(
                              color: Colors.white,
                              elevation: 4,
                              child: Container(
                                // height: 80,
                                decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15))),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: Column(
                                    children: [
                                      Image.asset("assets/images/guide.png",
                                          height: 40, width: 40),
                                      const SizedBox(height: 10),
                                      const Text("Media",
                                          style:
                                              TextStyle(color: Colors.black)),
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
              const SizedBox(height: 10),
              CarouselSlider(
                  items: [
                    Container(
                      margin: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        image: const DecorationImage(
                          image: AssetImage('assets/images/a1.jpg'),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        image: const DecorationImage(
                          image: AssetImage('assets/images/a2.jpg'),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        image: const DecorationImage(
                          image: AssetImage('assets/images/a3.png'),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        image: const DecorationImage(
                          image: AssetImage('assets/images/a4.webp'),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                  ],
                  options: CarouselOptions(
                    height: 200,
                    aspectRatio: 16 / 8,
                    // viewportFraction: 0.85,
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 3),
                    autoPlayAnimationDuration:
                        const Duration(milliseconds: 900),
                    enlargeCenterPage: true,
                    //enlargeFactor: 0.5,
                    //reverse: true,
                  )),
              const SizedBox(height: 65)
            ],
          ),
        ),
      ],
    );
  }

  Future<void> fetchNGOData() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      // Fetch data from Firestore
      DocumentSnapshot GovtSnapshot = await FirebaseFirestore.instance
          .collection('clc_ngo')
          .doc(user?.email)
          .get();

      // Check if the document exists
      if (GovtSnapshot.exists) {
        // Access the fields from the document
        setState(() {
          fetchedState = GovtSnapshot.get('state');
          fetchedCity = GovtSnapshot.get('city');
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
