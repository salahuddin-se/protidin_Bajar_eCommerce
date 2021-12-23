import 'package:customer_ui/Home_screen/category_home_screen.dart';
import 'package:customer_ui/components/button_widget.dart';
import 'package:customer_ui/components/size_config.dart';
import 'package:customer_ui/components/styles.dart';
import 'package:flutter/material.dart';

import '../homepage.dart';
import 'signupform.dart';
//import 'Language.dart';

class SignInPage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<SignInPage> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var width = SizeConfig.screenWidth;
    var height = SizeConfig.screenHeight;
    var block = SizeConfig.block;
    return Scaffold(
      backgroundColor: Colors.white,
      //backgroundColor: Colors.indigo[50],
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 130,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: SizedBox(
                height: height * 0.06,
                child: Image.asset(
                  "assets/img_20.png",
                  fit: BoxFit.contain,
                ),
              ),
            ),
            SizedBox(
              height: 100,
            ),
            Text(
              "Sign In to Your Account",
              style: TextStyle(color: kBlackColor, fontSize: block * 5.0, fontWeight: FontWeight.w500),
            ),
            sized20,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: TextFormField(
                autofocus: false,
                decoration: InputDecoration(
                    fillColor: Colors.grey[100],
                    filled: true,
                    contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide(color: Colors.white)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide(color: Colors.white)),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide(color: Colors.white)),
                    hintText: "User name or email"),
              ),
            ),
            sized20,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: TextFormField(
                autofocus: false,
                decoration: InputDecoration(
                    fillColor: Colors.grey[100],
                    filled: true,
                    contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide(color: Colors.white)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide(color: Colors.white)),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide(color: Colors.white)),
                    hintText: "Password"),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: ButtonWidget(
                height: height,
                width: width,
                child: Text("Sign in", style: TextStyle(color: Colors.white)),
                callback: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => CategoryHomeScreen()));
                },
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text("Forgot password",
                style: TextStyle(
                    fontSize: block * 4.0,
                    fontWeight: FontWeight.w500,
                    color: kBlackColor,
                    decoration: TextDecoration.underline,
                    decorationColor: kBlackColor,
                    decorationThickness: 1.0)),
            sized20,
            Center(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(60, 10, 10, 10),
                child: SizedBox(
                  width: 300,
                  child: Row(
                    children: [
                      SizedBox(
                        height: 35,
                        width: 75,
                        child: Image.asset("assets/img_22.png"),
                      ),
                      SizedBox(
                        height: 35,
                        width: 75,
                        child: Image.asset("assets/fbook.png"),
                      ),
                      SizedBox(
                        height: 35,
                        width: 75,
                        child: Image.asset("assets/img_23.png"),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 25,
            ),
            SizedBox(
              width:MediaQuery.of(context).size.width/1.2,
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account? ",
                    style: TextStyle(color: kBlackColor, fontSize: block * 4.0, fontWeight: FontWeight.w400),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpPage()));
                    },
                    child: Text(
                      "Sign Up",
                      style: TextStyle(color: kBlackColor, fontSize: block * 5.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  showAlertDialog(BuildContext context) {
    // Create button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // Create AlertDialog
    AlertDialog alert = AlertDialog(
      title: Center(child: Text("Forgot Password")),
      content: Text("We have sent you an url to change your password \n                       to your name@gmail.com"),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
