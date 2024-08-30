// ignore_for_file: camel_case_types, library_private_types_in_public_api, deprecated_member_use

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Citizen_HelpLines extends StatefulWidget {
  const Citizen_HelpLines({super.key});

  @override
  _Citizen_HelpLinesState createState() => _Citizen_HelpLinesState();
}

class _Citizen_HelpLinesState extends State<Citizen_HelpLines> {
  List<Contact> contacts = [
    // Contact(name: 'me', phoneNumber: '9106933376'),
    Contact(name: 'Andhra Pradesh', phoneNumber: '0866-2410978'),
    Contact(name: 'Arunachal Pradesh', phoneNumber: '9436055743'),
    Contact(name: 'Assam', phoneNumber: '6913347770'),
    Contact(name: 'Bihar', phoneNumber: '104'),
    Contact(name: 'Chhattisgarh', phoneNumber: '104'),
    Contact(name: 'Goa', phoneNumber: '104'),
    Contact(name: 'Gujarat', phoneNumber: '104'),
    Contact(name: 'Haryana', phoneNumber: '8558893911'),
    Contact(name: 'Himachal Pradesh', phoneNumber: '104'),
    Contact(name: 'Jharkhand', phoneNumber: '104'),
    Contact(name: 'Karnataka', phoneNumber: '104'),
    Contact(name: 'Kerala', phoneNumber: '0471-2552056'),
    Contact(name: 'Madhya Pradesh', phoneNumber: '104'),
    Contact(name: 'Manipur', phoneNumber: '3852411668'),
    Contact(name: 'Meghalaya', phoneNumber: '108'),
    Contact(name: 'Mizoram', phoneNumber: '102'),
    Contact(name: 'Nagaland', phoneNumber: '7005539653'),
    Contact(name: 'Odisha', phoneNumber: '9439994859'),
    Contact(name: 'Punjab', phoneNumber: '104'),
    Contact(name: 'Rajasthan', phoneNumber: '0141-2225624'),
    Contact(name: 'Sikkim', phoneNumber: '104'),
    Contact(name: 'Tamil Nadu', phoneNumber: '044-29510500'),
    Contact(name: 'Telangana', phoneNumber: '104'),
    Contact(name: 'Tripura', phoneNumber: '0381-2315879'),
    Contact(name: 'Uttarakhand', phoneNumber: '104'),
    Contact(name: 'Uttar Pradesh', phoneNumber: '18801805145'),
    Contact(name: 'West Bengal', phoneNumber: '1800313444222'),
    Contact(name: 'Andaman and Nicobar Island', phoneNumber: '03192-232102'),
    Contact(name: 'Chandigarh', phoneNumber: '9779558282'),
    Contact(name: 'Dadra and Nagar Haveli and Diu & Daman', phoneNumber: '104'),
    Contact(name: 'Delhi', phoneNumber: '011-22307145'),
    Contact(name: 'Jammu & Kashmir', phoneNumber: '01912520982'),
    Contact(name: 'Ladakh', phoneNumber: '1982256462'),
    Contact(name: 'Lakshadweep', phoneNumber: '104'),
    Contact(name: 'Pondicherry', phoneNumber: '104'),
  ];

  List<Contact> filteredContacts = [];

  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredContacts = contacts;
    searchController.addListener(searchContacts);
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void searchContacts() {
    String query = searchController.text.toLowerCase();
    setState(() {
      if (query.isEmpty) {
        filteredContacts = contacts;
      } else {
        filteredContacts = contacts.where((contact) {
          return contact.name.toLowerCase().contains(query);
        }).toList();
      }
    });
  }

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
        title: const Text("Helplines"),
      ),
      body: Column(
        children: [
          //search
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextField(
              controller: searchController,
              decoration: const InputDecoration(
                hintText: 'Search Help Line ...',
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          //list
          Expanded(
            child: filteredContacts.isEmpty
                ? const Center(child: Text('No matching Help line found '))
                : ListView.builder(
                    itemCount: filteredContacts.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: ListTile(
                          title: Text(filteredContacts[index].name),
                          subtitle: Text(filteredContacts[index].phoneNumber),
                          trailing: IconButton(
                            icon: Icon(color: Colors.deepPurple.shade500,
                              CupertinoIcons.phone_circle_fill,
                              size: 40,
                            ),
                            onPressed: () {
                              _launchPhoneDialer(
                                  filteredContacts[index].phoneNumber);
                            },
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  void _launchPhoneDialer(String phoneNumber) async {
    String uri = 'tel:$phoneNumber';
    if (await canLaunch(uri)) {
      await launch(uri);
    } else {
      throw 'Could not launch $uri';
    }
  }
}

class Contact {
  final String name;
  final String phoneNumber;

  Contact({required this.name, required this.phoneNumber});
}
