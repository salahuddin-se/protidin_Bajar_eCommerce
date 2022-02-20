/// new account
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:customer_ui/components/apis.dart';
import 'package:customer_ui/components/styles.dart';
import 'package:customer_ui/components/utils.dart';
import 'package:customer_ui/helpers/helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';

class MyAccountPage extends StatefulWidget {
  const MyAccountPage({Key? key}) : super(key: key);
  @override
  _MyAccountPageState createState() => _MyAccountPageState();
}

class _MyAccountPageState extends State<MyAccountPage> {
  final _picker = ImagePicker();
  File? _selectedFile;
  double? _percent;
  bool _completed = false;
  Future<void> updateAccount({required String name, required String password}) async {
    var jsonBody = (<String, dynamic>{"id": box.read(userID).toString(), "name": name, "password": password});

    log("check name $name");
    var res = await post(Uri.parse("http://test.protidin.com.bd:88/api/v2/profile/update"),
        headers: <String, String>{'Accept': 'application/json', 'Authorization': 'Bearer ${box.read(userToken)}'}, body: jsonBody);

    log("update address ${res.body}");
    if (res.statusCode == 200 || res.statusCode == 201) {
      var dataMap = jsonDecode(res.body);
      box.write(userName, name);
    } else {
      showToast("Something went wrong", context: context);
    }
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
  }

