// ignore_for_file: depend_on_referenced_packages, non_constant_identifier_names, deprecated_member_use, use_build_context_synchronously, camel_case_types

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import '../../Utils/Utils.dart';
import '../../Utils/dropdown_Items.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class Citizen_Details_Screen extends StatefulWidget {
  final DocumentSnapshot<Object?> documentSnapshot;

  const Citizen_Details_Screen({
    super.key,
    required this.documentSnapshot,
  });

  @override
  State<Citizen_Details_Screen> createState() => _Citizen_Details_ScreenState();
}

class _Citizen_Details_ScreenState extends State<Citizen_Details_Screen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool isLoading = true;
  bool isMale = true;
  bool isEditing = false;

  String selectedState = '';
  String selectedCity = '';
  List<String> dropdownItemCity = [];
  String? fetchedGender = "";

  String selectedGender = '';
  int userAge = 0;

  TextEditingController fnameTextController = TextEditingController();
  TextEditingController lnameTextController = TextEditingController();
  TextEditingController birthDateTextController = TextEditingController();
  TextEditingController addressTextController = TextEditingController();
  TextEditingController pincodeTextController = TextEditingController();
  TextEditingController stateTextController = TextEditingController();
  TextEditingController cityTextController = TextEditingController();

  late File pickedImage;
  bool isPicked = false;
  String profileUrl = "";

  @override
  void initState() {
    super.initState();
    selectedState = widget.documentSnapshot['state'];
    selectedCity = widget.documentSnapshot['city'];
    updateCityList(selectedState);
    // Start loading
    Future.delayed(const Duration(milliseconds: 1100), () {
      setState(() {
        setState(() {
          isLoading = false;
          fnameTextController.text = widget.documentSnapshot['firstName'];
          lnameTextController.text = widget.documentSnapshot['lastName'];
          addressTextController.text = widget.documentSnapshot['fullAddress'];
          pincodeTextController.text = widget.documentSnapshot['pinCode'];
          stateTextController.text = widget.documentSnapshot['state'];
          cityTextController.text = widget.documentSnapshot['city'];
          profileUrl = widget.documentSnapshot['profilePic'];

          selectedState = widget.documentSnapshot['state'];
          selectedCity = widget.documentSnapshot['city'];
          updateCityList(selectedState);
        });
      });
    });

    DateTime birthDate = widget.documentSnapshot['birthDate'].toDate();
    DateTime currentDate = DateTime.now();
    userAge = currentDate.year - birthDate.year;
    if (currentDate.month < birthDate.month ||
        (currentDate.month == birthDate.month &&
            currentDate.day < birthDate.day)) {
      userAge--;
    }
    birthDateTextController.text = DateFormat('MMMM dd, yyyy')
        .format(widget.documentSnapshot['birthDate'].toDate());
    fetchedGender = widget.documentSnapshot['gender'];
    selectedGender = fetchedGender!;
    if (fetchedGender == 'Female') {
      setState(() {
        isMale = false;
      });
    }
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
        title: const Text("Citizen details"),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: IconButton(
              icon: Icon(isEditing ? Iconsax.tick_circle4 : Iconsax.edit),
              onPressed: () {
                setState(() {
                  isEditing = !isEditing;
                });
              },
            ),
          ),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: Stack(
                                children: [
                                  Container(
                                    height: 90,
                                    width: 90,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                            color: Colors.deepPurple,
                                            width: 3)),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(75),
                                      child: isPicked
                                          ? Image.file(
                                        pickedImage,
                                        fit: BoxFit.cover,
                                      )
                                          : Image.network(
                                        profileUrl,
                                        fit: BoxFit.cover,
                                        loadingBuilder: (context, child,
                                            loadingProgress) {
                                          if (loadingProgress == null) {
                                            return child;
                                          }
                                          return const Center(
                                              child:
                                              CircularProgressIndicator());
                                        },
                                        errorBuilder:
                                            (context, object, stack) {
                                          return const Icon(Iconsax.user,
                                              size: 30,
                                              color: Colors.red);
                                        },
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                      bottom: 0,
                                      right: 0,
                                      child: Container(
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.blue,
                                              border: Border.all(
                                                  width: 4,
                                                  color: Colors.white)),
                                          child: GestureDetector(
                                              onTap: () async {
                                                final picker = ImagePicker();
                                                final XFile? image =
                                                await picker.pickImage(
                                                    source: ImageSource
                                                        .gallery);
                                                if (image != null) {
                                                  showDialog(
                                                    context: context,
                                                    barrierDismissible: false,
                                                    builder:
                                                        (BuildContext context) {
                                                      return const Dialog(
                                                        child: Padding(
                                                          padding:
                                                          EdgeInsets.only(
                                                              top: 35,
                                                              bottom: 25,
                                                              left: 20,
                                                              right: 20),
                                                          child: Column(
                                                            mainAxisSize:
                                                            MainAxisSize
                                                                .min,
                                                            crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                            mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                            children: [
                                                              SizedBox(
                                                                  height: 15),
                                                              CircularProgressIndicator(
                                                                  color: Colors
                                                                      .blue),
                                                              SizedBox(
                                                                  height: 30),
                                                              Text(
                                                                  'Processing ...')
                                                            ],
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  );
                                                  pickedImage =
                                                      File(image.path);
                                                  // Upload image to Firebase Storage
                                                  String? imageUrl =
                                                  await uploadImageToStorage(
                                                      pickedImage);

                                                  // Remove progress indicator
                                                  Navigator.pop(context);

                                                  if (imageUrl != null) {
                                                    await uploadDataToFirestore(
                                                        imageUrl);

                                                    // Show success message
                                                    ScaffoldMessenger.of(
                                                        context)
                                                        .showSnackBar(
                                                      const SnackBar(
                                                          content: Text(
                                                              'Profile picture uploaded successfully')),
                                                    );
                                                  } else {
                                                    // If image upload fails, show error message
                                                    ScaffoldMessenger.of(
                                                        context)
                                                        .showSnackBar(
                                                      const SnackBar(
                                                          content: Text(
                                                              'Failed to upload picture')),
                                                    );
                                                  }
                                                  setState(() {
                                                    isPicked = true;
                                                  });
                                                }
                                              },
                                              child: const Icon(Icons.add,
                                                  size: 25)))),
                                ],
                              ),
                            ),
                            const SizedBox(height: 15),
                            AbsorbPointer(
                              absorbing: !isEditing,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Padding(
                                    padding:
                                        EdgeInsets.only(left: 10, bottom: 3),
                                    child: Text("Citizen name :"),
                                  ),
                                  //username
                                  Row(
                                    children: [
                                      Expanded(
                                        child: SizedBox(
                                          child: TextFormField(
                                            controller: fnameTextController,
                                            decoration: InputDecoration(
                                              prefixIcon: const Icon(
                                                  CupertinoIcons.person_alt),
                                              hintText:
                                                  "${widget.documentSnapshot['firstName']}",
                                            ),
                                            enabled: isEditing,
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'Enter First name';
                                              }
                                              if (value.isNotEmpty &&
                                                  value.length < 3) {
                                                return 'Minimum 3 Characters required';
                                              }
                                              return null;
                                            },
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 20),
                                      Expanded(
                                        child: SizedBox(
                                          child: TextFormField(
                                            controller: lnameTextController,
                                            decoration: InputDecoration(
                                              prefixIcon: const Icon(
                                                  CupertinoIcons.person_alt),
                                              hintText:
                                                  "${widget.documentSnapshot['lastName']}",
                                            ),
                                            enabled: isEditing,
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'Enter last name';
                                              }
                                              if (value.isNotEmpty &&
                                                  value.length < 3) {
                                                return 'Minimum 3 Characters required';
                                              }
                                              return null;
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  const Padding(
                                    padding:
                                        EdgeInsets.only(left: 10, bottom: 3),
                                    child: Text("Gender :"),
                                  ),
                                  //gender
                                  SizedBox(
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Radio(
                                              value: 'Male',
                                              groupValue: selectedGender,
                                              onChanged: (value) {
                                                setState(() {
                                                  selectedGender =
                                                      value.toString();
                                                  isMale = true;
                                                });
                                              },
                                              toggleable: isEditing,
                                            ),
                                            const Text('Male'),
                                            const SizedBox(width: 10),
                                            Radio(
                                              value: 'Female',
                                              groupValue: selectedGender,
                                              onChanged: (value) {
                                                setState(() {
                                                  selectedGender =
                                                      value.toString();
                                                  isMale = false;
                                                });
                                              },
                                              toggleable: isEditing,
                                            ),
                                            const Text('Female'),
                                            const SizedBox(width: 10),
                                            Radio(
                                              value: 'Other',
                                              groupValue: selectedGender,
                                              onChanged: (value) {
                                                setState(() {
                                                  selectedGender =
                                                      value.toString();
                                                });
                                              },
                                              toggleable: isEditing,
                                            ),
                                            const Text('Other'),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  const Padding(
                                    padding:
                                        EdgeInsets.only(left: 10, bottom: 3),
                                    child: Text("Birth Date :"),
                                  ),
                                  //birthdate
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 5, right: 5),
                                    child: GestureDetector(
                                      onTap: () {
                                        if (isEditing) {
                                          _selectDate(context);
                                        }
                                      },
                                      child: AbsorbPointer(
                                        //absorbing: !isEditing,
                                        child: TextFormField(
                                          controller: birthDateTextController,
                                          readOnly: true,
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      20), // Make it round
                                            ),
                                            // hintText: DateFormat('MMMM dd, yyyy')
                                            //     .format(
                                            //         fetchedBirthDate.toDate()),
                                            prefixIcon: const Icon(
                                              CupertinoIcons.calendar_today,
                                            ),
                                          ),
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Select Birth date';
                                            }
                                            return null;
                                          },
                                          enabled: isEditing,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15),
                                    child: Text(
                                      "Citizen age : ${userAge.toString()}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: Colors.deepPurple.shade300,
                                          fontSize: 14),
                                    ),
                                  ),
                                  const SizedBox(height: 15),
                                  const Padding(
                                    padding:
                                        EdgeInsets.only(left: 10, bottom: 3),
                                    child: Text("Phone number :"),
                                  ),
                                  //phone
                                  SizedBox(
                                    // height: 55,
                                    child: TextFormField(
                                      enabled: false,
                                      decoration: InputDecoration(
                                        prefixIcon:
                                            const Icon(CupertinoIcons.phone),
                                        hintText:
                                            "${widget.documentSnapshot['phoneNumber']}",
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  const Padding(
                                    padding:
                                        EdgeInsets.only(left: 10, bottom: 3),
                                    child: Text("Full Address :"),
                                  ),
                                  //address
                                  SizedBox(
                                    child: TextFormField(
                                      maxLength: 100,
                                      minLines: 2,
                                      maxLines: 4,
                                      controller: addressTextController,
                                      decoration: InputDecoration(
                                        prefixIcon: const Icon(CupertinoIcons
                                            .pencil_ellipsis_rectangle),
                                        hintText:
                                            "${widget.documentSnapshot['fullAddress']}",
                                      ),
                                      enabled: isEditing,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Enter full address';
                                        }
                                        if (value.isNotEmpty &&
                                            value.length < 10) {
                                          return "Too short address";
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  const Padding(
                                    padding:
                                        EdgeInsets.only(left: 10, bottom: 3),
                                    child: Text("Pincode :"),
                                  ),
                                  //pincode
                                  SizedBox(
                                    child: TextFormField(
                                      controller: pincodeTextController,
                                      decoration: InputDecoration(
                                        prefixIcon:
                                            const Icon(Icons.pin_rounded),
                                        hintText:
                                            "${widget.documentSnapshot['pinCode']}",
                                      ),
                                      enabled: isEditing,
                                      keyboardType: TextInputType.number,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Enter Pin code';
                                        }
                                        if (value.isNotEmpty &&
                                            value.length < 6) {
                                          return 'Enter 6 digits Pin code';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  const Padding(
                                    padding:
                                        EdgeInsets.only(left: 10, bottom: 3),
                                    child: Text("State :"),
                                  ),
                                  //state
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      left: 5,
                                      right: 5,
                                    ),
                                    child: SizedBox(
                                      //height: 60,
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
                                            updateCityList(selectedState);
                                            selectedCity = '';
                                          });
                                        },
                                        decoration: InputDecoration(
                                          enabled: isEditing,
                                          // border: OutlineInputBorder(),
                                          hintText: "Select your State",
                                          prefixIcon: const Icon(
                                              CupertinoIcons.map_pin_ellipse),
                                        ),
                                        validator: (value) {
                                          if (value == "Select your State") {
                                            return 'Select your State';
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  const Padding(
                                    padding:
                                        EdgeInsets.only(left: 10, bottom: 3),
                                    child: Text("City :"),
                                  ),
                                  //city
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      left: 5,
                                      right: 5,
                                    ),
                                    child: SizedBox(
                                      //height: 60,
                                      child: DropdownButtonFormField<String>(
                                        value: selectedCity.isNotEmpty
                                            ? selectedCity
                                            : null,
                                        items:
                                            dropdownItemCity.map((String city) {
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
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(24),
                                          ),
                                          enabled: isEditing,
                                          hintText: "Select your City",
                                          prefixIcon: const Icon(
                                              Icons.location_city_rounded),
                                        ),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Select your City';
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 20),
                            //extra details
                            Align(
                              alignment: AlignmentDirectional.bottomEnd,
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.85,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    const SizedBox(height: 10),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 10),
                                      child: Text(
                                        "Citizen registered at : \t${widget.documentSnapshot['registrationTime'].toString().substring(0, 16)}",
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 10),
                                      ),
                                    ),
                                    const SizedBox(height: 15),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 9),
                  Padding(
                    padding:
                        const EdgeInsets.only(right: 5, left: 5, bottom: 0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: ElevatedButton(
                              onPressed: () async {
                                // if (_formKey.currentState!.validate()) {
                                //progress
                                showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (BuildContext context) {
                                    return const Dialog(
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            top: 35,
                                            bottom: 25,
                                            left: 20,
                                            right: 20),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            SizedBox(height: 15),
                                            CircularProgressIndicator(
                                                color: Colors.blue),
                                            SizedBox(height: 30),
                                            Text('Processing ...')
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                                await Future.delayed(
                                    const Duration(milliseconds: 1300));
                                if (isEditing == false) {
                                  showSnakeBar(
                                      context,
                                      "Enable editing to edit profile ..",
                                      "okay");
                                } else {
                                  if (_formKey.currentState!.validate()) {
                                    updateCitizenProfile();
                                  }
                                }
                                try {} catch (e) {
                                  if (kDebugMode) {
                                    print(
                                        'Error while updating citizen profile : $e');
                                  }
                                } finally {
                                  Navigator.pop(context);
                                }
                                // }
                              },
                              style: ButtonStyle(
                                backgroundColor:
                                    const MaterialStatePropertyAll(Colors.teal),
                                shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18),
                                )),
                              ),
                              child: const Text("Update"),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: ElevatedButton(
                              onPressed: () async {
                                final CupertinoAlertDialog alert =
                                    CupertinoAlertDialog(
                                  title: const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text('Confirm : ',
                                        style: TextStyle(fontSize: 16)),
                                  ),
                                  content: const Text('Delete this Citizen ?'),
                                  actions: <Widget>[
                                    CupertinoDialogAction(
                                      isDefaultAction: true,
                                      child: const Text('Cancel'),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    CupertinoDialogAction(
                                      isDefaultAction: true,
                                      child: const Text('Delete'),
                                      onPressed: () async {
                                        //delete user
                                        deleteUser();
                                        Navigator.pop(context, true);
                                        showDialog(
                                          context: context,
                                          barrierDismissible: false,
                                          builder: (BuildContext context) {
                                            return const Center(
                                              child: CircularProgressIndicator(
                                                  color: Colors.white),
                                            );
                                          },
                                        );
                                        await Future.delayed(
                                            const Duration(milliseconds: 1100));
                                        Navigator.pop(context);
                                        Navigator.pop(context, true);
                                      },
                                    )
                                  ],
                                );
                                // Show the dialog
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return alert;
                                  },
                                );
                              },
                              style: ButtonStyle(
                                backgroundColor: MaterialStatePropertyAll(
                                    Colors.red.shade400),
                                shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18),
                                )),
                              ),
                              child: const Text("Delete"),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    if (isEditing) {
      final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: widget.documentSnapshot['birthDate'].toDate(),
        firstDate: DateTime(1900),
        lastDate: DateTime.now(),
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData.light().copyWith(
              colorScheme: const ColorScheme.light(
                primary: Colors.blue,
                onPrimary: Colors.white,
                onSurface: Colors.black,
              ),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.blue,
                ),
              ),
            ),
            child: child!,
          );
        },
      );
      if (pickedDate != null) {
        final formattedDate = DateFormat('MMMM dd, yyyy').format(pickedDate);
        setState(() {
          //fetchedBirthDate = Timestamp.fromDate(pickedDate);
          birthDateTextController.text = formattedDate;
          //calculateAge(pickedDate);
        });
      }
    }
  }

  void updateCityList(String state) {
    setState(() {
      dropdownItemCity = DropdownItems.cityMap[state] ?? [];
    });
  }

  Future<void> updateCitizenProfile() async {
    try {
      String dateString = birthDateTextController.text;
      DateTime birthDate = DateFormat('MMMM dd, yyyy').parse(dateString);

      // User? user = FirebaseAuth.instance.currentUser;

      Map<String, dynamic> updatedData = {
        if (fnameTextController.text != widget.documentSnapshot['firstName'])
          'firstName': fnameTextController.text,
        if (lnameTextController.text != widget.documentSnapshot['lastName'])
          'lastName': lnameTextController.text,
        if (fetchedGender != selectedGender) 'gender': selectedGender,
        if (birthDate != widget.documentSnapshot['birthDate'].toDate())
          'birthDate': birthDate,
        if (selectedState != widget.documentSnapshot['state'])
          'state': selectedState,
        if (selectedCity != widget.documentSnapshot['city'])
          'city': selectedCity,
        if (pincodeTextController.text != widget.documentSnapshot['pinCode'])
          'pinCode': pincodeTextController.text,
        if (addressTextController.text !=
            widget.documentSnapshot['fullAddress'])
          'fullAddress': addressTextController.text,
      };

      // Check if any field is edited, including birth date
      if (updatedData.isNotEmpty) {
        // Update data in Firestore only for non-empty fields
        await FirebaseFirestore.instance
            .collection('clc_citizen')
            .doc(widget.documentSnapshot['phoneNumber'])
            .update(updatedData);

        setState(() {
          isEditing = false;
        });
        showSnakeBar(context, "User profile updated successfully .. ", "okay");
      } else {
        // setState(() {isEditing = false;});
        showSnakeBar(context, "No profile data edited !", "Close");
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error updating user profile: $e');
      }
      showSnakeBar(context, "$e!", "Okay");
    }
  }

  void deleteUser() async {
    try {
      int totalDocCount = 0;
      await FirebaseFirestore.instance.runTransaction((transaction) async {
        DocumentSnapshot snapshot = await transaction.get(FirebaseFirestore
            .instance
            .collection("clc_citizen")
            .doc("citizen_count"));
        totalDocCount = (snapshot.exists) ? snapshot.get('count') : 0;
        totalDocCount--;

        transaction.set(
            FirebaseFirestore.instance.collection("clc_citizen").doc("citizen_count"),
            {'count': totalDocCount});
      });
      // Delete user
      DocumentReference userRef = FirebaseFirestore.instance
          .collection('clc_citizen')
          .doc(widget.documentSnapshot['phoneNumber']);
      await userRef
          .delete()
          .then((value) => showToastMsg("User deleted successfully"));
    } catch (error) {
      if (kDebugMode) {
        print("Error deleting user: $error");
      }
      showToastMsg("Failed to delete citizen");
    }
  }

  Future<String?> uploadImageToStorage(File imageFile) async {
    try {
      firebase_storage.Reference storageRef = firebase_storage
          .FirebaseStorage.instance
          .ref()
          .child('citizen')
          .child(widget.documentSnapshot["phoneNumber"])
          .child('${DateTime.now().microsecondsSinceEpoch}.jpg');

      firebase_storage.UploadTask uploadTask = storageRef.putFile(imageFile);
      await uploadTask
          .whenComplete(() => print("Profile picture uploaded to Storage"));
      String imageURL = await storageRef.getDownloadURL();
      return imageURL;
    } catch (e) {
      if (kDebugMode) {
        print("Error while uploading profile picture : $e");
      }
    }
    return null;
  }

  uploadDataToFirestore(String imageUrl) async {
    try {
      await FirebaseFirestore.instance
          .collection("clc_citizen")
          .doc(widget.documentSnapshot["phoneNumber"])
          .update({"profilePic": imageUrl});
    } catch (e) {
      // An error occurred
      if (kDebugMode) {
        print('Error adding picture data to firestore : $e');
      }
    }
  }
}
