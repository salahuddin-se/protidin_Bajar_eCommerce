import 'dart:convert';
import 'dart:developer';

import 'package:customer_ui/all_screen/payment_successfull.dart';
import 'package:customer_ui/components/apis.dart';
import 'package:customer_ui/components/styles.dart';
import 'package:customer_ui/components/utils.dart';
import 'package:customer_ui/dataModel/user_info.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

enum SingingCharacter { xy, yz, zx, ab, bc, ca }

class Payment_Address1stPage extends StatefulWidget {
  const Payment_Address1stPage({Key? key}) : super(key: key);

  @override
  _Payment_Address1stPageState createState() => _Payment_Address1stPageState();
}

class _Payment_Address1stPageState extends State<Payment_Address1stPage> {
  SingingCharacter? _character = SingingCharacter.xy;

  var userAddressController = TextEditingController();
  var userCountryController = TextEditingController();
  var userCityController = TextEditingController();
  var userPostalCodeController = TextEditingController();
  var userPhoneController = TextEditingController();

  var userInfoData = [];
  Future<void> getUserInfo(userID) async {
    var res = await get(Uri.parse("$userInfoAPI$userID"), headers: {"Accept": "application/json", 'Authorization': 'Bearer $authToken'});

    log("user info response ${res.body}");

    if (res.statusCode == 200 || res.statusCode == 201) {
      var dataMap = jsonDecode(res.body);
      var userInfoModel = UserInfoModel.fromJson(dataMap);

      ///userInfoModel.data[0].country;

      userInfoData = userInfoModel.data;
      /*
      var groceryData = BreadBiscuit.fromJson(groceryItemDataMap);
      subCategoryProducts = groceryData.data;
      */

    }
  }

  Future<void> addUserAddress(userID, address, country, city, postalCode, phone) async {
    var res = await post(Uri.parse(addUserAddressAPI),
        headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8', 'Authorization': 'Bearer $authToken'},
        body: jsonEncode(<String, dynamic>{
          "user_id": userID,
          "address": address,
          "country": country,
          "city": city,
          "postal_code": postalCode,
          "phone": phone
        }));

    log("add user address response ${res.body}");
  }

