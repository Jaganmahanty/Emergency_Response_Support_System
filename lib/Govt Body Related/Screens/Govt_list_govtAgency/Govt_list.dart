// ignore_for_file: library_private_types_in_public_api, camel_case_types

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../Utils/Utils.dart';
import '../../../Utils/dropdown_Items.dart';
import 'Govt_listtile.dart';

class govt_ListofAgency extends StatefulWidget {
  const govt_ListofAgency({Key? key}) : super(key: key);

  @override
  State<govt_ListofAgency> createState() => _govt_ListofAgencyState();
}

class _govt_ListofAgencyState extends State<govt_ListofAgency> {
  String selectedState = '';
  String selectedCity = ''; // Variable to hold the selected city value
  List<String> dropdownItemCity = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedState = DropdownItems.dropdownItemState.first;
    updateCityList(selectedState);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 50,
        backgroundColor: Colors.black12,
        centerTitle: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(25),
                bottomLeft: Radius.circular(25))),
        title: const Text("List of other Govt Agencies"),
      ),
      body: Column(
        children: [
          const SizedBox(height: 12),
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
                      items:
                          DropdownItems.dropdownItemState.map((String state) {
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
                      //hint: const Text("Select your State"),
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
          govt_list_widget(
              selectedState: selectedState, selectedCity: selectedCity),
        ],
      ),
    );
  }

  void updateCityList(String state) {
    setState(() {
      dropdownItemCity = DropdownItems.cityMap[state] ?? [];
    });
  }
}

class govt_list_widget extends StatefulWidget {
  final String selectedState;
  final String selectedCity;

  const govt_list_widget(
      {Key? key, required this.selectedState, required this.selectedCity})
      : super(key: key);

  @override
  _govt_list_widgetState createState() => _govt_list_widgetState();
}

class _govt_list_widgetState extends State<govt_list_widget> {
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
                                return govtListTile(
                                  index: "${index + 1}",
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
