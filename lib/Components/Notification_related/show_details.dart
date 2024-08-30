import 'package:flutter/material.dart';

class ShowDetails extends StatefulWidget {
  final String msg;

  const ShowDetails({super.key, required this.msg});

  @override
  State<ShowDetails> createState() => _ShowDetailsState();
}

class _ShowDetailsState extends State<ShowDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 50,
          backgroundColor: Colors.white24,
          centerTitle: true,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(25),
                  bottomLeft: Radius.circular(25))),
          title: const Text("Show Details   : "),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text('The information retrieved from the notification is : - '),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  initialValue: widget.msg,
                  decoration:
                      const InputDecoration(prefixIcon: Icon(Icons.accessible)),
                ),
              ),
              // Text(widget.id,
              //     style: const TextStyle(
              //         color: Colors.lightBlue,
              //         fontSize: 30,
              //         fontWeight: FontWeight.bold)),
            ],
          ),
        ));
  }
}
