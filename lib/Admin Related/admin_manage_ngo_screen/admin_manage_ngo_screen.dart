// ignore_for_file: non_constant_identifier_names, camel_case_types

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../../Utils/constants.dart';
import '../../../Utils/dropdown_Items.dart';
import '../../Utils/Utils.dart';
import 'admin_ngo_listtile.dart';

class Admin_Manage_NGO_Screen extends StatefulWidget {
  const Admin_Manage_NGO_Screen({super.key});

  @override
  State<Admin_Manage_NGO_Screen> createState() =>
      _Admin_Manage_NGO_ScreenState();
}

class _Admin_Manage_NGO_ScreenState extends State<Admin_Manage_NGO_Screen> {
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
    return Scaffold(
        appBar: AppBar(
          elevation: 50,
          backgroundColor: color_AppBar,
          centerTitle: true,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(25),
                  bottomLeft: Radius.circular(25))),
          title: const Text("Registered NGOs"),
        ),
        body: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: RefreshIndicator(
                  onRefresh: _refreshData,
                  child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("clc_ngo")
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
                                : Scrollbar(
                                    child: ListView.builder(
                                      itemCount: snapshot.data!.docs.length,
                                      itemBuilder: (context, index) {
                                        return Admin_NGOListTile(
                                          NGOSnapshot: snapshot.data!.docs[index],
                                          index: "${index + 1}",
                                          nameOfNGO: snapshot.data!.docs[index]
                                              ["nameOfNGO"],
                                          regNo: snapshot.data!.docs[index]
                                              ["NGORegNo"],
                                          serviceList: snapshot.data!.docs[index]
                                              ["services"],
                                          contact: snapshot.data!.docs[index]
                                              ["contactNumber"],
                                          email: snapshot.data!.docs[index]
                                              ["email"],
                                          website: snapshot.data!.docs[index]
                                              ["website"],
                                          state: snapshot.data!.docs[index]
                                              ["state"],
                                          city: snapshot.data!.docs[index]["city"],
                                          pinCode: snapshot.data!.docs[index]
                                              ["pinCode"],
                                          address: snapshot.data!.docs[index]
                                              ["fullAddress"],
                                          pwd: snapshot.data!.docs[index]
                                              ["password"],
                                          // Add more fields as needed
                                        );
                                      },
                                    ),
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
            ),
          ],
        ));
  }

  void updateCityList(String state) {
    setState(() {
      dropdownItemCity = DropdownItems.cityMap[state] ?? [];
    });
  }

  Future<void> _refreshData() async {
    await Future.delayed(const Duration(milliseconds: 1200));
    setState(() {});
  }
}
