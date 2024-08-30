// ignore_for_file: camel_case_types, library_private_types_in_public_api, deprecated_member_use, depend_on_referenced_packages

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../../../Utils/Utils.dart';
import '../../../../Utils/constants.dart';
import 'package:intl/intl.dart';
import 'media_details_screen.dart';

class Media_History_Screen extends StatefulWidget {
  const Media_History_Screen({super.key});

  @override
  State<Media_History_Screen> createState() => _Media_History_ScreenState();
}

class _Media_History_ScreenState extends State<Media_History_Screen> {
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
        title: const Text("Media publishes"),
      ),
      body: const Column(
        children: [media_history_list_widget()],
      ),
    );
  }
}

class media_history_list_widget extends StatefulWidget {
  const media_history_list_widget({Key? key}) : super(key: key);

  @override
  _media_history_list_widgetState createState() =>
      _media_history_list_widgetState();
}

class _media_history_list_widgetState extends State<media_history_list_widget> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: RefreshIndicator(
          onRefresh: _refreshData,
          child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("clc_news")
                  // .where("contactNumber", isEqualTo: mobileNo)
                  .orderBy('sentTime', descending: true)
                  // .limit(25)
                  .snapshots(),
              builder: (context, snapshot) {
                //.where("city", isEqualTo: widget.selectedCity)
                if (snapshot.connectionState == ConnectionState.active) {
                  if (snapshot.hasData) {
                    return Padding(
                      padding:
                          const EdgeInsets.only(left: 7, right: 7, top: 10),
                      child: snapshot.data!.docs.isEmpty
                          ? const Center(
                              child: Text(
                                'No records found for media !',
                                style: TextStyle(
                                  fontSize: 19,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey,
                                ),
                              ),
                            )
                          : Scrollbar(
                              child: ListView.builder(
                                  itemCount: snapshot.data!.docs.length,
                                  itemBuilder: (context, index) {
                                    snapshot.data!.docs[index]['sentTime'];
                                    var document = snapshot.data!.docs[index];
                                    String newsDesc =
                                        document['news_description'];
                                    String newsImage = document['news_image'];
                                    return GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).push(
                                          PageRouteBuilder(
                                            pageBuilder: (context, animation,
                                                secondaryAnimation) =>
                                                Media_Details_Screen(
                                                  documentSnapshot:
                                                  snapshot.data!.docs[index],
                                                ),
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
                                      },
                                      child: Card(
                                        color: Colors.white,
                                        margin: const EdgeInsets.only(
                                            bottom: 13, left: 7, right: 7),
                                        // Set margin to zero to remove white spaces
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
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 5,
                                                      horizontal: 7),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  ListTile(
                                                    //textColor: Colors.white,
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
                                                                ['news_title'],
                                                            style:
                                                                const TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 17,
                                                            )),
                                                      ],
                                                    ),
                                                  ),
                                                  if (newsImage.isNotEmpty)
                                                    Hero(
                                                      tag: document['news_id'],
                                                      child: Padding(
                                                        padding: const EdgeInsets.all(8.0),
                                                        child: Image.network(
                                                          newsImage,
                                                          // width: 250,
                                                          height: 180,
                                                          fit: BoxFit.contain,
                                                          loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                                                            if (loadingProgress == null) {
                                                              return child; // If image is fully loaded, display the image
                                                            } else {
                                                              return Center(
                                                                child: CircularProgressIndicator( // Show CircularProgressIndicator while image is loading
                                                                  value: loadingProgress.expectedTotalBytes != null
                                                                      ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                                                                      : null,
                                                                ),
                                                              );
                                                            }
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                  const SizedBox(height: 2),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 13),
                                                    child: SizedBox(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.8,
                                                      child: Text(newsDesc,
                                                          maxLines: 5,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          textAlign: TextAlign.justify,
                                                          style:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize:
                                                                      15)),
                                                    ),
                                                  ),
                                                  const SizedBox(height: 5),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 10,
                                                            bottom: 3),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      children: [
                                                        const Icon(
                                                            Icons
                                                                .watch_later_outlined,
                                                            size: 16,
                                                            color:
                                                            Colors.black54),
                                                        const SizedBox(width: 7),
                                                        Text(
                                                            DateFormat(
                                                                'dd-MM-yyyy , HH:mm')
                                                                .format(DateTime
                                                                .parse(snapshot
                                                                .data!
                                                                .docs[index]
                                                            [
                                                            'sentTime'])),
                                                            style: const TextStyle(
                                                                color:
                                                                Colors.black38,
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
                                    );
                                  }),
                            ),
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

  Future<void> _refreshData() async {
    await Future.delayed(const Duration(milliseconds: 1200));
    setState(() {});
  }
}
