import 'package:fff/Utils/themes/widget_theme/appbar_theme.dart';
import 'package:fff/Utils/themes/widget_theme/bottom_sheet_theme.dart';
import 'package:fff/Utils/themes/widget_theme/checkbox_theme.dart';
import 'package:fff/Utils/themes/widget_theme/elevated_button_theme.dart';
import 'package:fff/Utils/themes/widget_theme/outlined_buttom_theme.dart';
import 'package:fff/Utils/themes/widget_theme/text_field_theme.dart';
import 'package:fff/Utils/themes/widget_theme/text_theme.dart';
import 'package:flutter/material.dart';

class TAppTheme {
  TAppTheme._();

  /// Light Theme
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    brightness: Brightness.light,
    primaryColor: Colors.blue,
    textTheme: TTextTheme.lightTextTheme,
    appBarTheme: TAppBarTheme.lightAppBarTheme,
    checkboxTheme: TCheckboxTheme.lightCheckboxTheme,
    bottomSheetTheme: TBottomSheetTheme.lightBottomSheetTheme,
    elevatedButtonTheme: TElevatedButtonTheme.lightElevatedButtonTheme,
    outlinedButtonTheme: TOutlinedButtonTheme.lightOutlinedButtonTheme,
    inputDecorationTheme: TTextFormFieldTheme.lightInputDecorationTheme,
    // textButtonTheme: TTextButtonTheme.lightTextButtonTheme,
    scaffoldBackgroundColor: Colors.white,
    //chipTheme: TChipTheme.lightChipTheme
  );

  /// Dark Theme
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    brightness: Brightness.dark,
    primaryColor: Colors.blue,
    textTheme: TTextTheme.darkTextTheme,
    scaffoldBackgroundColor: Colors.black,
    appBarTheme: TAppBarTheme.darkAppBarTheme,
    checkboxTheme: TCheckboxTheme.darkCheckboxTheme,
    bottomSheetTheme: TBottomSheetTheme.darkBottomSheetTheme,
    elevatedButtonTheme: TElevatedButtonTheme.darkElevatedButtonTheme,
    outlinedButtonTheme: TOutlinedButtonTheme.darkOutlinedButtonTheme,
    inputDecorationTheme: TTextFormFieldTheme.darkInputDecorationTheme,
    // textButtonTheme: TTextButtonTheme.darkTextButtonTheme
    //chipTheme: TChipTheme.darkChipTheme
  );
}



//removed from sed notification page ...


