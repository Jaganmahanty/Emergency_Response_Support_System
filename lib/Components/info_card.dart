import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InfoCard extends StatelessWidget {
  const InfoCard({
    Key? key,
    required this.name,
    required this.mail,
  }) : super(key: key);

  final String name, mail;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: ListTile(
        leading: const CircleAvatar(
          backgroundColor: Colors.white24,
          child: Icon(
            CupertinoIcons.person,
            color: Colors.white,
          ),
        ),
        title: Text(
          name,
          style: const TextStyle(color: Colors.white,),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(right: 30),
          child: Text(
            mail,
            style: const TextStyle(color: Colors.white70,fontSize: 12),
          ),
        ),
      ),
    );
  }
}
