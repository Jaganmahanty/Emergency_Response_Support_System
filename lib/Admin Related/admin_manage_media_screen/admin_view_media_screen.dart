// ignore_for_file: camel_case_types, depend_on_referenced_packages, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../Utils/Utils.dart';

class Admin_Manage_News_Screen extends StatefulWidget {
  final DocumentSnapshot documentSnapshot;

  const Admin_Manage_News_Screen({super.key, required this.documentSnapshot});

  @override
  State<Admin_Manage_News_Screen> createState() =>
      _Admin_Manage_News_ScreenState();
}

class _Admin_Manage_News_ScreenState extends State<Admin_Manage_News_Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 50,
          backgroundColor: Colors.black12,
          centerTitle: true,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(25),
                  bottomLeft: Radius.circular(25))),
          title: const Text("Media Details"),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 18),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Column(
                  children: [
                    Text(
                      widget.documentSnapshot['news_title'],
                      style: const TextStyle(
                        color: Colors.deepPurple,
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const Spacer(),
                        const Icon(Icons.watch_later_outlined, size: 16),
                        const SizedBox(width: 5),
                        Text(
                            DateFormat('dd-MM-yyyy , HH:mm').format(
                                DateTime.parse(
                                    widget.documentSnapshot['sentTime'])),
                            style: const TextStyle(fontSize: 10)),
                        const SizedBox(width: 15)
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Align(
                alignment: AlignmentDirectional.center,
                child: Hero(
                  tag: widget.documentSnapshot['news_id'],
                  child: Container(
                    width: MediaQuery.of(context).size.width - 20,
                    height: 200,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(
                              "${widget.documentSnapshot['news_image']}"),
                          fit: BoxFit.scaleDown,
                        )),
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 2),
                        Text(
                          widget.documentSnapshot['news_description'],
                          textAlign: TextAlign.justify,
                          style: const TextStyle(
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(height: 25),
                        const SizedBox(height: 30)
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(right: 20, left: 20, bottom: 15,top: 9),
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: ElevatedButton(
                    onPressed: () async {
                      final CupertinoAlertDialog alert = CupertinoAlertDialog(
                        title: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('Confirm : ',
                              style: TextStyle(fontSize: 16)),
                        ),
                        content: const Text('Delete this media ?'),
                        actions: <Widget>[
                          CupertinoDialogAction(
                            isDefaultAction: true,
                            child: const Text('Cancel'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          CupertinoDialogAction(
                            isDefaultAction: true,
                            child: const Text('Delete'),
                            onPressed: () async {
                              deleteMedia();
                              Navigator.pop(context, true);
                              showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (BuildContext context) {
                                  return const Center(
                                    child: CircularProgressIndicator(
                                        color: Colors.white),
                                  );
                                },
                              );
                              await Future.delayed(
                                  const Duration(milliseconds: 1200));
                              Navigator.pop(context);
                              Navigator.pop(context, true);
                            },
                          )
                        ],
                      );
                      // Show the dialog
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return alert;
                        },
                      );
                    },
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStatePropertyAll(Colors.red.shade300),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      )),
                    ),
                    child: const Text("Delete Media"),
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  Future<void> deleteMedia() async {
    int totalDocCount = 0;
    await FirebaseFirestore.instance.runTransaction((transaction) async {
      DocumentSnapshot snapshot = await transaction.get(
          FirebaseFirestore.instance.collection("clc_news").doc("news_count"));
      totalDocCount = (snapshot.exists) ? snapshot.get('count') : 0;
      totalDocCount--;

      transaction.set(
          FirebaseFirestore.instance.collection("clc_news").doc("news_count"),
          {'count': totalDocCount});
    });
    //delete feedback doc
    DocumentReference feedbackRef = FirebaseFirestore.instance
        .collection("clc_news")
        .doc(widget.documentSnapshot["news_id"]);
    feedbackRef
        .delete()
        .then((value) => showToastMsg("Media removed successfully"));
  }
}