// notificationServices
//     .getDeviceToken()
//     .then((value) async {
//   //final int notificationId = ++_notificationId;
//   var data = {
//     //token of the current device on which send notification
//     //token of Redmi 11s JD
//     //'to': 'cZqH_WMLSK2V8HdN6wNCer:APA91bGlnFnXHHC7o5lCfP4d3AhHt8ta8-ABfcbomMXCCS0C4u7gspYubniOUHR4RYGvrmqBWtCcqsZE4vhgP5etTMVf6-jJawhcbbmyY2AI8X4zME_u341-wJJbDEi1YOp8yygzxKvV',
//     //10s P
//     //'to': 'eFXrWYvwSJmz1I6pa9QPd5:APA91bG4ef9vR2xMxIclUjvFslcw_5vscBui4ogz3wN3qJ1-kRICsUZCZb4CwQBPYAxbfJDSmWiKMXOLOYgRFFoPme_qsWdGYv6xNZ52t71TUJMf6kPrejZ4ciroWjwuK3XFISZ0-BUH',
//     //5g G
//     //'to':'eOCtztseTY-sStK8pWjUyr:APA91bFcCFH7veaxwHNQmow9yzDwdoRYz6X8HuTvXa8TB_49CfahlrqO4u7oX1cUGZmMaZGTQa2N8-TCQQOdNnDo1pWZdgdFe4W8kjK33wy1zsKDyBfExZj2lFErIcOhUy7QkHQzggAj',
//     //4g 12
//     //'to': 'dDN6-YaRQv6czfMyfp46Td:APA91bEuwyvOcHgZOCoZxkjCTonKFnSMg86LVRLZD0oIjdCQspGjgl0qesd0qV8v5ffoeRGFJL6YTG6R8wkRpCdGqzg6hvMiqwE9eqPuZcIvQSNv2X5LLODqyjDErA6rDHFV9hsXh6iG',
//     //8 TT
//     // 'to': 'dEcBt0ybQlqvu2WBaBCIDr:APA91bGPT7at0ZpLLoRIKBY3ScLAn01CY-At80NZInKsiFFJQE7_iefiJEXxoym67IV66iaIrutolu2czHU8UxOnt1e6Dd841-x-YTSaZU2Vfo_N4FWP_0NGffp0Bz8cnWsZtrROi9Ef',
//     'to':'dSB5hSl9RsKPFGkpuEP2lF:APA91bHsLp9rPGV_ClDRwj70MA-zve389i-JhDUKm3Ca87qKf4ziH6ynj73YVs7WiaUJJNmz_7nRDx5U2KAqODUzfS3nUd-yap0GygWIeqqSeB8nYG_reXlUm96hMYMOiJkizx-CHfFw',
//     //'to': value.toString(),
//     'priority': 'high',
//     //shown details
//     'notification': {
//       'title': selectedService,
//       'body': "${selectedRadioAddress == 1 ? fetchedFullAddress : addressController.text}"
//           "${selectedRadioAddress == 1 ? fetchedPinCode : pincodeController.text}"
//       //'body': "It's Emergency Alert ...",
//     },
//     //
//     'android': {
//       'notification': {'notification_count': 23},
//     },
//     //passed data
//     'data': {
//       //'type': "It's Emergency Alert ...",
//       'title': "It's $selectedService",
//       'address': selectedRadioAddress == 1 ? fetchedFullAddress : addressController.text,
//       'pincode': selectedRadioAddress == 1 ? fetchedPinCode : pincodeController.text,
//     }
//   };
//   //send over http
//   await http.post(
//       Uri.parse(
//           'https://fcm.googleapis.com/fcm/send'),
//       body: jsonEncode(data),
//       headers: {
//         'Content-Type':
//             'application/json; charset=UTF-8',
//         'Authorization':
//             'key=AAAAqhgqKGQ:APA91bEi_iwrEhn8BbQOG7pfFwUikl3Kp0K1sKAoOadF9Evb8Off1U5EqwljkoMprm5uO-aS_wctndIRoJum30YbvyJIBA5W4TF-EBmL8DRTrY1kHTTsDXaW8wWPLBSrbcgPobzzm8No'
//       });
//   setState(() {
//     // Increment notificationId so that each notification has a unique ID
//     //_notificationId++;
//   });
// });



//==================================================================
//==================================================================

//from another page


