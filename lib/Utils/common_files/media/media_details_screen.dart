// ignore_for_file: camel_case_types, depend_on_referenced_packages

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Media_Details_Screen extends StatefulWidget {
  final DocumentSnapshot documentSnapshot;

  const Media_Details_Screen({super.key, required this.documentSnapshot});

  @override
  State<Media_Details_Screen> createState() => _Media_Details_ScreenState();
}

class _Media_Details_ScreenState extends State<Media_Details_Screen> {
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
                    image:
                        NetworkImage("${widget.documentSnapshot['news_image']}"),
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
    );
  }
}
