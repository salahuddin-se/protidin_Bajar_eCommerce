import 'dart:convert';
import 'dart:developer';

import 'package:customer_ui/all_screen/payment_screen.dart';
import 'package:customer_ui/components/apis.dart';
import 'package:customer_ui/components/styles.dart';
import 'package:customer_ui/components/utils.dart';
import 'package:customer_ui/dataModel/payment_method.dart';
import 'package:customer_ui/dataModel/show_user_model.dart';
import 'package:customer_ui/dataModel/user_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:http/http.dart';

class PaymentAddress1stPage extends StatefulWidget {
  String grandTotal = "";
  String user_address = "";
  int ownerId = 0;

  PaymentAddress1stPage({Key? key, required this.grandTotal, required this.ownerId, required this.user_address}) : super(key: key);

  @override
  _PaymentAddress1stPageState createState() => _PaymentAddress1stPageState();
}

class _PaymentAddress1stPageState extends State<PaymentAddress1stPage> {
  var userAddressController = TextEditingController();
  var userCountryController = TextEditingController();
  var userCityController = TextEditingController();
  var userPostalCodeController = TextEditingController();
  var userPhoneController = TextEditingController();

  var value = " ";

  ///
  var formKey = GlobalKey<FormState>();

  ///

  var userInfoData = [];
  Future<void> getUserInfo(userID) async {
    var res = await get(Uri.parse("$userInfoAPI$userID"), headers: {"Accept": "application/json", 'Authorization': 'Bearer $authToken'});

    ///log("user info response ${res.body}");
    var dataMap = jsonDecode(res.body);
    if (res.statusCode == 200 || res.statusCode == 201) {
      var userInfoModel = UserInfoModel.fromJson(dataMap);

      ///userInfoModel.data[0].country

      userInfoData = userInfoModel.data;

      //print(userInfoData[0].address);
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

    ///log("add user address response ${res.body}");

    if (res.statusCode == 200 || res.statusCode == 201) {
      showToast("Shipping information has been added successfully", context: context);
      await getUserInfo(userID);
    } else {
      showToast("Something went wrong", context: context);
    }

    setState(() {
      userAddress = userAddressController.text;
      userCity = userCityController.text;
      userPostalCode = userPostalCodeController.text;
      userCountry = userCountryController.text;
      userPhone = userPhoneController.text;
    });
  }

  var userAddressData = [];
  var userAddress = "";
  var userCity = "";
  var userCountry = "";
  var userPostalCode = "";
  var userPhone = "";
  var paymentType = "";

  Future<void> getUserAddress(userID) async {
    var res =
        await get(Uri.parse("$showAddressAPI/$userID"), headers: {"Accept": "application/json", 'Authorization': 'Bearer $authToken'});

    ///log("user info response ${res.body}");
    var dataMap2 = jsonDecode(res.body);
    if (res.statusCode == 200 || res.statusCode == 201) {
      var userAddressModel = ShowUserAddressModel.fromJson(dataMap2);

      ///userInfoModel.data[0].country;
      userAddressData = userAddressModel.data;
      userAddress = userAddressData[0].address;
      userCity = userAddressData[0].city;
      userCountry = userAddressData[0].country;
      userPostalCode = userAddressData[0].postalCode;
      userPhone = userAddressData[0].phone;

      print("Area ${userAddressData[0].address} city ${userAddressData[0].city}  Country ${userAddressData[0].country}");

      setState(() {});
    }
  }

  ///
  var paymentModel = [];
  var paymentData = [];
  Future<void> getPaymentTypes() async {
    var response = await get(Uri.parse("https://test.protidin.com.bd/api/v2/payment-types"), headers: <String, String>{
      'Accept': 'application/json',
    });

    ///List<String> userData = List<String>.from(usersDataFromJson);
    final dataMap = jsonDecode(response.body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      paymentData = dataMap.map((json) => PaymentTypeResponse.fromJson(json)).toList();
      //print(paymentModel[1].payment_type_key);
      setState(() {});
    }
  }

  ///

  Future<void> orderCreate(ownerID, paymentType, userId, userAddress, grandTotal) async {
    log("CALLING");
    log("owner_ID $ownerID user id $userId payment type $paymentType");

    var jsonBody = (<String, dynamic>{"owner_id": ownerID.toString(), "user_id": userId.toString(), "payment_type": "cash_payment"});

    var res = await post(Uri.parse(createOrderAPI),
        headers: <String, String>{'Accept': 'application/json', 'Authorization': 'Bearer $authToken'}, body: jsonBody);

    log("after click ${res.body}");

    ///log("add user address response ${res.body}");

    if (res.statusCode == 200 || res.statusCode == 201) {
      var dataMap = jsonDecode(res.body);

      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Payment_Screen(
                    orderNo: dataMap["order_id"].toString(),
                    address: userAddress,
                    grandTotal: grandTotal.toString(),
                  )));
    }

    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    log("Grand Total ${widget.grandTotal} and owner Id ${widget.ownerId}");
    getUserInfo(61);
    getUserAddress(61);
    getPaymentTypes();
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

                  Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Text(
                          ////print(box.read('userName'));
                          "",
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
                            "$userAddress,$userCity-$userPostalCode, $userCountry, $userPhone",
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
                        padding: const EdgeInsets.only(left: 15.0),
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
                                "Delivered date :",
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black),
                              ),
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Align(
                            alignment: Alignment.centerRight,
                            child: Container(
                                width: MediaQuery.of(context).size.width / 2.5,
                                child: const Text(
                                  "Time slot :",
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

                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: Container(
                    height: 300,
                    child: ListView.builder(
                        shrinkWrap: true,
                        physics: ClampingScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        itemCount: paymentData.length,
                        itemBuilder: (_, index) {
                          return value == index.toString()
                              ? Row(
                                  children: [
                                    Container(
                                      height: 15,
                                      width: 15,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle, border: Border.all(color: kBlackColor), color: Colors.black),
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width * 3 / 5,
                                      child: ListTile(
                                        title: Text(
                                          paymentData[index].payment_type,
                                          style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800, color: Colors.black),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 40,
                                      width: MediaQuery.of(context).size.width / 7,
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 0),
                                        child: Image.network(
                                          paymentData[index].image,
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              : GestureDetector(
                                  onTap: () {
                                    paymentType = paymentData[index].payment_type;
                                    setState(() {
                                      value = index.toString();
                                    });
                                  },
                                  child: Row(
                                    children: [
                                      Container(
                                        height: 15,
                                        width: 15,
                                        decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: kBlackColor)),
                                      ),
                                      Container(
                                        width: MediaQuery.of(context).size.width * 3 / 5,
                                        child: ListTile(
                                          title: Text(
                                            paymentData[index].payment_type,
                                            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800, color: Colors.black),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        height: 40,
                                        width: MediaQuery.of(context).size.width / 7,
                                        child: Padding(
                                          padding: const EdgeInsets.only(left: 0),
                                          child: Image.network(
                                            paymentData[index].image,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                        }),
                  ),
                ),

                SizedBox(
                  height: 20,
                ),

                ///card image
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

                ///card number
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
                        children: const [
                          Padding(
                            padding: EdgeInsets.only(left: 22),
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

            GestureDetector(
              onTap: () {
                orderCreate(
                    widget.ownerId, paymentType, 61, "$userAddress,$userCity-$userPostalCode, $userCountry, $userPhone", widget.grandTotal);
              },
              child: Container(
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
                child: Center(
                  child: Column(
                    children: [
                      Text(
                        widget.grandTotal,
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
          ],
        ),
      ),
    );
  }
}

/*


import 'dart:convert';
import 'dart:developer';

import 'package:customer_ui/components/apis.dart';
import 'package:customer_ui/components/styles.dart';
import 'package:customer_ui/components/utils.dart';
import 'package:customer_ui/dataModel/payment_method.dart';
import 'package:customer_ui/dataModel/show_user_model.dart';
import 'package:customer_ui/dataModel/user_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:http/http.dart';


class PaymentAddress1stPage extends StatefulWidget {
  String grandTotal = "";
  int ownerId = 0;

  PaymentAddress1stPage({Key? key, required this.grandTotal, required this.ownerId}) : super(key: key);

  @override
  _PaymentAddress1stPageState createState() => _PaymentAddress1stPageState();
}

class _PaymentAddress1stPageState extends State<PaymentAddress1stPage> {
  var userAddressController = TextEditingController();
  var userCountryController = TextEditingController();
  var userCityController = TextEditingController();
  var userPostalCodeController = TextEditingController();
  var userPhoneController = TextEditingController();

  var value = " ";

  var userInfoData = [];
  Future<void> getUserInfo(userID) async {
    var res = await get(Uri.parse("$userInfoAPI$userID"), headers: {"Accept": "application/json", 'Authorization': 'Bearer $authToken'});

    ///log("user info response ${res.body}");
    var dataMap = jsonDecode(res.body);
    if (res.statusCode == 200 || res.statusCode == 201) {
      var userInfoModel = UserInfoModel.fromJson(dataMap);

      ///userInfoModel.data[0].country

      userInfoData = userInfoModel.data;

      //print(userInfoData[0].address);
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

    ///log("add user address response ${res.body}");

    if (res.statusCode == 200 || res.statusCode == 201) {
      showToast("Shipping information has been added successfully", context: context);
      await getUserInfo(userID);
    } else {
      showToast("Something went wrong", context: context);
    }

    setState(() {
      userAddress = userAddressController.text;
      userCity = userCityController.text;
      userPostalCode = userPostalCodeController.text;
      userCountry = userCountryController.text;
      userPhone = userPhoneController.text;
    });
  }

  var userAddressData = [];
  var userAddress = "";
  var userCity = "";
  var userCountry = "";
  var userPostalCode = "";
  var userPhone = "";
  var paymentType = "";

  Future<void> getUserAddress(userID) async {
    var res =
    await get(Uri.parse("$showAddressAPI/$userID"), headers: {"Accept": "application/json", 'Authorization': 'Bearer $authToken'});

    ///log("user info response ${res.body}");
    var dataMap2 = jsonDecode(res.body);
    if (res.statusCode == 200 || res.statusCode == 201) {
      var userAddressModel = ShowUserAddressModel.fromJson(dataMap2);

      ///userInfoModel.data[0].country;
      userAddressData = userAddressModel.data;
      userAddress = userAddressData[0].address;
      userCity = userAddressData[0].city;
      userCountry = userAddressData[0].country;
      userPostalCode = userAddressData[0].postalCode;
      userPhone = userAddressData[0].phone;

      print("Area ${userAddressData[0].address} city ${userAddressData[0].city}  Country ${userAddressData[0].country}");

      setState(() {});
    }
  }

  ///
  var paymentModel = [];
  var paymentData = [];
  Future<void> getPaymentTypes() async {
    var response = await get(Uri.parse("https://test.protidin.com.bd/api/v2/payment-types"), headers: <String, String>{
      'Accept': 'application/json',
    });

    ///List<String> userData = List<String>.from(usersDataFromJson);
    final dataMap = jsonDecode(response.body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      paymentData = dataMap.map((json) => PaymentTypeResponse.fromJson(json)).toList();
      //print(paymentModel[1].payment_type_key);
      setState(() {});
    }
  }

  ///

  Future<void> orderCreate(ownerID, paymentType) async {
    log("CALLING");
    var res = await post(Uri.parse(createOrderAPI),
        headers: <String, String>{'Accept': 'application/json', 'Authorization': 'Bearer $authToken'},
        body: jsonEncode(<String, dynamic>{"owner_id": ownerID, "user_id": userId, "payment_type": paymentType}));
    log("After placing order ${res.body}");

    ///log("add user address response ${res.body}");

    if (res.statusCode == 200 || res.statusCode == 201) {}

    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    log("Grand Total ${widget.grandTotal} and owner Id ${widget.ownerId}");
    getUserInfo(61);
    getUserAddress(61);
    getPaymentTypes();
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

                  Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Text(
                          ////print(box.read('userName'));
                          "",
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
                            "$userAddress,$userCity-$userPostalCode, $userCountry, $userPhone",
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
                        padding: const EdgeInsets.only(left: 15.0),
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
                                "Delivered date :",
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black),
                              ),
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Align(
                            alignment: Alignment.centerRight,
                            child: Container(
                                width: MediaQuery.of(context).size.width / 2.5,
                                child: const Text(
                                  "Time slot :",
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
                  height: 300,
                  child: ListView.builder(
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      itemCount: paymentData.length,
                      itemBuilder: (_, index) {
                        return value == index.toString()
                            ? Row(
                          children: [
                            Container(
                              height: 20,
                              width: 20,
                              decoration:
                              BoxDecoration(shape: BoxShape.circle, border: Border.all(color: kBlackColor), color: kPrimaryColor),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 3 / 5,
                              child: ListTile(
                                title: Text(
                                  paymentData[index].payment_type,
                                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800, color: Colors.black),
                                ),
                              ),
                            ),
                            Container(
                              height: 40,
                              width: MediaQuery.of(context).size.width / 7,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 0),
                                child: Image.network(
                                  paymentData[index].image,
                                ),
                              ),
                            ),
                          ],
                        )
                            : GestureDetector(
                          onTap: () {
                            paymentType = paymentData[index].payment_type;
                            setState(() {
                              value = index.toString();
                            });
                          },
                          child: Row(
                            children: [
                              Container(
                                height: 20,
                                width: 20,
                                decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: kBlackColor)),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 3 / 5,
                                child: ListTile(
                                  title: Text(
                                    paymentData[index].payment_type,
                                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800, color: Colors.black),
                                  ),
                                ),
                              ),
                              Container(
                                height: 40,
                                width: MediaQuery.of(context).size.width / 7,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 0),
                                  child: Image.network(
                                    paymentData[index].image,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
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
                        children: const [
                          Padding(
                            padding: EdgeInsets.only(left: 22),
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
              child: GestureDetector(
                onTap: () async {
                  log("TAP");
                  await orderCreate(widget.ownerId, paymentType);
                },
                child: Center(
                  child: Column(
                    children: [
                      Text(
                        "${widget.grandTotal}",
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
          ],
        ),
      ),
    );
  }
}

*/
