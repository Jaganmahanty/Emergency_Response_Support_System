// ignore_for_file: library_private_types_in_public_api, camel_case_types, file_names, deprecated_member_use, unused_field
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class govtListTile extends StatefulWidget {
  final String index;
  final String regNo;
  final String govtAgencyName;
  final String serviceList;
  final String contact;
  final String website;
  final String email;
  final String state;
  final String city;
  final String pinCode;
  final String address;
  final String pwd;

  const govtListTile({
    Key? key,
    required this.index,
    required this.regNo,
    required this.govtAgencyName,
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
  _GovtListTileState createState() => _GovtListTileState();
}

class _GovtListTileState extends State<govtListTile>
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
        margin: const EdgeInsets.only(bottom: 12, left: 10, right: 10),
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
                      widget.govtAgencyName,
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
                              size: 14, color: Colors.green.shade800),
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
                        child: Text("City : ${widget.city}",
                            style: const TextStyle(color: Colors.black)),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Text("State : ${widget.state}",
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
                      const SizedBox(height: 15)
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
