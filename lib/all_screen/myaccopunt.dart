import 'dart:convert';
import 'dart:io';

import 'package:customer_ui/components/apis.dart';
import 'package:customer_ui/components/styles.dart';
import 'package:customer_ui/components/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class MyAccountPage extends StatefulWidget {
  const MyAccountPage({Key? key}) : super(key: key);

  @override
  _MyAccountPageState createState() => _MyAccountPageState();
}

class _MyAccountPageState extends State<MyAccountPage> {
  final _picker = ImagePicker();
  File? _selectedFile;
  double? _percent;
  bool isUploading = false;

  Future<void> updateAccount({required String name, required String password, required BuildContext context}) async {
    var jsonBody = (<String, dynamic>{"id": box.read(userID).toString(), "name": name, "password": password});

    var res = await http.post(Uri.parse("http://test.protidin.com.bd:88/api/v2/profile/update"),
        headers: <String, String>{'Accept': 'application/json', 'Authorization': 'Bearer ${box.read(userToken)}'}, body: jsonBody);

    //log("update address ${res.body}");
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

  _selectSource(BuildContext context) {
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
                    _uploadImage(ImageSource.camera, context);
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
                    print("MYACC AVATAR ${baseUrl + box.read(userAvatar).toString()}");
                    _uploadImage(ImageSource.gallery, context);
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
      },
    );
  }

  _uploadImage(ImageSource imageSource, BuildContext context) async {
    setState(
      () {
        isUploading = true;
      },
    );
    try {
      final pickedFile = await _picker.pickImage(source: imageSource);

      if (pickedFile == null) return;
      if (!mounted) return;
      setState(() {
        _selectedFile = File(pickedFile.path);
      });
      if (_selectedFile != null) {
        box.write(avatarBytes, _selectedFile!.path);
        var request = http.MultipartRequest('POST', Uri.parse('http://test.protidin.com.bd:88/api/v2/profile/update-image'));
        request.headers.addAll({'Accept': 'application/json', 'Authorization': 'Bearer ${box.read(userToken)}'});

        request.files.add(await http.MultipartFile.fromPath(
          "image",
          _selectedFile!.path,
          filename: basename(_selectedFile!.path),
          // contentType:new http.MediaType()
        ));

        request.fields["filename"] = basename(_selectedFile!.path);
        request.fields["id"] = box.read(userID).toString();

        request.send().then((value) {
          //rint(value.);
          value.stream.transform(utf8.decoder).listen((event) {
            var res = jsonDecode(event);
            print(res["path"]);
          });

          print(value.statusCode);

          setState(
            () {
              isUploading = false;
            },
          );
        });
      }
    } catch (err) {
      print(err.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final avarByteData = box.read(avatarBytes);
    //log(avarByteData);
    File? imageAvatar;
    if (avarByteData != null) {
      //final bytes = base64Decode(avarByteData);
      imageAvatar = File(avarByteData);
    }
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: kWhiteColor,
        centerTitle: true,
        title: Text(
          "My Account",
          style: TextStyle(color: Color(0xFF515151), fontSize: 14, fontWeight: FontWeight.w400, fontFamily: "ceraProMedium"),
        ),
        iconTheme: IconThemeData(color: kBlackColor),
        actions: const [
          Center(
              // child: Icon(
              //   Icons.menu,
              //   color: kBlackColor,
              // ),
              ),
          SizedBox(
            width: 10,
          )
        ],
      ),
      //backgroundColor: Colors.white,
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 25,
            ),
            CircleAvatar(
              radius: 50,
              backgroundColor: Color(0xFF515151),
              child: Center(
                child: Stack(
                  children: [
                    Container(
                      //color: Colors.white,
                      height: 120,
                      width: 120,

                      decoration: imageAvatar != null
                          ? BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: FileImage(imageAvatar),
                              ),
                            )
                          /*
                      BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: FileImage(imageAvatar),
                              ),
                            )
                       */
                          : _selectedFile != null
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
                                    image: NetworkImage(
                                      imagePath + box.read(userAvatar),
                                    ),
                                  ),
                                ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: isUploading
                          ? CircularProgressIndicator()
                          : InkWell(
                              onTap: () => _selectSource(context),
                              child: CircleAvatar(
                                radius: 18,
                                child: Icon(Icons.camera_alt),
                              ),
                            ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                height: 37,
                width: MediaQuery.of(context).size.width / 1,
                child: Center(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 4.0),
                      child: Text(
                        ///box.write(userName, userDataModel.user.name);///datacount.read('count')
                        box.read(userName),
                        style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18, color: Colors.black, fontFamily: "ceraProMedium"),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: GestureDetector(
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
                                        updateAccount(name: _nameController.text, password: '123456', context: context)
                                            .then((value) => Navigator.pop(context));
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
                  //color: Colors.grey[50],
                  //borderRadius: BorderRadius.circular(20),
                  ),
              child: Column(
                children: [
                  SizedBox(
                    height: 15,
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
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 20.0),
                                      child: Text(
                                        "My Address",
                                        style: TextStyle(
                                            color: Color(0xFF515151),
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500,
                                            fontFamily: "ceraProMedium"),
                                      ),
                                    ),
                                  ),
                                  box.read(account_userAddress) == null
                                      ? Align(
                                          alignment: Alignment.centerLeft,
                                          child: Padding(
                                            padding: const EdgeInsets.only(top: 10.0),
                                            child: Text(
                                                //box.read(account_userAddress) ?? "No address",
                                                "No address",
                                                style: TextStyle(
                                                    color: Color(0xFFA299A8),
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w500,
                                                    fontFamily: "ceraProMedium")),
                                          ),
                                        )
                                      : Align(
                                          alignment: Alignment.centerLeft,
                                          child: Padding(
                                            padding: const EdgeInsets.only(top: 10.0),
                                            child: Text(
                                                //box.read(account_userAddress) ?? "No address",
                                                box.read(account_userAddress),
                                                style: TextStyle(
                                                    color: Color(0xFFA299A8),
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w500,
                                                    fontFamily: "ceraProMedium")),
                                          ),
                                        ),
                                ],
                              ),
                            ),

                            //Padding(padding: const EdgeInsets.fromLTRB(0,0,50,0),),

                            Container(
                              width: MediaQuery.of(context).size.width / 7,
                              child: GestureDetector(
                                onTap: () {
                                  TextEditingController _nameController = TextEditingController(text: box.read(userName));
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Column(
                                          children: <Widget>[
                                            TextFormField(
                                              //controller: _nameController,
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
                                                updateAccount(name: _nameController.text, password: '123456', context: context)
                                                    .then((value) => Navigator.pop(context));
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
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
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
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 20.0),
                                      child: Text("Email",
                                          style: TextStyle(
                                              color: Color(0xFF515151),
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500,
                                              fontFamily: "ceraProMedium")),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 10.0),
                                      child: box.read(userEmail) != null
                                          ? Text(
                                              /// "${box.read(userPhone)}",
                                              box.read(userEmail),
                                              style: TextStyle(
                                                color: Color(0xFFA299A8),
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500,
                                                fontFamily: "ceraProMedium",
                                              ),
                                            )
                                          : Text(""),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width / 7,
                              child: GestureDetector(
                                onTap: () {
                                  TextEditingController _nameController = TextEditingController(text: box.read(userName));
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Column(
                                          children: <Widget>[
                                            TextFormField(
                                              //controller: _nameController,
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
                                                updateAccount(name: _nameController.text, password: '123456', context: context)
                                                    .then((value) => Navigator.pop(context));
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
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
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
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 20.0),
                                      child: Text("Phone",
                                          style: TextStyle(
                                              color: Color(0xFF515151),
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500,
                                              fontFamily: "ceraProMedium")),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 10.0),
                                      child: box.read(userPhone) != null
                                          ? Text(

                                              /// "${box.read(userPhone)}",
                                              box.read(userPhone),
                                              style: TextStyle(
                                                  color: Color(0xFFA299A8),
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w500,
                                                  fontFamily: "ceraProMedium"))
                                          : Text(""),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width / 7,
                              child: GestureDetector(
                                onTap: () {
                                  TextEditingController _nameController = TextEditingController(text: box.read(userName));
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Column(
                                          children: <Widget>[
                                            TextFormField(
                                              //controller: _nameController,
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
                                                updateAccount(name: _nameController.text, password: '123456', context: context)
                                                    .then((value) => Navigator.pop(context));
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
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
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
                                    child: Padding(
                                      padding: EdgeInsets.only(top: 20.0),
                                      child: Text("Change Password",
                                          style: TextStyle(
                                              color: Color(0xFF515151),
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500,
                                              fontFamily: "ceraProMedium")),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 5.0),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text("......",
                                          style: TextStyle(
                                              color: Color(0xFFA299A8),
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500,
                                              fontFamily: "ceraProMedium")),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            //Padding(padding: const EdgeInsets.fromLTRB(0,0,50,0),),

                            Container(
                              width: MediaQuery.of(context).size.width / 7,
                              child: GestureDetector(
                                onTap: () {
                                  TextEditingController _nameController = TextEditingController(text: box.read(userName));
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Column(
                                          children: <Widget>[
                                            TextFormField(
                                              //controller: _nameController,
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
                                                updateAccount(name: _nameController.text, password: '123456', context: context)
                                                    .then((value) => Navigator.pop(context));
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
          ],
        ),
      ),
    );
  }
}

/// 09/03/22
/*
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:customer_ui/components/apis.dart';
import 'package:customer_ui/components/styles.dart';
import 'package:customer_ui/components/utils.dart';
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
  bool isUploading = false;

  Future<void> updateAccount({required String name, required String password, required BuildContext context}) async {
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

  _selectSource(BuildContext context) {
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
                    _uploadImage(ImageSource.camera, context);
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
                    _uploadImage(ImageSource.gallery, context);
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
      },
    );
  }

  _uploadImage(ImageSource imageSource, BuildContext context) async {
    setState(() {
      isUploading = true;
    });
    try {
      final pickedFile = await _picker.pickImage(source: imageSource);

      if (pickedFile == null) return;
      if (!mounted) return;
      setState(() {
        _selectedFile = File(pickedFile.path);
      });
      if (_selectedFile != null) {
        final byteData = await _selectedFile!.readAsBytes();
        String base64String = base64Encode(byteData);
        box.write(avatarBytes, base64String);
        var jsonBody = jsonEncode(
          {
            "id": box.read(userID),
            "filename": 'profile.png',
            "image": base64String,
          },
        );

        // log(jsonBody);

        var res = await post(Uri.parse("http://test.protidin.com.bd:88/api/v2/profile/update-image"),
            headers: <String, String>{'Accept': 'application/json', 'Authorization': 'Bearer ${box.read(userToken)}'}, body: jsonBody);

        log("update image ${res.body}");
        if (res.statusCode == 200 || res.statusCode == 201) {
          print('UPLOAD_RESPONSE: ${res.body}');
          showToast("Uploaded image successfully", context: context);
        } else {
          showToast("Something went wrong", context: context);
        }
        setState(() {
          isUploading = false;
        });
      }
    } catch (err) {
      print(err.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    print("MYACC AVATAR ${baseUrl + box.read(userAvatar).toString()}");
    final avarByteData = box.read(avatarBytes);
    //log(avarByteData);
    File? imageAvatar;
    if (avarByteData != null) {
      final bytes = base64Decode(avarByteData);
      imageAvatar = File.fromRawPath(bytes);
    }
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: kWhiteColor,
        centerTitle: true,
        title: Text(
          "My Account",
          style: TextStyle(color: Color(0xFF515151), fontSize: 14, fontWeight: FontWeight.w400, fontFamily: "ceraProMedium"),
        ),
        iconTheme: IconThemeData(color: kBlackColor),
        actions: const [
          Center(
              // child: Icon(
              //   Icons.menu,
              //   color: kBlackColor,
              // ),
              ),
          SizedBox(
            width: 10,
          )
        ],
      ),
      //backgroundColor: Colors.white,
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 25,
            ),
            CircleAvatar(
              radius: 50,
              backgroundColor: Color(0xFF515151),
              child: Center(
                child: Stack(
                  children: [
                    Container(
                      //color: Colors.white,
                      height: 120,
                      width: 120,

                      decoration: imageAvatar != null
                          ? BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: FileImage(imageAvatar),
                              ),
                            )
                          : _selectedFile != null
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
                                    image: NetworkImage(imagePath + box.read(userAvatar).toString()),
                                  ),
                                ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: isUploading
                          ? CircularProgressIndicator()
                          : InkWell(
                              onTap: () => _selectSource(context),
                              child: CircleAvatar(
                                radius: 18,
                                child: Icon(Icons.camera_alt),
                              ),
                            ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                height: 37,
                width: MediaQuery.of(context).size.width / 1,
                child: Center(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 4.0),
                      child: Text(
                        ///box.write(userName, userDataModel.user.name);///datacount.read('count')
                        box.read(userName),
                        style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18, color: Colors.black, fontFamily: "ceraProMedium"),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: GestureDetector(
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
                                        updateAccount(name: _nameController.text, password: '123456', context: context)
                                            .then((value) => Navigator.pop(context));
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
                  //color: Colors.grey[50],
                  //borderRadius: BorderRadius.circular(20),
                  ),
              child: Column(
                children: [
                  SizedBox(
                    height: 15,
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
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 20.0),
                                      child: Text(
                                        "My Address",
                                        style: TextStyle(
                                            color: Color(0xFF515151),
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500,
                                            fontFamily: "ceraProMedium"),
                                      ),
                                    ),
                                  ),
                                  box.read(account_userAddress) == null
                                      ? Align(
                                          alignment: Alignment.centerLeft,
                                          child: Padding(
                                            padding: const EdgeInsets.only(top: 10.0),
                                            child: Text(
                                                //box.read(account_userAddress) ?? "No address",
                                                "No address",
                                                style: TextStyle(
                                                    color: Color(0xFFA299A8),
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w500,
                                                    fontFamily: "ceraProMedium")),
                                          ),
                                        )
                                      : Align(
                                          alignment: Alignment.centerLeft,
                                          child: Padding(
                                            padding: const EdgeInsets.only(top: 10.0),
                                            child: Text(
                                                //box.read(account_userAddress) ?? "No address",
                                                box.read(account_userAddress),
                                                style: TextStyle(
                                                    color: Color(0xFFA299A8),
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w500,
                                                    fontFamily: "ceraProMedium")),
                                          ),
                                        ),
                                ],
                              ),
                            ),

                            //Padding(padding: const EdgeInsets.fromLTRB(0,0,50,0),),

                            Container(
                              width: MediaQuery.of(context).size.width / 7,
                              child: GestureDetector(
                                onTap: () {
                                  TextEditingController _nameController = TextEditingController(text: box.read(userName));
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Column(
                                          children: <Widget>[
                                            TextFormField(
                                              //controller: _nameController,
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
                                                updateAccount(name: _nameController.text, password: '123456', context: context)
                                                    .then((value) => Navigator.pop(context));
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
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
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
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 20.0),
                                      child: Text("Email",
                                          style: TextStyle(
                                              color: Color(0xFF515151),
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500,
                                              fontFamily: "ceraProMedium")),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 10.0),
                                      child: box.read(userEmail) != null
                                          ? Text(
                                              /// "${box.read(userPhone)}",
                                              box.read(userEmail),
                                              style: TextStyle(
                                                color: Color(0xFFA299A8),
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500,
                                                fontFamily: "ceraProMedium",
                                              ),
                                            )
                                          : Text(""),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width / 7,
                              child: GestureDetector(
                                onTap: () {
                                  TextEditingController _nameController = TextEditingController(text: box.read(userName));
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Column(
                                          children: <Widget>[
                                            TextFormField(
                                              //controller: _nameController,
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
                                                updateAccount(name: _nameController.text, password: '123456', context: context)
                                                    .then((value) => Navigator.pop(context));
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
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
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
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 20.0),
                                      child: Text("Phone",
                                          style: TextStyle(
                                              color: Color(0xFF515151),
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500,
                                              fontFamily: "ceraProMedium")),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 10.0),
                                      child: box.read(userPhone) != null
                                          ? Text(

                                              /// "${box.read(userPhone)}",
                                              box.read(userPhone),
                                              style: TextStyle(
                                                  color: Color(0xFFA299A8),
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w500,
                                                  fontFamily: "ceraProMedium"))
                                          : Text(""),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width / 7,
                              child: GestureDetector(
                                onTap: () {
                                  TextEditingController _nameController = TextEditingController(text: box.read(userName));
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Column(
                                          children: <Widget>[
                                            TextFormField(
                                              //controller: _nameController,
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
                                                updateAccount(name: _nameController.text, password: '123456', context: context)
                                                    .then((value) => Navigator.pop(context));
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
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
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
                                    child: Padding(
                                      padding: EdgeInsets.only(top: 20.0),
                                      child: Text("Change Password",
                                          style: TextStyle(
                                              color: Color(0xFF515151),
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500,
                                              fontFamily: "ceraProMedium")),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 5.0),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text("......",
                                          style: TextStyle(
                                              color: Color(0xFFA299A8),
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500,
                                              fontFamily: "ceraProMedium")),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            //Padding(padding: const EdgeInsets.fromLTRB(0,0,50,0),),

                            Container(
                              width: MediaQuery.of(context).size.width / 7,
                              child: GestureDetector(
                                onTap: () {
                                  TextEditingController _nameController = TextEditingController(text: box.read(userName));
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Column(
                                          children: <Widget>[
                                            TextFormField(
                                              //controller: _nameController,
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
                                                updateAccount(name: _nameController.text, password: '123456', context: context)
                                                    .then((value) => Navigator.pop(context));
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
          ],
        ),
      ),
    );
  }
}

*/

/// 10/03/22
/*
import 'dart:convert';
import 'dart:io';

import 'package:customer_ui/components/apis.dart';
import 'package:customer_ui/components/styles.dart';
import 'package:customer_ui/components/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class MyAccountPage extends StatefulWidget {
  const MyAccountPage({Key? key}) : super(key: key);

  @override
  _MyAccountPageState createState() => _MyAccountPageState();
}

class _MyAccountPageState extends State<MyAccountPage> {
  final _picker = ImagePicker();
  File? _selectedFile;
  double? _percent;
  bool isUploading = false;

  Future<void> updateAccount({required String name, required String password, required BuildContext context}) async {
    var jsonBody = (<String, dynamic>{"id": box.read(userID).toString(), "name": name, "password": password});

    var res = await http.post(Uri.parse("http://test.protidin.com.bd:88/api/v2/profile/update"),
        headers: <String, String>{'Accept': 'application/json', 'Authorization': 'Bearer ${box.read(userToken)}'}, body: jsonBody);

    //log("update address ${res.body}");
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

  _selectSource(BuildContext context) {
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
                    _uploadImage(ImageSource.camera, context);
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
                    print("MYACC AVATAR ${baseUrl + box.read(userAvatar).toString()}");
                    _uploadImage(ImageSource.gallery, context);
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
      },
    );
  }

  _uploadImage(ImageSource imageSource, BuildContext context) async {
    setState(
      () {
        isUploading = true;
      },
    );
    try {
      final pickedFile = await _picker.pickImage(source: imageSource);

      if (pickedFile == null) return;
      if (!mounted) return;
      setState(() {
        _selectedFile = File(pickedFile.path);
      });
      if (_selectedFile != null) {
        box.write(avatarBytes, _selectedFile!.path);
        var request = http.MultipartRequest('POST', Uri.parse('http://test.protidin.com.bd:88/api/v2/profile/update-image'));
        request.headers.addAll({'Accept': 'application/json', 'Authorization': 'Bearer ${box.read(userToken)}'});

        request.files.add(await http.MultipartFile.fromPath(
          "image",
          _selectedFile!.path,
          filename: basename(_selectedFile!.path),
          // contentType:new http.MediaType()
        ));

        request.fields["filename"] = basename(_selectedFile!.path);
        request.fields["id"] = box.read(userID).toString();

        request.send().then((value) {
          //rint(value.);
          value.stream.transform(utf8.decoder).listen((event) {
            var res = jsonDecode(event);
            print(res["path"]);
          });

          print(value.statusCode);

          setState(
            () {
              isUploading = false;
            },
          );
        });
      }
    } catch (err) {
      print(err.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final avarByteData = box.read(avatarBytes);
    //log(avarByteData);
    File? imageAvatar;
    if (avarByteData != null) {
      //final bytes = base64Decode(avarByteData);
      imageAvatar = File(avarByteData);
    }
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: kWhiteColor,
        centerTitle: true,
        title: Text(
          "My Account",
          style: TextStyle(color: Color(0xFF515151), fontSize: 14, fontWeight: FontWeight.w400, fontFamily: "ceraProMedium"),
        ),
        iconTheme: IconThemeData(color: kBlackColor),
        actions: const [
          Center(
              // child: Icon(
              //   Icons.menu,
              //   color: kBlackColor,
              // ),
              ),
          SizedBox(
            width: 10,
          )
        ],
      ),
      //backgroundColor: Colors.white,
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 25,
            ),
            CircleAvatar(
              radius: 50,
              backgroundColor: Color(0xFF515151),
              child: Center(
                child: Stack(
                  children: [
                    Container(
                      //color: Colors.white,
                      height: 120,
                      width: 120,

                      decoration: imageAvatar != null
                          ? BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: FileImage(imageAvatar),
                              ),
                            )
                          : _selectedFile != null
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
                                    image: NetworkImage(
                                      imagePath + box.read(userAvatar),
                                    ),
                                  ),
                                ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: isUploading
                          ? CircularProgressIndicator()
                          : InkWell(
                              onTap: () => _selectSource(context),
                              child: CircleAvatar(
                                radius: 18,
                                child: Icon(Icons.camera_alt),
                              ),
                            ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                height: 37,
                width: MediaQuery.of(context).size.width / 1,
                child: Center(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 4.0),
                      child: Text(
                        ///box.write(userName, userDataModel.user.name);///datacount.read('count')
                        box.read(userName),
                        style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18, color: Colors.black, fontFamily: "ceraProMedium"),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: GestureDetector(
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
                                        updateAccount(name: _nameController.text, password: '123456', context: context)
                                            .then((value) => Navigator.pop(context));
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
                  //color: Colors.grey[50],
                  //borderRadius: BorderRadius.circular(20),
                  ),
              child: Column(
                children: [
                  SizedBox(
                    height: 15,
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
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 20.0),
                                      child: Text(
                                        "My Address",
                                        style: TextStyle(
                                            color: Color(0xFF515151),
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500,
                                            fontFamily: "ceraProMedium"),
                                      ),
                                    ),
                                  ),
                                  box.read(account_userAddress) == null
                                      ? Align(
                                          alignment: Alignment.centerLeft,
                                          child: Padding(
                                            padding: const EdgeInsets.only(top: 10.0),
                                            child: Text(
                                                //box.read(account_userAddress) ?? "No address",
                                                "No address",
                                                style: TextStyle(
                                                    color: Color(0xFFA299A8),
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w500,
                                                    fontFamily: "ceraProMedium")),
                                          ),
                                        )
                                      : Align(
                                          alignment: Alignment.centerLeft,
                                          child: Padding(
                                            padding: const EdgeInsets.only(top: 10.0),
                                            child: Text(
                                                //box.read(account_userAddress) ?? "No address",
                                                box.read(account_userAddress),
                                                style: TextStyle(
                                                    color: Color(0xFFA299A8),
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w500,
                                                    fontFamily: "ceraProMedium")),
                                          ),
                                        ),
                                ],
                              ),
                            ),

                            //Padding(padding: const EdgeInsets.fromLTRB(0,0,50,0),),

                            Container(
                              width: MediaQuery.of(context).size.width / 7,
                              child: GestureDetector(
                                onTap: () {
                                  TextEditingController _nameController = TextEditingController(text: box.read(userName));
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Column(
                                          children: <Widget>[
                                            TextFormField(
                                              //controller: _nameController,
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
                                                updateAccount(name: _nameController.text, password: '123456', context: context)
                                                    .then((value) => Navigator.pop(context));
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
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
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
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 20.0),
                                      child: Text("Email",
                                          style: TextStyle(
                                              color: Color(0xFF515151),
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500,
                                              fontFamily: "ceraProMedium")),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 10.0),
                                      child: box.read(userEmail) != null
                                          ? Text(
                                              /// "${box.read(userPhone)}",
                                              box.read(userEmail),
                                              style: TextStyle(
                                                color: Color(0xFFA299A8),
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500,
                                                fontFamily: "ceraProMedium",
                                              ),
                                            )
                                          : Text(""),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width / 7,
                              child: GestureDetector(
                                onTap: () {
                                  TextEditingController _nameController = TextEditingController(text: box.read(userName));
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Column(
                                          children: <Widget>[
                                            TextFormField(
                                              //controller: _nameController,
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
                                                updateAccount(name: _nameController.text, password: '123456', context: context)
                                                    .then((value) => Navigator.pop(context));
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
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
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
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 20.0),
                                      child: Text("Phone",
                                          style: TextStyle(
                                              color: Color(0xFF515151),
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500,
                                              fontFamily: "ceraProMedium")),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 10.0),
                                      child: box.read(userPhone) != null
                                          ? Text(

                                              /// "${box.read(userPhone)}",
                                              box.read(userPhone),
                                              style: TextStyle(
                                                  color: Color(0xFFA299A8),
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w500,
                                                  fontFamily: "ceraProMedium"))
                                          : Text(""),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width / 7,
                              child: GestureDetector(
                                onTap: () {
                                  TextEditingController _nameController = TextEditingController(text: box.read(userName));
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Column(
                                          children: <Widget>[
                                            TextFormField(
                                              //controller: _nameController,
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
                                                updateAccount(name: _nameController.text, password: '123456', context: context)
                                                    .then((value) => Navigator.pop(context));
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
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
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
                                    child: Padding(
                                      padding: EdgeInsets.only(top: 20.0),
                                      child: Text("Change Password",
                                          style: TextStyle(
                                              color: Color(0xFF515151),
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500,
                                              fontFamily: "ceraProMedium")),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 5.0),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text("......",
                                          style: TextStyle(
                                              color: Color(0xFFA299A8),
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500,
                                              fontFamily: "ceraProMedium")),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            //Padding(padding: const EdgeInsets.fromLTRB(0,0,50,0),),

                            Container(
                              width: MediaQuery.of(context).size.width / 7,
                              child: GestureDetector(
                                onTap: () {
                                  TextEditingController _nameController = TextEditingController(text: box.read(userName));
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Column(
                                          children: <Widget>[
                                            TextFormField(
                                              //controller: _nameController,
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
                                                updateAccount(name: _nameController.text, password: '123456', context: context)
                                                    .then((value) => Navigator.pop(context));
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
          ],
        ),
      ),
    );
  }
}

*/
