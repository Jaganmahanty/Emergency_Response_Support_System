import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constants.dart';

class ApplyForGrant extends StatelessWidget {
  const ApplyForGrant({super.key});

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
        title: const Text("Apply for grant"),
      ),
      body: Column(
        children: [
          const SizedBox(height: 7),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              textAlign: TextAlign.center,
                'Apply online for any Grant-in-aid '
                'to any of your respective Ministry or Department of Government of India',
                style: TextStyle(fontSize: 15)),
          ),
          // const SizedBox(height: 10),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 5,left: 8,right: 8),
              child: ListView.builder(
                itemCount: grantItems.length,
                itemBuilder: (BuildContext context, int index) {
                  return GrantItem(
                    title: grantItems[index]['title']!,
                    link: grantItems[index]['link']!,
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class GrantItem extends StatelessWidget {
  final String title;
  final String link;

  const GrantItem({Key? key, required this.title, required this.link})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        launchUrl(Uri.parse(link), mode: LaunchMode.inAppBrowserView);
      },
      child: Card(
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(9),
          ),
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.symmetric(vertical: 9, horizontal: 12),
          child: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.w500),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}

// List of grant items
final List<Map<String, String>> grantItems = [
  {
    'title': 'Ministry of finance',
    'link': 'https://mofapp.nic.in/deagrants/deango/default.aspx',
  },
  {
    'title': 'Ministry of Environment, Forest and Climate Change',
    'link': 'http://www.moefngo.nic.in/ngo/',
  },
  {
    'title': 'Ministry of Home Affairs',
    'link':
        'https://www.mha.gov.in/en/commoncontent/implementation-of-rule-2302-of-gfr-2017',
  },
  {
    'title': 'Department for Animal Welfare',
    'link': 'https://csms.nic.in/login/index.php',
  },
  {
    'title': 'PMO India',
    'link': 'https://www.pmindia.gov.in/en/pms-funds/',
  },
  {
    'title': 'Ministry of Information and Broadcasting',
    'link': 'https://ngo.mib.gov.in/',
  },
  {
    'title': 'Ministry of Food Processing Industries',
    'link': 'https://sampada-mofpi.gov.in/',
  },
  {
    'title': 'Ministry of Housing and Urban Affairs',
    'link': 'https://ngodarpan.nacwc.gov.in/',
  },
  {
    'title': 'Department for Transportation',
    'link': 'https://grants-msje.gov.in/ngo-login',
  },
  {
    'title': 'Ministry of Electronics and Information Technology',
    'link': 'https://jsactr.mowr.gov.in/ngogrant/pages/Account/login.aspx',
  },
  {
    'title': 'Ministry of Rural Development',
    'link': 'http://ngodordgoi.nic.in/',
  },
  {
    'title': 'NITI Aayog',
    'link': 'https://aimapp2.aim.gov.in/',
  },
  {
    'title': 'Ministry of Jal Shakti',
    'link': 'https://jsactr.mowr.gov.in/ngogrant/pages/Account/login.aspx',
  },
];
