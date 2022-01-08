import 'dart:async';

import 'package:customer_ui/all_screen/home_screen.dart';
import 'package:customer_ui/components/utils.dart';
import 'package:customer_ui/welcomeScreen/welcome_page.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  await GetStorage.init();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyHomePage(),
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
  const MyHomePage({Key? key}) : super(key: key);

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
            : Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => CategoryHomeScreenRuf())));
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