  @override
  void initState() {
    // TODO: implement initState
    getUserInfo(userId);
    addUserAddress;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: kWhiteColor,
        centerTitle: true,
        title: Text(
          "Payment & address",
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
      backgroundColor: Colors.grey[100],
      //backgroundColor: Colors.indigo[50],
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Colors.white,
              //height: 440 ,
              height: 480,
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),

                  //const SizedBox(height: 20,),

                  Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: const Text(
                          "Delivered to",
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black),
                        ),
                      )),

                  SizedBox(
                    height: 20,
                  ),

                  ///map
                  Container(
                    height: 140,
                    width: MediaQuery.of(context).size.width / 1.1,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.15),
                          spreadRadius: 5, //spread radius
                          blurRadius: 5, // blur radius
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Container(
                        //height: 190,
                        //width: 200,
                        child: Image.asset(
                      "assets/img_116.png",
                      fit: BoxFit.cover,
                    )),
                  ),

                  SizedBox(
                    height: 30,
                  ),

                  ///address
                  Container(
                    width: MediaQuery.of(context).size.width / 1.1,
                    child: Row(children: [
                      Container(
                        height: 25,
                        width: MediaQuery.of(context).size.width / 7,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 0),
                          child: Image.asset(
                            "assets/img_117.png",
                          ),
                        ),
                      ),

                      ///userInfoModel.data[0].country;

                      ///userInfoData = userInfoModel.data;

                      Container(
                        height: 80,
                        width: MediaQuery.of(context).size.width * 3 / 4,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                          child:
                              //"${demo[index].currencySymbol} ${demo[index].price}",
                              //Text("3 Purana Paltan, Near Segunbagicha Bazar,\nDhaka-1000\nContact: 01812345678",style: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.w600,),
                              Text(
                            ",3 Purana Paltan,Near Segunbagicha Bazar,\nDhaka-1000\nContact: 01812345678",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ]),
                  ),

                  /*
                  ///address
                  Container(
                    width: MediaQuery.of(context).size.width/1.1,
                    child: Row(
                        children: [

                          Container(
                            height: 25,
                            width: MediaQuery.of(context).size.width/7,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 0),
                              child: Image.asset("assets/img_117.png",),
                            ),
                          ),

                          /*Padding(
                            padding: const EdgeInsets.fromLTRB(0,0,10,0),
                          ),*/

                          Container(
                            height: 80,
                              width: MediaQuery.of(context).size.width*3/4,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(10,0,0,0),
                              child: Text("3 Purana Paltan, Near Segunbagicha Bazar,\nDhaka-1000\nContact: 01812345678",style: TextStyle(
                                color: Colors.black,fontSize: 16,fontWeight: FontWeight.w600,
                              ),),
                            ),
                          ),



                        ]
                    ),
                  ),
                  */

                  SizedBox(
                    height: 10,
                  ),

                  ///add address button
                  ///
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Color(0xFF9900FF), //background color of button
                        //side: BorderSide(width:3, color:Colors.brown), //border width and color
                        elevation: 1, //elevation of button
                        shape: RoundedRectangleBorder(
                            //to set border radius to button
                            borderRadius: BorderRadius.circular(30)),
                        padding: EdgeInsets.all(10) //content padding inside button
                        ),
                    onPressed: () {
                      /*bottomSheet(
                          context: context, userId: userId, address: 'Kolabagan,Dhanmondi', country: 'Bangladesh', city: 'Dhaka', postalCode: '1100', phone: '01812009900',callBack: (){

                      });*/

                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        builder: (context) {
                          return SingleChildScrollView(
                            child: Padding(
                              padding: MediaQuery.of(context).viewInsets,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  left: 20,
                                  right: 20,
                                  top: 20,
                                  bottom: 10,
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        'ADD ADDRESS',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    TextFormField(
                                      controller: userAddressController,
                                      autofocus: true,
                                      onChanged: (value) {},
                                      decoration: InputDecoration(
                                        hintText: 'Address',
                                        fillColor: Colors.grey[100],
                                        filled: true,
                                        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide(color: Colors.white)),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide(color: Colors.white)),
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide(color: Colors.white)),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    TextFormField(
                                      controller: userCityController,
                                      autofocus: true,
                                      onChanged: (value) {},
                                      decoration: InputDecoration(
                                        hintText: 'City',
                                        fillColor: Colors.grey[100],
                                        filled: true,
                                        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide(color: Colors.white)),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide(color: Colors.white)),
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide(color: Colors.white)),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    TextFormField(
                                      controller: userPostalCodeController,
                                      autofocus: true,
                                      onChanged: (value) {},
                                      decoration: InputDecoration(
                                        hintText: 'Postal code',
                                        fillColor: Colors.grey[100],
                                        filled: true,
                                        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide(color: Colors.white)),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide(color: Colors.white)),
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide(color: Colors.white)),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    TextFormField(
                                      controller: userCountryController,
                                      autofocus: true,
                                      onChanged: (value) {},
                                      decoration: InputDecoration(
                                        hintText: 'Country',
                                        fillColor: Colors.grey[100],
                                        filled: true,
                                        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide(color: Colors.white)),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide(color: Colors.white)),
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide(color: Colors.white)),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    TextFormField(
                                      controller: userPhoneController,
                                      keyboardType: TextInputType.phone,
                                      autofocus: true,
                                      onChanged: (value) {},
                                      decoration: InputDecoration(
                                        hintText: 'Phone',
                                        fillColor: Colors.grey[100],
                                        filled: true,
                                        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide(color: Colors.white)),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide(color: Colors.white)),
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide(color: Colors.white)),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                primary: Color(0xFF9900FF), //background color of button
                                                //side: BorderSide(width:3, color:Colors.brown), //border width and color
                                                elevation: 1, //elevation of button
                                                shape: RoundedRectangleBorder(
                                                    //to set border radius to button
                                                    borderRadius: BorderRadius.circular(30)),
                                                padding: EdgeInsets.all(10) //content padding inside button
                                                ),
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: const Text(
                                              'Cancel',
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        Expanded(
                                          child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                primary: Color(0xFF9900FF), //background color of button
                                                //side: BorderSide(width:3, color:Colors.brown), //border width and color
                                                elevation: 1, //elevation of button
                                                shape: RoundedRectangleBorder(
                                                    //to set border radius to button
                                                    borderRadius: BorderRadius.circular(30)),
                                                padding: EdgeInsets.all(10) //content padding inside button
                                                ),
                                            onPressed: () {
                                              addUserAddress(userId, userAddressController.text, userCountryController.text,
                                                  userCityController.text, userPostalCodeController.text, userPhoneController.text);
                                            },
                                            child: const Text(
                                              'Save',
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                    child: Text(
                      'Add address',
                    ),
                  ),

                  ///
                  SizedBox(
                    height: 10,
                  ),

                  Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: Container(
                            width: MediaQuery.of(context).size.width / 1.5,
                            child: const Text(
                              "+ Add delivery instruction",
                              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800, color: Colors.green),
                            )),
                      )),
                ],
              ),
            ),

            SizedBox(
              height: 30,
            ),

            ///Preferred delivery slot
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.15),
                    spreadRadius: 5, //spread radius
                    blurRadius: 5, // blur radius
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              width: MediaQuery.of(context).size.width / 1.1,
              height: 130,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                  ),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 18.0),
                        child: const Text(
                          "Preferred delivery slot",
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black),
                        ),
                      )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              width: MediaQuery.of(context).size.width / 2.5,
                              child: const Text(
                                "Delivered date",
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black),
                              ),
                            )),
                      ),

                      /*Padding(
                        padding: const EdgeInsets.fromLTRB(40,0,40,0),
                      ),*/

                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Align(
                            alignment: Alignment.centerRight,
                            child: Container(
                                width: MediaQuery.of(context).size.width / 2.5,
                                child: const Text(
                                  "Delivered date",
                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black),
                                ))),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width / 2.5,
                          height: 40,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              // Red border with the width is equal to 5
                              border: Border.all(width: 1, color: Colors.black)),
                          child: Row(
                            children: [
                              Container(
                                height: 20,
                                //width: 200,
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(4, 0, 7, 0),
                                  child: Text(
                                    "Today, 23 Sep ",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                height: 15,
                                width: 15,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 0),
                                  child: Image.asset(
                                    "assets/ca.png",
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      /*Padding(
                            padding: const EdgeInsets.only(left:10),
                          ),*/

                      Container(
                        width: MediaQuery.of(context).size.width / 2.5,
                        height: 40,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            // Red border with the width is equal to 5
                            border: Border.all(width: 1, color: Colors.black)),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(5, 0, 8, 0),
                              //width: 200,
                              child: Text(
                                "Tap to choose",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Container(
                              height: 15,
                              width: 15,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 0),
                                child: Image.asset(
                                  "assets/dr.png",
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ]),
                  )
                ],
              ),
            ),

            SizedBox(
              height: 20,
            ),

            ///Payment Method
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.15),
                    spreadRadius: 5, //spread radius
                    blurRadius: 5, // blur radius
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              width: MediaQuery.of(context).size.width / 1.1,
              height: 785,
              child: Column(children: [
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                ),

                Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: const Text(
                        "Payment Method",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black),
                      ),
                    )),

                SizedBox(
                  height: 15,
                ),

                Container(
                  child: Row(
                    children: [
                      /*Padding(
                            padding: const EdgeInsets.only(left: 20),
                          ),*/

                      Container(
                        width: MediaQuery.of(context).size.width * 3 / 5,
                        child: ListTile(
                          title: const Text(
                            'Cash On Delivery',
                            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800, color: Colors.black),
                          ),
                          leading: Radio<SingingCharacter>(
                            value: SingingCharacter.yz,
                            groupValue: _character,
                            onChanged: (SingingCharacter? value) {
                              setState(() {
                                _character = value;
                              });
                            },
                          ),
                        ),
                      ),
                      Container(
                        height: 40,
                        width: MediaQuery.of(context).size.width / 7,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 0),
                          child: Image.asset(
                            "assets/img_119.png",
                          ),
                        ),
                      ),

                      /*Padding(
                            padding: const EdgeInsets.only(left: 20.0),
                            child: const Text("Cash On Delivery",style: TextStyle(fontSize: 17,fontWeight: FontWeight.w600,color: Colors.black),),
                          ),*/
                    ],
                  ),
                ),

                Container(
                  child: Row(
                    children: [
                      /*Padding(
                            padding: const EdgeInsets.only(left: 20),
                          ),*/

                      Container(
                        width: MediaQuery.of(context).size.width * 3 / 5,
                        child: ListTile(
                          title: const Text(
                            'bKash',
                            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800, color: Colors.black),
                          ),
                          leading: Radio<SingingCharacter>(
                            value: SingingCharacter.yz,
                            groupValue: _character,
                            onChanged: (SingingCharacter? value) {
                              setState(() {
                                _character = value;
                              });
                            },
                          ),
                        ),
                      ),
                      Container(
                        height: 40,
                        width: MediaQuery.of(context).size.width / 7,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 0),
                          child: Image.asset(
                            "assets/img_168.png",
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                Container(
                  child: Row(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 3 / 5,
                        child: ListTile(
                          title: const Text(
                            'Nagad',
                            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800, color: Colors.black),
                          ),
                          leading: Radio<SingingCharacter>(
                            value: SingingCharacter.yz,
                            groupValue: _character,
                            onChanged: (SingingCharacter? value) {
                              setState(() {
                                _character = value;
                              });
                            },
                          ),
                        ),
                      ),
                      Container(
                        height: 40,
                        width: MediaQuery.of(context).size.width / 7,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 0),
                          child: Image.asset(
                            "assets/img_121.png",
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                Container(
                  child: Row(
                    children: [
                      /*Padding(
                            padding: const EdgeInsets.only(left: 20),
                          ),*/

                      Container(
                        width: MediaQuery.of(context).size.width * 3 / 5,
                        child: ListTile(
                          title: const Text(
                            'Visa',
                            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800, color: Colors.black),
                          ),
                          leading: Radio<SingingCharacter>(
                            value: SingingCharacter.yz,
                            groupValue: _character,
                            onChanged: (SingingCharacter? value) {
                              setState(() {
                                _character = value;
                              });
                            },
                          ),
                        ),
                      ),
                      Container(
                        height: 40,
                        width: MediaQuery.of(context).size.width / 7,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 0),
                          child: Image.asset(
                            "assets/img_122.png",
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                Container(
                  child: Row(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 3 / 5,
                        child: ListTile(
                          title: const Text(
                            'Mastercard',
                            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800, color: Colors.black),
                          ),
                          leading: Radio<SingingCharacter>(
                            value: SingingCharacter.yz,
                            groupValue: _character,
                            onChanged: (SingingCharacter? value) {
                              setState(() {
                                _character = value;
                              });
                            },
                          ),
                        ),
                      ),
                      Container(
                        height: 40,
                        width: MediaQuery.of(context).size.width / 7,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 0),
                          child: Image.asset(
                            "assets/img_123.png",
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(
                  height: 20,
                ),

                Center(
                  child: Container(
                    height: 190,
                    width: MediaQuery.of(context).size.width / 1.1,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 0),
                      child: Image.asset(
                        "assets/img_124.png",
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 20),

                ///
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                    border: Border.all(width: 0.5, color: Colors.black),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 22),
                            child: Text(
                              "Card Number",
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black),
                            ),
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(5, 10, 10, 10),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(width: 0.8, color: Colors.black),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          height: 45,
                          width: MediaQuery.of(context).size.width / 1.3,
                        ),
                      ),
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 15.0),
                                  child: Container(
                                      width: MediaQuery.of(context).size.width / 2.5,
                                      child: const Text(
                                        "Exdpery date",
                                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black),
                                      )),
                                )),

                            /*Padding(
                                  padding: const EdgeInsets.fromLTRB(40,0,40,0),
                                ),*/

                            Align(
                                alignment: Alignment.centerRight,
                                child: Container(
                                    width: MediaQuery.of(context).size.width / 2.5,
                                    child: const Text(
                                      "CV code",
                                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black),
                                    ))),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Container(
                            width: MediaQuery.of(context).size.width / 6,
                            height: 40,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                // Red border with the width is equal to 5
                                border: Border.all(width: 1, color: Colors.black)),
                            child: Center(
                              child: Text(
                                "MM",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width / 6,
                          height: 40,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              // Red border with the width is equal to 5
                              border: Border.all(width: 1, color: Colors.black)),
                          child: Container(
                            height: 20,
                            //width: 200,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                              child: Center(
                                child: Text(
                                  "YY",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 25.0),
                          child: Container(
                            width: MediaQuery.of(context).size.width / 3,
                            height: 40,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                // Red border with the width is equal to 5
                                border: Border.all(width: 1, color: Colors.black)),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                              child: Center(
                                child: Text(
                                  "CV",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ])
                    ],
                  ),
                )
              ]),
            ),

            SizedBox(
              height: 25,
            ),

            Center(
              child: Container(
                height: 40,
                width: MediaQuery.of(context).size.width / 1,
                child: Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 5.0),
                      child: Column(
                        children: const [
                          Text(
                            "By tapping on 'place order',you agree to our",
                            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black),
                          ),
                          Text(
                            "Terms & Conditions",
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.green),
                          ),
                        ],
                      ),
                    )),
              ),
            ),

            SizedBox(
              height: 25,
            ),

            Container(
              width: MediaQuery.of(context).size.width / 1,
              height: 56,
              decoration: BoxDecoration(
                border: Border.all(
                  width: 0.150,
                  color: Colors.deepPurpleAccent,
                ),
                color: Color(0xFF9900FF),
                borderRadius: BorderRadius.circular(0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 5, //spread radius
                    blurRadius: 5, // blur radius
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Payment_Successful()));
                },
                child: Container(
                  child: Center(
                    child: Column(
                      children: const [
                        Text(
                          "৳707.00",
                          style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w800),
                        ),
                        Text(
                          "place order",
                          style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w800),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

bottomSheet(
    {required BuildContext context,
    required int userId,
    String? subDocId,
    required String address,
    required String country,
    required String city,
    required String postalCode,
    required String phone,
    required VoidCallback? callBack}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (context) {
      String newAddress = address;
      String newCountry = country;
      String newCity = city;
      String newPostalCode = postalCode;
      String newPhone = phone;

      return SingleChildScrollView(
        child: Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: Padding(
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
              top: 20,
              bottom: 10,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    subDocId == null ? 'ADD ADDRESS' : 'EDIT ADDRESS',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  initialValue: address,
                  autofocus: true,
                  onChanged: (value) {
                    newAddress = value;
                  },
                  decoration: InputDecoration(
                    hintText: 'Address',
                    fillColor: Colors.grey[100],
                    filled: true,
                    contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                    enabledBorder:
                        OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide(color: Colors.white)),
                    focusedBorder:
                        OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide(color: Colors.white)),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide(color: Colors.white)),
                    /*
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 2, color: Color(0xFF9900FF)),

                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 2, color: Color(0xFF9900FF)),
                      )
                     */
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  initialValue: city,
                  autofocus: true,
                  onChanged: (value) {
                    newCity = value;
                  },
                  decoration: InputDecoration(
                    hintText: 'City',
                    fillColor: Colors.grey[100],
                    filled: true,
                    contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                    enabledBorder:
                        OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide(color: Colors.white)),
                    focusedBorder:
                        OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide(color: Colors.white)),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide(color: Colors.white)),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  initialValue: postalCode,
                  autofocus: true,
                  onChanged: (value) {
                    newPostalCode = value;
                  },
                  decoration: InputDecoration(
                    hintText: 'Postal code',
                    fillColor: Colors.grey[100],
                    filled: true,
                    contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                    enabledBorder:
                        OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide(color: Colors.white)),
                    focusedBorder:
                        OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide(color: Colors.white)),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide(color: Colors.white)),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  initialValue: country,
                  autofocus: true,
                  onChanged: (value) {
                    newCountry = value;
                  },
                  decoration: InputDecoration(
                    hintText: 'Country',
                    fillColor: Colors.grey[100],
                    filled: true,
                    contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                    enabledBorder:
                        OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide(color: Colors.white)),
                    focusedBorder:
                        OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide(color: Colors.white)),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide(color: Colors.white)),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  keyboardType: TextInputType.phone,
                  initialValue: phone,
                  autofocus: true,
                  onChanged: (value) {
                    newPhone = value;
                  },
                  decoration: InputDecoration(
                    hintText: 'Phone',
                    fillColor: Colors.grey[100],
                    filled: true,
                    contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                    enabledBorder:
                        OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide(color: Colors.white)),
                    focusedBorder:
                        OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide(color: Colors.white)),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide(color: Colors.white)),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Color(0xFF9900FF), //background color of button
                            //side: BorderSide(width:3, color:Colors.brown), //border width and color
                            elevation: 1, //elevation of button
                            shape: RoundedRectangleBorder(
                                //to set border radius to button
                                borderRadius: BorderRadius.circular(30)),
                            padding: EdgeInsets.all(10) //content padding inside button
                            ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          'Cancel',
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Color(0xFF9900FF), //background color of button
                            //side: BorderSide(width:3, color:Colors.brown), //border width and color
                            elevation: 1, //elevation of button
                            shape: RoundedRectangleBorder(
                                //to set border radius to button
                                borderRadius: BorderRadius.circular(30)),
                            padding: EdgeInsets.all(10) //content padding inside button
                            ),
                        onPressed: callBack,
                        child: const Text(
                          'Save',
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
