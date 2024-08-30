// // ignore_for_file: depend_on_referenced_packages, camel_case_types
//
// import 'dart:math';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:marquee/marquee.dart';
// import 'package:pie_chart/pie_chart.dart';
// import 'package:stacked_bar_chart/stacked_bar_chart.dart';
//
// import 'package:intl/intl.dart';
//
// class commonbg extends StatefulWidget {
//   const commonbg({super.key});
//
//   @override
//   State<commonbg> createState() => _commonbgState();
// }
//
// class _commonbgState extends State<commonbg> {
//   int randomNumber = Random().nextInt(2);
//   List<Color> colors = [
//     const Color(0xff4d504d),
//     const Color(0xff6b79a6),
//     const Color(0xffd6dcd6),
//     const Color(0xff779b73),
//     const Color(0xffa9dda5),
//     const Color(0xff9aaced),
//   ];
//
//   Map<String, double> dataMap = {
//     "Flutter": 5,
//     "React": 3,
//     "Xamarin": 2,
//     "Ionic": 2,
//   };
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         // Positioned(
//         //     width: MediaQuery.of(context).size.width * 1.7,
//         //     bottom: 200,
//         //     left: 100,
//         //     child: Image.asset("assets/Backgrounds/Spline.png")),
//         // Positioned.fill(
//         //   child: BackdropFilter(
//         //     filter: ImageFilter.blur(sigmaX: 78, sigmaY: 78),
//         //   ),
//         // ),
//         // const RiveAnimation.asset("assets/RiveAssets/shapes.riv"),
//         // Positioned.fill(
//         //   child: BackdropFilter(
//         //     filter: ImageFilter.blur(sigmaX: 78, sigmaY: 78),
//         //     child: const SizedBox(),
//         //   ),
//         // ),
//
//         Expanded(
//           child: Column(
//             children: [
//               Padding(
//                 padding: const EdgeInsets.only(left: 130),
//                 //first bar
//                 child: Container(
//                   height: 35,
//                   width: 1330,
//                   decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(10),
//                       border: Border.all(
//                         color: Colors.lightGreen,
//                         width: 2,
//                       )
//                   ),
//                   child: const Row(
//                     children: [
//                       Padding(
//                         padding: EdgeInsets.only(right: 20),
//                         child: Icon(
//                           Icons.person, weight: 20, size: 32,),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 10),
//               Row(
//                 // news bar
//                 children: [
//                   Container(
//                     height: 35,
//                     width: 1335,
//                     decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(10),
//                         border: Border.all(
//                           color: Colors.lightGreen,
//                           width: 2,
//                         )
//                     ),
//                     child: Marquee(
//                       text: 'A Flutter widget that scrolls text infinitely. Provides many customizations including custom scroll directions, durations, curves as well as pauses after every round.Appreciate the widget? Show some ❤ and star the repo to support the project.',
//                       style: const TextStyle(fontWeight: FontWeight.bold),
//                       scrollAxis: Axis.horizontal,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       blankSpace: 20.0,
//                       velocity: 100.0,
//                       pauseAfterRound: const Duration(microseconds: 800),
//                       startPadding: 10.0,
//                       accelerationDuration: const Duration(seconds: 1),
//                       accelerationCurve: Curves.linear,
//                       decelerationDuration: const Duration(milliseconds: 500),
//                       decelerationCurve: Curves.easeOut,
//                     ),
//                   )
//
//                 ],
//               ),
//               const SizedBox(height: 10),
//               Row(
//                 //quick access
//                 children: [
//                   //USER
//                   Container(
//                       width: 270,
//                       height: 120,
//                       decoration: BoxDecoration(
//                         gradient: const LinearGradient(
//                           colors: [
//                             Colors.orangeAccent,
//                             Colors.deepOrangeAccent
//                           ],
//                           begin: Alignment.topLeft,
//                           end: Alignment.topRight,
//                           stops: [0.0, 1.0],
//                           tileMode: TileMode.mirror,
//                         ),
//                         borderRadius: BorderRadius.circular(10.0),
//                       ),
//                       child: const Row(children: [
//                         Padding(
//                           padding: EdgeInsets.only(left: 15),
//                           child: Text(
//                             '1500\nUser',
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 20,
//                             ),
//                           ),
//                         ),
//                         SizedBox(width: 80),
//                         Icon(Icons.person, color: Colors.white,
//                             size: 100)
//                       ])
//
//                   ),
//
//                   const SizedBox(width: 20.0),
//                   //Requests
//                   Container(
//                       width: 250,
//                       height: 120,
//                       decoration: BoxDecoration(
//                         gradient: const LinearGradient(
//                           colors: [
//                             Colors.redAccent,
//                             Colors.lightBlue
//                           ],
//                           begin: Alignment.topLeft,
//                           end: Alignment.topRight,
//                           stops: [0.0, 1.0],
//                           tileMode: TileMode.mirror,
//                         ),
//                         borderRadius: BorderRadius.circular(10.0),
//                       ),
//                       child: const Row(children: [
//                         Padding(
//                           padding: EdgeInsets.only(left: 15),
//                           child: Text(
//                             '5478\nRequests',
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 20,
//                             ),
//                           ),
//                         ),
//                         SizedBox(width: 49.2),
//                         Icon(Icons.help_outline_rounded,
//                             color: Colors.white, size: 100)
//                       ])),
//                   const SizedBox(width: 20.0),
//                   //Donations
//                   Container(
//                       width: 250,
//                       height: 120,
//                       decoration: BoxDecoration(
//                         gradient: const LinearGradient(
//                           colors: [Colors.green, Colors.indigoAccent],
//                           begin: Alignment.topLeft,
//                           end: Alignment.topRight,
//                           stops: [0.0, 2.0],
//                           tileMode: TileMode.clamp,
//                         ),
//                         borderRadius: BorderRadius.circular(10.0),
//                       ),
//                       child: const Row(children: [
//                         Text(
//                           '15k\nDonations',
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 20,
//                           ),
//                         ),
//
//                         SizedBox(width: 42),
//                         Icon(Icons.attach_money_outlined,
//                             color: Colors.white, size: 100)
//                       ])),
//                   const SizedBox(width: 20.0),
//                   //CITIES
//                   Container(
//                       width: 250,
//                       height: 120,
//                       decoration: BoxDecoration(
//                         gradient: const LinearGradient(
//                           colors: [Colors.blue, Colors.lightGreen],
//                           begin: Alignment.topLeft,
//                           end: Alignment.topRight,
//                           stops: [0.0, 1.0],
//                           tileMode: TileMode.mirror,
//                         ),
//                         borderRadius: BorderRadius.circular(10.0),
//                       ),
//                       child: const Row(children: [
//                         Text(
//                           'In 137\ncities ',
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 20,
//                           ),
//                         ),
//
//                         SizedBox(width: 70),
//                         Icon(Icons.location_on_outlined,
//                             color: Colors.white, size: 100)
//                       ])),
//                   const SizedBox(width: 20.0),
//                   //CITIES
//                   Container(
//                       width: 250,
//                       height: 120,
//                       decoration: BoxDecoration(
//                         gradient: const LinearGradient(
//                           colors: [Colors.blue, Colors.lightGreen],
//                           begin: Alignment.topLeft,
//                           end: Alignment.topRight,
//                           stops: [0.0, 1.0],
//                           tileMode: TileMode.mirror,
//                         ),
//                         borderRadius: BorderRadius.circular(10.0),
//                       ),
//                       child: const Row(
//                           children: [
//                             Text(
//                               'In 137\ncities ',
//                               style: TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 20,
//                               ),
//                             ),
//
//                             SizedBox(width: 70),
//                             Icon(Icons.location_on_outlined,
//                                 color: Colors.white, size: 100)
//                           ])),
//                 ],
//               ),
//               const SizedBox(height: 20.0),
//               //CHARTS
//               Row(
//                 children: [
//                   //Bar charts
//                   Container(
//                     width: 700,
//                     height: 500,
//                     decoration: BoxDecoration(
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.white.withOpacity(0.3),
//                             spreadRadius: 2,
//                             blurRadius: 5,
//                             offset: const Offset(0, 3),
//                           )
//                         ],
//                         border: Border.all(
//                           color: Colors.black,
//                           width: 1,
//                         ),
//                         borderRadius: BorderRadius.circular(8)),
//                     child: AspectRatio(
//                       aspectRatio: 1,
//                       child: Graph(
//                         GraphData(
//                           "My Graph",
//                           [
//                             GraphBar(
//                               DateTime(2020, 01),
//                               [
//                                 GraphBarSection(100,
//                                     color: colors[randomNumber]),
//                                 GraphBarSection(900,
//                                     color: colors[randomNumber +
//                                         1]),
//                                 GraphBarSection(0,
//                                     color: colors[randomNumber +
//                                         2]),
//                                 GraphBarSection(0,
//                                     color: colors[randomNumber +
//                                         3]),
//                               ],
//                             ),
//                             GraphBar(
//                               DateTime(2020, 2),
//                               [
//                                 GraphBarSection(50,
//                                     color: colors[randomNumber]),
//                                 //second
//                                 GraphBarSection(501,
//                                     color: colors[randomNumber +
//                                         1]),
//                                 //first
//                                 GraphBarSection(-100,
//                                     color: colors[randomNumber +
//                                         2]),
//                                 GraphBarSection(-700,
//                                     color: colors[randomNumber +
//                                         3]),
//                               ],
//                             ),
//                             GraphBar(
//                               DateTime(2020, 3),
//                               [
//                                 GraphBarSection(150,
//                                     color: colors[randomNumber]),
//                                 GraphBarSection(800.22,
//                                     color: colors[randomNumber +
//                                         1]),
//                                 GraphBarSection(-150,
//                                     color: colors[randomNumber +
//                                         2]),
//                                 GraphBarSection(-550,
//                                     color: colors[randomNumber +
//                                         3]),
//                               ],
//                             ),
//                             GraphBar(
//                               DateTime(2020, 4),
//                               [
//                                 GraphBarSection(750,
//                                     color: colors[randomNumber]),
//                                 GraphBarSection(45,
//                                     color: colors[randomNumber +
//                                         1]),
//                                 GraphBarSection(-50,
//                                     color: colors[randomNumber +
//                                         2]),
//                                 GraphBarSection(-570,
//                                     color: colors[randomNumber +
//                                         3]),
//                               ],
//                             ),
//                             GraphBar(
//                               DateTime(2020, 5),
//                               [
//                                 GraphBarSection(200,
//                                     color: colors[randomNumber]),
//                                 GraphBarSection(670,
//                                     color: colors[randomNumber +
//                                         1]),
//                                 GraphBarSection(-400,
//                                     color: colors[randomNumber +
//                                         2]),
//                                 GraphBarSection(-50,
//                                     color: colors[randomNumber +
//                                         3]),
//                               ],
//                             ),
//                             GraphBar(
//                               DateTime(2020, 6),
//                               [
//                                 GraphBarSection(200,
//                                     color: colors[randomNumber]),
//                                 GraphBarSection(307,
//                                     color: colors[randomNumber +
//                                         1]),
//                                 GraphBarSection(-309,
//                                     color: colors[randomNumber +
//                                         2]),
//                                 GraphBarSection(-90,
//                                     color: colors[randomNumber +
//                                         3]),
//                               ],
//                             ),
//                             GraphBar(
//                               DateTime(2020, 7),
//                               [
//                                 GraphBarSection(200,
//                                     color: colors[randomNumber]),
//                                 GraphBarSection(350,
//                                     color: colors[randomNumber +
//                                         1]),
//                                 GraphBarSection(-170,
//                                     color: colors[randomNumber +
//                                         2]),
//                                 GraphBarSection(-500,
//                                     color: colors[randomNumber +
//                                         3]),
//                               ],
//                             ),
//                             GraphBar(
//                               DateTime(2020, 8),
//                               [
//                                 GraphBarSection(200,
//                                     color: colors[randomNumber]),
//                                 GraphBarSection(300,
//                                     color: colors[randomNumber +
//                                         1]),
//                                 GraphBarSection(-300,
//                                     color: colors[randomNumber +
//                                         2]),
//                                 GraphBarSection(-500,
//                                     color: colors[randomNumber +
//                                         3]),
//                               ],
//                             ),
//                             GraphBar(
//                               DateTime(2020, 9),
//                               [
//                                 GraphBarSection(200,
//                                     color: colors[randomNumber]),
//                                 GraphBarSection(390,
//                                     color: colors[randomNumber +
//                                         1]),
//                                 GraphBarSection(-1000,
//                                     color: colors[randomNumber +
//                                         2]),
//                                 GraphBarSection(-0,
//                                     color: colors[randomNumber +
//                                         3]),
//                               ],
//                             ),
//                             GraphBar(
//                               DateTime(2020, 10),
//                               [
//                                 GraphBarSection(60,
//                                     color: colors[randomNumber]),
//                                 GraphBarSection(700,
//                                     color: colors[randomNumber +
//                                         1]),
//                                 GraphBarSection(-100,
//                                     color: colors[randomNumber +
//                                         2]),
//                                 GraphBarSection(-500,
//                                     color: colors[randomNumber +
//                                         3]),
//                               ],
//                             ),
//                             GraphBar(
//                               DateTime(2020, 11),
//                               [
//                                 GraphBarSection(200,
//                                     color: colors[randomNumber]),
//                                 GraphBarSection(470,
//                                     color: colors[randomNumber +
//                                         1]),
//                                 GraphBarSection(-700,
//                                     color: colors[randomNumber +
//                                         2]),
//                                 GraphBarSection(-320,
//                                     color: colors[randomNumber +
//                                         3]),
//                               ],
//                             ),
//                             GraphBar(
//                               DateTime(2020, 12),
//                               [
//                                 GraphBarSection(500,
//                                     color: colors[randomNumber]),
//                                 GraphBarSection(500.0,
//                                     color: colors[randomNumber +
//                                         1]),
//                                 GraphBarSection(-500.0,
//                                     color: colors[randomNumber +
//                                         2]),
//                                 GraphBarSection(-500.0,
//                                     color: colors[randomNumber +
//                                         3]),
//                               ],
//                             ),
//
//                           ],
//                           Colors.white,
//                         ),
//                         yLabelConfiguration: YLabelConfiguration(
//                           labelStyle: const TextStyle(
//                             color: Colors.grey,
//                             fontSize: 11,
//                           ),
//                           interval: 500,
//                           labelCount: 5,
//                           labelMapper: (num value) {
//                             return NumberFormat.compactCurrency(
//                                 locale: "en",
//                                 decimalDigits: 0,
//                                 symbol: "\$")
//                                 .format(value);
//                           },
//                         ),
//                         xLabelConfiguration: XLabelConfiguration(
//                           labelStyle: const TextStyle(
//                             color: Colors.grey,
//                             fontSize: 11,
//                           ),
//                           labelMapper: (DateTime date) {
//                             return DateFormat("MMM yyyy").format(
//                                 date);
//                           },
//                         ),
//                         netLine: NetLine(
//                           showLine: true,
//                           lineColor: Colors.blue,
//                           pointBorderColor: Colors.black,
//                           coreColor: Colors.white,
//                         ),
//                         graphType: GraphType.StackedRounded,
//                         onBarTapped: (GraphBar bar) {
//                           if (kDebugMode) {
//                             print(bar.month);
//                           }
//                           setState(() {});
//                         },
//                       ),
//                     ),
//                   ),
//                   const SizedBox(width: 20),
//                   //Pie chart different package
//                   Container(
//                       width: 603,
//                       height: 500,
//                       decoration: BoxDecoration(
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.white.withOpacity(0.3),
//                               spreadRadius: 2,
//                               blurRadius: 5,
//                               offset: const Offset(0, 3),
//                             )
//                           ],
//                           border: Border.all(
//                             color: Colors.black,
//                             width: 1,
//                           ),
//                           borderRadius: BorderRadius.circular(8)),
//                       child: PieChart(
//                         dataMap: dataMap,
//                         animationDuration: const Duration(
//                             seconds: 2),
//                         chartLegendSpacing: 32,
//                         chartRadius: MediaQuery
//                             .of(context)
//                             .size
//                             .width / 3.2,
//                         colorList: colors,
//                         initialAngleInDegree: 0,
//                         ringStrokeWidth: 32,
//                         centerText: "HYBRID",
//                         legendOptions: const LegendOptions(
//                           showLegendsInRow: false,
//                           legendPosition: LegendPosition.right,
//                           showLegends: true,
//                           legendShape: BoxShape.circle,
//                           legendTextStyle: TextStyle(
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       )
//                   ),
//                 ],
//               ),
//
//
//               const Padding(
//                 padding: EdgeInsets.only(left:160),
//                 child: Row(
//                     children: [
//                       //below the charts
//                     ]
//                 ),
//               ),
//             ],
//           ),
//
//         ),
//
//         //home design
//         Center(
//           child: ElevatedButton(
//             child: const Text("Click"),
//             onPressed: () {
//               // Navigator.of(context).push(MaterialPageRoute(
//               //     builder: (context) => const msgScreen())
//               // );
//             },
//           ),
//         ),
//       ],
//     );
//   }
// }
