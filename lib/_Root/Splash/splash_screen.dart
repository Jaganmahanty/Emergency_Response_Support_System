// ignore_for_file: use_build_context_synchronously, camel_case_types
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Admin Related/admin_home_screen/home_screen_admin.dart';
import '../../Citizen Related/Screens/citizen_login_screen/otp_screen.dart';
import '../../Components/check_for_internet/check_internet.dart';
import '../../Govt Body Related/Screens/govt_home_screen/home_screen_govt.dart';
import '../../NGO Related/Screens/ngo_home_screen/home_screen_ngo.dart';
import '../../Utils/themes/theme.dart';
import '../../Citizen Related/Screens/citizen_home_screen/home_screen_citizen.dart';
import '../onBoarding/onBoard.dart';

class splash extends StatelessWidget {
  const splash({super.key});
  @override
  Widget build(BuildContext context) {
    final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

    return GetMaterialApp(
      title: 'Safety Assistant',
      navigatorKey: navigatorKey,
      // title: 'Citizen Emergency & response system',
      debugShowCheckedModeBanner: false,
      theme: TAppTheme.lightTheme,
      darkTheme: TAppTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: const SplashScreen(),
      initialRoute: '/',

      //Paths of the screens in key value pair ..
      routes: <String, WidgetBuilder>{
        '/otpScreen': (BuildContext ctx) => OtpScreen(),
        '/liquidpages': (BuildContext ctx) => const Onboarding_Screen(),
        '/homeScreen': (BuildContext ctx) => const CitizenHomeScreen(),
        '/GovtHomeScreen': (BuildContext ctx) => const GovtHomeScreen(),
        '/NGOHomeScreen': (BuildContext ctx) => const NGOHomeScreen(),
      },
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool animate = false;
  String? finalUserType = "";

  @override
  void initState() {
    super.initState();
    startAnimationIn().whenComplete(() async {
      Timer(const Duration(milliseconds: 5),
          () => navigateToPageBasedOnUserType(finalUserType));
    });
    InternetPopup().initialize(context: context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          //1st object on the top left corner ..
          AnimatedPositioned(
            duration: const Duration(milliseconds: 1600),
            top: animate ? 15 : -60,
            left: animate ? 20 : -60,
            height: 130,
            width: 130,
            child: Container(
              //color: Colors.teal,
              width: 70,
              height: 70,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(600),
                      topLeft: Radius.circular(320),
                      bottomLeft: Radius.circular(230),
                      topRight: Radius.circular(200)),
                  color: Color(0xFF2c4178)),
            ),
          ),
          //2nd object as a 2 texts
          AnimatedPositioned(
              duration: const Duration(milliseconds: 1600),
              top: 135,
              left: animate ? 150 : -10,
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 1600),
                opacity: animate ? 1 : 0,
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Welcome",
                      style: TextStyle(fontSize: 22),
                    ),
                    // Text(
                    //   "Safety Assistant",
                    //   style: Theme.of(context).textTheme.bodyLarge,
                    // ),
                  ],
                ),
              )),
          //3rd object as an image
          AnimatedPositioned(
              duration: const Duration(milliseconds: 1600),
              bottom: animate ? 300 : 0,
              left: 40,
              height: 280,
              width: 280,
              child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 1600),
                  opacity: animate ? 1 : 0,
                  child: SvgPicture.asset("assets/images/logo_svg.svg"))),
          //2nd object as a 2 texts
          AnimatedPositioned(
              duration: const Duration(milliseconds: 1600),
              bottom: 160,
              left: animate ? 90 : 400,
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 1600),
                opacity: animate ? 1 : 0,
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "आपदा सेवा सदैव सर्वत्र",
                      style: TextStyle(fontSize: 25, color: Color(0xFF2c4178)),
                    ),
                  ],
                ),
              )),
          //4th small object at bottom ..
          AnimatedPositioned(
            duration: const Duration(milliseconds: 1600),
            bottom: animate ? 40 : 0,
            right: 30,
            // height: 450,
            // width: 350,
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 1600),
              opacity: animate ? 1 : 0,
              child: Container(
                //color: Colors.teal,
                width: 70,
                height: 70,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(100),
                        topLeft: Radius.circular(120),
                        bottomLeft: Radius.circular(30),
                        topRight: Radius.circular(290)),
                    color: Color(0xFFd2af6d)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  //function for animation
  Future startAnimationIn() async {
    await Future.delayed(const Duration(milliseconds: 300));
    setState(() {
      animate = true;
    });
    // await Future.delayed(const Duration(milliseconds: 2700));
    // setState(() {
    //   animate = false;
    // });
    await Future.delayed(const Duration(milliseconds: 3000));

    final SharedPreferences sharedPref = await SharedPreferences.getInstance();
    var obtainedUserType = sharedPref.getString("userType");
    setState(() {
      finalUserType = obtainedUserType;
    });
  }

  void navigateToPageBasedOnUserType(String? userType) {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;
    if (userType == "ADMIN") {
      Get.offAll(() => const AdminHomeScreen());
    } else if (userType == "NGO") {
      Get.offAll(() => const NGOHomeScreen());
    } else if (userType == "Govt") {
      // Navigate to Government screen
      Get.offAll(() => const GovtHomeScreen());
    } else if (userType == "Citizen") {
      //user is not null (has some value)
      if (user != null) {
        //String? userEmail = auth.currentUser!.email;
        String? phone = auth.currentUser!.phoneNumber;
        if (kDebugMode) {
          print("citizen phone : ");
        }
        if (kDebugMode) {
          print(phone);
        }
        // Navigate to Citizen screen
        Get.offAll(() => const CitizenHomeScreen());
      }
    } else {
      Get.offAll(() => const Onboarding_Screen());

      // Handle invalid userType
      if (kDebugMode) {
        print("Invalid userType : $userType");
      }
    }
  }

  Future<void> checkUSerState() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;

    //user is not null (has some value)
    if (user != null) {
      String? userEmail = auth.currentUser!.email;
      String? phone = auth.currentUser!.phoneNumber;
      if (kDebugMode) {
        print("citizen phone : ");
      }
      if (kDebugMode) {
        print(phone);
      }

      if (kDebugMode) {
        print("user is : $user");
      }
      //email is not null
      if (userEmail != null) {
      } else {
        // User is signed in. Navigate to the home screen.
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const CitizenHomeScreen(),
            ));
        //CitizenHomeScreen
      }
    } else {
      if (kDebugMode) {
        print("user is null :( ");
      }

      // User is not signed in. Navigate to the login screen.
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const Onboarding_Screen(),
          ));
    }
  }
}
