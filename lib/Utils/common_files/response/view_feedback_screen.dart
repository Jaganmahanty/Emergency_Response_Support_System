// ignore_for_file: library_private_types_in_public_api, camel_case_types, non_constant_identifier_names, use_build_context_synchronously

import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../Utils/Utils.dart';

class View_Feedback_Details_Screen extends StatefulWidget {
  final String fid;

  const View_Feedback_Details_Screen({super.key, required this.fid});

  @override
  _View_Feedback_Details_ScreenState createState() =>
      _View_Feedback_Details_ScreenState();
}

class _View_Feedback_Details_ScreenState
    extends State<View_Feedback_Details_Screen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool isLoading = true;

  String fetchedFid = "";
  String serviceFulfill = '';
  String starCount = '';
  String fetchedDesc = '';
  String fetchedAuthority_id = '';
  String fetchedResponse_id = '';

  final bool _showError = false;
  int _starRating = 3;
  bool _thumbsUpSelected = false;
  bool _thumbsDownSelected = false;

  TextEditingController descController = TextEditingController();

  @override
  void initState() {
    fetchFeedbackData().then((value) => {
          setState(() {
            isLoading = false;
            descController.text = fetchedDesc;
          })
        });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blueGrey.shade50,
        appBar: AppBar(
          elevation: 50,
          backgroundColor: Colors.black12,
          centerTitle: true,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(25),
                  bottomLeft: Radius.circular(25))),
          title: const Text("Feedback Details"),
        ),
        body: isLoading
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 15),

                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            "Feedback on your response : ",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        const SizedBox(height: 15),
                        //stars
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 5, vertical: 5),
                          child: Container(
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 15),
                              child: Column(
                                children: [
                                  const Text(
                                    "Selected rating as per service :",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  const SizedBox(height: 15),
                                  Row(
                                    //mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const SizedBox(width: 18),
                                      Row(
                                        children: List.generate(
                                          5,
                                          (index) => GestureDetector(
                                            // onTap: () => _selectStar(index + 1),
                                            child: Icon(
                                              index < _starRating
                                                  ? Icons.star
                                                  : Icons.star_border,
                                              color: Colors.orangeAccent,
                                              size: 35,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 18),
                                      Text(
                                        getRatingString(_starRating),
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 5),
                        // Padding(
                        //   padding: const EdgeInsets.all(8.0),
                        //   child: Row(
                        //     children: [
                        //       const Text('Selected Rating:'),
                        //       const SizedBox(width: 10),
                        //       Text(_starRating.toString()),
                        //     ],
                        //   ),
                        // ),
                        // Padding(
                        //   padding: const EdgeInsets.all(8.0),
                        //   child: Row(
                        //     children: [
                        //       const Text('Select emojis:'),
                        //       const SizedBox(width: 10),
                        //       // Display different emojis based on star rating
                        //       _starRating == 1
                        //           ? const Text('Poor')
                        //           : _starRating == 2
                        //               ? const Text('Fair')
                        //               : _starRating == 3
                        //                   ? const Text('Average')
                        //                   : _starRating == 4
                        //                       ? const Text('Good')
                        //                       : _starRating == 5
                        //                           ? const Text('Excellent')
                        //                           : const Text(''),
                        //     ],
                        //   ),
                        // ),
                        // Padding(
                        //   padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 7),
                        //   //btn
                        //   child: Container(
                        //     decoration: const BoxDecoration(
                        //       color: Colors.white,
                        //       borderRadius: BorderRadius.all(Radius.circular(12)),
                        //     ),
                        //     child: Padding(
                        //       padding:
                        //           const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        //       child: Column(
                        //         mainAxisAlignment: MainAxisAlignment.start,
                        //         crossAxisAlignment: CrossAxisAlignment.start,
                        //         children: [
                        //           const Padding(
                        //             padding: EdgeInsets.only(left: 10, top: 5),
                        //             child: Text('What can be improved ?',
                        //                 style: TextStyle(
                        //                     fontSize: 17, fontWeight: FontWeight.w600)),
                        //           ),
                        //           const SizedBox(height: 15),
                        //           // Display custom checkboxes
                        //           Wrap(
                        //             children: [
                        //               Row(
                        //                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        //                 children: [
                        //                   GestureDetector(
                        //                     onTap: () => _toggleCheckbox(0),
                        //                     child: Container(
                        //                       margin: const EdgeInsets.all(5),
                        //                       padding: const EdgeInsets.all(8),
                        //                       decoration: BoxDecoration(
                        //                         color: _checkboxValues[0]
                        //                             ? Colors.green.shade200
                        //                             : Colors.grey.shade200,
                        //                         borderRadius: BorderRadius.circular(5),
                        //                         border: Border.all(color: Colors.grey),
                        //                       ),
                        //                       child: const Padding(
                        //                         padding:
                        //                             EdgeInsets.symmetric(horizontal: 20),
                        //                         child: Text('Checkbox 1'),
                        //                       ),
                        //                     ),
                        //                   ),
                        //                   const SizedBox(width: 10),
                        //                   GestureDetector(
                        //                     onTap: () => _toggleCheckbox(1),
                        //                     child: Container(
                        //                       margin: const EdgeInsets.all(5),
                        //                       padding: const EdgeInsets.all(8),
                        //                       decoration: BoxDecoration(
                        //                         color: _checkboxValues[1]
                        //                             ? Colors.green.shade200
                        //                             : Colors.grey.shade200,
                        //                         borderRadius: BorderRadius.circular(5),
                        //                         border: Border.all(color: Colors.grey),
                        //                       ),
                        //                       child: const Padding(
                        //                         padding:
                        //                             EdgeInsets.symmetric(horizontal: 20),
                        //                         child: Text('Checkbox 2'),
                        //                       ),
                        //                     ),
                        //                   ),
                        //                 ],
                        //               ),
                        //               const SizedBox(height: 13),
                        //               Row(
                        //                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        //                 children: [
                        //                   GestureDetector(
                        //                     onTap: () => _toggleCheckbox(2),
                        //                     child: Container(
                        //                       margin: const EdgeInsets.all(5),
                        //                       padding: const EdgeInsets.all(8),
                        //                       decoration: BoxDecoration(
                        //                         color: _checkboxValues[2]
                        //                             ? Colors.green.shade200
                        //                             : Colors.grey.shade200,
                        //                         borderRadius: BorderRadius.circular(5),
                        //                         border: Border.all(color: Colors.grey),
                        //                       ),
                        //                       child: const Padding(
                        //                         padding:
                        //                             EdgeInsets.symmetric(horizontal: 20),
                        //                         child: Text('Checkbox 4'),
                        //                       ),
                        //                     ),
                        //                   ),
                        //                   const SizedBox(width: 10),
                        //                   GestureDetector(
                        //                     onTap: () => _toggleCheckbox(3),
                        //                     child: Container(
                        //                       margin: const EdgeInsets.all(5),
                        //                       padding: const EdgeInsets.all(8),
                        //                       decoration: BoxDecoration(
                        //                         color: _checkboxValues[3]
                        //                             ? Colors.green.shade200
                        //                             : Colors.grey.shade200,
                        //                         borderRadius: BorderRadius.circular(5),
                        //                         border: Border.all(color: Colors.grey),
                        //                       ),
                        //                       child: const Padding(
                        //                         padding:
                        //                             EdgeInsets.symmetric(horizontal: 20),
                        //                         child: Text('Checkbox 5'),
                        //                       ),
                        //                     ),
                        //                   ),
                        //                 ],
                        //               ),
                        //             ],
                        //           ),
                        //         ],
                        //       ),
                        //     ),
                        //   ),
                        // ),

                        //other
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 5, vertical: 7),
                          child: Container(
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 15),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.only(left: 10, top: 5),
                                    child: Text('Tell us more !',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 17,
                                            fontWeight: FontWeight.w600)),
                                  ),
                                  const SizedBox(height: 15),
                                  // Display custom checkboxes
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                          'Was the request fulfilled ? :',
                                          style: TextStyle(
                                            color: Colors.black,
                                          )),
                                      const Spacer(),
                                      const SizedBox(width: 10),
                                      // Display thumbs up and thumbs down icons
                                      GestureDetector(
                                        onTap: () {
                                          // _thumbsUpSelected =
                                          // !_thumbsUpSelected;
                                          // setState(() {
                                          //   _thumbsDownSelected = false;
                                          //   //_showError = false;
                                          // });
                                        },
                                        child: Icon(
                                          Icons.thumb_up,
                                          color: _thumbsUpSelected
                                              ? Colors.blue
                                              : Colors.grey,
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      GestureDetector(
                                        onTap: () {
                                          // _thumbsDownSelected =
                                          // !_thumbsDownSelected;
                                          // setState(() {
                                          //   _thumbsUpSelected = false;
                                          //   //_showError = false;
                                          // });
                                        },
                                        child: Icon(
                                          Icons.thumb_down,
                                          color: _thumbsDownSelected
                                              ? Colors.blue
                                              : Colors.grey,
                                        ),
                                      ),
                                      const SizedBox(height: 15),
                                    ],
                                  ),
                                  const SizedBox(height: 15),
                                  if (_showError)
                                    const Padding(
                                      padding:
                                          EdgeInsets.only(left: 10, top: 5),
                                      child: Text(
                                        '* Please select either thumbs-up or thumbs-down.',
                                        style: TextStyle(
                                          color: Colors.red,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 5, vertical: 7),
                          child: Container(
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 15),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.only(left: 10, top: 5),
                                    child: Text('Detailed review !',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 17,
                                            fontWeight: FontWeight.w600)),
                                  ),
                                  const SizedBox(height: 15),
                                  //desc
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextFormField(
                                      textCapitalization:
                                          TextCapitalization.sentences,
                                      controller: descController,
                                      maxLength: 100,
                                      enabled: false,
                                      style:
                                          const TextStyle(color: Colors.black),
                                      decoration: InputDecoration(
                                        hintText:
                                            'Write your feedback here ...',
                                        hintStyle: const TextStyle(
                                            color: Colors.black),
                                        enabledBorder:
                                            const OutlineInputBorder().copyWith(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: const BorderSide(
                                              width: 1, color: Colors.black),
                                        ),
                                        focusedBorder:
                                            const OutlineInputBorder().copyWith(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: const BorderSide(
                                              width: 1, color: Colors.black12),
                                        ),
                                        // border: OutlineInputBorder(
                                        //     borderRadius:
                                        //         BorderRadius.all(Radius.circular(5))),
                                      ),
                                      maxLines: 5,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Feedback is required';
                                        } else if (value.length < 3) {
                                          return 'Too short feedback ..';
                                        }
                                        return null; // Return null if the input is valid
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),
                        // const Spacer(
                        //   flex: 1,
                        // ),
                        //const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(right: 20, left: 20, bottom: 15),
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: ElevatedButton(
                    onPressed: () async {
                      Navigator.pop(context);
                    },
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStatePropertyAll(Colors.red.shade300),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      )),
                    ),
                    child: const Text("Back to home"),
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  Future<void> fetchFeedbackData() async {
    try {
      // Fetch data from Firestore
      DocumentSnapshot feedbackSnapshot = await FirebaseFirestore.instance
          .collection('clc_feedback')
          .doc(widget.fid)
          .get();

      // Check if the document exists
      if (feedbackSnapshot.exists) {
        setState(() {
          fetchedFid = feedbackSnapshot.get('feedback_id');
          starCount = feedbackSnapshot.get('selectedStar');
          serviceFulfill = feedbackSnapshot.get('serviceFulfilled');
          fetchedDesc = feedbackSnapshot.get('description');
          _starRating = mapRatingStringToStar(starCount);
          if (serviceFulfill == 'Yes') {
            _thumbsUpSelected = true;
            _thumbsDownSelected = false;
          } else if (serviceFulfill == 'No') {
            _thumbsUpSelected = false;
            _thumbsDownSelected = true;
          }
          fetchedAuthority_id = feedbackSnapshot.get('authority_id');
          fetchedResponse_id = feedbackSnapshot.get('response_id');
        });
      } else {
        if (kDebugMode) {
          print('Document does not exist');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching feedback data : $e');
      }
    }
  }

  void updateFeedback() async {
    try {
      DocumentReference feedbackRef =
          FirebaseFirestore.instance.collection('clc_feedback').doc(widget.fid);

      // Update the fields in the document
      await feedbackRef.update({
        'selectedStar': getRatingString(_starRating),
        'serviceFulfilled':
            _thumbsUpSelected ? 'Yes' : (_thumbsDownSelected ? 'No' : ''),
        'score': _starRating * 2,
        'description': descController.text,
        // Add other fields here if needed
      });

      showToastMsg("Feedback updated successfully");
    } catch (e) {
      if (kDebugMode) {
        print('Error updating feedback: $e');
      }
      // Show an error message or perform any other actions upon error
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error updating feedback')),
      );
    }
  }

  void deleteFeedback() async {
    //removes fid from response clc
    if (fetchedAuthority_id.startsWith("g")) {
      //its govt response
      DocumentReference govtResponseRef = FirebaseFirestore.instance
          .collection("clc_response")
          .doc(fetchedResponse_id)
          .collection("govt")
          .doc("govt_details");

      govtResponseRef.update({'fid': ""});
    }
    //its ngo response
    else if (fetchedAuthority_id.startsWith("n")) {
      DocumentReference govtResponseRef = FirebaseFirestore.instance
          .collection("clc_response")
          .doc(fetchedResponse_id)
          .collection("ngo")
          .doc("ngo_details");

      govtResponseRef.update({'fid': ""});
    }

    //delete feedback doc
    DocumentReference feedbackRef =
        FirebaseFirestore.instance.collection("clc_feedback").doc(fetchedFid);
    feedbackRef
        .delete()
        .then((value) => showToastMsg("Feedback deleted successfully"));
  }

  String getRatingString(int starRating) {
    switch (starRating) {
      case 1:
        return 'Poor';
      case 2:
        return 'Fair';
      case 3:
        return 'Average';
      case 4:
        return 'Good';
      case 5:
        return 'Excellent';
      default:
        return '';
    }
  }

  int mapRatingStringToStar(String ratingString) {
    switch (ratingString) {
      case "Poor":
        return 1;
      case "Fair":
        return 2;
      case "Average":
        return 3;
      case "Good":
        return 4;
      case "Excellent":
        return 5;
      default:
        return 3; // Default to 3 if the rating string is unknown or null
    }
  }
}
