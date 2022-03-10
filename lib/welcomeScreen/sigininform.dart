import 'dart:convert';
import 'dart:developer';

import 'package:customer_ui/all_screen/cart_detailspage.dart';
import 'package:customer_ui/all_screen/home_screen.dart';
import 'package:customer_ui/components/apis.dart';
import 'package:customer_ui/components/button_widget.dart';
import 'package:customer_ui/components/size_config.dart';
import 'package:customer_ui/components/styles.dart';
import 'package:customer_ui/components/utils.dart';
import 'package:customer_ui/controller/cartItemsController.dart';
import 'package:customer_ui/dataModel/login_user_model.dart';
import 'package:customer_ui/dataModel/order_product_model.dart';
import 'package:customer_ui/preferences/user_preferance.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:http/http.dart' as http;

import 'signupform.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key, this.isFromCart = false, this.orderList}) : super(key: key);
  final bool isFromCart;
  final orderList;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<SignInPage> {
  var userEmailController = TextEditingController();
  var userPassController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  var controller = Get.put(
    CartItemsController(),
  );

  //User Log in API
  Future userSignIn(email, password) async {
    var jsonBody = (<String, dynamic>{"email": email, "password": password});

    var res =
        await http.post(Uri.parse(userSignInAPI), headers: <String, String>{'Accept': 'application/json; charset=UTF-8'}, body: jsonBody);

    log("Response code ${res.statusCode}");
    log("Response code ${res.body}");

    if (res.statusCode == 200 || res.statusCode == 201) {
      showToast("Login Successfully", context: context);
      var dataMap = jsonDecode(res.body);
      var userDataModel = LogInUserModel.fromJson(dataMap);
      box.write(userToken, userDataModel.accessToken);
      box.write(userID, userDataModel.user.id);
      box.write(userName, userDataModel.user.name);
      box.write(userEmail, userDataModel.user.email);
      log("User AVATAR: ${userDataModel.user.avatarOriginal}");
      box.write(userAvatar, userDataModel.user.avatarOriginal);
      box.write(userPhone, userDataModel.user.phone);
      await UserPreference.setBool(UserPreference.isLoggedIn, true);
      if (widget.isFromCart) {
        if (widget.orderList != null) {
          for (var cartItem in widget.orderList) {
            controller.addToCart(
              OrderItemModel(
                discount: cartItem.discount,
                unit: cartItem.unit,
                discountType: cartItem.discountType,
                price: cartItem.price,
                productThumbnailImage: cartItem.productThumbnailImage,
                productName: cartItem.productName,
                quantity: cartItem.quantity,
                userId: cartItem.userId,
                variant: cartItem.variant,
                productId: cartItem.productId,
              ),
              context,
            );
          }
        }
        Future.delayed(
          Duration(seconds: 3),
          () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CartDetailsPage(),
              ),
            );
          },
        );
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CategoryHomeScreen(),
          ),
        );
      }

      setState(() {});
    }
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
  }

  @override
  void initState() {
    super.initState();
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
                height: 80,
              ),
              Text(
                "Sign In to Your Account",
                style: TextStyle(color: kBlackColor, fontSize: block * 5.0, fontWeight: FontWeight.w500, fontFamily: "ceraProMedium"),
              ),
              SizedBox(
                height: 20,
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
                    hintText: "email or phone",
                  ),
                ),
              ),
              sized20,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: TextFormField(
                  autofocus: false,
                  obscureText: true,
                  enableSuggestions: false,
                  autocorrect: false,
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
                  child: Text("Sign in", style: TextStyle(color: Colors.white, fontSize: 16, fontFamily: "ceraProMedium")),
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
              Text(
                "Forgot password",
                style: TextStyle(
                    fontSize: block * 4.0,
                    fontWeight: FontWeight.w500,
                    color: kBlackColor,
                    decoration: TextDecoration.underline,
                    decorationColor: kBlackColor,
                    decorationThickness: 1.0),
              ),
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
                      "Don't have an account?  ",
                      style: TextStyle(color: kBlackColor, fontSize: block * 4.0, fontWeight: FontWeight.w400),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpPage()));
                      },
                      child: Text(
                        " Sign Up",
                        style: TextStyle(color: kBlackColor, fontSize: 16, fontWeight: FontWeight.bold, fontFamily: "ceraProMedium"),
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

/*
import 'dart:convert';
import 'dart:developer';

import 'package:customer_ui/all_screen/cart_detailspage.dart';
import 'package:customer_ui/all_screen/home_screen.dart';
import 'package:customer_ui/components/apis.dart';
import 'package:customer_ui/components/button_widget.dart';
import 'package:customer_ui/components/size_config.dart';
import 'package:customer_ui/components/styles.dart';
import 'package:customer_ui/components/utils.dart';
import 'package:customer_ui/controller/cartItemsController.dart';
import 'package:customer_ui/dataModel/login_user_model.dart';
import 'package:customer_ui/dataModel/order_product_model.dart';
import 'package:customer_ui/preferences/user_preferance.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:http/http.dart' as http;

import 'signupform.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key, this.isFromCart = false, this.orderList}) : super(key: key);
  final bool isFromCart;
  final orderList;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<SignInPage> {
  var userEmailController = TextEditingController();
  var userPassController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  var controller = Get.put(CartItemsController());

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
      log("User AVATAR: ${userDataModel.user.avatarOriginal}");
      box.write(userAvatar, userDataModel.user.avatarOriginal);
      box.write(userPhone, userDataModel.user.phone);
      await UserPreference.setBool(UserPreference.isLoggedIn, true);
      if (widget.isFromCart) {
        if (widget.orderList != null) {
          for (var cartItem in widget.orderList) {
            controller.addToCart(
              OrderItemModel(
                discount: cartItem.discount,
                discountType: cartItem.discountType,
                price: cartItem.price,
                productThumbnailImage: cartItem.productThumbnailImage,
                productName: cartItem.productName,
                quantity: cartItem.quantity,
                userId: cartItem.userId,
                variant: cartItem.variant,
                productId: cartItem.productId,
              ),
              context,
            );
          }
        }
        Future.delayed(Duration(seconds: 3), () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CartDetails(),
            ),
          );
        });
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CategoryHomeScreen(),
          ),
        );
      }

      setState(() {});
    }

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
  }

  @override
  void initState() {
    super.initState();
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
                  obscureText: true,
                  enableSuggestions: false,
                  autocorrect: false,
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

*/
