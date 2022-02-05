import 'dart:developer';

import 'package:flutter/material.dart';

class NewSignUp extends StatefulWidget {
  const NewSignUp({Key? key}) : super(key: key);

  @override
  _NewSignUpState createState() => _NewSignUpState();
}

class _NewSignUpState extends State<NewSignUp> {
  var registerEmail = "email";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              registerEmail == "email"
                  ? GestureDetector(
                      onTap: () {
                        setState(() {
                          registerEmail = "phone";
                          log(registerEmail);
                        });
                      },
                      child: Text(
                        "Use Phone",
                        style: TextStyle(fontSize: 30),
                      ),
                    )
                  : GestureDetector(
                      onTap: () {
                        setState(() {
                          registerEmail = "email";
                          log(registerEmail);
                        });
                      },
                      child: Text(
                        "Use EMail",
                        style: TextStyle(fontSize: 30),
                      ),
                    )
            ],
          ),
        ),
      ),
    );
  }
}

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

import '../app_config.dart';
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
            width: _screen_width * (3 / 4),
            child: Image.asset("assets/splash_login_registration_background_image.png"),
          ),
          Container(
            width: double.infinity,
            child: SingleChildScrollView(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                /*Padding(
                  padding: const EdgeInsets.only(top: 40.0, bottom: 15),
                  child: Container(
                    width: 75,
                    height: 75,
                    child: Image.asset('assets/login_registration_form_logo.png'),
                  ),
                ),*/
                Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: Text(
                    "Join " + AppConfig.app_name,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                ),
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
