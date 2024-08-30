// ignore_for_file: camel_case_types
import 'package:flutter/material.dart';
import 'menu_govt.dart';

class SideMenu_govt extends StatelessWidget {
  const SideMenu_govt(
      {super.key,
      required this.menu,
      required this.press,
      required this.selectedMenu});

  final Menu_govt menu;
  final VoidCallback press;
  // final ValueChanged<Artboard> riveOnInit;
  final Menu_govt selectedMenu;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 24),
          child: Divider(color: Colors.white24, height: 1),
        ),
        Stack(
          children: [
            AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              curve: Curves.fastOutSlowIn,
              width: selectedMenu == menu ? 288 : 0,
              height: 56,
              left: 0,
              child: Container(
                decoration: const BoxDecoration(
                  color: Color(0xFF6792FF),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
            ),
            ListTile(
              onTap: press,
              //     () {
              //   if (menu.title == "Profile") {
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //         builder: (context) =>
              //             const MessageScreen(), // Replace with the desired destination screen
              //       ),
              //     );
              //   }
              //   // Navigate to the corresponding page
              // },
              leading: SizedBox(
                height: 36,
                width: 36,
                child: Icon(menu.icon,color: Colors.grey.shade400)
              ),
              title: Text(
                menu.title,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
