import 'dart:convert';
import 'dart:developer';

import 'package:customer_ui/components/apis.dart';
import 'package:customer_ui/components/size_config.dart';
import 'package:customer_ui/dataModel/signup_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:http/http.dart' as http;

import '../my_theme.dart';
import 'sigininform.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key, this.isFromCart = false}) : super(key: key);
  final bool isFromCart;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<SignUpPage> {
  String _register_by = "email"; //phone or email
  String initialCountry = 'US';

  ///PhoneNumber phoneCode = PhoneNumber(isoCode: 'US', dialCode: "+1");

  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _passwordConfirmController = TextEditingController();

  @override
  void initState() {
    // on Splash Screen hide statusBar
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    super.initState();
  }

  @override
  void dispose() {
    //before going to other screen show statusbar
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top, SystemUiOverlay.bottom]);
    super.dispose();
  }

  Future<SignupResponse> getSignupResponse(@required String name, @required String emailOrPhone, @required String password,
      @required String passowrdConfirmation, @required String registerBy) async {
    var postBody = jsonEncode({
      "name": "$name",
      "email_or_phone": "${emailOrPhone}",
      "password": "$password",
      "password_confirmation": "${passowrdConfirmation}",
      "register_by": "$registerBy"
    });

    final response = await http.post(Uri.parse(userSignupAPI), headers: {"Content-Type": "application/json"}, body: postBody);

    log(response.body);

    //
    if (response.statusCode == 200 || response.statusCode == 201) {
      var dataMap = jsonDecode(response.body);

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SignInPage(
            isFromCart: widget.isFromCart,
          ),
        ),
      );

      showToast(dataMap["message"], context: context);
      //Navigator.push(context, MaterialPageRoute(builder: (context) => CategoryHomeScreen()));

      ///print(box.read('userName'));
      ///log(userDataModel.user.name);

      setState(() {});
    }
    //

    return signupResponseFromJson(response.body.toString());
  }

  bool isEmail = true;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var width = SizeConfig.screenWidth;
    var height = SizeConfig.screenHeight;
    var block = SizeConfig.block;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        //width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: SizedBox(
                    height: height * 0.06,
                    child: Image.asset(
                      "assets/img_20.png",
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 45,
              ),
              Align(
                alignment: Alignment.center,
                child: Text(
                  "Create Your Account",
                  style: TextStyle(color: Color(0xFF515151), fontSize: 18, fontWeight: FontWeight.w700),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 4.0),
                child: Text(
                  "Name",
                  style: TextStyle(fontWeight: FontWeight.w600, color: Color(0xFF515151), fontFamily: "ceraProMedium", fontSize: 14),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Container(
                  height: 47,
                  child: TextField(
                    controller: _nameController,
                    autofocus: false,

                    ///decoration: InputDecorations.buildInputDecoration_1(hint_text: "John Doe"),
                    //
                    decoration: InputDecoration(
                        fillColor: Colors.grey[100],
                        filled: true,
                        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                        enabledBorder:
                            OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide(color: Colors.white)),
                        focusedBorder:
                            OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide(color: Colors.white)),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide(color: Colors.white)),
                        hintText: ""),
                    //
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 4.0),
                child: isEmail == true
                    ? Text(
                        "Email",
                        style: TextStyle(fontWeight: FontWeight.w600, color: Color(0xFF515151), fontFamily: "ceraProMedium", fontSize: 14),
                      )
                    : Text(
                        "Phone",
                        style: TextStyle(fontWeight: FontWeight.w600, color: Color(0xFF515151), fontFamily: "ceraProMedium", fontSize: 14),
                      ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Container(
                  height: 47,
                  child: TextField(
                    controller: _emailController,
                    autofocus: false,
                    decoration: InputDecoration(
                        fillColor: Colors.grey[100],
                        filled: true,
                        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                        enabledBorder:
                            OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide(color: Colors.white)),
                        focusedBorder:
                            OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide(color: Colors.white)),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide(color: Colors.white)),
                        hintText: ""),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              isEmail == true
                  ? GestureDetector(
                      onTap: () {
                        setState(() {
                          isEmail = false;
                          _register_by = "phone";
                        });
                      },
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          width: MediaQuery.of(context).size.width / 4,
                          height: 20,
                          decoration: BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                color: Color(0xFF9900FF),
                              )),
                          child: Center(
                            child: Text(
                              "Use Phone",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, color: Color(0xFF515151), fontFamily: "ceraProMedium", fontSize: 14),
                            ),
                          ),
                        ),
                      ))
                  : GestureDetector(
                      onTap: () {
                        setState(() {
                          isEmail = true;
                          _register_by = "email";
                        });
                      },
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          width: MediaQuery.of(context).size.width / 4,
                          height: 20,
                          decoration: BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                color: Color(0xFF9900FF),
                              )),
                          child: Center(
                            child: Text(
                              "Use Email",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, color: Color(0xFF515151), fontFamily: "ceraProMedium", fontSize: 14),
                            ),
                          ),
                        ),
                      ),
                    ),
              SizedBox(
                height: 0,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 4.0),
                child: Text(
                  "Password",
                  style: TextStyle(fontWeight: FontWeight.w600, color: Color(0xFF515151), fontFamily: "ceraProMedium", fontSize: 14),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      height: 47,
                      child: TextField(
                        controller: _passwordController,
                        autofocus: false,
                        obscureText: true,
                        enableSuggestions: false,
                        autocorrect: false,
                        decoration: InputDecoration(
                            fillColor: Colors.grey[100],
                            filled: true,
                            contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                            enabledBorder:
                                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide(color: Colors.white)),
                            focusedBorder:
                                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide(color: Colors.white)),
                            border:
                                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide(color: Colors.white)),
                            hintText: ""),
                      ),
                    ),
                    Text(
                      "Password must be at least 6 character",
                      style: TextStyle(color: MyTheme.textfield_grey, fontStyle: FontStyle.italic),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 4.0),
                child: Text(
                  "Retype Password",
                  style: TextStyle(fontWeight: FontWeight.w600, color: Color(0xFF515151), fontFamily: "ceraProMedium", fontSize: 14),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Container(
                  height: 47,
                  child: TextField(
                    controller: _passwordConfirmController,
                    autofocus: false,
                    obscureText: true,
                    enableSuggestions: false,
                    autocorrect: false,
                    decoration: InputDecoration(
                        fillColor: Colors.grey[100],
                        filled: true,
                        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                        enabledBorder:
                            OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide(color: Colors.white)),
                        focusedBorder:
                            OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide(color: Colors.white)),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide(color: Colors.white)),
                        hintText: ""),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: Container(
                  height: 47,
                  decoration: BoxDecoration(
                      border: Border.all(color: MyTheme.textfield_grey, width: 1), borderRadius: BorderRadius.all(Radius.circular(30.0))),
                  child: FlatButton(
                    minWidth: MediaQuery.of(context).size.width,
                    //height: 50,
                    color: MyTheme.accent_color,
                    shape: RoundedRectangleBorder(borderRadius: const BorderRadius.all(Radius.circular(30.0))),
                    child: Text(
                      "Sign Up",
                      style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600, fontFamily: "ceraProMedium"),
                    ),
                    onPressed: () {
                      //onPressSignUp();
                      getSignupResponse(_nameController.text, _emailController.text, _passwordController.text,
                          _passwordConfirmController.text, _register_by);

                      /*
                      if (formKey.currentState == null || formKey.currentState!.validate()) {
                      userSignUp(userNameController.text, userEmailOrPhoneController.text, userPasswordController.text);

                      Navigator.push(context, MaterialPageRoute(builder: (context) => SignInPage()));
                    }
                       */
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PhoneNumber {}

/*
import 'dart:convert';
import 'dart:developer';

import 'package:customer_ui/components/apis.dart';
import 'package:customer_ui/components/size_config.dart';
import 'package:customer_ui/customs/input_decorations.dart';
import 'package:customer_ui/dataModel/signup_model.dart';
import 'package:customer_ui/welcomeScreen/sigininform.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import '../my_theme.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<SignUpPage> {
  String _register_by = "email"; //phone or email
  String initialCountry = 'US';

  ///PhoneNumber phoneCode = PhoneNumber(isoCode: 'US', dialCode: "+1");

  String _phone = "";

  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _passwordConfirmController = TextEditingController();

  @override
  void initState() {
    // on Splash Screen hide statusBar
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    super.initState();
  }

  @override
  void dispose() {
    //before going to other screen show statusbar
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top, SystemUiOverlay.bottom]);
    super.dispose();
  }

  Future<SignupResponse> getSignupResponse(@required String name, @required String email_or_phone, @required String password,
      @required String passowrd_confirmation, @required String register_by) async {
    var post_body = jsonEncode({
      "name": "$name",
      "email_or_phone": "${email_or_phone}",
      "password": "$password",
      "password_confirmation": "${passowrd_confirmation}",
      "register_by": "$register_by"
    });

    final response = await http.post(Uri.parse(userSignupAPI), headers: {"Content-Type": "application/json"}, body: post_body);

    log(response.body);

    return signupResponseFromJson(response.body.toString());
  }

  bool isEmail = true;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final _screen_width = MediaQuery.of(context).size.width;
    var width = SizeConfig.screenWidth;
    var height = SizeConfig.screenHeight;
    var block = SizeConfig.block;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            child: SingleChildScrollView(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: _screen_width * (3 / 4),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 4.0),
                        child: Text(
                          "Name",
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Container(
                          height: 36,
                          child: TextField(
                            controller: _nameController,
                            autofocus: false,
                            decoration: InputDecorations.buildInputDecoration_1(hint_text: "John Doe"),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 4.0),
                        child: isEmail == true
                            ? Text(
                                "Email",
                                style: TextStyle(fontWeight: FontWeight.w600),
                              )
                            : Text(
                                "Phone",
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Container(
                          height: 36,
                          child: TextField(
                            controller: _emailController,
                            autofocus: false,
                            decoration: InputDecorations.buildInputDecoration_1(hint_text: "John Doe"),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      isEmail == true
                          ? GestureDetector(
                              onTap: () {
                                setState(() {
                                  isEmail = false;
                                  _register_by = "phone";
                                });
                              },
                              child: Text("Use Phone"))
                          : GestureDetector(
                              onTap: () {
                                setState(() {
                                  isEmail = true;
                                  _register_by = "email";
                                });
                              },
                              child: Text("Use Email")),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 4.0),
                        child: Text(
                          "Password",
                          style: TextStyle(color: MyTheme.accent_color, fontWeight: FontWeight.w600),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              height: 36,
                              child: TextField(
                                controller: _passwordController,
                                autofocus: false,
                                obscureText: true,
                                enableSuggestions: false,
                                autocorrect: false,
                                decoration: InputDecorations.buildInputDecoration_1(hint_text: "• • • • • • • •"),
                              ),
                            ),
                            Text(
                              "Password must be at least 6 character",
                              style: TextStyle(color: MyTheme.textfield_grey, fontStyle: FontStyle.italic),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 4.0),
                        child: Text(
                          "Retype Password",
                          style: TextStyle(color: MyTheme.accent_color, fontWeight: FontWeight.w600),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Container(
                          height: 36,
                          child: TextField(
                            controller: _passwordConfirmController,
                            autofocus: false,
                            obscureText: true,
                            enableSuggestions: false,
                            autocorrect: false,
                            decoration: InputDecorations.buildInputDecoration_1(hint_text: "• • • • • • • •"),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 30.0),
                        child: Container(
                          height: 45,
                          decoration: BoxDecoration(
                              border: Border.all(color: MyTheme.textfield_grey, width: 1),
                              borderRadius: const BorderRadius.all(Radius.circular(12.0))),
                          child: FlatButton(
                            minWidth: MediaQuery.of(context).size.width,
                            //height: 50,
                            color: MyTheme.accent_color,
                            shape: RoundedRectangleBorder(borderRadius: const BorderRadius.all(Radius.circular(12.0))),
                            child: Text(
                              "Sign Up",
                              style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600),
                            ),
                            onPressed: () {
                              // onPressSignUp();
                              getSignupResponse(_nameController.text, _emailController.text, _passwordController.text,
                                  _passwordConfirmController.text, _register_by);
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: Center(
                            child: Text(
                          "Already have an Account ?",
                          style: TextStyle(color: MyTheme.medium_grey, fontSize: 12),
                        )),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 4.0),
                        child: Container(
                          height: 45,
                          decoration: BoxDecoration(
                              border: Border.all(color: MyTheme.textfield_grey, width: 1),
                              borderRadius: const BorderRadius.all(Radius.circular(12.0))),
                          child: FlatButton(
                            minWidth: MediaQuery.of(context).size.width,
                            //height: 50,
                            color: MyTheme.golden,
                            shape: RoundedRectangleBorder(borderRadius: const BorderRadius.all(Radius.circular(12.0))),
                            child: Text(
                              "Log in",
                              style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600),
                            ),
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) {
                                return SignInPage();
                              }));
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            )),
          )
        ],
      ),
    );
  }
}

class PhoneNumber {}



*/
