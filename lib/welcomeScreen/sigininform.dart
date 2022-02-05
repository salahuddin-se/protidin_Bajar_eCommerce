/*import 'dart:convert';

import 'package:customer_ui/all_screen/home_screen.dart';
import 'package:customer_ui/components/apis.dart';
import 'package:customer_ui/customs/input_decorations.dart';
import 'package:customer_ui/customs/toast_component.dart';
import 'package:customer_ui/dataModel/login_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import '../addon_config.dart';
import '../app_config.dart';
import '../my_theme.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<SignInPage> {
  String _login_by = "email"; //phone or email
  String initialCountry = 'US';
  //PhoneNumber phoneCode = PhoneNumber(isoCode: 'US', dialCode: "+1");
  String _phone = "";

  //controllers
  TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    super.initState();
  }

  @override
  void dispose() {
    //before going to other screen show statusbar
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top, SystemUiOverlay.bottom]);
    super.dispose();
  }

  Future<LoginResponse> getLoginResponse(@required String email, @required String password) async {
    var post_body = jsonEncode({"email": "${email}", "password": "$password", "identity_matrix": AppConfig.purchase_code});

    final response = await http.post(Uri.parse(userSignInAPI), headers: {"Content-Type": "application/json"}, body: post_body);
    return loginResponseFromJson(response.body);
  }

  onPressedLogin() async {
    var email = _emailController.text.toString();
    var password = _passwordController.text.toString();

    if (_login_by == 'email' && email == "") {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return CategoryHomeScreen();
      }));
      ToastComponent.showDialog(
        "Enter email",
        context,
      );
      return;
    } else if (_login_by == 'phone' && _phone == "") {
      ToastComponent.showDialog(
        "Enter phone number",
        context,
      );
      return;
    } else if (password == "") {
      ToastComponent.showDialog(
        "Enter password",
        context,
      );
      return;
    }

    var loginResponse = await getLoginResponse(_login_by == 'email' ? email : _phone, password);

    ///var loginResponse = await AuthRepository().getSocialLoginResponse(profile['name'], profile['email'], profile['id'].toString());

    if (loginResponse.result == false) {
      ToastComponent.showDialog(loginResponse.message, context);
    } else {
      ToastComponent.showDialog(

        loginResponse.message,
        context,
      );
      AuthHelper().setUserData(loginResponse);
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return Main();
      }));
    }
  }

  @override
  Widget build(BuildContext context) {
    final _screen_width = MediaQuery.of(context).size.width;
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
                Padding(
                  padding: const EdgeInsets.only(top: 40.0, bottom: 15),
                  child: Container(
                    width: 75,
                    height: 75,
                    child: Image.asset('assets/login_registration_form_logo.png'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: Text(
                    "Login to " + AppConfig.app_name,
                    style: TextStyle(color: MyTheme.accent_color, fontSize: 18, fontWeight: FontWeight.w600),
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
                          _login_by == "email" ? "Email" : "Phone",
                          style: TextStyle(color: MyTheme.accent_color, fontWeight: FontWeight.w600),
                        ),
                      ),
                      if (_login_by == "email")
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Container(
                                height: 36,
                                child: TextField(
                                  controller: _emailController,
                                  autofocus: false,
                                  decoration: InputDecorations.buildInputDecoration_1(hint_text: "johndoe@example.com"),
                                ),
                              ),
                              AddonConfig.otp_addon_installed
                                  ? GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _login_by = "phone";
                                        });
                                      },
                                      child: Text(
                                        "or, Login with a phone number",
                                        style: TextStyle(
                                            color: MyTheme.accent_color, fontStyle: FontStyle.italic, decoration: TextDecoration.underline),
                                      ),
                                    )
                                  : Container()
                            ],
                          ),
                        )
                      else
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              // Container(
                              //   height: 36,
                              //   child: CustomInternationalPhoneNumberInput(
                              //     onInputChanged: (PhoneNumber number) {
                              //       print(number.phoneNumber);
                              //       setState(() {
                              //         _phone = number.phoneNumber;
                              //       });
                              //     },
                              //     onInputValidated: (bool value) {
                              //       print(value);
                              //     },
                              //     selectorConfig: SelectorConfig(
                              //       selectorType: PhoneInputSelectorType.DIALOG,
                              //     ),
                              //     ignoreBlank: false,
                              //     autoValidateMode: AutovalidateMode.disabled,
                              //     selectorTextStyle: TextStyle(color: MyTheme.font_grey),
                              //     textStyle: TextStyle(color: MyTheme.font_grey),
                              //     initialValue: phoneCode,
                              //     textFieldController: _phoneNumberController,
                              //     formatInput: true,
                              //     keyboardType: TextInputType.numberWithOptions(signed: true, decimal: true),
                              //     inputDecoration: InputDecorations.buildInputDecoration_phone(hint_text: "01710 333 558"),
                              //     onSaved: (PhoneNumber number) {
                              //       print('On Saved: $number');
                              //     },
                              //   ),
                              // ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _login_by = "email";
                                  });
                                },
                                child: Text(
                                  "or, Login with an email",
                                  style: TextStyle(
                                      color: MyTheme.accent_color, fontStyle: FontStyle.italic, decoration: TextDecoration.underline),
                                ),
                              )
                            ],
                          ),
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
                            GestureDetector(
                              // onTap: () {
                              //   Navigator.push(context, MaterialPageRoute(builder: (context) {
                              //     return PasswordForget();
                              //   }));
                              // },
                              child: Text(
                                "Forgot Password?",
                                style: TextStyle(
                                    color: MyTheme.accent_color, fontStyle: FontStyle.italic, decoration: TextDecoration.underline),
                              ),
                            )
                          ],
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
                            color: MyTheme.golden,
                            shape: RoundedRectangleBorder(borderRadius: const BorderRadius.all(Radius.circular(12.0))),
                            child: Text(
                              "Log in",
                              style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600),
                            ),
                            onPressed: () {
                              onPressedLogin();
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: Center(
                            child: Text(
                          "or, create a new account ?",
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
                            color: MyTheme.accent_color,
                            shape: RoundedRectangleBorder(borderRadius: const BorderRadius.all(Radius.circular(12.0))),
                            onPressed: () {},
                            child: Text(
                              "Sign up",
                              style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 30.0),
                        child: Center(
                          child: Container(
                            width: 120,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Visibility(
                                  visible: false,
                                  child: InkWell(
                                    onTap: () {
                                      // onPressedTwitterLogin();
                                    },
                                    child: Container(
                                      width: 28,
                                      child: Image.asset("assets/twitter_logo.png"),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
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
}*/

