// @dart=2.9
import 'dart:async';
import 'package:customer_ui/ruf_home_screen.dart';
import 'package:customer_ui/welcomeScreen/sigininform.dart';
import 'package:customer_ui/welcomeScreen/signupform.dart';
import 'package:customer_ui/welcomeScreen/welcome_page.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'HomePage/final_home_screen.dart';
import 'HomePage/grocer_offer/product_details.dart';
import 'HomePage/grocer_offer/grocery_offer_page.dart';
import 'HomePage/offer/offer_page.dart';
import 'Home_screen/category_home_screen.dart';
import 'Home_screen/category_home_screen_main.dart';
import 'OthersPage/cart_details1st_page.dart';
import 'column_test.dart';
import 'ruf.dart';
import 'test_3.dart';
import 'welcomeScreen/alert_dialog.dart';


void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home:CategoryHomeScreenRuf(),
  ));
}

/*void main() => runApp(
  DevicePreview(
    enabled: !kReleaseMode MaterialApp(
        locale: DevicePreview.locale(context),
        builder: DevicePreview.appBuilder,
        home: CategoryHomeScreenRuf(),
      ), builder: (BuildContext context) {  },
    ), // Wrap your app
  ),
);*/

/*class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: const HomePage(),
    );
  }
}*/

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 3), () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => WelcomePage()))
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          //backgroundColor: Color(0xFFE3FEFF),
          body: SingleChildScrollView(
            child: Center(
              child: Container(
                child: Image.asset(
                  "assets/img_174.png",
                  fit: BoxFit.cover,
                ),
                height:MediaQuery.of(context).size.height/1,
                width: MediaQuery.of(context).size.width/1,
            ),
          )

          )
      );

  }
}
