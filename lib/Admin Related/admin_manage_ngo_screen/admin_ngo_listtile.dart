// ignore_for_file: deprecated_member_use, file_names, library_private_types_in_public_api, unused_field, camel_case_types, non_constant_identifier_names
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'admin_ngo_details_screen.dart';

class Admin_NGOListTile extends StatefulWidget {
  final DocumentSnapshot NGOSnapshot;
  final String index;
  final String regNo;
  final String nameOfNGO;
  final String serviceList;
  final String contact;
  final String website;
  final String email;
  final String state;
  final String city;
  final String pinCode;
  final String address;
  final String pwd;

  const Admin_NGOListTile({
    Key? key,
    required this.index,
    required this.NGOSnapshot,
    required this.regNo,
    required this.nameOfNGO,
    required this.serviceList,
    required this.contact,
    required this.website,
    required this.email,
    required this.state,
    required this.city,
    required this.pinCode,
    required this.address,
    required this.pwd,
  }) : super(key: key);

  @override
  _Admin_NGOListTileState createState() => _Admin_NGOListTileState();
}

class _Admin_NGOListTileState extends State<Admin_NGOListTile>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _heightAnimation;

  bool isExpanded = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _heightAnimation = Tween<double>(begin: 0, end: 100).animate(
      CurvedAnimation(parent: _controller, curve: Curves.fastOutSlowIn),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isExpanded = !isExpanded;
          if (isExpanded) {
            _controller.forward();
          } else {
            _controller.reverse();
          }
        });
      },
      child: Card(
        color: Colors.white,
        margin: const EdgeInsets.only(bottom: 12),
        // Set margin to zero to remove white spaces
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    leading: CircleAvatar(
                      maxRadius: 14,
                      backgroundColor: Colors.grey,
                      child: Text(widget.index),
                    ),
                    textColor: Colors.white,
                    title: Text(
                      widget.nameOfNGO,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Colors.black.withOpacity(0.6),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Text("Service List: ${widget.serviceList}",
                        style: const TextStyle(color: Colors.black)),
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Text("City : ${widget.state} , ${widget.city}",
                        style: const TextStyle(color: Colors.black)),
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Row(
                      children: [
                        Text("Contact: ${widget.contact}",
                            style: const TextStyle(color: Colors.black)),
                        TextButton(
                          onPressed: () {
                            launch(
                              'tel:${widget.contact}',
                            );
                          },
                          child: Icon(Icons.call,
                              size: 18, color: Colors.green.shade800),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            AnimatedSize(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              //vsync: this,
              child: SizedBox(
                height: isExpanded ? null : 0,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text("Registration Number: ${widget.regNo}",
                            style: const TextStyle(color: Colors.black)),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Text("Address : ${widget.address}",
                            style: const TextStyle(color: Colors.black)),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Text("Pincode : ${widget.pinCode}",
                            style: const TextStyle(color: Colors.black)),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Text("Email : ${widget.email}",
                            style: const TextStyle(color: Colors.black)),
                      ),
                      Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(3.0),
                            child: Text(
                              "Website : ",
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              _launchWebURL(widget.website);
                            },
                            child: MouseRegion(
                              cursor: SystemMouseCursors.click,
                              child: Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Text(
                                  widget.website,
                                  style: TextStyle(
                                    color: Colors.blue.shade200,
                                    // Change the text color to blue for indicating a link
                                    decoration: TextDecoration
                                        .underline, // Add underline decoration for indicating a link
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.only(
                                bottom: 30, left: 20, right: 20),
                            width: 200,
                            child: ClipRRect(
                                child: TextButton(
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Colors.deepPurple.shade300),
                                      foregroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Colors.white),
                                    ),
                                    onPressed: () async {
                                      Navigator.of(context).push(
                                        PageRouteBuilder(
                                          pageBuilder: (context, animation,
                                                  secondaryAnimation) =>
                                              Admin_NGO_Details_Screen(
                                                  NGOSnapshot:
                                                      widget.NGOSnapshot),
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
                                    child: const Text(
                                      "Manage",
                                      style: TextStyle(fontSize: 15),
                                    ))),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8, top: 4),
              // Adjusting the padding
              child: SizedBox(
                height: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Transform.translate(
                      offset: const Offset(0, -44),
                      // Moving the icon slightly up
                      child: IconButton(
                        icon: Icon(
                            isExpanded ? Icons.expand_less : Icons.expand_more),
                        onPressed: () {
                          setState(() {
                            isExpanded = !isExpanded;
                            if (isExpanded) {
                              _controller.forward();
                            } else {
                              _controller.reverse();
                            }
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _launchWebURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
