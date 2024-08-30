// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import '../../Utils/themes/theme.dart';
// import '../../Citizen Related/Screens/citizen_request_screen.dart';
// import 'notification_services.dart';
//
// // void main() async {
// //   WidgetsFlutterBinding.ensureInitialized();
// //   await Firebase.initializeApp();
// //
// //   FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandle);
// //   //runApp(const MessageScreen());
// // }
// //
// // //top lvl function ...
// // @pragma('vm:entry-point')
// // Future<void> _firebaseMessagingBackgroundHandle(RemoteMessage message) async {
// //   await Firebase.initializeApp();
// //   if (kDebugMode) {
// //     print(message.notification!.title.toString());
// //   }
// // }
//
// class MessageScreen extends StatelessWidget {
//   const MessageScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       //For the themes functionalities as per the system .
//       theme: TAppTheme.lightTheme,
//       darkTheme: TAppTheme.darkTheme,
//       themeMode: ThemeMode.system,
//       home: const msgScreen(),
//       debugShowCheckedModeBanner: false,
//     );
//   }
// }
//
// // ignore: camel_case_types
// class msgScreen extends StatefulWidget {
//   const msgScreen({super.key});
//
//   @override
//   State<msgScreen> createState() => _msgScreenState();
// }
//
// // ignore: camel_case_types
// class _msgScreenState extends State<msgScreen> {
//   final nameController = TextEditingController();
//   NotificationServices notificationServices = NotificationServices();
//
//   @override
//   //initState method
//   void initState() {
//     super.initState();
//
//     //at 12pm
//     //NotificationServices().initLocalNotification(context, null); // Initialize local notifications
//
//     // //for notification permission pop up
//     // notificationServices.requestNotificationPermission();
//
//     //listen to  incoming msg...
//     //notificationServices.firebaseInit(context);
//
//     //for  notification when background and terminated case of application
//     //notificationServices.setupInteractMessage(context);
//
//     //for token refresh
//     //notificationServices.isTokenRefresh();
//
//     //for token mechanism
//     notificationServices.getDeviceToken().then((value) {
//       if (kDebugMode) {
//         // print('Device token :');
//         //print(value);
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         elevation: 50,
//         backgroundColor: Colors.white24,
//         centerTitle: true,
//         shape: const RoundedRectangleBorder(
//             borderRadius: BorderRadius.only(
//                 bottomRight: Radius.circular(25),
//                 bottomLeft: Radius.circular(25))),
//         title: const Text("DMS"),
//       ),
//       // appBar: AppBar(
//       //   leading: const Icon(Icons.ac_unit_sharp),
//       //   title: const Text('Landing Page'),
//       //   elevation: 50,
//       //   backgroundColor: Colors.black12,
//       //   centerTitle: true,
//       //   shape: const RoundedRectangleBorder(
//       //       borderRadius: BorderRadius.only(
//       //           bottomRight: Radius.circular(25),
//       //           bottomLeft: Radius.circular(25))),
//       // ),
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.only(right: 20, left: 20),
//           child: Container(
//             padding: const EdgeInsets.only(bottom: 15),
//             width: double.infinity,
//             child: ClipRRect(
//                 child: ElevatedButton(
//                     onPressed: () {
//                       Navigator.of(context).push(
//                         PageRouteBuilder(
//                           pageBuilder:
//                               (context, animation, secondaryAnimation) =>
//                                   const userRequest_Screen(),
//                           transitionsBuilder:
//                               (context, animation, secondaryAnimation, child) {
//                             var begin = const Offset(1.0, 0.0);
//                             var end = Offset.zero;
//                             var curve = Curves.ease;
//
//                             var tween = Tween(begin: begin, end: end)
//                                 .chain(CurveTween(curve: curve));
//                             var offsetAnimation = animation.drive(tween);
//
//                             return SlideTransition(
//                               position: offsetAnimation,
//                               child: child,
//                             );
//                           },
//                         ),
//                       );
//                     },
//                     style: ButtonStyle(
//                         shape: MaterialStateProperty.all(RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(18)))),
//                     child: const Text("Proceed for a request"))),
//           ),
//         ),
//       ),
//     );
//   }
// }
