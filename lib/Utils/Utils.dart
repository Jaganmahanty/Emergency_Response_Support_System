// ignore_for_file: use_build_context_synchronously, file_names, non_constant_identifier_names
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

// for toast
void showToastMsg(String msg) {
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM_RIGHT,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.white,
      textColor: Colors.black,
      fontSize: 16.0);
}

//for circular progressbar
Future<dynamic> showCircularProgressBar(BuildContext context) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return const Dialog(
        child: Padding(
          padding: EdgeInsets.only(top: 35, bottom: 25, left: 20, right: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 15),
              CircularProgressIndicator(color: Colors.blue),
              SizedBox(height: 30),
              Text('Processing ...')
            ],
          ),
        ),
      );
    },
  );
}

//snakebar
SnackBar TsnakeBar(BuildContext context, String headingText, String labelTxt) {
  return SnackBar(
    dismissDirection: DismissDirection.vertical,
    elevation: 35,
    padding: const EdgeInsets.all(7),
    content: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(headingText),
    ),
    duration: const Duration(seconds: 3),
    // Duration for which SnackBar will be visible
    action: SnackBarAction(
      label: labelTxt,
      onPressed: () {
        // Undo functionality
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
      },
    ),
  );
}

void showSnakeBar(BuildContext context, String message, String actionLabel) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      action: SnackBarAction(
        label: actionLabel,
        onPressed: () {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
        },
      ),
    ),
  );
}

//dialog
void showMsgDialog(BuildContext context, String message) {
  // Set up the AlertDialog
  final CupertinoAlertDialog alert = CupertinoAlertDialog(
    title: const Text('Alert : '),
    content: Text('\n$message'),
    actions: <Widget>[
      CupertinoDialogAction(
        isDefaultAction: true,
        child: const Text('Okay'),
        onPressed: () {
          Navigator.of(context).pop();
        },
      )
    ],
  );
  // Show the dialog
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

//special dialog for back
void showDialogAlert(BuildContext context, String message) {
  // Set up the AlertDialog
  final CupertinoAlertDialog alert = CupertinoAlertDialog(
    title: const Text('Alert : '),
    content: Text('\n$message'),
    actions: <Widget>[
      CupertinoDialogAction(
        isDefaultAction: true,
        child: const Text('Okay'),
        onPressed: () {
          Navigator.of(context).pop();
          Navigator.of(context).pop();
        },
      )
    ],
  );
  // Show the dialog
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

//for pwd validate
String? validatePassword(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter a password';
  }

  if (value.length < 8) {
    return 'Password must be at least 8 characters long';
  }

  if (!value.contains(RegExp(r'[a-z]'))) {
    return 'Password must contain at least one lowercase letter';
  }

  if (!value.contains(RegExp(r'[A-Z]'))) {
    return 'Password must contain at least one uppercase letter';
  }

  if (!value.contains(RegExp(r'[0-9]'))) {
    return 'Password must contain at least one digit';
  }

  if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
    return 'Password must contain at least one special character';
  }

  return null; // Return null if the password passes all validations
}

//for forgot pwd
Future<void> showForgotPasswordDialog(BuildContext context) async {
  TextEditingController forgotPwdController = TextEditingController();
  bool isValidEmail = false; // Track email validation
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return const Center(
        child: CircularProgressIndicator(color: Colors.white),
      );
    },
  );
  await Future.delayed(const Duration(milliseconds: 600));
  Navigator.pop(context);
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return CupertinoAlertDialog(
        title: const Text("Forgot Password"),
        content: Column(
          children: [
            const SizedBox(height: 15),
            const Text("Please enter email to send the reset link below :"),
            const SizedBox(height: 15),
            CupertinoTextField(
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  color: Colors.black12),
              controller: forgotPwdController,
              placeholder: ' Email address',
              onChanged: (value) {
                // Validate email on each change
                isValidEmail = EmailValidator.validate(value.trim());
              },
            ),
          ],
        ),
        actions: <Widget>[
          CupertinoDialogAction(
            onPressed: () async {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) {
                  return const Center(
                    child: CircularProgressIndicator(color: Colors.white),
                  );
                },
              );
              await Future.delayed(const Duration(milliseconds: 800));
              Navigator.pop(context);
              if (isValidEmail) {
                try {
                  FirebaseAuth.instance.sendPasswordResetEmail(
                      email: forgotPwdController.text.trim());
                } on FirebaseAuthException catch (e) {
                  showToastMsg(e.message!);
                }
                // Implement sending email logic here
                // Send email, etc.
                // After email is sent, close the dialog
                Navigator.of(context).pop();
                // Show success message
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return CupertinoAlertDialog(
                      title: const Text("Email sent !"),
                      content: const Text(
                          "We have sent a password reset link to your email check it out , In some case also check spam ."),
                      actions: <Widget>[
                        CupertinoDialogAction(
                          onPressed: () {
                            Navigator.of(context)
                                .pop(); // Close the success message dialog
                          },
                          child: const Text("OKAY"),
                        ),
                      ],
                    );
                  },
                );
              } else {
                // Show error message if email is invalid
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return CupertinoAlertDialog(
                      title: const Text("Invalid Email"),
                      content:
                          const Text("Please enter a valid email address."),
                      actions: <Widget>[
                        CupertinoDialogAction(
                          onPressed: () {
                            Navigator.of(context)
                                .pop(); // Close the error message dialog
                          },
                          child: const Text("OKAY"),
                        ),
                      ],
                    );
                  },
                );
              }
            },
            child: const Text("Send"),
          ),
          CupertinoDialogAction(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
            child: const Text("Cancel"),
          ),
        ],
      );
    },
  );
}

//for table data
DataRow buildDataRow(String field, String data) {
  return DataRow(cells: [
    DataCell(Text(
      field,
      style: const TextStyle(fontWeight: FontWeight.bold),
    )),
    DataCell(Text(data)),
  ]);
}

DataRow buildSingleRow(String? data) {
  return DataRow(cells: [
    DataCell(Text(data!)),
  ]);
}

Color getColorForLevel(String level) {
  switch (level) {
    case 'Low':
      return Colors.yellow.shade400;
    case 'Severe':
      return Colors.orange.shade700;
    case 'Critical':
      return Colors.red.shade500;
    default:
      return Colors.orange;
  }
}