  _selectSource() {
    showDialog(
        context: context,
        builder: (ctx) {
          return Dialog(
            child: Container(
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  InkWell(
                    onTap: () {
                      _uploadImage(ImageSource.camera);
                      Navigator.of(context).pop();
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Text('Camera'),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      _uploadImage(ImageSource.gallery);
                      Navigator.of(context).pop();
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Text('Gallery'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  _uploadImage(ImageSource imageSource) async {
    try {
      final pickedFile = await _picker.pickImage(source: imageSource);

      if (pickedFile == null) return;
      if (!mounted) return;
      setState(() {
        _selectedFile = File(pickedFile.path);
      });
      if (_selectedFile != null) {
        final response = await Helper.uploadImage(_selectedFile!, (percent) {
          setState(() {
            _percent = percent;
          });
        });

        if (response.statusCode == 200 || response.statusCode == 201) {
          setState(() {
            _completed = true;
          });
        }
      }
    } catch (err) {
      print(err.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    print("MYACC AVATAR ${baseUrl + box.read(userAvatar).toString()}");
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: kWhiteColor,
          centerTitle: true,
          title: Text(
            "My account",
            style: TextStyle(color: kBlackColor, fontSize: 14),
          ),
          iconTheme: IconThemeData(color: kBlackColor),
          actions: const [
            Center(
              child: Icon(
                Icons.menu,
                color: kBlackColor,
              ),
            ),
            SizedBox(
              width: 10,
            )
          ],
        ),
        //backgroundColor: Colors.white,
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            child: Column(children: [
          SizedBox(
            height: 25,
          ),
          Center(
            child: Stack(
              children: [
                _selectedFile != null
                    ? Container(
                        //color: Colors.white,
                        height: 120,
                        width: 120,

                        decoration: _selectedFile != null
                            ? BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: FileImage(_selectedFile!),
                                ),
                              )
                            : BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(box.read(userAvatar) != null ? imagePath + box.read(userAvatar) : ""),
                                ),
                              ),
                      )
                    : Container(
                        //color: Colors.white,
                        height: 120,
                        width: 120,
                        child: Image.asset(
                          "assets/img_141.png",
                        ),
                      ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: InkWell(
                    onTap: () => _selectSource(),
                    child: CircleAvatar(
                      radius: 18,
                      child: Icon(Icons.camera_alt),
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Center(
            child: Container(
              height: 37,
              width: 150,
              child: Center(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    ///box.write(userName, userDataModel.user.name);///datacount.read('count')
                    box.read(userName),
                    style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16, color: Colors.black),
                  ),
                  GestureDetector(
                    onTap: () {
                      TextEditingController _nameController = TextEditingController(text: box.read(userName));
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Column(
                              children: <Widget>[
                                TextFormField(
                                  controller: _nameController,
                                  decoration: const InputDecoration(
                                      //icon: Icon(Icons.ac_unit),
                                      ),
                                  maxLength: 20,
                                  textAlign: TextAlign.center,
                                  onChanged: (val) {},
                                  validator: (value) {
                                    return null;
                                  },
                                ),
                              ],
                            ),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  if (_nameController.text != box.read(userName)) {
                                    updateAccount(name: _nameController.text, password: '123456').then((value) => Navigator.pop(context));
                                  }
                                  Navigator.pop(context);
                                },
                                child: Text("Save"),
                              ),
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text('Cancel')),
                            ],
                          );
                        },
                      );
                    },
                    child: Container(
                      //color: Colors.white,
                      height: 15,
                      width: 15,
                      child: Image.asset(
                        "assets/img_143.png",
                      ),
                    ),
                  ),
                ],
              )),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            width: MediaQuery.of(context).size.width / 1,
            height: MediaQuery.of(context).size.height / 1.6,
            decoration: BoxDecoration(
              color: Colors.grey[50],
              //borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Align(
                    alignment: Alignment.center,
                    child: Container(
                      //width:MediaQuery.of(context).size.width/6,
                      child: Row(
                        //mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            //color: Colors.white,
                            height: 15,
                            width: MediaQuery.of(context).size.width / 7,
                            child: Image.asset(
                              "assets/img_144.png",
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 30, 0),
                          ),

                          Container(
                            width: MediaQuery.of(context).size.width / 2,
                            child: Column(
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "My Address",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                                box.read(account_userAddress) == null
                                    ? Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          //box.read(account_userAddress) ?? "No address",
                                          "No address",
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      )
                                    : Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          //box.read(account_userAddress) ?? "No address",
                                          box.read(account_userAddress),
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                              ],
                            ),
                          ),

                          //Padding(padding: const EdgeInsets.fromLTRB(0,0,50,0),),

                          Container(
                            //color: Colors.white,
                            height: 15,
                            width: MediaQuery.of(context).size.width / 7,
                            child: Image.asset(
                              "assets/img_145.png",
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Align(
                    alignment: Alignment.center,
                    child: Container(
                      child: Row(
                        //mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            //color: Colors.white,
                            height: 15,
                            width: MediaQuery.of(context).size.width / 7,
                            child: Image.asset(
                              "assets/img_146.png",
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 30, 0),
                          ),

                          Container(
                            width: MediaQuery.of(context).size.width / 2,
                            child: Column(
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Email",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    /// "${box.read(userPhone)}",
                                    box.read(userPhone) ?? box.read(userEmail),

                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          //Padding(padding: const EdgeInsets.fromLTRB(0,0,50,0),),

                          Container(
                            //color: Colors.white,
                            height: 15,
                            width: MediaQuery.of(context).size.width / 7,
                            child: Image.asset(
                              "assets/img_145.png",
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Align(
                    alignment: Alignment.center,
                    child: Container(
                      child: Row(
                        //mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            //color: Colors.white,
                            height: 15,
                            width: MediaQuery.of(context).size.width / 7,
                            child: Image.asset(
                              "assets/img_148.png",
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 30, 0),
                          ),

                          Container(
                            width: MediaQuery.of(context).size.width / 2,
                            child: Column(
                              children: const [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Change Password",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "......",
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          //Padding(padding: const EdgeInsets.fromLTRB(0,0,50,0),),

                          Container(
                            //color: Colors.white,
                            height: 15,
                            width: MediaQuery.of(context).size.width / 7,
                            child: Image.asset(
                              "assets/img_145.png",
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
              ],
            ),
          )
        ])));
  }
}

/*
/// new account
import 'dart:convert';
import 'dart:developer';
import 'package:customer_ui/components/styles.dart';
import 'package:customer_ui/components/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:http/http.dart';

class MyAccountPage extends StatefulWidget {
  const MyAccountPage({Key? key}) : super(key: key);
  @override
  _MyAccountPageState createState() => _MyAccountPageState();
}

class _MyAccountPageState extends State<MyAccountPage> {
  Future<void> updateAccount({required String name, required String password}) async {
    var jsonBody = (<String, dynamic>{"id": box.read(userID).toString(), "name": name, "password": password});

    var res = await post(Uri.parse("https://test.protidin.com.bd/api/v2/profile/update"),
        headers: <String, String>{'Accept': 'application/json', 'Authorization': 'Bearer ${box.read(userToken)}'}, body: jsonBody);

    log("update address ${res.body}");

    if (res.statusCode == 200 || res.statusCode == 201) {
      var dataMap = jsonDecode(res.body);
    } else {
      showToast("Something went wrong", context: context);
    }
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: kWhiteColor,
          centerTitle: true,
          title: Text(
            "My account",
            style: TextStyle(color: kBlackColor, fontSize: 14),
          ),
          iconTheme: IconThemeData(color: kBlackColor),
          actions: const [
            Center(
              child: Icon(
                Icons.menu,
                color: kBlackColor,
              ),
            ),
            SizedBox(
              width: 10,
            )
          ],
        ),
        //backgroundColor: Colors.white,
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            child: Column(children: [
          SizedBox(
            height: 25,
          ),
          Center(
            child: Container(
              //color: Colors.white,
              height: 120,
              width: 120,

              child: Image.asset(
                "assets/img_142.png",
              ),

              /*child: Image.network(
                box.read(imagePath + 'userAvatar'),
              ),*/

              /*child: Image.asset(
                "assets/img_142.png",
              ),*/
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Center(
            child: Container(
              height: 37,
              width: 150,
              child: Center(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    ///box.write(userName, userDataModel.user.name);///datacount.read('count')
                    box.read(userName),
                    style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16, color: Colors.black),
                  ),
                  GestureDetector(
                    onTap: () {
                      TextEditingController _nameController = TextEditingController(text: box.read(userName));
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Column(
                                children: <Widget>[
                                  TextFormField(
                                    controller: _nameController,
                                    decoration: const InputDecoration(
                                        //icon: Icon(Icons.ac_unit),
                                        ),
                                    maxLength: 20,
                                    textAlign: TextAlign.center,
                                    onChanged: (val) {},
                                    validator: (value) {
                                      return null;
                                    },
                                  )
                                ],
                              ),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    if (_nameController.text != box.read(userName)) {
                                      updateAccount(name: _nameController.text, password: '123456').then((value) => Navigator.pop(context));
                                    }
                                    Navigator.pop(context);
                                  },
                                  child: Text("Save"),
                                ),
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text('Cancel')),
                              ],
                            );
                          });
                    },
                    child: Container(
                      //color: Colors.white,
                      height: 15,
                      width: 15,
                      child: Image.asset(
                        "assets/img_143.png",
                      ),
                    ),
                  ),
                ],
              )),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            width: MediaQuery.of(context).size.width / 1,
            height: MediaQuery.of(context).size.height / 1.6,
            decoration: BoxDecoration(
              color: Colors.grey[50],
              //borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Align(
                    alignment: Alignment.center,
                    child: Container(
                      //width:MediaQuery.of(context).size.width/6,
                      child: Row(
                        //mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            //color: Colors.white,
                            height: 15,
                            width: MediaQuery.of(context).size.width / 7,
                            child: Image.asset(
                              "assets/img_144.png",
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 30, 0),
                          ),

                          Container(
                            width: MediaQuery.of(context).size.width / 2,
                            child: Column(
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "My Address",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    box.read(account_userAddress) ?? "No address",
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          //Padding(padding: const EdgeInsets.fromLTRB(0,0,50,0),),

                          Container(
                            //color: Colors.white,
                            height: 15,
                            width: MediaQuery.of(context).size.width / 7,
                            child: Image.asset(
                              "assets/img_145.png",
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Align(
                    alignment: Alignment.center,
                    child: Container(
                      child: Row(
                        //mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            //color: Colors.white,
                            height: 15,
                            width: MediaQuery.of(context).size.width / 7,
                            child: Image.asset(
                              "assets/img_146.png",
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 30, 0),
                          ),

                          Container(
                            width: MediaQuery.of(context).size.width / 2,
                            child: Column(
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Email",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    /// "${box.read(userPhone)}",
                                    box.read(userPhone) ?? box.read(userEmail),

                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          //Padding(padding: const EdgeInsets.fromLTRB(0,0,50,0),),

                          Container(
                            //color: Colors.white,
                            height: 15,
                            width: MediaQuery.of(context).size.width / 7,
                            child: Image.asset(
                              "assets/img_145.png",
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Align(
                    alignment: Alignment.center,
                    child: Container(
                      child: Row(
                        //mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            //color: Colors.white,
                            height: 15,
                            width: MediaQuery.of(context).size.width / 7,
                            child: Image.asset(
                              "assets/img_148.png",
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 30, 0),
                          ),

                          Container(
                            width: MediaQuery.of(context).size.width / 2,
                            child: Column(
                              children: const [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Change Password",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "......",
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          //Padding(padding: const EdgeInsets.fromLTRB(0,0,50,0),),

                          Container(
                            //color: Colors.white,
                            height: 15,
                            width: MediaQuery.of(context).size.width / 7,
                            child: Image.asset(
                              "assets/img_145.png",
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
              ],
            ),
          )
        ])));
  }
}
*/

/*
import 'package:customer_ui/components/styles.dart';
import 'package:customer_ui/components/utils.dart';
import 'package:flutter/material.dart';

class MyAccountPage extends StatefulWidget {
  const MyAccountPage({Key? key}) : super(key: key);
  @override
  _MyAccountPageState createState() => _MyAccountPageState();
}

class _MyAccountPageState extends State<MyAccountPage> {


  // Future<void> updateAddressInCart(userId) async {
  //   var jsonBody = (<String, dynamic>{"user_id": userId.toString(), "address_id": userId.toString()});
  //
  //   var res = await post(Uri.parse("https://test.protidin.com.bd/api/v2/update-address-in-cart"),
  //       headers: <String, String>{'Accept': 'application/json', 'Authorization': 'Bearer ${box.read(userToken)}'}, body: jsonBody);
  //
  //   log("update cart ${res.body}");
  //
  //   if (res.statusCode == 200 || res.statusCode == 201) {
  //     var dataMap = jsonDecode(res.body);
  //   } else {
  //     showToast("Something went wrong", context: context);
  //   }
  //   setState(() {});
  // }
  //
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   log("------USER TOKEN IS------ :${box.read(userToken)}");
  //   //Clipboard.setData(ClipboardData(text: box.read(userToken)));
  //   controller.getCartName();
  //
  //   UserPreference.setPreference().then((value) {
  //     if (!UserPreference.containsKey(UserPreference.showAreaDialogue)) {
  //       getCityName(true);
  //     } else {
  //       getCityName(false).then((value) {
  //         setState(() {
  //           selectAreaName = UserPreference.getString(UserPreference.selectedArea) ?? "";
  //         });
  //       });
  //     }
  //   });
  //
  //   getCategory();
  //   getSliderSearch();
  //   getOneTo99Data();
  // }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: kWhiteColor,
          centerTitle: true,
          title: Text(
            "My account",
            style: TextStyle(color: kBlackColor, fontSize: 14),
          ),
          iconTheme: IconThemeData(color: kBlackColor),
          actions: const [
            Center(
              child: Icon(
                Icons.menu,
                color: kBlackColor,
              ),
            ),
            SizedBox(
              width: 10,
            )
          ],
        ),
        //backgroundColor: Colors.white,
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            child: Column(children: [
          SizedBox(
            height: 25,
          ),
          Center(
            child: Container(
              //color: Colors.white,
              height: 120,
              width: 120,

              child: Image.asset(
                "assets/img_142.png",
              ),

              /*child: Image.network(
                box.read(imagePath + 'userAvatar'),
              ),*/

              /*child: Image.asset(
                "assets/img_142.png",
              ),*/
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Center(
            child: Container(
              height: 37,
              width: 150,
              child: Center(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    ///box.write(userName, userDataModel.user.name);///datacount.read('count')
                    box.read(userName),
                    style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16, color: Colors.black),
                  ),
                  Container(
                    //color: Colors.white,
                    height: 15,
                    width: 15,
                    child: Image.asset(
                      "assets/img_143.png",
                    ),
                  ),
                ],
              )),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            width: MediaQuery.of(context).size.width / 1,
            height: MediaQuery.of(context).size.height / 1.6,
            decoration: BoxDecoration(
              color: Colors.grey[50],
              //borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Align(
                    alignment: Alignment.center,
                    child: Container(
                      //width:MediaQuery.of(context).size.width/6,
                      child: Row(
                        //mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            //color: Colors.white,
                            height: 15,
                            width: MediaQuery.of(context).size.width / 7,
                            child: Image.asset(
                              "assets/img_144.png",
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 30, 0),
                          ),

                          Container(
                            width: MediaQuery.of(context).size.width / 2,
                            child: Column(
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "My Address",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    box.read(account_userAddress) ?? "No address",
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          //Padding(padding: const EdgeInsets.fromLTRB(0,0,50,0),),

                          Container(
                            //color: Colors.white,
                            height: 15,
                            width: MediaQuery.of(context).size.width / 7,
                            child: Image.asset(
                              "assets/img_145.png",
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Align(
                    alignment: Alignment.center,
                    child: Container(
                      child: Row(
                        //mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            //color: Colors.white,
                            height: 15,
                            width: MediaQuery.of(context).size.width / 7,
                            child: Image.asset(
                              "assets/img_146.png",
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 30, 0),
                          ),

                          Container(
                            width: MediaQuery.of(context).size.width / 2,
                            child: Column(
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Email",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    /// "${box.read(userPhone)}",
                                    box.read(userPhone) ?? box.read(userEmail),

                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          //Padding(padding: const EdgeInsets.fromLTRB(0,0,50,0),),

                          Container(
                            //color: Colors.white,
                            height: 15,
                            width: MediaQuery.of(context).size.width / 7,
                            child: Image.asset(
                              "assets/img_145.png",
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Align(
                    alignment: Alignment.center,
                    child: Container(
                      child: Row(
                        //mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            //color: Colors.white,
                            height: 15,
                            width: MediaQuery.of(context).size.width / 7,
                            child: Image.asset(
                              "assets/img_148.png",
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 30, 0),
                          ),

                          Container(
                            width: MediaQuery.of(context).size.width / 2,
                            child: Column(
                              children: const [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Change Password",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "......",
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          //Padding(padding: const EdgeInsets.fromLTRB(0,0,50,0),),

                          Container(
                            //color: Colors.white,
                            height: 15,
                            width: MediaQuery.of(context).size.width / 7,
                            child: Image.asset(
                              "assets/img_145.png",
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
              ],
            ),
          )
        ])));
  }
}

*/
