// import 'package:flutter/material.dart';
// import 'menu_item.dart';
//
// class MenuItems {
//   //static const profile = MenuItem('Profile', Icons.people_alt);
//   static const payment = MenuItem('Payment', Icons.payment);
//   static const promos = MenuItem('Promo', Icons.card_giftcard);
//   static const workspace = MenuItem('WorkSpace', Icons.workspace_premium);
//   static const help = MenuItem('Help', Icons.help);
//   static const aboutUs = MenuItem('About Us', Icons.info_outline);
//   static const rateUs = MenuItem('Rate Us', Icons.card_giftcard);
//
//   static const all = <MenuItem>[
//     //profile,
//     payment,
//     promos,
//     workspace,
//     help,
//     aboutUs,
//     rateUs
//   ];
// }
//
// class MenuPage extends StatelessWidget {
//   final MenuItem currentItem;
//   final ValueChanged<MenuItem> onSelectedItem;
//
//   const MenuPage({
//     Key? key,
//     required this.currentItem,
//     required this.onSelectedItem,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) => Theme(
//         data: ThemeData.light(),
//         child: Scaffold(
//           body: Center(
//             child: Container(
//               height: double.infinity,
//               width: double.infinity,
//               decoration: const BoxDecoration(
//                 gradient: LinearGradient(
//                   colors: [
//                     Color(0xFFebbba7),
//                     Color(0xFFcfc7f8),
//                   ],
//                   tileMode: TileMode.decal,
//                 ),
//               ),
//               //backgroundColor: Colors.transparent,
//               //body: SafeArea(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: <Widget>[
//                   const Spacer(flex: 1),
//                   const Padding(
//                     padding: EdgeInsets.only(left: 8.0),
//                     child: CircleAvatar(
//                       maxRadius: 50,
//                       backgroundImage: AssetImage(
//                         "assets/avaters/Avatar 1.jpg",
//                       ),
//                     ),
//                   ),
//                   const Padding(
//                     padding: EdgeInsets.only(left: 20, bottom: 25),
//                     child: Text(
//                       "hey",
//                       style: TextStyle(fontSize: 26),
//                     ),
//                   ),
//                   ...MenuItems.all.map(buildMenuItem).toList(),
//                   const Spacer(flex: 2),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       );
//
//   Widget buildMenuItem(MenuItem item) => ListTileTheme(
//         selectedColor: Colors.amber[900],
//         child: ListTile(
//           titleTextStyle: const TextStyle(
//               color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600),
//           iconColor: Colors.black,
//           selectedTileColor: Colors.white,
//           selected: currentItem == item,
//           minLeadingWidth: 15,
//           minVerticalPadding: 22,
//           leading: Icon(item.icon),
//           title: Text(item.title),
//           onTap: () => onSelectedItem(item),
//         ),
//       );
// }
