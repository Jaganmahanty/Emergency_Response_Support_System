// ignore_for_file: library_private_types_in_public_api, depend_on_referenced_packages, unrelated_type_equality_checks, use_build_context_synchronously, avoid_print

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import '../../Utils/Utils.dart';
import '../../Utils/dropdown_Items.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isLoading = true;
  bool isMale = true;
  bool isEditing = false;

  String fetchedFname = "";
  String fetchedLname = "";
  String profileUrl = "";
  String? fetchedGender = "";
  late Timestamp fetchedBirthDate = Timestamp.now();
  String? fetchedPhone = "";
  String fetchedState = "";
  String fetchedCity = "";
  String fetchedPinCode = "";
  String fetchedFullAddress = "";
  String fetchedRegTime = "";
  String selectedGender = '';

  int userAge = 0;

  String selectedState = '';
  String selectedCity = '';
  List<String> dropdownItemCity = [];

  TextEditingController fnameTextController = TextEditingController();
  TextEditingController lnameTextController = TextEditingController();
  TextEditingController birthDateTextController = TextEditingController();
  TextEditingController addressTextController = TextEditingController();
  TextEditingController pincodeTextController = TextEditingController();
  TextEditingController stateTextController = TextEditingController();
  TextEditingController cityTextController = TextEditingController();

  late File pickedImage;
  bool isPicked = false;

  @override
  void initState() {
    super.initState();
    fetchCitizenData().then((_) {
      setState(() {
        isLoading = false;
        fnameTextController.text = fetchedFname.trim();
        lnameTextController.text = fetchedLname.trim();
        addressTextController.text = fetchedFullAddress.trim();
        pincodeTextController.text = fetchedPinCode.trim();
        stateTextController.text = fetchedState.trim();
        cityTextController.text = fetchedCity.trim();

        selectedState = fetchedState.trim();
        selectedCity = fetchedCity.trim();
        updateCityList(selectedState);
      });
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
            bottomLeft: Radius.circular(25),
          ),
        ),
        title: const Text("Profile"),
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
          ? const Center(
              child: CircularProgressIndicator(),
            )
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
                            // Center(
                            //   child: CircleAvatar(
                            //     radius: 37,
                            //     backgroundImage: isMale
                            //         ? const AssetImage("assets/images/man.png")
                            //         : const AssetImage(
                            //             "assets/images/woman.png"),
                            //   ),
                            // ),
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
                                              hintText: fetchedFname,
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
                                              hintText: fetchedLname,
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
                                                  isMale =
                                                      true; // Set isMale to true when Male is selected
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
                                                  isMale =
                                                      false; // Set isMale to false when Female is selected
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
                                          enabled:
                                              isEditing, // Always disabled for editing directly
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
                                        hintText: fetchedPhone,
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
                                        hintText: fetchedFullAddress,
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
                                        return null; // Return null if the input is valid
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
                                        hintText: fetchedPinCode,
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
                                        return null; // Return null if the input is valid
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
                                            // Update city list based on the selected state
                                            updateCityList(selectedState);
                                            // Reset selected city when state changes
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
                                          return null; // Return null if the input is valid
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
                                          return null; // Return null if the input is valid
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
                                        "You created this account on : \t$fetchedRegTime",
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 11),
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
                    padding: const EdgeInsets.only(right: 20, left: 20),
                    child: Container(
                      padding: const EdgeInsets.only(bottom: 2),
                      width: double.infinity,
                      child: ClipRRect(
                        child: ElevatedButton(
                          onPressed: () {
                            if (isEditing == false) {
                              showSnakeBar(
                                  context,
                                  "Enable editing to edit your profile ..",
                                  "Okay");
                            } else {
                              if (_formKey.currentState!.validate()) {
                                updateUserProfile();
                              }
                            }
                          },
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18),
                              ),
                            ),
                          ),
                          child: const Text("Update Profile"),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Future<void> fetchCitizenData() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      DocumentSnapshot citizenSnapshot = await FirebaseFirestore.instance
          .collection('clc_citizen')
          .doc(user?.phoneNumber)
          .get();

      if (citizenSnapshot.exists) {
        setState(() {
          fetchedFname = citizenSnapshot.get('firstName');
          fetchedLname = citizenSnapshot.get('lastName');
          profileUrl = citizenSnapshot.get('profilePic');
          fetchedGender = citizenSnapshot.get('gender');
          selectedGender = fetchedGender!;
          if (fetchedGender == 'Female') {
            setState(() {
              isMale = false;
            });
          }
          fetchedPhone = user!.phoneNumber;
          fetchedState = citizenSnapshot.get('state');
          fetchedCity = citizenSnapshot.get('city');
          fetchedPinCode = citizenSnapshot.get('pinCode');
          fetchedFullAddress = citizenSnapshot.get('fullAddress');
          fetchedRegTime = citizenSnapshot.get('registrationTime');
          fetchedRegTime = fetchedRegTime.substring(0, 16);
          fetchedBirthDate = citizenSnapshot.get('birthDate');
          birthDateTextController.text =
              DateFormat('MMMM dd, yyyy').format(fetchedBirthDate.toDate());

          DateTime birthDate = fetchedBirthDate.toDate();
          DateTime currentDate = DateTime.now();
          userAge = currentDate.year - birthDate.year;
          if (currentDate.month < birthDate.month ||
              (currentDate.month == birthDate.month &&
                  currentDate.day < birthDate.day)) {
            userAge--;
          }
        });
      } else {
        if (kDebugMode) {
          print('Document does not exist');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching user data: $e');
      }
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    if (isEditing) {
      final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: fetchedBirthDate.toDate(),
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
          calculateAge(pickedDate);
        });
      }
    }
  }

  Future<void> updateUserProfile() async {
    try {
      String dateString = birthDateTextController.text;
      DateTime birthDate = DateFormat('MMMM dd, yyyy').parse(dateString);

      User? user = FirebaseAuth.instance.currentUser;

      Map<String, dynamic> updatedData = {
        if (fnameTextController.text != fetchedFname)
          'firstName': fnameTextController.text,
        if (lnameTextController.text != fetchedLname)
          'lastName': lnameTextController.text,
        if (fetchedGender != selectedGender) 'gender': selectedGender,
        if (birthDate != fetchedBirthDate.toDate()) 'birthDate': birthDate,
        if (selectedState != fetchedState) 'state': selectedState,
        if (selectedCity != fetchedCity) 'city': selectedCity,
        if (pincodeTextController.text != fetchedPinCode)
          'pinCode': pincodeTextController.text,
        if (addressTextController.text != fetchedFullAddress)
          'fullAddress': addressTextController.text,
      };

      // Check if any field is edited, including birth date
      if (updatedData.isNotEmpty) {
        // Update data in Firestore only for non-empty fields
        await FirebaseFirestore.instance
            .collection('clc_citizen')
            .doc(user?.phoneNumber)
            .update(updatedData);

        setState(() {
          isEditing = false;
        });
        showSnakeBar(context, "User profile updated successfully .. ", "Okay");
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

  void updateCityList(String state) {
    setState(() {
      dropdownItemCity = DropdownItems.cityMap[state] ?? [];
    });
  }

  void calculateAge(DateTime passedDate) {
    DateTime birthDate = passedDate;
    DateTime currentDate = DateTime.now();
    userAge = currentDate.year - birthDate.year;
    if (currentDate.month < birthDate.month ||
        (currentDate.month == birthDate.month &&
            currentDate.day < birthDate.day)) {
      userAge--;
    }
  }

  Future<String?> uploadImageToStorage(File imageFile) async {
    try {
      firebase_storage.Reference storageRef = firebase_storage
          .FirebaseStorage.instance
          .ref()
          .child('citizen')
          .child(fetchedPhone!)
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
          .doc(fetchedPhone)
          .update({"profilePic": imageUrl});
    } catch (e) {
      // An error occurred
      if (kDebugMode) {
        print('Error adding picture data to firestore : $e');
      }
    }
  }
}