// const Text('The information from the notification Is : - '),
// Padding(
// padding: const EdgeInsets.symmetric(horizontal: 40),
// child: TextFormField(
// controller: txtControl,
// keyboardType: TextInputType.text,
// //initialValue: widget.id,
// decoration:
// const InputDecoration(prefixIcon: Icon(Icons.accessible)),
// ),
// ),
// // Text(widget.id,
// //     style: const TextStyle(
// //         color: Colors.lightBlue,
// //         fontSize: 30,
// //         fontWeight: FontWeight.bold)),
// TextButton(
// onPressed: () {
// // notificationServices.getDeviceToken().then((value) async {
// //   var data = {
// //     //token of the current device on which send notification
// //     //token of Redmi 11s
// //     //'to': 'diH2eMWdRv-v6tt3pO4lPA:APA91bHTwnPxE8sbeejiN5dK7xzcyR3uv9v_iM9ExCZ9r_oJu7GMw8MSO-QSX5oyIpG3hd3cNk42LJvlsJT50fG1UahMZxSc2pFI9lfauZFT3O90KDEu9tH6o5glznr_rpKC9iEFkq5r',
// //     //10s
// //     'to': 'd2VeiI14SPijdDYxyoAqll:APA91bGzi2QV-nQWA2yr6d_dAsBl1ouj6UeO_ajyLk4UwfJkXgoXCuYKC5PSISCPFTud1fl05KFTwTqQXxqUyqBjf7JkEpw03j7_VepL2yUeEWRcFNjIeFG747a5f_Qq8OLdHfA854-C',
// //     //5g
// //     //'to':'eOCtztseTY-sStK8pWjUyr:APA91bFcCFH7veaxwHNQmow9yzDwdoRYz6X8HuTvXa8TB_49CfahlrqO4u7oX1cUGZmMaZGTQa2N8-TCQQOdNnDo1pWZdgdFe4W8kjK33wy1zsKDyBfExZj2lFErIcOhUy7QkHQzggAj',
// //
// //     //'to': value.toString(),
// //     'priority': 'high',
// //     //shown details
// //     'notification': {
// //       'title': 'Alert!',
// //       'body': txtControl.text
// //       //'body': "It's Emergency Alert ...",
// //     },
// //     //
// //     'android': {
// //       'notification': {
// //         'notification_count': 23
// //       },
// //     },
// //     //passed data
// //     'data': {
// //       //'type': "It's Emergency Alert ...",
// //       'type': "It's ${txtControl.text}",
// //       'id': '1234567890'}
// //   };
// //   await http.post(
// //       Uri.parse('https://fcm.googleapis.com/fcm/send'),
// //       body: jsonEncode(data),
// //       headers: {
// //         'Content-Type': 'application/json; charset=UTF-8',
// //         'Authorization':
// //             'key=AAAAqhgqKGQ:APA91bEi_iwrEhn8BbQOG7pfFwUikl3Kp0K1sKAoOadF9Evb8Off1U5EqwljkoMprm5uO-aS_wctndIRoJum30YbvyJIBA5W4TF-EBmL8DRTrY1kHTTsDXaW8wWPLBSrbcgPobzzm8No'
// //       });
// // });
// notificationServices.getDeviceToken().then((value) async {
// var data = {
// //token of the current device on which send notification
// //token of Redmi 11s JD
// //'to': 'diH2eMWdRv-v6tt3pO4lPA:APA91bHTwnPxE8sbeejiN5dK7xzcyR3uv9v_iM9ExCZ9r_oJu7GMw8MSO-QSX5oyIpG3hd3cNk42LJvlsJT50fG1UahMZxSc2pFI9lfauZFT3O90KDEu9tH6o5glznr_rpKC9iEFkq5r',
// //10s P
// //'to': 'd2VeiI14SPijdDYxyoAqll:APA91bGzi2QV-nQWA2yr6d_dAsBl1ouj6UeO_ajyLk4UwfJkXgoXCuYKC5PSISCPFTud1fl05KFTwTqQXxqUyqBjf7JkEpw03j7_VepL2yUeEWRcFNjIeFG747a5f_Qq8OLdHfA854-C',
// //5g G
// //'to':'eOCtztseTY-sStK8pWjUyr:APA91bFcCFH7veaxwHNQmow9yzDwdoRYz6X8HuTvXa8TB_49CfahlrqO4u7oX1cUGZmMaZGTQa2N8-TCQQOdNnDo1pWZdgdFe4W8kjK33wy1zsKDyBfExZj2lFErIcOhUy7QkHQzggAj',
// //4g 12
// //'to': 'dDN6-YaRQv6czfMyfp46Td:APA91bEuwyvOcHgZOCoZxkjCTonKFnSMg86LVRLZD0oIjdCQspGjgl0qesd0qV8v5ffoeRGFJL6YTG6R8wkRpCdGqzg6hvMiqwE9eqPuZcIvQSNv2X5LLODqyjDErA6rDHFV9hsXh6iG',
// //8 TT
// 'to':
// 'dEcBt0ybQlqvu2WBaBCIDr:APA91bGPT7at0ZpLLoRIKBY3ScLAn01CY-At80NZInKsiFFJQE7_iefiJEXxoym67IV66iaIrutolu2czHU8UxOnt1e6Dd841-x-YTSaZU2Vfo_N4FWP_0NGffp0Bz8cnWsZtrROi9Ef',
// //'to': value.toString(),
// 'priority': 'high',
// //shown details
// 'notification': {
// 'title': 'Alert!',
// 'body': txtControl.text
// //'body': "It's Emergency Alert ...",
// },
// //
// 'android': {
// 'notification': {'notification_count': 23},
// },
// //passed data
// 'data': {
// //'type': "It's Emergency Alert ...",
// 'type': "It's ${txtControl.text}",
// 'id': '1234567890'
// }
// };
// await http.post(
// Uri.parse('https://fcm.googleapis.com/fcm/send'),
// body: jsonEncode(data),
// headers: {
// 'Content-Type': 'application/json; charset=UTF-8',
// 'Authorization':
// 'key=AAAAqhgqKGQ:APA91bEi_iwrEhn8BbQOG7pfFwUikl3Kp0K1sKAoOadF9Evb8Off1U5EqwljkoMprm5uO-aS_wctndIRoJum30YbvyJIBA5W4TF-EBmL8DRTrY1kHTTsDXaW8wWPLBSrbcgPobzzm8No'
// });
// });
// },
// child: const Text("Send Notification"))
