import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final clickOnLogin;

  // ignore: sort_constructors_first
  const CustomButton(this.clickOnLogin, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 20,left: 20,right: 20),
      width: double.infinity,
      child: ClipRRect(
          child: ElevatedButton(
              onPressed: () async {
                //Circular progress bar ..
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
                // ignore: use_build_context_synchronously
                Navigator.pop(context);
                // ignore: use_build_context_synchronously
                clickOnLogin(context);
                //Navigator.push(context, MaterialPageRoute(builder: (context) => OtpScreen()));
              },
              child: const Text("Proceed"))),
    );
  }
}

// GestureDetector(
// onTap: () {
// verifyOtp();
// },
// child: Container(
// margin: const EdgeInsets.all(8),
// height: 45,
// width: double.infinity,
// decoration: BoxDecoration(
// color: const Color.fromARGB(255, 253, 188, 51),
// borderRadius: BorderRadius.circular(36),
// ),
// alignment: Alignment.center,
// child: const Text(
// 'Verify',
// style: TextStyle(color: Colors.black, fontSize: 16.0),
// ),
// ),
// ),
