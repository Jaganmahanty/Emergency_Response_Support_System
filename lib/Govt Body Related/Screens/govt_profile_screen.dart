// ignore_for_file: library_private_types_in_public_api, depend_on_referenced_packages, unrelated_type_equality_checks, use_build_context_synchronously, camel_case_types, avoid_print

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import '../../Utils/Utils.dart';
import '../../Utils/dropdown_Items.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class Govt_Profile extends StatefulWidget {
  const Govt_Profile({super.key});

  @override
  _Govt_ProfileState createState() => _Govt_ProfileState();
}

class _Govt_ProfileState extends State<Govt_Profile> {
  final GlobalKey<FormState> _personalFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _othersFormKey = GlobalKey<FormState>();
  bool isLoading = true;
  bool isEditing = false;

  String fetchedGid = "";
  String fetchedGovtName = "";
  String fetchedGovtRegNo = "";
  String fetchedAboutGovt = "";
  String profileUrl = '';
  String fetchedServices = '';
  String fetchedContactNo = "";
  String fetchedWebsite = '';
  String fetchedEmail = '';
  String fetchedState = "";
  String fetchedCity = "";
  String fetchedPinCode = "";
  String fetchedFullAddress = "";
  String fetchedRegTime = "";
  int fetchedScore = 0;

  TextEditingController nameTextController = TextEditingController();
  TextEditingController serviceGovtTextController = TextEditingController();
  TextEditingController emailTextController = TextEditingController();
  TextEditingController phoneTextController = TextEditingController();
  TextEditingController websiteTextController = TextEditingController();
  TextEditingController addressTextController = TextEditingController();
  TextEditingController pincodeTextController = TextEditingController();
  TextEditingController cityTextController = TextEditingController();
  TextEditingController stateTextController = TextEditingController();
  TextEditingController aboutGovtTextController = TextEditingController();

  String selectedState = '';
  String selectedCity = '';
  List<String> dropdownItemCity = [];

  late File pickedImage;
  bool isPicked = false;

