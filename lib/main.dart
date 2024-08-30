import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'Citizen Related/Screens/citizen_request_screen/citizen_req_history_screen.dart';
import 'Components/Notification_related/notification_services.dart';
import 'Utils/common_files/request/open_req_screen.dart';
import '_Root/Splash/splash_screen.dart';
import 'package:get/get.dart';

//void main
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    //TO run the app on the web
    options: const FirebaseOptions(
      apiKey: 'AIzaSyA0-7aYWL06konrMbgAU2aqQz7abmigULE',
      //authDomain: 'YOUR_AUTH_DOMAIN',
      projectId: 'flutter-demo-63b73',
      //storageBucket: 'YOUR_STORAGE_BUCKET',
      messagingSenderId: '730549856356',
      appId: '1:730549856356:android:1f057a3601180a5a5ed771',
    ),
  );
  //Get.put(Authentication_Repo());
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandle);
  runApp(const splash());

  //Orientation
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
  // Status color
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.white12));
}

//top lvl function ...
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandle(RemoteMessage message) async {
  //await Firebase.initializeApp();
  if (message.data['type'] == 'response') {
    Get.to(() => const Request_History_Screen());
    // Get.to(() => Open_Response_Screen(
    //       selectedService: message.data['service'],
    //       authorityName: message.data['authorityName'],
    //       regNo: message.data['regNo'],
    //       address: message.data['address'],
    //       phone: message.data['phone'],
    //       email: message.data['email'],
    //       city: message.data['city'],
    //       website: message.data['website'],
    //     ));
  } else if (message.data['type'] == 'request') {
    Get.to(() => Open_Req_Screen(
          title: message.data['title'],
          add: message.data['address'],
          pin: message.data['pincode'],
          userName: message.data['username'],
          city: message.data['city'],
          rid: message.data['ReqId'],
          contactNo: message.data['phoneNumber'],
        ));
  }

  if (kDebugMode) {
    print(message.notification!.title.toString());
  }
}

//Stateful widget
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

//Widget state
class _MyAppState extends State<MyApp> {
  final nameController = TextEditingController();
  NotificationServices notificationServices = NotificationServices();

  @override
  //initState method
  void initState() {
    // TODO: implement initState
    super.initState();

    //at 12pm
    //NotificationServices().initLocalNotification(context, null); // Initialize local notifications

    //for notification permission pop up
    notificationServices.requestNotificationPermission();

    //for ...
    notificationServices.firebaseInit(context);

    //for token refresh
    //notificationServices.isTokenRefresh();

    //for token mechanism
    notificationServices.getDeviceToken().then((value) {
      if (kDebugMode) {
        print('Device token :');
        print(value);
      }
    });
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          elevation: 50,
          backgroundColor: Colors.grey,
          centerTitle: true,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(25),
                  bottomLeft: Radius.circular(25))),
          title: const Text("DMS"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(80.0),
          child: Column(
            children: [
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                  hintText: 'add',
                ),
              ),
              const SizedBox(
                height: 100,
              ),
              ElevatedButton(
                  onPressed: () {
                    CollectionReference colRef =
                        FirebaseFirestore.instance.collection('client');
                    colRef.add({'name': nameController.text});
                  },
                  child: const Text("Add to database")),
              const SizedBox(
                height: 50,
              ),
              ElevatedButton(
                  onPressed: () {
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //       builder: (context) => const MessageScreen(),
                    //     ));
                  },
                  child: const Text("Next screen")),
            ],
          ),
        ),
      ),
    );
  }
}
