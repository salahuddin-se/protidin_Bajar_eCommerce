// import 'dart:async';
//
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// void main() {
//   runApp(MyStatelessApp());
// }
//
// class MyStatelessApp extends StatelessWidget {
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Stateless Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: StatelessWidgetDemo(),
//     );
//   }
// }
//
// class StatelessWidgetDemo extends StatelessWidget {
//   final keyIsFirstLoaded = 'is_first_loaded';
//
//   @override
//   Widget build(BuildContext context) {
//     Future.delayed(Duration.zero, () => showDialogIfFirstLoaded(context));
//     return SafeArea(
//         child: Scaffold(
//             appBar: AppBar(
//               title: Text('Flutter Stateless Demo'),
//             ),
//             body: Center(
//               child: Text('Hello'),
//             )));
//   }
//
//   showDialogIfFirstLoaded(BuildContext context) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     bool isFirstLoaded = prefs.getBool(keyIsFirstLoaded);
//     if (isFirstLoaded == null) {
//       showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           // return object of type Dialog
//           return AlertDialog(
//             title: Text("Title"),
//             content: Text("This is one time dialog"),
//             actions: <Widget>[
//               // usually buttons at the bottom of the dialog
//               TextButton(
//                 child: Text("Dismiss"),
//                 onPressed: () {
//                   // Close the dialog
//                   Navigator.of(context).pop();
//                   prefs.setBool(keyIsFirstLoaded, false);
//                 },
//               ),
//             ],
//           );
//         },
//       );
//     }
//   }
// }
