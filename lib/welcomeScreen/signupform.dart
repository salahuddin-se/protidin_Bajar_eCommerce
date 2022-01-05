import 'dart:convert';
import 'dart:developer';

import 'package:customer_ui/components/apis.dart';
import 'package:customer_ui/components/button_widget.dart';
import 'package:customer_ui/components/size_config.dart';
import 'package:customer_ui/components/styles.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
//import 'Language.dart';

class SignUpPage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<SignUpPage> {
  var userNameController = TextEditingController();
  var userEmailOrPhoneController = TextEditingController();
  var userPasswordController = TextEditingController();

  var formKey=GlobalKey<FormState>();

  //User registration API
  Future<void> userSignUp(name, emailOrPhone, password) async {
    var jsonBody =
        (<String, dynamic>{"name": name, "email_or_phone": emailOrPhone, "password": password, "password_confirmation": password});
    debugPrint(jsonBody.toString());

    var res = await http.post(Uri.parse(userSignupAPI),
        headers: <String, String>{'Accept': 'application/json'}, body: jsonBody);
    log("Response ${res.body}");
    log("Response code ${res.statusCode}");

    var dataMap = jsonDecode(res.body);

    setState(() {});
    //log("demo length "+demo.length.toString());
  }

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
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 130,
              ),
              SizedBox(
                height: height * 0.06,
                child: Image.asset(
                  "assets/img_20.png",
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(
                height: 100,
              ),
              Center(
                child: Text(
                  "Create New Account",
                  style: TextStyle(color: kBlackColor, fontSize: block * 5.0, fontWeight: FontWeight.w500),
                ),
              ),
              sized20,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: TextFormField(
                  autofocus: false,
                  controller: userNameController,
                  validator: (String? value){
                    if(value!.isEmpty){
                      return "Name must not be empty";
                    }
                  },
                  decoration: InputDecoration(
                      fillColor: Colors.grey[100],
                      filled: true,
                      contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                      enabledBorder:
                          OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide(color: Colors.white)),
                      focusedBorder:
                          OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide(color: Colors.white)),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide(color: Colors.white)),
                      hintText: "User name"),
                ),
              ),
              sized20,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: TextFormField(
                  autofocus: false,
                  controller: userEmailOrPhoneController,
                  validator: (String? value){
                    if(value!.isEmpty){
                      return "Email or phone number must not be empty";
                    }
                  },
                  decoration: InputDecoration(
                      fillColor: Colors.grey[100],
                      filled: true,
                      contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                      enabledBorder:
                          OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide(color: Colors.white)),
                      focusedBorder:
                          OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide(color: Colors.white)),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide(color: Colors.white)),
                      hintText: "Email or Phone"),
                ),
              ),
              sized20,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: TextFormField(
                  autofocus: false,
                  controller: userPasswordController,
                  validator: (String? value){
                    if(value!.isEmpty){
                      return "Password must not be empty";
                    }
                  },
                  decoration: InputDecoration(
                      fillColor: Colors.grey[100],
                      filled: true,
                      contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                      enabledBorder:
                          OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide(color: Colors.white)),
                      focusedBorder:
                          OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide(color: Colors.white)),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide(color: Colors.white)),
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
                  child: Text("Sign Up", style: TextStyle(color: Colors.white)),
                  callback: () {

                    if (formKey.currentState == null || formKey.currentState!.validate()){
                      userSignUp(userNameController.text, userEmailOrPhoneController.text, userPasswordController.text);
                    }
                    // Navigator.push(context, MaterialPageRoute(builder: (context) => CategoryHomeScreen()));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
