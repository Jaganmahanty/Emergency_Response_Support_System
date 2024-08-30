// import 'package:flutter/material.dart';
//
//
// // ignore: camel_case_types
// class signIn extends StatefulWidget {
//   const signIn({super.key});
//
//   @override
//   State<signIn> createState() => _signInState();
// }
//
// // ignore: camel_case_types
// class _signInState extends State<signIn> {
//   final AuthService _auth = AuthService();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.brown[900],
//       appBar: AppBar(
//         backgroundColor: Colors.brown[400],
//         elevation: 0.0,
//         title: const Text("Sign inn to Brew  Crew"),
//       ),
//       body: Container(
//         padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
//         child: ElevatedButton(
//           child: const Text("Sign in anonymus"),
//           onPressed: () async {
//             dynamic result = await _auth.signInAnon();
//             if (result == null) {
//               print("Error Signing in");
//             } else {
//               print("signed in");
//               print(result.uid);
//             }
//           },
//         ),
//       ),
//     );
//   }
// }
