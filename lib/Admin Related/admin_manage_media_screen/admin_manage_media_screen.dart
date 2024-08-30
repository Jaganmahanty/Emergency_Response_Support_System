// ignore_for_file: non_constant_identifier_names, depend_on_referenced_packages, use_build_context_synchronously, avoid_print, camel_case_types

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:intl/intl.dart';
import '../../Models/send_news_model.dart';
import '../../Utils/Utils.dart';
import 'admin_view_media_screen.dart';

class Admin_Manage_Media_Screen extends StatefulWidget {
  const Admin_Manage_Media_Screen({super.key});

  @override
  State<Admin_Manage_Media_Screen> createState() =>
      _Admin_Manage_Media_ScreenState();
}

class _Admin_Manage_Media_ScreenState extends State<Admin_Manage_Media_Screen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final FocusNode _FocusNode = FocusNode();

  File? pickedImage;
  bool isPicked = false;
  bool _showError = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Number of tabs
      child: Scaffold(
        appBar: AppBar(
          elevation: 50,
          backgroundColor: Colors.black12,
          centerTitle: true,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(25),
                  bottomLeft: Radius.circular(25))),
          title: const Text("Manage media"),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Add media'), // First tab
              Tab(text: 'View media'), // Second tab
            ],
          ),
        ),
        body: TabBarView(
          children: [
            SizedBox(
              width: double.infinity,
              child: RefreshIndicator(
                onRefresh: _refreshData,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    SingleChildScrollView(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Form(
                                          key: _formKey,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const SizedBox(height: 8),
                                              //title
                                              TextFormField(
                                                controller: _titleController,
                                                keyboardType:
                                                    TextInputType.multiline,
                                                decoration: InputDecoration(
                                                  hintText:
                                                      'Add media title...',
                                                  labelText: 'Add media title',
                                                  prefixIcon: const Icon(
                                                      Icons.newspaper),
                                                  focusColor: Colors.deepPurple,
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12),
                                                  ),
                                                ),
                                                validator: (value) {
                                                  if (value == null ||
                                                      value.isEmpty) {
                                                    _FocusNode.requestFocus();
                                                    return 'Title is required ';
                                                  }
                                                  if (value.isNotEmpty &&
                                                      value.length < 5) {
                                                    _FocusNode.requestFocus();
                                                    return "Too short title";
                                                  }
                                                  return null;
                                                },
                                              ),
                                              //upload btn
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 8, bottom: 10),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    const Text(
                                                      'Select your image : ',
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    const Spacer(),
                                                    GestureDetector(
                                                      onTap: () async {
                                                        final picker =
                                                            ImagePicker();
                                                        final XFile? image =
                                                            await picker.pickImage(
                                                                source:
                                                                    ImageSource
                                                                        .gallery);
                                                        if (image != null) {
                                                          pickedImage =
                                                              File(image.path);
                                                          setState(() {
                                                            isPicked = true;
                                                            _showError = false;
                                                          });
                                                        }
                                                      },
                                                      child: Align(
                                                        alignment:
                                                            AlignmentDirectional
                                                                .center,
                                                        child: Container(
                                                          width: 50,
                                                          height: 50,
                                                          decoration: BoxDecoration(
                                                              color: Colors
                                                                  .grey[200],
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          30)),
                                                          child: Icon(
                                                              Icons
                                                                  .add_a_photo_outlined,
                                                              size: 20,
                                                              color: Colors
                                                                  .deepPurple
                                                                  .shade400),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                  height: 180,
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          width: 2,
                                                          color: Colors
                                                              .deepPurple
                                                              .withOpacity(
                                                                  0.4)),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20)),
                                                  child: isPicked
                                                      ? FutureBuilder<void>(
                                                          future: loadImage(),
                                                          // Use a function to handle loading the image
                                                          builder: (BuildContext
                                                                  context,
                                                              AsyncSnapshot<
                                                                      void>
                                                                  snapshot) {
                                                            if (snapshot
                                                                    .connectionState ==
                                                                ConnectionState
                                                                    .waiting) {
                                                              return const Center(
                                                                child:
                                                                    CircularProgressIndicator(),
                                                              );
                                                            } else if (snapshot
                                                                .hasError) {
                                                              return const Center(
                                                                child: Text(
                                                                  'Error loading image',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          17,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500),
                                                                ),
                                                              );
                                                            } else {
                                                              return Image.file(
                                                                pickedImage!,
                                                                fit: BoxFit
                                                                    .contain,
                                                                height: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height,
                                                                width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width,
                                                              );
                                                            }
                                                          },
                                                        )
                                                      : const Center(
                                                          child: Text(
                                                            'No photo selected !',
                                                            style: TextStyle(
                                                                fontSize: 17,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                          ),
                                                        )),
                                              //img selection
                                              if (_showError)
                                                const Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 25, top: 5),
                                                  child: Text(
                                                    '* Kindly select an image first ..',
                                                    style: TextStyle(
                                                        color: Colors.red,
                                                        fontSize: 13,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                ),
                                              const SizedBox(height: 15),
                                              TextFormField(
                                                controller:
                                                    _descriptionController,
                                                keyboardType:
                                                    TextInputType.multiline,
                                                maxLines: 7,
                                                decoration: InputDecoration(
                                                  hintText:
                                                      'Add media description...',
                                                  labelText:
                                                      'Add media Description',
                                                  prefixIcon: const Icon(Icons
                                                      .description_outlined),
                                                  focusColor: Colors.deepPurple,
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12),
                                                  ),
                                                ),
                                                validator: (value) {
                                                  if (value == null ||
                                                      value.isEmpty) {
                                                    _FocusNode.requestFocus();
                                                    return 'Enter description';
                                                  }
                                                  if (value.isNotEmpty &&
                                                      value.length < 10) {
                                                    _FocusNode.requestFocus();
                                                    return "Too short description";
                                                  }
                                                  return null;
                                                },
                                              ),
                                              const SizedBox(height: 10),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Padding(
                        padding: const EdgeInsets.only(right: 20, left: 20),
                        child: Container(
                          padding: const EdgeInsets.only(bottom: 15),
                          width: double.infinity,
                          child: ClipRRect(
                              child: ElevatedButton(
                                  onPressed: () async {
                                    // Show progress indicator
                                    showDialog(
                                      context: context,
                                      barrierDismissible: false,
                                      builder: (BuildContext context) {
                                        return const Dialog(
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                top: 35,
                                                bottom: 25,
                                                left: 20,
                                                right: 20),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                SizedBox(height: 15),
                                                CircularProgressIndicator(
                                                    color: Colors.blue),
                                                SizedBox(height: 30),
                                                Text('Processing ...')
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    );

                                    // If form is valid, upload data
                                    if (isPicked == false) {
                                      setState(() {
                                        _showError = true;
                                      });
                                      // Navigator.pop(
                                      //     context); // Dismiss progress indicator
                                    }
                                    // Check if the form is valid
                                    if (_formKey.currentState!.validate()) {
                                      // Upload image to Firebase Storage
                                      String? imageUrl =
                                          await uploadImageToStorage(
                                              pickedImage!);

                                      // Remove progress indicator
                                      Navigator.pop(context);

                                      if (imageUrl != null) {
                                        // If image upload is successful, upload data to Firestore
                                        String description =
                                            _descriptionController.text;
                                        await uploadDataToFirestore(
                                            imageUrl, description);

                                        // Reset form fields
                                        setState(() {
                                          isPicked = false;
                                          _showError = false;
                                          _descriptionController.text = '';
                                          _titleController.text = '';
                                        });

                                        // Show success message
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                              content: Text(
                                                  'Media released successfully')),
                                        );
                                      } else {
                                        // If image upload fails, show error message
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                              content: Text(
                                                  'Failed to release media')),
                                        );
                                      }
                                    } else {
                                      Navigator.pop(
                                          context); // Dismiss progress indicator
                                    }
                                  },
                                  style: ButtonStyle(
                                      shape: MaterialStateProperty.all(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(18)))),
                                  child: const Text("Release media"))),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Content of the second tab View media history
            Column(
              children: [
                Expanded(
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
                            if (snapshot.connectionState ==
                                ConnectionState.active) {
                              if (snapshot.hasData) {
                                return Padding(
                                  padding: const EdgeInsets.only(
                                      left: 7, right: 7, top: 10),
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
                                              itemCount:
                                                  snapshot.data!.docs.length,
                                              itemBuilder: (context, index) {
                                                snapshot.data!.docs[index]
                                                    ['sentTime'];
                                                var document =
                                                    snapshot.data!.docs[index];
                                                String newsDesc = document[
                                                    'news_description'];
                                                String newsImage =
                                                    document['news_image'];
                                                return GestureDetector(
                                                  onTap: () {
                                                    Navigator.of(context).push(
                                                      PageRouteBuilder(
                                                        pageBuilder: (context,
                                                                animation,
                                                                secondaryAnimation) =>
                                                            Admin_Manage_News_Screen(
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
                                                          var curve =
                                                              Curves.ease;

                                                          var tween = Tween(
                                                                  begin: begin,
                                                                  end: end)
                                                              .chain(CurveTween(
                                                                  curve:
                                                                      curve));
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
                                                  child: Card(
                                                    color: Colors.white,
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
                                                                //textColor: Colors.white,
                                                                title: Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    const SizedBox(
                                                                        height:
                                                                            3),
                                                                    Text(
                                                                        snapshot
                                                                            .data!
                                                                            .docs[index]['news_title'],
                                                                        style: const TextStyle(
                                                                          color:
                                                                              Colors.black,
                                                                          fontSize:
                                                                              17,
                                                                        )),
                                                                  ],
                                                                ),
                                                              ),
                                                              if (newsImage
                                                                  .isNotEmpty)
                                                                Hero(
                                                                  tag: document[
                                                                      'news_id'],
                                                                  child:
                                                                      Padding(
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .all(
                                                                            8.0),
                                                                    child: Image
                                                                        .network(
                                                                      newsImage,
                                                                      // width:
                                                                      //     250,
                                                                      height:
                                                                          180,
                                                                      fit: BoxFit
                                                                          .contain,
                                                                      loadingBuilder: (BuildContext context,
                                                                          Widget
                                                                              child,
                                                                          ImageChunkEvent?
                                                                              loadingProgress) {
                                                                        if (loadingProgress ==
                                                                            null) {
                                                                          return child; // If image is fully loaded, display the image
                                                                        } else {
                                                                          return Center(
                                                                            child:
                                                                                CircularProgressIndicator(
                                                                              // Show CircularProgressIndicator while image is loading
                                                                              value: loadingProgress.expectedTotalBytes != null ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes! : null,
                                                                            ),
                                                                          );
                                                                        }
                                                                      },
                                                                    ),
                                                                  ),
                                                                ),
                                                              const SizedBox(
                                                                  height: 2),
                                                              Padding(
                                                                padding: const EdgeInsets
                                                                    .symmetric(
                                                                    horizontal:
                                                                        13),
                                                                child: SizedBox(
                                                                  width: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width *
                                                                      0.8,
                                                                  child: Text(
                                                                      newsDesc,
                                                                      maxLines:
                                                                          5,
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
                              return const Center(
                                  child: CircularProgressIndicator());
                            }
                            return const Center(
                                child: CircularProgressIndicator());
                          }),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<String?> uploadImageToStorage(File imageFile) async {
    try {
      firebase_storage.Reference storageRef = firebase_storage
          .FirebaseStorage.instance
          .ref()
          .child('news')
          .child('${DateTime.now().microsecondsSinceEpoch}.jpg');

      firebase_storage.UploadTask uploadTask = storageRef.putFile(imageFile);
      await uploadTask.whenComplete(() => print("Image uploaded to Storage"));
      String imageURL = await storageRef.getDownloadURL();
      return imageURL;
    } catch (e) {
      if (kDebugMode) {
        print("Error while uploading news image : $e");
      }
    }
    return null;
  }

  uploadDataToFirestore(String imageUrl, String description) async {
    try {
      int totalDocCount = 0;
      await FirebaseFirestore.instance.runTransaction((transaction) async {
        // Get the current count of requests
        DocumentSnapshot snapshot = await transaction.get(FirebaseFirestore
            .instance
            .collection("clc_news")
            .doc("news_count"));
        totalDocCount = (snapshot.exists) ? snapshot.get('count') : 0;
        totalDocCount++;

        transaction.set(
            FirebaseFirestore.instance.collection("clc_news").doc("news_count"),
            {'count': totalDocCount});
      });

      News_Registration newsData = News_Registration(
          news_Id: "News_${totalDocCount.toString()}",
          news_image: imageUrl,
          news_title: _titleController.text.trim(),
          news_desc: description);

      Map<String, dynamic> AdminAlertJson = newsData.toJsonNews();

      await FirebaseFirestore.instance
          .collection("clc_news")
          .doc("News_${totalDocCount.toString()}")
          .set(AdminAlertJson)
          .then((value) =>
              showMsgDialog(context, 'Media published successfully ..'));
    } catch (e) {
      // An error occurred
      if (kDebugMode) {
        print('Error adding alert data to firestore : $e');
      }
    }
  }

  Future<void> loadImage() async {
    await Future.delayed(const Duration(seconds: 1));
  }

  Future<void> _refreshData() async {
    await Future.delayed(const Duration(milliseconds: 1200));
    setState(() {});
  }
}
