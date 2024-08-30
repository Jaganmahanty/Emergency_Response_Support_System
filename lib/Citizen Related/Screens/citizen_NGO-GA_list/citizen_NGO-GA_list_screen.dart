// ignore_for_file: non_constant_identifier_names, file_names, camel_case_types, library_private_types_in_public_api, deprecated_member_use

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../Utils/Utils.dart';
import '../../../Utils/dropdown_Items.dart';
import 'citizen_donate_screen.dart';

class NGO_GA_ListScreen extends StatefulWidget {
  const NGO_GA_ListScreen({super.key});

  @override
  State<NGO_GA_ListScreen> createState() => _NGO_GA_ListScreenState();
}

class _NGO_GA_ListScreenState extends State<NGO_GA_ListScreen> {
  String selectedState = '';
  String selectedCity = '';
  String selectedState_ngo = '';
  String selectedCity_ngo = '';
  List<String> dropdownItemCity = [];

  @override
  void initState() {
    super.initState();
    selectedState = DropdownItems.dropdownItemState.first;
    updateCityList(selectedState);
    selectedState_ngo = DropdownItems.dropdownItemState.first;
    updateCityList(selectedState_ngo);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Number of tabs
      child: Scaffold(
        //backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 50,
          backgroundColor: Colors.black12,
          centerTitle: true,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(25),
                  bottomLeft: Radius.circular(25))),
          title: const Text("Search your nearby Agencies"),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'NGOs'), // First tab
              Tab(text: 'Govt Agencies'), // Second tab
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // Content of the first tab (NGO)
            Column(
              children: [
                const SizedBox(height: 15),
                //state
                Flex(
                  direction: Axis.horizontal,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 25,
                          right: 25,
                        ),
                        child: SizedBox(
                          height: 60,
                          child: DropdownButtonFormField<String>(
                            value: selectedState_ngo,
                            items: DropdownItems.dropdownItemState
                                .map((String state) {
                              return DropdownMenuItem<String>(
                                // alignment: AlignmentDirectional.topStart,
                                value: state,
                                child: Text(state),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                selectedState_ngo = value!;
                                // Update city list based on the selected state
                                updateCityList(selectedState_ngo);
                                // Reset selected city when state changes
                                selectedCity_ngo = '';
                              });
                            },
                            decoration: const InputDecoration(
                              // border: OutlineInputBorder(),
                              hintText: "Select your State",
                            ),
                            //hint: const Text("Select your State"), // Hint text displayed initially
                            validator: (value) {
                              if (value == "Select your state") {
                                return 'Select your State';
                              }
                              return null; // Return null if the input is valid
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                //city
                Padding(
                  padding: const EdgeInsets.only(
                    left: 25,
                    right: 25,
                  ),
                  child: SizedBox(
                    height: 60,
                    child: DropdownButtonFormField<String>(
                      value:
                          selectedCity_ngo.isNotEmpty ? selectedCity_ngo : null,
                      items: dropdownItemCity.map((String city) {
                        return DropdownMenuItem<String>(
                          value: city,
                          child: Text(city),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedCity_ngo = value!;
                        });
                      },
                      decoration: const InputDecoration(
                        hintText: "Select your City",
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                ngo_list(
                    selectedState: selectedState_ngo,
                    selectedCity: selectedCity_ngo),
              ],
            ),
            // Content of the second tab (Govt)
            Column(
              children: [
                const SizedBox(height: 15),
                //state
                Flex(
                  direction: Axis.horizontal,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 25,
                          right: 25,
                        ),
                        child: SizedBox(
                          height: 60,
                          child: DropdownButtonFormField<String>(
                            value: selectedState,
                            items: DropdownItems.dropdownItemState
                                .map((String state) {
                              return DropdownMenuItem<String>(
                                // alignment: AlignmentDirectional.topStart,
                                value: state,
                                child: Text(state),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                selectedState = value!;
                                // Update city list based on the selected state
                                updateCityList(selectedState);
                                // Reset selected city when state changes
                                selectedCity = '';
                              });
                            },
                            decoration: const InputDecoration(
                              // border: OutlineInputBorder(),
                              hintText: "Select your State",
                            ),
                            //hint: const Text("Select your State"), // Hint text displayed initially
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                //city
                Padding(
                  padding: const EdgeInsets.only(
                    left: 25,
                    right: 25,
                  ),
                  child: SizedBox(
                    height: 60,
                    child: DropdownButtonFormField<String>(
                      value: selectedCity.isNotEmpty ? selectedCity : null,
                      items: dropdownItemCity.map((String city) {
                        return DropdownMenuItem<String>(
                          value: city,
                          child: Text(city),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedCity = value!;
                        });
                      },
                      decoration: const InputDecoration(
                        hintText: "Select your City",
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                govt_list(
                    selectedState: selectedState, selectedCity: selectedCity),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void updateCityList(String state) {
    setState(() {
      dropdownItemCity = DropdownItems.cityMap[state] ?? [];
    });
  }
}

//for NGO list
class ngo_list extends StatefulWidget {
  final String selectedState;
  final String selectedCity;

  const ngo_list(
      {Key? key, required this.selectedState, required this.selectedCity})
      : super(key: key);

  @override
  _ngo_listState createState() => _ngo_listState();
}

class _ngo_listState extends State<ngo_list> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: RefreshIndicator(
          onRefresh: _refreshData,
          child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("clc_ngo")
                .where("state", isEqualTo: widget.selectedState)
                .where("city", isEqualTo: widget.selectedCity)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.active) {
                if (snapshot.hasData) {
                  return Padding(
                    padding:
                        const EdgeInsets.only(left: 10, right: 10, top: 10),
                    child: snapshot.data!.docs.isEmpty
                        ? const Center(
                            child: Text(
                              'No records found !',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey,
                              ),
                            ),
                          )
                        : ListView.builder(
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              return NgoTile(
                                index: "${index + 1}",
                                auth_id: snapshot.data!.docs[index]["nid"],
                                nameOfNGO: snapshot.data!.docs[index]
                                    ["nameOfNGO"],
                                regNo: snapshot.data!.docs[index]["NGORegNo"],
                                serviceList: snapshot.data!.docs[index]
                                    ["services"],
                                contact: snapshot.data!.docs[index]
                                    ["contactNumber"],
                                email: snapshot.data!.docs[index]["email"],
                                website: snapshot.data!.docs[index]["website"],
                                state: snapshot.data!.docs[index]["state"],
                                city: snapshot.data!.docs[index]["city"],
                                pinCode: snapshot.data!.docs[index]["pinCode"],
                                address: snapshot.data!.docs[index]
                                    ["fullAddress"],
                                upi: snapshot.data!.docs[index]["upiId"],
                                // Add more fields as needed
                              );
                            },
                          ),
                  );
                }
              } else if (snapshot.hasError) {
                showToastMsg(snapshot.error.toString());
              } else {
                return const Center(child: CircularProgressIndicator());
              }
              return const Center(child: CircularProgressIndicator());
            },
          ),
        ),
      ),
    );
  }

  Future<void> _refreshData() async {
    // Simulate a delay for refreshing data
    await Future.delayed(const Duration(milliseconds: 1200));
    setState(() {
      // Update your data here
    });
  }
}

class NgoTile extends StatefulWidget {
  final String index;
  final String auth_id;
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
  final String upi;

  const NgoTile({
    Key? key,
    required this.index,
    required this.auth_id,
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
    required this.upi,
  }) : super(key: key);

  @override
  _NgoTileState createState() => _NgoTileState();
}

class _NgoTileState extends State<NgoTile> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  // late Animation<double> _heightAnimation;

  bool isExpanded = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    // _heightAnimation = Tween<double>(begin: 0, end: 100).animate(
    //   CurvedAnimation(parent: _controller, curve: Curves.fastOutSlowIn),
    // );
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
                      //website
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
                              _launchWebURL("https://${widget.website}");
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
                      const SizedBox(height: 5),
                      //donate
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.only(
                                bottom: 3, left: 20, right: 20),
                            //width: 150,
                            child: ClipRRect(
                                child: TextButton(
                                    onPressed: () async {
                                      Navigator.of(context).push(
                                        PageRouteBuilder(
                                          pageBuilder: (context, animation,
                                                  secondaryAnimation) =>
                                              Citizen_Donate_Screen(
                                            authority_name: widget.nameOfNGO,
                                            authority_id: widget.auth_id,
                                            authority_email: widget.email,
                                            authority_upi: widget.upi,
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
                                    child: const Row(
                                      children: [
                                        Icon(Icons.currency_rupee),
                                        SizedBox(width: 5),
                                        Text(
                                          "Donate",
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    ))),
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

//for govt list

class govt_list extends StatefulWidget {
  final String selectedState;
  final String selectedCity;

  const govt_list(
      {Key? key, required this.selectedState, required this.selectedCity})
      : super(key: key);

  @override
  _govt_listState createState() => _govt_listState();
}

class _govt_listState extends State<govt_list> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: RefreshIndicator(
          onRefresh: _refreshData,
          child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("clc_govt")
                  .where("state", isEqualTo: widget.selectedState)
                  .where("city", isEqualTo: widget.selectedCity)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.active) {
                  if (snapshot.hasData) {
                    return Padding(
                      padding:
                          const EdgeInsets.only(left: 10, right: 10, top: 10),
                      child: snapshot.data!.docs.isEmpty
                          ? const Center(
                              child: Text(
                                'No records found !',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey,
                                ),
                              ),
                            )
                          : ListView.builder(
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (context, index) {
                                return govtTile(
                                  index: "${index + 1}",
                                  auth_id: snapshot.data!.docs[index]["gid"],
                                  govtAgencyName: snapshot.data!.docs[index]
                                      ["GovtAgencyName"],
                                  regNo: snapshot.data!.docs[index]
                                      ["GovtAgencyRegNo"],
                                  serviceList: snapshot.data!.docs[index]
                                      ["services"],
                                  contact: snapshot.data!.docs[index]
                                      ["contactNumber"],
                                  email: snapshot.data!.docs[index]["email"],
                                  website: snapshot.data!.docs[index]
                                      ["website"],
                                  state: snapshot.data!.docs[index]["state"],
                                  city: snapshot.data!.docs[index]["city"],
                                  pinCode: snapshot.data!.docs[index]
                                      ["pinCode"],
                                  address: snapshot.data!.docs[index]
                                      ["fullAddress"],
                                  pwd: snapshot.data!.docs[index]["password"],
                                  // Add more fields as needed
                                );
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

  Future<void> _refreshData() async {
    // Simulate a delay for refreshing data
    await Future.delayed(const Duration(milliseconds: 1200));
    setState(() {
      // Update your data here
    });
  }
}

class govtTile extends StatefulWidget {
  final String index;
  final String auth_id;
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

  const govtTile({
    Key? key,
    required this.index,
    required this.auth_id,
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
  _GovtTileState createState() => _GovtTileState();
}

class _GovtTileState extends State<govtTile>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  // late Animation<double> _heightAnimation;

  bool isExpanded = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    // _heightAnimation = Tween<double>(begin: 0, end: 100).animate(
    //   CurvedAnimation(parent: _controller, curve: Curves.fastOutSlowIn),
    // );
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
                              _launchWebURL("https://${widget.website}");
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