import 'dart:convert';
import 'dart:developer';

import 'package:customer_ui/all_screen/home_screen.dart';
import 'package:customer_ui/components/apis.dart';
import 'package:customer_ui/components/button_widget.dart';
import 'package:customer_ui/components/size_config.dart';
import 'package:customer_ui/components/styles.dart';
import 'package:customer_ui/components/utils.dart';
import 'package:customer_ui/dataModel/login_user_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'signupform.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<SignInPage> {
  var userEmailController = TextEditingController();
  var userPassController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  //User Log in API
  Future userSignIn(email, password) async {
    var jsonBody = (<String, dynamic>{"email": email, "password": password});
    var res =
        await http.post(Uri.parse(userSignInAPI), headers: <String, String>{'Accept': 'application/json; charset=UTF-8'}, body: jsonBody);

    log("Response code ${res.statusCode}");
    log("Response code ${res.body}");

    if (res.statusCode == 200 || res.statusCode == 201) {
      var dataMap = jsonDecode(res.body);
      var userDataModel = LogInUserModel.fromJson(dataMap);
      box.write(userToken, userDataModel.accessToken);
      box.write(userID, userDataModel.user.id);
      box.write(userName, userDataModel.user.name);
      box.write(userEmail, userDataModel.user.email);
      box.write(userAvatar, userDataModel.user.avatar);
      box.write(userPhone, userDataModel.user.phone);
      Navigator.push(context, MaterialPageRoute(builder: (context) => CategoryHomeScreen()));

      ///print(box.read('userName'));
      ///log(userDataModel.user.name);

      setState(() {});
    }

    //log("demo length "+demo.length.toString());
  }

  //Get user via access token
  Future<void> getUser(accessToken) async {
    var jsonBody = (<String, dynamic>{"access_token": accessToken});
    var res =
        await http.post(Uri.parse(userGetAPI), headers: <String, String>{'Accept': 'application/json; charset=UTF-8'}, body: jsonBody);
    log("Response code ${res.statusCode}");

    var dataMap = jsonDecode(res.body);
    print(jsonDecode(res.body));

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
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
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
                  controller: userEmailController,
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return "Email must not be empty";
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
                      hintText: "email or phone"),
                ),
              ),
              sized20,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: TextFormField(
                  autofocus: false,
                  controller: userPassController,
                  validator: (String? value) {
                    if (value!.isEmpty) {
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
                      hintText: "password"),
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
                    if (formKey.currentState == null || formKey.currentState!.validate()) {
                      userSignIn(userEmailController.text, userPassController.text);
                      //Navigator.push(context, MaterialPageRoute(builder: (context) => CategoryHomeScreenRuf()));
                    }
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
                width: MediaQuery.of(context).size.width / 1.2,
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