  @override
  void initState() {
    super.initState();
    fetchGovtData().then((_) {
      setState(() {
        nameTextController.text = fetchedGovtName.trim();
        serviceGovtTextController.text = fetchedServices;
        phoneTextController.text = fetchedContactNo.trim();
        emailTextController.text = fetchedEmail.trim();
        websiteTextController.text = fetchedWebsite.trim();
        addressTextController.text = fetchedFullAddress.trim();
        pincodeTextController.text = fetchedPinCode.trim();
        cityTextController.text = fetchedCity.trim();
        stateTextController.text = fetchedState.trim();
        aboutGovtTextController.text = fetchedAboutGovt.trim();

        selectedState = fetchedState.trim();
        selectedCity = fetchedCity.trim();
        updateCityList(selectedState);

        for (int i = 0;
            i < DropdownItems.dropdownItemListofServices.length;
            i++) {
          if (fetchedServices
              .contains(DropdownItems.dropdownItemListofServices[i])) {
            _checked[i] = true;
          }
        }
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
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
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Personal Details'),
              Tab(text: 'Other Details'),
            ],
          ),
        ),
        body: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : TabBarView(
                children: [
                  Column(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              Expanded(
                                child: SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                                borderRadius:
                                                    BorderRadius.circular(75),
                                                child: isPicked
                                                    ? Image.file(
                                                        pickedImage,
                                                        fit: BoxFit.cover,
                                                      )
                                                    : Image.network(
                                                        profileUrl,
                                                        fit: BoxFit.cover,
                                                        loadingBuilder: (context,
                                                            child,
                                                            loadingProgress) {
                                                          if (loadingProgress ==
                                                              null) {
                                                            return child;
                                                          }
                                                          return const Center(
                                                              child:
                                                                  CircularProgressIndicator());
                                                        },
                                                        errorBuilder: (context,
                                                            object, stack) {
                                                          return Image.network(
                                                              'https://i.pinimg.com/originals/b4/8a/b9/b48ab9f9b9e169a2a308728d1ba2fa82.jpg');
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
                                                            color:
                                                                Colors.white)),
                                                    child: GestureDetector(
                                                        onTap: () async {
                                                          final picker =
                                                              ImagePicker();
                                                          final XFile? image =
                                                              await picker.pickImage(
                                                                  source: ImageSource
                                                                      .gallery);
                                                          if (image != null) {
                                                            showDialog(
                                                              context: context,
                                                              barrierDismissible:
                                                                  false,
                                                              builder:
                                                                  (BuildContext
                                                                      context) {
                                                                return const Dialog(
                                                                  child:
                                                                      Padding(
                                                                    padding: EdgeInsets.only(
                                                                        top: 35,
                                                                        bottom:
                                                                            25,
                                                                        left:
                                                                            20,
                                                                        right:
                                                                            20),
                                                                    child:
                                                                        Column(
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
                                                                            height:
                                                                                15),
                                                                        CircularProgressIndicator(
                                                                            color:
                                                                                Colors.blue),
                                                                        SizedBox(
                                                                            height:
                                                                                30),
                                                                        Text(
                                                                            'Processing ...')
                                                                      ],
                                                                    ),
                                                                  ),
                                                                );
                                                              },
                                                            );
                                                            pickedImage = File(
                                                                image.path);
                                                            // Upload image to Firebase Storage
                                                            String? imageUrl =
                                                                await uploadImageToStorage(
                                                                    pickedImage);

                                                            // Remove progress indicator
                                                            Navigator.pop(
                                                                context);

                                                            if (imageUrl !=
                                                                null) {
                                                              await uploadDataToFirestore(
                                                                  imageUrl);

                                                              // Show success message
                                                              ScaffoldMessenger
                                                                      .of(context)
                                                                  .showSnackBar(
                                                                const SnackBar(
                                                                    content: Text(
                                                                        'Profile picture uploaded successfully')),
                                                              );
                                                            } else {
                                                              // If image upload fails, show error message
                                                              ScaffoldMessenger
                                                                      .of(context)
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
                                                        child: const Icon(
                                                            Icons.add,
                                                            size: 25)))),
                                          ],
                                        ),
                                      ),
                                      Form(
                                        key: _personalFormKey,
                                        child: AbsorbPointer(
                                          absorbing: !isEditing,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  const Spacer(),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 15,
                                                            left: 10,
                                                            bottom: 3),
                                                    child: Row(
                                                      children: [
                                                        const Icon(
                                                            Iconsax.medal_star),
                                                        const SizedBox(
                                                            width: 3),
                                                        Text(
                                                            "Credit score : $fetchedScore",
                                                            style: const TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600)),
                                                        const SizedBox(
                                                            width: 3),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const Padding(
                                                padding: EdgeInsets.only(
                                                    top: 10,
                                                    left: 10,
                                                    bottom: 3),
                                                child: Text(
                                                    "Name of Govt Agency :"),
                                              ),
                                              //username
                                              SizedBox(
                                                child: TextFormField(
                                                  controller:
                                                      nameTextController,
                                                  decoration: InputDecoration(
                                                    prefixIcon: const Icon(
                                                        CupertinoIcons
                                                            .person_alt),
                                                    hintText: fetchedGovtName,
                                                  ),
                                                  enabled: isEditing,
                                                  validator: (value) {
                                                    if (value == null ||
                                                        value.isEmpty) {
                                                      return 'Enter Govt agency name';
                                                    }
                                                    if (value.isNotEmpty &&
                                                        value.length < 3) {
                                                      return 'Minimum 3 Characters required';
                                                    }
                                                    return null;
                                                  },
                                                ),
                                              ),
                                              const SizedBox(height: 12),
                                              //reg no
                                              const Padding(
                                                padding: EdgeInsets.only(
                                                    left: 10, bottom: 3),
                                                child: Text(
                                                    "Registration Number :"),
                                              ),
                                              SizedBox(
                                                height: 55,
                                                child: TextFormField(
                                                  enabled: false,
                                                  decoration: InputDecoration(
                                                    prefixIcon: const Icon(
                                                        Icons.app_registration),
                                                    hintText: fetchedGovtRegNo,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(height: 12),
                                              //service
                                              const Padding(
                                                padding: EdgeInsets.only(
                                                    left: 10, bottom: 3),
                                                child: Text("Services :"),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                  left: 5,
                                                  right: 5,
                                                ),
                                                child: TextFormField(
                                                  enabled: isEditing,
                                                  onTap: () {
                                                    _showCupertinoDialog(
                                                      context,
                                                    );
                                                  },
                                                  controller:
                                                      serviceGovtTextController,
                                                  readOnly: true,
                                                  decoration: const InputDecoration(
                                                      hintText:
                                                          "Select Services NGO can provide",
                                                      prefixIcon: Icon(
                                                          CupertinoIcons
                                                              .square_list_fill)),
                                                  validator: (value) {
                                                    if (value == null ||
                                                        value.isEmpty) {
                                                      return 'Select your services from list';
                                                    }
                                                    return null;
                                                  },
                                                  onEditingComplete: () {
                                                    FocusScope.of(context)
                                                        .nextFocus();
                                                  },
                                                ),
                                              ),
                                              const SizedBox(height: 12),
                                              //contact
                                              const Padding(
                                                padding: EdgeInsets.only(
                                                    left: 10, bottom: 3),
                                                child: Text("Contact Number :"),
                                              ),
                                              //contact
                                              SizedBox(
                                                // height: 55,
                                                child: TextFormField(
                                                  controller:
                                                      phoneTextController,
                                                  enabled: isEditing,
                                                  maxLength: 13,
                                                  decoration: InputDecoration(
                                                    prefixIcon: const Icon(
                                                        CupertinoIcons.phone),
                                                    hintText: fetchedContactNo,
                                                  ),
                                                  keyboardType:
                                                      TextInputType.phone,
                                                  validator: (value) {
                                                    if (value == null ||
                                                        value.isEmpty) {
                                                      return 'Enter contact number';
                                                    } else if (value
                                                            .isNotEmpty &&
                                                        value.length < 13) {
                                                      //_contactNoFocusNode.requestFocus();
                                                      return 'Contact no should be of 10 digits + country code';
                                                    }
                                                    return null; // Return null if the input is valid
                                                  },
                                                ),
                                              ),
                                              const SizedBox(height: 12),
                                              const Padding(
                                                padding: EdgeInsets.only(
                                                    left: 10, bottom: 3),
                                                child: Text("Email Address :"),
                                              ),
                                              //email
                                              SizedBox(
                                                child: TextFormField(
                                                  controller:
                                                      emailTextController,
                                                  decoration: InputDecoration(
                                                    prefixIcon: const Icon(
                                                        Icons.email_outlined),
                                                    hintText: fetchedEmail,
                                                  ),
                                                  enabled: isEditing,
                                                  validator: (value) {
                                                    if (value == null ||
                                                        value.isEmpty) {
                                                      return 'Enter an email address';
                                                    }
                                                    // Regular expression for validating an email address
                                                    final emailRegex = RegExp(
                                                        r'^[\w.-]+@([\w-]+\.)+[\w-]{2,4}$');
                                                    if (!emailRegex
                                                        .hasMatch(value)) {
                                                      return 'Enter valid email address';
                                                    }
                                                    return null; // Return null if the input is valid
                                                  },
                                                ),
                                              ),
                                              const SizedBox(height: 12),
                                              const Padding(
                                                padding: EdgeInsets.only(
                                                    left: 10, bottom: 3),
                                                child: Text("Website :"),
                                              ),
                                              //website
                                              SizedBox(
                                                child: TextFormField(
                                                  controller:
                                                      websiteTextController,
                                                  decoration: InputDecoration(
                                                    prefixIcon: const Icon(Icons
                                                        .dataset_linked_outlined),
                                                    hintText: fetchedWebsite,
                                                  ),
                                                  enabled: isEditing,
                                                  validator: (value) {
                                                    if (value == null ||
                                                        value.isEmpty) {
                                                      return 'Enter website URL';
                                                    }
                                                    // Regular expression for validating a URL
                                                    final urlRegex = RegExp(
                                                      r'^(https?://)?'
                                                      r'([a-z0-9-]+\.)*[a-z0-9-]+'
                                                      r'\.[a-z]{2,}(\/\S*)?$',
                                                      caseSensitive: false,
                                                    );
                                                    if (websiteTextController
                                                            .text.isNotEmpty &&
                                                        !urlRegex
                                                            .hasMatch(value)) {
                                                      // _websiteFocusNode.requestFocus();
                                                      return 'Enter valid URL';
                                                    }
                                                    return null; // Return null if the input is valid
                                                  },
                                                ),
                                              ),
                                              const SizedBox(height: 12),
                                              const Padding(
                                                padding: EdgeInsets.only(
                                                    left: 10, bottom: 3),
                                                child: Text("Full Address :"),
                                              ),
                                              //address
                                              SizedBox(
                                                child: TextFormField(
                                                  maxLength: 100,
                                                  minLines: 2,
                                                  maxLines: 4,
                                                  controller:
                                                      addressTextController,
                                                  decoration: InputDecoration(
                                                    prefixIcon: const Icon(
                                                        CupertinoIcons
                                                            .pencil_ellipsis_rectangle),
                                                    hintText:
                                                        fetchedFullAddress,
                                                  ),
                                                  enabled: isEditing,
                                                  validator: (value) {
                                                    if (value == null ||
                                                        value.isEmpty) {
                                                      return 'Enter full address';
                                                    }
                                                    if (value.isNotEmpty &&
                                                        value.length < 10) {
                                                      return 'Too short address';
                                                    }
                                                    return null; // Return null if the input is valid
                                                  },
                                                ),
                                              ),
                                              const SizedBox(height: 12),
                                              const Padding(
                                                padding: EdgeInsets.only(
                                                    left: 10, bottom: 3),
                                                child: Text("Pincode :"),
                                              ),
                                              //pincode
                                              SizedBox(
                                                child: TextFormField(
                                                  controller:
                                                      pincodeTextController,
                                                  decoration: InputDecoration(
                                                    prefixIcon: const Icon(
                                                        Icons.pin_rounded),
                                                    hintText: fetchedPinCode,
                                                  ),
                                                  enabled: isEditing,
                                                  keyboardType:
                                                      TextInputType.phone,
                                                  validator: (value) {
                                                    if (value == null ||
                                                        value.isEmpty) {
                                                      return 'Enter pin code of an NGO';
                                                    }
                                                    if (value.isNotEmpty &&
                                                        value.length < 6) {
                                                      return 'Enter 6 digits Pin code';
                                                    }
                                                    return null; // Return null if the input is valid
                                                  },
                                                ),
                                              ),
                                              const SizedBox(height: 12),
                                              const Padding(
                                                padding: EdgeInsets.only(
                                                    left: 10, bottom: 3),
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
                                                  child:
                                                      DropdownButtonFormField<
                                                          String>(
                                                    value: selectedState,
                                                    items: DropdownItems
                                                        .dropdownItemState
                                                        .map((String state) {
                                                      return DropdownMenuItem<
                                                          String>(
                                                        // alignment: AlignmentDirectional.topStart,
                                                        value: state,
                                                        child: Text(state),
                                                      );
                                                    }).toList(),
                                                    onChanged: (value) {
                                                      setState(() {
                                                        selectedState = value!;
                                                        // Update city list based on the selected state
                                                        updateCityList(
                                                            selectedState);
                                                        // Reset selected city when state changes
                                                        selectedCity = '';
                                                      });
                                                    },
                                                    decoration: InputDecoration(
                                                      enabled: isEditing,
                                                      // border: OutlineInputBorder(),
                                                      hintText:
                                                          "Select your State",
                                                      prefixIcon: const Icon(
                                                          CupertinoIcons
                                                              .map_pin_ellipse),
                                                    ),
                                                    validator: (value) {
                                                      if (value ==
                                                          "Select your State") {
                                                        return 'Select your State';
                                                      }
                                                      return null; // Return null if the input is valid
                                                    },
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(height: 10),
                                              const Padding(
                                                padding: EdgeInsets.only(
                                                    left: 10, bottom: 3),
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
                                                  child:
                                                      DropdownButtonFormField<
                                                          String>(
                                                    value:
                                                        selectedCity.isNotEmpty
                                                            ? selectedCity
                                                            : null,
                                                    items: dropdownItemCity
                                                        .map((String city) {
                                                      return DropdownMenuItem<
                                                          String>(
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
                                                      border:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(24),
                                                      ),
                                                      enabled: isEditing,
                                                      hintText:
                                                          "Select your City",
                                                      prefixIcon: const Icon(Icons
                                                          .location_city_rounded),
                                                    ),
                                                    validator: (value) {
                                                      if (value == null ||
                                                          value.isEmpty) {
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
                                      ),
                                      const SizedBox(height: 20),
                                      //extra details
                                      Align(
                                        alignment:
                                            AlignmentDirectional.bottomEnd,
                                        child: SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.85,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              const SizedBox(height: 10),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 10),
                                                child: Text(
                                                  "Govt agency registered at : \t$fetchedRegTime",
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w400,
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
                              const SizedBox(height: 9),
                              Padding(
                                padding:
                                    const EdgeInsets.only(right: 20, left: 20),
                                child: Container(
                                  padding: const EdgeInsets.only(bottom: 2),
                                  width: double.infinity,
                                  child: ClipRRect(
                                    child: ElevatedButton(
                                      onPressed: () {
                                        if (isEditing == false) {
                                          showSnakeBar(
                                              context,
                                              "Enable editing to edit Govt Agency profile ..",
                                              "Okay");
                                        } else {
                                          if (_personalFormKey.currentState!
                                              .validate()) {
                                            updateGovtProfile();
                                          }
                                        }
                                      },
                                      style: ButtonStyle(
                                        shape: MaterialStateProperty.all(
                                          RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(18),
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
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              Expanded(
                                child: SingleChildScrollView(
                                  child: Form(
                                    key: _othersFormKey,
                                    child: AbsorbPointer(
                                      absorbing: !isEditing,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Padding(
                                            padding: EdgeInsets.only(
                                                top: 25, left: 10, bottom: 3),
                                            child: Text("About govt Agency :"),
                                          ),
                                          const SizedBox(height: 10),
                                          //About govt
                                          SizedBox(
                                            child: TextFormField(
                                              controller:
                                                  aboutGovtTextController,
                                              textCapitalization:
                                                  TextCapitalization.sentences,
                                              decoration: InputDecoration(
                                                prefixIcon: const Icon(
                                                    CupertinoIcons
                                                        .building_2_fill),
                                                hintText: fetchedAboutGovt
                                                        .isEmpty
                                                    ? "Add about Govt Agency"
                                                    : fetchedAboutGovt,
                                              ),
                                              enabled: isEditing,
                                              maxLines: 5,
                                              maxLength: 250,
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return 'Enter about Govt';
                                                }
                                                if (value.isNotEmpty &&
                                                    value.length < 10) {
                                                  return 'Too short';
                                                }
                                                return null;
                                              },
                                            ),
                                          ),
                                          const SizedBox(height: 12),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 20, left: 20),
                        child: Container(
                          padding: const EdgeInsets.only(bottom: 18),
                          width: double.infinity,
                          child: ClipRRect(
                            child: ElevatedButton(
                              onPressed: () {
                                if (isEditing == false) {
                                  showSnakeBar(
                                      context,
                                      "Enable editing to edit Govt Agency profile ..",
                                      "okay");
                                } else {
                                  if (_othersFormKey.currentState!.validate()) {
                                    updateOtherProfile();
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
                ],
              ),
      ),
    );
  }

  Future<void> fetchGovtData() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      DocumentSnapshot govtSnapshot = await FirebaseFirestore.instance
          .collection('clc_govt')
          .doc(user?.email)
          .get();

      if (govtSnapshot.exists) {
        setState(() {
          fetchedGid = govtSnapshot.get('gid');
          fetchedGovtName = govtSnapshot.get('GovtAgencyName');
          fetchedGovtRegNo = govtSnapshot.get('GovtAgencyRegNo');
          fetchedAboutGovt = govtSnapshot.get('aboutGovt');
          profileUrl = govtSnapshot.get('profilePic');
          fetchedServices = govtSnapshot.get('services');
          fetchedContactNo = govtSnapshot.get('contactNumber');
          fetchedWebsite = govtSnapshot.get('website');
          fetchedEmail = govtSnapshot.get('email');
          fetchedState = govtSnapshot.get('state');
          fetchedCity = govtSnapshot.get('city');
          fetchedPinCode = govtSnapshot.get('pinCode');
          fetchedFullAddress = govtSnapshot.get('fullAddress');
          fetchedRegTime = govtSnapshot.get('registrationTime');
          fetchedRegTime = fetchedRegTime.substring(0, 16);
          fetchedScore = govtSnapshot.get('creditScore');
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

  Future<void> updateGovtProfile() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      Map<String, dynamic> updatedData = {
        if (nameTextController.text.trim() != fetchedGovtName)
          'GovtAgencyName': nameTextController.text.trim(),
        if (fetchedServices != serviceGovtTextController.text.trim())
          'services': serviceGovtTextController.text.trim(),
        if (phoneTextController.text.trim() != fetchedContactNo)
          'contactNumber': phoneTextController.text,
        if (emailTextController.text.trim() != fetchedEmail)
          'email': emailTextController.text,
        if (websiteTextController.text.trim() != fetchedWebsite)
          'website': websiteTextController.text.trim(),
        if (selectedState != fetchedState) 'state': selectedState,
        if (selectedCity != fetchedCity) 'city': selectedCity,
        if (pincodeTextController.text != fetchedPinCode)
          'pinCode': pincodeTextController.text.trim(),
        if (addressTextController.text.trim() != fetchedFullAddress)
          'fullAddress': addressTextController.text.trim(),
      };

      // Check if any field is edited
      if (updatedData.isNotEmpty) {
        // Update data in Firestore only for non-empty fields
        await FirebaseFirestore.instance
            .collection('clc_govt')
            .doc(user?.email)
            .update(updatedData);

        setState(() {
          isEditing = false;
        });
        showSnakeBar(context, "Govt profile updated successfully .. ", "okay");
      } else {
        showSnakeBar(context, "No Govt profile data edited !", "close");
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error updating govt profile : $e');
      }
      showSnakeBar(context, "$e!", "Okay");
    }
  }

  //for services selection //
  final List<bool> _checked = List.filled(
    DropdownItems.dropdownItemListofServices.length,
    false,
  );

  void _showCupertinoDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('Select your services from the list :'),
              content: SizedBox(
                width: double.maxFinite,
                height: 300, // Adjust the height as needed
                child: ListView.builder(
                  itemCount: DropdownItems.dropdownItemListofServices.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title:
                          Text(DropdownItems.dropdownItemListofServices[index]),
                      trailing: CupertinoSwitch(
                        value: _checked[index],
                        onChanged: (bool value) {
                          setState(() {
                            _checked[index] = value;
                          });

                          // Update the text field whenever a toggle is changed
                          _updateTextField(_checked);
                        },
                      ),
                    );
                  },
                ),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancel',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('OK',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ],
            );
          },
        );
      },
    ).then((value) {
      _updateTextField(_checked);
    });
  }

  void _updateTextField(List<bool> checked) {
    String selectedOptions = '';
    for (int i = 0; i < DropdownItems.dropdownItemListofServices.length; i++) {
      if (checked[i]) {
        selectedOptions += '${DropdownItems.dropdownItemListofServices[i]}, ';
      }
    }
    if (selectedOptions.isNotEmpty) {
      selectedOptions =
          selectedOptions.substring(0, selectedOptions.length - 2);
    }
    serviceGovtTextController.text = selectedOptions;
  }

  void updateCityList(String state) {
    setState(() {
      dropdownItemCity = DropdownItems.cityMap[state] ?? [];
    });
  }

  Future<String?> uploadImageToStorage(File imageFile) async {
    try {
      firebase_storage.Reference storageRef = firebase_storage
          .FirebaseStorage.instance
          .ref()
          .child('govt')
          .child(fetchedEmail)
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
          .collection("clc_govt")
          .doc(fetchedEmail)
          .update({"profilePic": imageUrl});
    } catch (e) {
      // An error occurred
      if (kDebugMode) {
        print('Error adding picture data to firestore : $e');
      }
    }
  }

  Future<void> updateOtherProfile() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      Map<String, dynamic> updatedData = {
        if (aboutGovtTextController.text.trim() != fetchedAboutGovt)
          'aboutGovt': aboutGovtTextController.text.trim(),
      };

      // Check if any field is edited
      if (updatedData.isNotEmpty) {
        // Update data in Firestore only for non-empty fields
        await FirebaseFirestore.instance
            .collection('clc_govt')
            .doc(user?.email)
            .update(updatedData);

        setState(() {
          isEditing = false;
        });
        showSnakeBar(context, "Govt profile updated successfully .. ", "okay");
      } else {
        // setState(() {isEditing = false;});
        showSnakeBar(context, "No Govt profile data edited !", "close");
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error updating govt profile : $e');
      }
      showSnakeBar(context, "$e!", "Okay");
    }
  }
}
