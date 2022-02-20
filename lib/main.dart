// @dart=2.9

import 'package:customer_ui/preferences/user_preferance.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import 'all_screen/home_screen.dart';
import 'welcomeScreen/welcome_page.dart';

/*void main() => runApp(

      DevicePreview(
        enabled: !kReleaseMode,
        builder: (context) => MyHomePage(), // Wrap your app
      ),
    );
*/

void main() async {
  await GetStorage.init();
  await UserPreference.setPreference();

  ///runApp(MaterialApp(debugShowCheckedModeBanner: false, home: SearchScreen()));

  runApp(MaterialApp(debugShowCheckedModeBanner: false, home: MyHomePage()));
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    // Timer(Duration(seconds: 3), () {
    // box.remove(userToken);
    if (UserPreference.containsKey(UserPreference.isLoggedIn)) {
      Future.delayed(Duration.zero, () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => CategoryHomeScreen(),
          ),
        );
      });
    } else {
      Future.delayed(Duration.zero, () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => WelcomePage(),
          ),
        );
      });
    }
    // });
    //: Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => RufDrawerWhenLogOut())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Color(0xFFE3FEFF),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            child: Image.asset(
              "assets/sp.png",
              fit: BoxFit.cover,
            ),
            height: MediaQuery.of(context).size.height / 1,
            width: MediaQuery.of(context).size.width / 1,
          ),
        ),
      ),
    );
  }
}

// 15/02 with old
/*
// @dart=2.9

//flutter pub run flutter_launcher_icons:main
//flutter pub run flutter_launcher_name:main
import 'dart:async';

import 'package:customer_ui/welcomeScreen/welcome_page.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import 'all_screen/home_screen.dart';
import 'components/utils.dart';



void main() async {
  await GetStorage.init();

  ///runApp(MaterialApp(debugShowCheckedModeBanner: false, home: SearchScreen()));

  runApp(MaterialApp(debugShowCheckedModeBanner: false, home: MyHomePage()));
}



class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 3),
        () => box.read(userToken) == null
            ? Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => WelcomePage()))
            : Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => CategoryHomeScreen())));
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
        height: MediaQuery.of(context).size.height / 1,
        width: MediaQuery.of(context).size.width / 1,
      ),
    )));
  }
}

*/
