import 'dart:convert';
import 'dart:developer';

import 'package:customer_ui/all_screen/payment_screen.dart';
import 'package:customer_ui/components/apis.dart';
import 'package:customer_ui/components/styles.dart';
import 'package:customer_ui/components/utils.dart';
import 'package:customer_ui/controller/cartItemsController.dart';
import 'package:customer_ui/dataModel/payment_method.dart';
import 'package:customer_ui/dataModel/purchase_history.dart ' as purHistory;
import 'package:customer_ui/dataModel/show_user_model.dart';
import 'package:customer_ui/dataModel/user_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class PaymentAddress1stPage extends StatefulWidget {
  String grandTotal = "";
  String user_address = "";
  int ownerId = 0;

  PaymentAddress1stPage({Key? key, required this.grandTotal, required this.ownerId, required this.user_address}) : super(key: key);

  @override
  _PaymentAddress1stPageState createState() => _PaymentAddress1stPageState();
}

class _PaymentAddress1stPageState extends State<PaymentAddress1stPage> with SingleTickerProviderStateMixin {
  late TabController controller2;

  var userAddressController = TextEditingController();
  var userCountryController = TextEditingController();
  var userCityController = TextEditingController();
  var userPostalCodeController = TextEditingController();
  var userPhoneController = TextEditingController();
  var controller = Get.put(CartItemsController());

  var value = " ";
  var addressValue = " ";
  bool isLoading = false;
  var formKey = GlobalKey<FormState>();
  String addr = "Please Add Your Address";
  var userInfoData = [];

  Future addressDeleteAPI(userID) async {
    var res = await http.get(Uri.parse("$addressDelete/$userID"),
        headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8', 'Authorization': 'Bearer ${box.read(userToken)}'});

    log("CART DELETE RESPONSE ${res.body}");

    if (res.statusCode == 200 || res.statusCode == 201) {
      showToast("Address delete Successfully", context: context);
      // await Get.find<CartItemsController>().getCartName();
      await getUserAddress(userID);

      setState(() {});
    }
  }

  List<purHistory.Data> purchaseData = [];

  Future<void> getUserInfo(userID) async {
    var res = await get(Uri.parse("$userInfoAPI$userID"),
        headers: {"Accept": "application/json", 'Authorization': 'Bearer ${box.read(userToken)}'});

    ///log("user info response ${res.body}");
    var dataMap = jsonDecode(res.body);
    if (res.statusCode == 200 || res.statusCode == 201) {
      var userInfoModel = UserInfoModel.fromJson(dataMap);

      ///userInfoModel.data[0].country

      userInfoData = userInfoModel.data;

      //print(userInfoData[0].address);
    }
  }

  Future<void> addUserAddress(userID, address, country, city, postalCode, phone, bool isUpdate, addressId) async {
    String targetUrl = isUpdate ? "http://test.protidin.com.bd:88/api/v2/update-address-in-cart" : addUserAddressAPI;

    log("new address id $addressId");
    log("target url $targetUrl");

    var bodyData = isUpdate
        ? jsonEncode(<String, dynamic>{
            "user_id": userID,
            "address": address,
            "address_id": addressId,
            "country": country,
            "city": city,
            "postal_code": postalCode,
            "phone": phone
          })
        : jsonEncode(<String, dynamic>{
            "user_id": userID,
            "address": address,
            "country": country,
            "city": city,
            "postal_code": postalCode,
            "phone": phone
          });

    var res = await post(
      Uri.parse(targetUrl),
      headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8', 'Authorization': 'Bearer ${box.read(userToken)}'},
      body: bodyData,
    );

    ///log("add user address response ${res.body}");

    if (res.statusCode == 200 || res.statusCode == 201) {
      showToast("Shipping information has been added successfully", context: context);
      await getUserAddress(userID);
    } else {
      showToast("Something went wrong", context: context);
    }

    setState(() {
      _userAddress = userAddressController.text;
      userCity = userCityController.text;
      userPostalCode = userPostalCodeController.text;
      userCountry = userCountryController.text;
      userPhone = userPhoneController.text;
    });
  }

  List<AddressData> userAddressData = [];
  var _userAddress = "";
  var userCity = "";
  var userCountry = "";
  var userPostalCode = "";
  var userPhone = "";
  var paymentType = "";

  var selectedAddress = "";

  Future<void> getUserAddress(userID) async {
    var res = await get(Uri.parse("$showAddressAPI/$userID"),
        headers: {"Accept": "application/json", 'Authorization': 'Bearer ${box.read(userToken)}'});

    ///log("user info response ${res.body}");
    var dataMap2 = jsonDecode(res.body);
    if (res.statusCode == 200 || res.statusCode == 201) {
      var userAddressModel = ShowUserAddressModel.fromJson(dataMap2);

      ///userInfoModel.data[0].country;
      userAddressData = userAddressModel.data;
      _userAddress = userAddressData[0].address!;

      box.write("Phone_Number", userPhone);

      //userCountry = userAddressData[0].country;
      print("Area ${userAddressData[0].address} city ${userAddressData[0].city}  Country ${userAddressData[0].country}");
      setState(() {});
    }
  }

  ///
  ///var paymentModel = [];
  var paymentData = [];

  Future<void> getPaymentTypes() async {
    var response = await get(Uri.parse("http://test.protidin.com.bd:88/api/v2/payment-types"), headers: <String, String>{
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

  Future<void> updateAddressInCart(userId, addressID) async {
    log("address ID $addressID");
    var jsonBody = (<String, dynamic>{"user_id": userId.toString(), "address_id": addressID.toString()});

    var res = await post(Uri.parse("http://test.protidin.com.bd:88/api/v2/update-address-in-cart"),
        headers: <String, String>{'Accept': 'application/json', 'Authorization': 'Bearer ${box.read(userToken)}'}, body: jsonBody);

    log("update address in cart ${res.body}");

    ///log("add user address response ${res.body}");

    if (res.statusCode == 200 || res.statusCode == 201) {
      var dataMap = jsonDecode(res.body);
    } else {
      showToast("Something went wrong", context: context);
    }
    setState(() {});
  }

  Future<void> orderCreate(userId, ownerID, paymentType, userAddress, grandTotal) async {
    log("CALLING");
    log("owner_ID $ownerID user id $userId payment type $paymentType");

    var jsonBody = (<String, dynamic>{
      "user_id": userId.toString(),
      "owner_id": ownerID.toString(),
      "payment_type_key": "cash_payment",
      "address": userAddress
    });

    var res = await post(Uri.parse(createOrderAPI),
        headers: <String, String>{'Accept': 'application/json', 'Authorization': 'Bearer ${box.read(userToken)}'}, body: jsonBody);

    log("after click place order ${res.body}");

    ///log("add user address response ${res.body}");

    if (res.statusCode == 200 || res.statusCode == 201) {
      showToast("Payment Successfull", context: context);

      var dataMap = jsonDecode(res.body);
      box.write(cart_item, '');
      controller.getCartName();
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => Payment_Screen(
                    orderNo: dataMap["order_id"].toString(),
                    address: userAddress,
                    paymentTypes: paymentType,
                    grandTotal: grandTotal.toString(),
                  )));
    } else {
      showToast("Something went wrong", context: context);
    }
    setState(() {});
  }

  @override
  void initState() {
    /// TODO: implement initState
    log("Grand Total ${widget.grandTotal} and owner Id ${widget.ownerId}");
    getUserInfo(box.read(userID));
    getUserAddress(box.read(userID));

    /// updateAddressInCart(11);
    getPaymentTypes();
    controller2 = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    // print("ITEM_UID: ${controller.cartItemsList[1].ownerId}");
    // print("BOX_UID: ${box.read(user_Id)}");
    var physicalProducts = controller.cartItemsList.where((item) => item.ownerId.toString() == box.read(user_Id).toString()).toList();
    var cloudProducts = controller.cartItemsList.where((item) => item.ownerId.toString() == box.read(webStoreId).toString()).toList();
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
      body: RefreshIndicator(
        onRefresh: () async {
          setState(() {});
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                color: Colors.white,
                //height: 480 ,
                height: 330,
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: const Text(
                                "Delivered to",
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black),
                              ),
                            )),
                        Padding(
                          padding: const EdgeInsets.only(left: 80.0),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              //primary: Color(0xFF9900FF),
                              primary: Colors.white,
                              //side: BorderSide(width:3, color:Colors.brown), //border width and color
                              elevation: 1.5, //elevation of button

                              padding: EdgeInsets.all(10) //content padding inside button
                              ),
                          onPressed: () {
                            _swAddressBottoSheet(false, -1);
                          },
                          child: Container(
                              height: 20,
                              width: 20,
                              //height: 190,
                              //width: 200,
                              child: Image.asset(
                                "assets/img_47.png",
                                fit: BoxFit.cover,
                              )),
                        ),
                      ],
                    ),

                    SizedBox(
                      height: 20,
                    ),

                    ///map
                    // Container(
                    //   height: 140,
                    //   width: MediaQuery.of(context).size.width / 1.1,
                    //   decoration: BoxDecoration(
                    //     borderRadius: BorderRadius.circular(5),
                    //     boxShadow: [
                    //       BoxShadow(
                    //         color: Colors.grey.withOpacity(0.15),
                    //         spreadRadius: 5, //spread radius
                    //         blurRadius: 5, // blur radius
                    //         offset: Offset(0, 3),
                    //       ),
                    //     ],
                    //   ),
                    //   child: Container(
                    //       //height: 190,
                    //       //width: 200,
                    //       child: Image.asset(
                    //     "assets/img_116.png",
                    //     fit: BoxFit.cover,
                    //   )),
                    // ),

                    SizedBox(
                      height: 30,
                    ),

                    ///address list
                    Container(
                      //height: 120,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(12, 0, 0, 10),
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          itemCount: userAddressData.length,
                          itemBuilder: (_, index) {
                            return addressValue == index.toString()
                                ? Container(
                                    height: 75,
                                    child: Padding(
                                      padding: const EdgeInsets.only(bottom: 8.0),
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(left: 10.0),
                                          ),
                                          Container(
                                            height: 15,
                                            width: 15,
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle, border: Border.all(color: kBlackColor), color: kPrimaryColor),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(left: 10.0),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(6.0),
                                            child: Align(
                                              alignment: Alignment.center,
                                              child: Container(
                                                height: 45,
                                                child: Padding(
                                                  padding: const EdgeInsets.only(top: 5.0),
                                                  child: Text(
                                                    "${userAddressData[index].address},${userAddressData[index].city},${userAddressData[index].postalCode},${userAddressData[index].country},${userAddressData[index].phone},",
                                                    style: TextStyle(fontWeight: FontWeight.w500),
                                                  ),
                                                ),
                                                width: MediaQuery.of(context).size.width / 1.8,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(left: 20.0),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              userAddressController.text = userAddressData[index].address!;
                                              userCityController.text = userAddressData[index].city!;
                                              userPostalCodeController.text = userAddressData[index].postalCode!;
                                              userCountryController.text = userAddressData[index].country!;
                                              userPhoneController.text = userAddressData[index].phone!;
                                              //updateAddressInCart(box.read(userID), userAddressData[index].id);
                                              print("ADDR_ID: ${userAddressData[index].id}");
                                              _swAddressBottoSheet(true, userAddressData[index].id);
                                            },
                                            child: Align(
                                              alignment: Alignment.center,
                                              child: Container(
                                                height: 45,
                                                width: 45,
                                                child: Align(
                                                  alignment: Alignment.center,
                                                  child: Container(
                                                    height: 25,
                                                    width: 25,
                                                    child: Padding(
                                                      padding: const EdgeInsets.only(left: 0),
                                                      child: Image.asset(
                                                        "assets/img_60.png",
                                                        height: 15,
                                                        width: 15,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),

                                          // GestureDetector(
                                          //   onTap: () {
                                          //     addressDeleteAPI(userAddressData[index].userId);
                                          //
                                          //     ///updateAddressInCart(box.read(userID), userAddressData[index].id);
                                          //   },
                                          //   child: Container(
                                          //     height: 45,
                                          //     width: 45,
                                          //     child: Align(
                                          //       alignment: Alignment.center,
                                          //       child: Container(
                                          //         height: 35,
                                          //         width: 35,
                                          //         child: Padding(
                                          //           padding: const EdgeInsets.only(left: 0),
                                          //           child: Image.asset(
                                          //             "assets/img_106.png",
                                          //             height: 25,
                                          //             width: 25,
                                          //           ),
                                          //         ),
                                          //       ),
                                          //     ),
                                          //   ),
                                          // ),
                                        ],
                                      ),
                                    ),
                                  )
                                : Container(
                                    height: 75,
                                    child: GestureDetector(
                                      onTap: () {
                                        ///updateAddressInCart(box.read(userID), userAddressData[index].id);
                                        selectedAddress =
                                            ("${userAddressData[index].address},${userAddressData[index].city},${userAddressData[index].postalCode},${userAddressData[index].country},${userAddressData[index].phone}");
                                        log(selectedAddress);
                                        box.write(account_userAddress, selectedAddress);
                                        setState(
                                          () {
                                            addressValue = index.toString();
                                          },
                                        );
                                      },
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(left: 10.0),
                                          ),
                                          Container(
                                            height: 15,
                                            width: 15,
                                            decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: kBlackColor)),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(left: 10.0),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(6.0),
                                            child: Align(
                                              alignment: Alignment.center,
                                              child: Container(
                                                height: 45,
                                                child: Padding(
                                                  padding: const EdgeInsets.only(top: 5.0),
                                                  child: Text(
                                                    "${userAddressData[index].address},${userAddressData[index].city},${userAddressData[index].postalCode},${userAddressData[index].country},${userAddressData[index].phone},",
                                                    style: TextStyle(fontWeight: FontWeight.w500),
                                                  ),
                                                ),
                                                width: MediaQuery.of(context).size.width / 1.8,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(left: 20.0),
                                          ),
                                          Align(
                                            alignment: Alignment.center,
                                            child: Container(
                                              height: 45,
                                              width: 45,
                                              child: Align(
                                                alignment: Alignment.center,
                                                child: Container(
                                                  height: 25,
                                                  width: 25,
                                                  child: Padding(
                                                    padding: const EdgeInsets.only(top: 0),
                                                    child: Image.asset(
                                                      "assets/img_60.png",
                                                      height: 15,
                                                      width: 15,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),

                                          // GestureDetector(
                                          //   onTap: () {
                                          //     addressDeleteAPI(userAddressData[index].userId);
                                          //
                                          //     ///updateAddressInCart(box.read(userID), userAddressData[index].id);
                                          //   },
                                          //   child: Container(
                                          //     height: 45,
                                          //     width: 45,
                                          //     child: Align(
                                          //       alignment: Alignment.center,
                                          //       child: Container(
                                          //         //25
                                          //         height: 35,
                                          //         width: 35,
                                          //         child: Padding(
                                          //           padding: const EdgeInsets.only(left: 0),
                                          //           child: Image.asset(
                                          //             "assets/img_106.png",
                                          //             height: 25,
                                          //             width: 25,
                                          //           ),
                                          //         ),
                                          //       ),
                                          //     ),
                                          //   ),
                                          // ),
                                        ],
                                      ),
                                    ),
                                  );
                          },
                        ),
                      ),
                    ),

                    SizedBox(
                      height: 10,
                    ),

                    ///add address button
                    // SizedBox(
                    //   height: 60,
                    // ),
                    //
                    // Align(
                    //   alignment: Alignment.center,
                    //   child: Padding(
                    //     padding: const EdgeInsets.fromLTRB(60, 0, 0, 0),
                    //     child: Container(
                    //       width: MediaQuery.of(context).size.width / 1.5,
                    //       child: const Text(
                    //         "+ Add delivery instruction",
                    //         style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800, color: Colors.green),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),

              SizedBox(
                height: 30,
              ),

              ///Preferred delivery slot
              // Container(
              //   decoration: BoxDecoration(
              //     color: Colors.white,
              //     borderRadius: BorderRadius.circular(15),
              //     boxShadow: [
              //       BoxShadow(
              //         color: Colors.grey.withOpacity(0.15),
              //         spreadRadius: 5, //spread radius
              //         blurRadius: 5, // blur radius
              //         offset: Offset(0, 3),
              //       ),
              //     ],
              //   ),
              //   width: MediaQuery.of(context).size.width / 1.1,
              //   height: 130,
              //   child: Column(
              //     children: [
              //       Padding(
              //         padding: const EdgeInsets.only(top: 15),
              //       ),
              //       Align(
              //           alignment: Alignment.centerLeft,
              //           child: Padding(
              //             padding: const EdgeInsets.only(left: 15.0),
              //             child: const Text(
              //               "Preferred delivery slot",
              //               style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black),
              //             ),
              //           )),
              //       Row(
              //         mainAxisAlignment: MainAxisAlignment.spaceAround,
              //         children: [
              //           Padding(
              //             padding: const EdgeInsets.only(left: 10.0),
              //             child: Align(
              //                 alignment: Alignment.centerLeft,
              //                 child: Container(
              //                   width: MediaQuery.of(context).size.width / 2.5,
              //                   child: const Text(
              //                     "Delivered date :",
              //                     style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black),
              //                   ),
              //                 )),
              //           ),
              //           Padding(
              //             padding: const EdgeInsets.only(left: 10.0),
              //             child: Align(
              //                 alignment: Alignment.centerRight,
              //                 child: Container(
              //                     width: MediaQuery.of(context).size.width / 2.5,
              //                     child: const Text(
              //                       "Time slot :",
              //                       style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black),
              //                     ))),
              //           ),
              //         ],
              //       ),
              //       SizedBox(
              //         height: 10,
              //       ),
              //       Container(
              //         child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
              //           Padding(
              //             padding: const EdgeInsets.only(left: 8.0),
              //             child: Container(
              //               width: MediaQuery.of(context).size.width / 2.5,
              //               height: 40,
              //               decoration: BoxDecoration(
              //                   color: Colors.white,
              //                   // Red border with the width is equal to 5
              //                   border: Border.all(width: 1, color: Colors.black)),
              //               child: Row(
              //                 children: [
              //                   Container(
              //                     height: 20,
              //                     //width: 200,
              //                     child: Padding(
              //                       padding: const EdgeInsets.fromLTRB(4, 0, 7, 0),
              //                       child: Text(
              //                         "Today, 23 Sep ",
              //                         style: TextStyle(
              //                           color: Colors.black,
              //                           fontSize: 14,
              //                           fontWeight: FontWeight.w600,
              //                         ),
              //                       ),
              //                     ),
              //                   ),
              //                   Container(
              //                     height: 15,
              //                     width: 15,
              //                     child: Padding(
              //                       padding: const EdgeInsets.only(left: 0),
              //                       child: Image.asset(
              //                         "assets/ca.png",
              //                       ),
              //                     ),
              //                   ),
              //                 ],
              //               ),
              //             ),
              //           ),
              //           Container(
              //             width: MediaQuery.of(context).size.width / 2.5,
              //             height: 40,
              //             decoration: BoxDecoration(
              //                 color: Colors.white,
              //                 // Red border with the width is equal to 5
              //                 border: Border.all(width: 1, color: Colors.black)),
              //             child: Row(
              //               children: [
              //                 Padding(
              //                   padding: const EdgeInsets.fromLTRB(5, 0, 8, 0),
              //                   //width: 200,
              //                   child: Text(
              //                     "Tap to choose",
              //                     style: TextStyle(
              //                       color: Colors.black,
              //                       fontSize: 14,
              //                       fontWeight: FontWeight.w600,
              //                     ),
              //                   ),
              //                 ),
              //                 Container(
              //                   height: 15,
              //                   width: 15,
              //                   child: Padding(
              //                     padding: const EdgeInsets.only(top: 0),
              //                     child: Image.asset(
              //                       "assets/dr.png",
              //                     ),
              //                   ),
              //                 ),
              //               ],
              //             ),
              //           ),
              //         ]),
              //       )
              //     ],
              //   ),
              // ),

              SizedBox(
                height: 20,
              ),

              ///package information
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

                ///height: 785,
                height: 400,
                child: Column(children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 40),
                  ),

                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: const Text(
                        "Package Information",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Color(0xFF515151), fontFamily: "ceraProMedium"),
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 15,
                  ),

                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            //                   <--- left side
                            color: Colors.grey,
                            width: 1.5,
                          ),
                        ),
                      ),
                      //height: 300,
                      height: 44,
                      width: MediaQuery.of(context).size.width / 1,
                      child: TabBar(
                        isScrollable: true,
                        indicatorWeight: 4,
                        indicatorColor: kPrimaryColor,
                        controller: controller2,
                        tabs: [
                          Container(
                            child: Padding(
                              padding: EdgeInsets.only(right: 0.0),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 5.0),
                                    child: Image.asset(
                                      "assets/img_213.png",
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Store Package",
                                          style: TextStyle(
                                              color: Color(0xFF515151),
                                              fontSize: 14,
                                              fontFamily: "ceraProMedium",
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Text(
                                          "1 hr Delivery",
                                          style: TextStyle(
                                              color: Color(0xFFA299A8),
                                              fontSize: 12,
                                              fontFamily: "ceraProMedium",
                                              fontWeight: FontWeight.w500),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            width: 152,
                          ),
                          Container(
                            child: Padding(
                              padding: EdgeInsets.only(right: 0.0),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 5.0),
                                    child: Image.asset(
                                      "assets/img_214.png",
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Cloud Package",
                                          style: TextStyle(
                                              color: Color(0xFF515151),
                                              fontSize: 14,
                                              fontFamily: "ceraProMedium",
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Text(
                                          "Next Day Delivery",
                                          style: TextStyle(
                                              color: Color(0xFFA299A8),
                                              fontSize: 12,
                                              fontFamily: "ceraProMedium",
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            width: 152,
                          ),
                        ],
                      ),
                    ),
                  ),

                  Expanded(
                    child: TabBarView(
                      controller: controller2,
                      children: [
                        physical(physicalProducts),
                        cloud(cloudProducts),
                      ],
                    ),
                  ),

                  SizedBox(
                    height: 10,
                  ),

                  ///card image
                  /*
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

                   */
                  SizedBox(height: 20),

                  ///card number
                  /*
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
                   */
                ]),
              ),

              SizedBox(
                height: 35,
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

                ///height: 785,
                height: 350,
                child: Column(children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 40),
                  ),

                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: const Text(
                        "Payment Method",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black),
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 15,
                  ),

                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Container(
                      //height: 300,
                      height: 210,
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
                                        height: 40,
                                        width: MediaQuery.of(context).size.width / 7,
                                        child: Padding(
                                          padding: const EdgeInsets.only(left: 0),
                                          child: Image.network(
                                            paymentData[index].image,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: MediaQuery.of(context).size.width * 3 / 5,
                                        child: ListTile(
                                          title: Padding(
                                            padding: const EdgeInsets.only(left: 15.0),
                                            child: Text(
                                              paymentData[index].payment_type_key,
                                              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800, color: Colors.black),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        height: 15,
                                        width: 15,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle, border: Border.all(color: kBlackColor), color: Colors.black),
                                      ),
                                    ],
                                  )
                                : GestureDetector(
                                    onTap: () {
                                      paymentType = paymentData[index].payment_type_key;
                                      setState(() {
                                        value = index.toString();
                                      });
                                    },
                                    child: Row(
                                      children: [
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
                                        Container(
                                          width: MediaQuery.of(context).size.width * 3 / 5,
                                          child: ListTile(
                                            title: Padding(
                                              padding: const EdgeInsets.only(left: 15.0),
                                              child: Text(
                                                ///payment_type_key
                                                paymentData[index].payment_type_key,
                                                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800, color: Colors.black),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          height: 15,
                                          width: 15,
                                          decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: kBlackColor)),
                                        ),
                                      ],
                                    ),
                                  );
                          }),
                    ),
                  ),

                  SizedBox(
                    height: 10,
                  ),

                  ///card image
                  /*
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

                   */
                  SizedBox(height: 20),

                  ///card number
                  /*
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
                   */
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
                onTap: isLoading
                    ? () {}
                    : () {
                        setState(() {
                          isLoading = true;
                        });
                        orderCreate(
                          "${box.read(userID)}",
                          widget.ownerId,
                          paymentType,
                          selectedAddress,
                          widget.grandTotal,
                        ).then((value) {
                          setState(() {
                            isLoading = false;
                          });
                        });
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
                    child: isLoading
                        ? CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : Column(
                            children: [
                              Text(
                                widget.grandTotal,
                                style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w800),
                              ),
                              Text(
                                "Place Order",
                                style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w800),
                              ),
                            ],
                          ),
                  ),
                ),
              ),

              // GestureDetector(
              //   onTap: () {
              //     orderCreate("${box.read(userID)}", widget.ownerId, paymentType, selectedAddress, widget.grandTotal);
              //   },
              //   child: Container(
              //     width: MediaQuery.of(context).size.width / 1,
              //     height: 56,
              //     decoration: BoxDecoration(
              //       border: Border.all(
              //         width: 0.150,
              //         color: Colors.deepPurpleAccent,
              //       ),
              //       color: Color(0xFF9900FF),
              //       borderRadius: BorderRadius.circular(0),
              //       boxShadow: [
              //         BoxShadow(
              //           color: Colors.grey.withOpacity(0.1),
              //           spreadRadius: 5, //spread radius
              //           blurRadius: 5, // blur radius
              //           offset: Offset(0, 2),
              //         ),
              //       ],
              //     ),
              //     child: Center(
              //       child: Column(
              //         children: [
              //           Text(
              //             widget.grandTotal,
              //             style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w800),
              //           ),
              //           Text(
              //             "place order",
              //             style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w800),
              //           ),
              //         ],
              //       ),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  num totalPrice(List<dynamic> items) {
    num sum = 0;
    num discountTotal = 0;
    for (var item in items) {
      print("DISCOUNT: ${item.discount}");
      sum += item.price * item.quantity as int;
      discountTotal += item.discount ?? 0 * item.quantity;
    }
    return sum - discountTotal;
  }

  //controller.cartItemsList[index].productName
  physical(physicalProducts) {
    return Container(
      child: Container(
        width: MediaQuery.of(context).size.width / 1,
        //height: 290,
        color: Color(0xFFFFFFFF),
        child: Column(
          children: [
            Container(
              height: 188,
              width: double.infinity,
              child: ListView.builder(
                  itemCount: physicalProducts.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (_, index) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Container(
                        //height: 290,
                        width: 100,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              ///120
                              height: 70,
                              width: MediaQuery.of(context).size.width / 2.5,
                              child: Image.network(
                                imagePath + physicalProducts[index].productThumbnailImage,
                              ),
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: Container(
                                height: 45,
                                width: 110,
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(5, 4, 5, 0),
                                  child: Center(
                                    child: Text(
                                      physicalProducts[index].productName,
                                      style: TextStyle(
                                          color: Color(0xFF515151), fontSize: 12, fontWeight: FontWeight.w700, fontFamily: "ceraProMedium"),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: Container(
                                height: 10,
                                width: 60,
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: Center(
                                    child: physicalProducts[index].unit != null
                                        ? Text(
                                            physicalProducts[index].unit,
                                            style: TextStyle(
                                                color: Color(0xFF515151),
                                                fontSize: 11,
                                                fontWeight: FontWeight.w700,
                                                fontFamily: "ceraProMedium"),
                                          )
                                        : Text(""),
                                  ),
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: Container(
                                height: 20,
                                width: 50,
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: Center(
                                    child: Text(
                                      "${physicalProducts[index].currencySymbol}${physicalProducts[index].price}",
                                      style: TextStyle(
                                          color: Color(0xFF515151), fontSize: 11, fontWeight: FontWeight.w400, fontFamily: "ceraProMedium"),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 0, 15, 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // Text(
                  //   "Estimated Delivery :",
                  //   style: TextStyle(fontSize: 10, color: Color(0xFF515151), fontFamily: "ceraProMedium", fontWeight: FontWeight.w500),
                  // ),
                  Text(
                    "${physicalProducts.length.toString()} items",
                    style: TextStyle(fontSize: 10, color: Color(0xFF515151), fontFamily: "ceraProMedium", fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // Text(
                  //   " 3 P.M",
                  //   style: TextStyle(fontSize: 16, color: Color(0xFF515151), fontFamily: "ceraProMedium", fontWeight: FontWeight.w500),
                  // ),
                  Text(
                    "${totalPrice(physicalProducts).toString()} TK",
                    //"${totalPrice(cloudProducts).toString()} TK",
                    style: TextStyle(fontSize: 24, color: Color(0xFF515151), fontFamily: "ceraProMedium", fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  cloud(cloudProducts) {
    return Container(
      width: MediaQuery.of(context).size.width / 1,
      //height: 290,
      color: Color(0xFFFFFFFF),
      child: Column(
        children: [
          Container(
            height: 188,
            width: double.infinity,
            child: ListView.builder(
                itemCount: cloudProducts.length,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (_, index) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Container(
                      //height: 290,
                      width: 100,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            ///120
                            height: 70,
                            width: MediaQuery.of(context).size.width / 2.5,
                            child: Image.network(
                              imagePath + cloudProducts[index].productThumbnailImage,
                            ),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Container(
                              height: 45,
                              width: 110,
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(5, 4, 5, 0),
                                child: Center(
                                  child: Text(
                                    cloudProducts[index].productName,
                                    style: TextStyle(
                                        color: Color(0xFF515151), fontSize: 12, fontWeight: FontWeight.w700, fontFamily: "ceraProMedium"),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Container(
                              height: 20,
                              width: 60,
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                child: Center(
                                  child: cloudProducts[index].unit != null
                                      ? Text(
                                          cloudProducts[index].unit,
                                          style: TextStyle(
                                              color: Color(0xFF515151),
                                              fontSize: 11,
                                              fontWeight: FontWeight.w700,
                                              fontFamily: "ceraProMedium"),
                                        )
                                      : Text(""),
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Container(
                              height: 20,
                              width: 50,
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                child: Center(
                                  child: Text(
                                    "${cloudProducts[index].currencySymbol}${cloudProducts[index].price}",
                                    style: TextStyle(
                                        color: Color(0xFF515151), fontSize: 11, fontWeight: FontWeight.w400, fontFamily: "ceraProMedium"),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 0, 15, 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // Text(
                //   "Tomorrow 3 P.M",
                //   style: TextStyle(fontSize: 10, color: Color(0xFF515151), fontFamily: "ceraProMedium", fontWeight: FontWeight.w500),
                // ),
                Text(
                  "${cloudProducts.length.toString()} items",
                  style: TextStyle(fontSize: 10, color: Color(0xFF515151), fontFamily: "ceraProMedium", fontWeight: FontWeight.w700),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // Text(
                //   "3 p.m Thursday, Dec 15",
                //   style: TextStyle(fontSize: 16, color: Color(0xFF515151), fontFamily: "ceraProMedium", fontWeight: FontWeight.w500),
                // ),
                Text(
                  "${totalPrice(cloudProducts).toString()} TK",
                  style: TextStyle(fontSize: 24, color: Color(0xFF515151), fontFamily: "ceraProMedium", fontWeight: FontWeight.w700),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _swAddressBottoSheet(bool isUpdate, int addrId) {
    return showModalBottomSheet(
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
                    controller: userPostalCodeController,
                    autofocus: true,
                    onChanged: (value) {},
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
                    controller: userCountryController,
                    autofocus: true,
                    onChanged: (value) {},
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
                    controller: userPhoneController,
                    keyboardType: TextInputType.phone,
                    autofocus: true,
                    onChanged: (value) {},
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
                          onPressed: () {
                            Navigator.pop(context);
                            addUserAddress(
                              "${box.read(userID)}",
                              userAddressController.text,
                              userCountryController.text,
                              userCityController.text,
                              userPostalCodeController.text,
                              userPhoneController.text,
                              isUpdate,
                              addrId,
                            );
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
  }
}

// running
/*
import 'dart:convert';
import 'dart:developer';

import 'package:customer_ui/all_screen/payment_screen.dart';
import 'package:customer_ui/components/apis.dart';
import 'package:customer_ui/components/styles.dart';
import 'package:customer_ui/components/utils.dart';
import 'package:customer_ui/controller/cartItemsController.dart';
import 'package:customer_ui/dataModel/payment_method.dart';
import 'package:customer_ui/dataModel/show_user_model.dart';
import 'package:customer_ui/dataModel/user_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
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
  var controller = Get.put(CartItemsController());

  var value = " ";
  var addressValue = " ";
  bool isLoading = false;
  var formKey = GlobalKey<FormState>();
  String addr = "Please Add Your Address";
  var userInfoData = [];

  Future addressDeleteAPI(userID) async {
    var res = await http.get(Uri.parse("$addressDelete/$userID"),
        headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8', 'Authorization': 'Bearer ${box.read(userToken)}'});

    log("CART DELETE RESPONSE ${res.body}");

    if (res.statusCode == 200 || res.statusCode == 201) {
      showToast("Address delete Successfully", context: context);
      // await Get.find<CartItemsController>().getCartName();
      await getUserAddress(userID);

      setState(() {});
    }
  }

  Future<void> getUserInfo(userID) async {
    var res = await get(Uri.parse("$userInfoAPI$userID"),
        headers: {"Accept": "application/json", 'Authorization': 'Bearer ${box.read(userToken)}'});

    ///log("user info response ${res.body}");
    var dataMap = jsonDecode(res.body);
    if (res.statusCode == 200 || res.statusCode == 201) {
      var userInfoModel = UserInfoModel.fromJson(dataMap);

      ///userInfoModel.data[0].country

      userInfoData = userInfoModel.data;

      //print(userInfoData[0].address);
    }
  }

  Future<void> addUserAddress(userID, address, country, city, postalCode, phone, bool isUpdate, addressId) async {
    String targetUrl = isUpdate ? "http://test.protidin.com.bd:88/api/v2/update-address-in-cart" : addUserAddressAPI;

    log("new address id $addressId");
    log("target url $targetUrl");

    var bodyData = isUpdate
        ? jsonEncode(<String, dynamic>{
            "user_id": userID,
            "address": address,
            "address_id": addressId,
            "country": country,
            "city": city,
            "postal_code": postalCode,
            "phone": phone
          })
        : jsonEncode(<String, dynamic>{
            "user_id": userID,
            "address": address,
            "country": country,
            "city": city,
            "postal_code": postalCode,
            "phone": phone
          });

    var res = await post(
      Uri.parse(targetUrl),
      headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8', 'Authorization': 'Bearer ${box.read(userToken)}'},
      body: bodyData,
    );

    ///log("add user address response ${res.body}");

    if (res.statusCode == 200 || res.statusCode == 201) {
      showToast("Shipping information has been added successfully", context: context);
      await getUserAddress(userID);
    } else {
      showToast("Something went wrong", context: context);
    }

    setState(() {
      _userAddress = userAddressController.text;
      userCity = userCityController.text;
      userPostalCode = userPostalCodeController.text;
      userCountry = userCountryController.text;
      userPhone = userPhoneController.text;
    });
  }

  List<AddressData> userAddressData = [];
  var _userAddress = "";
  var userCity = "";
  var userCountry = "";
  var userPostalCode = "";
  var userPhone = "";
  var paymentType = "";

  var selectedAddress = "";

  Future<void> getUserAddress(userID) async {
    var res = await get(Uri.parse("$showAddressAPI/$userID"),
        headers: {"Accept": "application/json", 'Authorization': 'Bearer ${box.read(userToken)}'});

    ///log("user info response ${res.body}");
    var dataMap2 = jsonDecode(res.body);
    if (res.statusCode == 200 || res.statusCode == 201) {
      var userAddressModel = ShowUserAddressModel.fromJson(dataMap2);

      ///userInfoModel.data[0].country;
      userAddressData = userAddressModel.data;
      _userAddress = userAddressData[0].address!;

      box.write("Phone_Number", userPhone);

      //userCountry = userAddressData[0].country;
      print("Area ${userAddressData[0].address} city ${userAddressData[0].city}  Country ${userAddressData[0].country}");
      setState(() {});
    }
  }

  ///
  ///var paymentModel = [];
  var paymentData = [];

  Future<void> getPaymentTypes() async {
    var response = await get(Uri.parse("http://test.protidin.com.bd:88/api/v2/payment-types"), headers: <String, String>{
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

  Future<void> updateAddressInCart(userId, addressID) async {
    log("address ID $addressID");
    var jsonBody = (<String, dynamic>{"user_id": userId.toString(), "address_id": addressID.toString()});

    var res = await post(Uri.parse("http://test.protidin.com.bd:88/api/v2/update-address-in-cart"),
        headers: <String, String>{'Accept': 'application/json', 'Authorization': 'Bearer ${box.read(userToken)}'}, body: jsonBody);

    log("update address in cart ${res.body}");

    ///log("add user address response ${res.body}");

    if (res.statusCode == 200 || res.statusCode == 201) {
      var dataMap = jsonDecode(res.body);
    } else {
      showToast("Something went wrong", context: context);
    }
    setState(() {});
  }

  Future<void> orderCreate(userId, ownerID, paymentType, userAddress, grandTotal) async {
    log("CALLING");
    log("owner_ID $ownerID user id $userId payment type $paymentType");

    var jsonBody = (<String, dynamic>{
      "user_id": userId.toString(),
      "owner_id": ownerID.toString(),
      "payment_type_key": "cash_payment",
      "address": selectedAddress
    });

    var res = await post(Uri.parse(createOrderAPI),
        headers: <String, String>{'Accept': 'application/json', 'Authorization': 'Bearer ${box.read(userToken)}'}, body: jsonBody);

    log("after click place order ${res.body}");

    ///log("add user address response ${res.body}");

    if (res.statusCode == 200 || res.statusCode == 201) {
      showToast("Payment Successfull", context: context);

      var dataMap = jsonDecode(res.body);
      box.write(cart_item, '');
      controller.getCartName();
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => Payment_Screen(
                    orderNo: dataMap["order_id"].toString(),
                    address: userAddress,
                    paymentTypes: paymentType,
                    grandTotal: grandTotal.toString(),
                  )));
    } else {
      showToast("Something went wrong", context: context);
    }
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    log("Grand Total ${widget.grandTotal} and owner Id ${widget.ownerId}");
    getUserInfo(box.read(userID));
    getUserAddress(box.read(userID));
    // updateAddressInCart(11);
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
              //height: 480 ,
              height: 500,
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: const Text(
                              "Delivered to",
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black),
                            ),
                          )),
                      Padding(
                        padding: const EdgeInsets.only(left: 80.0),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            //primary: Color(0xFF9900FF),
                            primary: Colors.white,
                            //side: BorderSide(width:3, color:Colors.brown), //border width and color
                            elevation: 1.5, //elevation of button

                            padding: EdgeInsets.all(10) //content padding inside button
                            ),
                        onPressed: () {
                          _swAddressBottoSheet(false, -1);
                        },
                        child: Container(
                            height: 20,
                            width: 20,
                            //height: 190,
                            //width: 200,
                            child: Image.asset(
                              "assets/img_47.png",
                              fit: BoxFit.cover,
                            )),
                      ),
                    ],
                  ),

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

                  ///address list
                  Container(
                    //height: 120,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(12, 0, 0, 10),
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        itemCount: userAddressData.length,
                        itemBuilder: (_, index) {
                          return addressValue == index.toString()
                              ? Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(left: 10.0),
                                      ),
                                      Container(
                                        height: 15,
                                        width: 15,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle, border: Border.all(color: kBlackColor), color: kPrimaryColor),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 10.0),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(6.0),
                                        child: Container(
                                          child: Text(
                                            "${userAddressData[index].address},${userAddressData[index].city},${userAddressData[index].postalCode},${userAddressData[index].country},${userAddressData[index].phone},",
                                            style: TextStyle(fontWeight: FontWeight.w500),
                                          ),
                                          width: MediaQuery.of(context).size.width / 1.8,
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          userAddressController.text = userAddressData[index].address!;
                                          userCityController.text = userAddressData[index].city!;
                                          userPostalCodeController.text = userAddressData[index].postalCode!;
                                          userCountryController.text = userAddressData[index].country!;
                                          userPhoneController.text = userAddressData[index].phone!;
                                          //updateAddressInCart(box.read(userID), userAddressData[index].id);
                                          print("ADDR_ID: ${userAddressData[index].id}");
                                          _swAddressBottoSheet(true, userAddressData[index].id);
                                        },
                                        child: Container(
                                          height: 15,
                                          width: 15,
                                          child: Padding(
                                            padding: const EdgeInsets.only(left: 0),
                                            child: Image.asset(
                                              "assets/img_60.png",
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 20.0),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          addressDeleteAPI(userAddressData[index].userId);

                                          ///updateAddressInCart(box.read(userID), userAddressData[index].id);
                                        },
                                        child: Container(
                                          height: 25,
                                          width: 25,
                                          child: Padding(
                                            padding: const EdgeInsets.only(left: 0),
                                            child: Image.asset(
                                              "assets/img_106.png",
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : GestureDetector(
                                  onTap: () {
                                    ///updateAddressInCart(box.read(userID), userAddressData[index].id);
                                    selectedAddress =
                                        ("${userAddressData[index].address},${userAddressData[index].city},${userAddressData[index].postalCode},${userAddressData[index].country},${userAddressData[index].phone}");
                                    log(selectedAddress);
                                    box.write(account_userAddress, selectedAddress);
                                    setState(() {
                                      addressValue = index.toString();
                                    });
                                  },
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(left: 10.0),
                                      ),
                                      Container(
                                        height: 15,
                                        width: 15,
                                        decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: kBlackColor)),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 10.0),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(6.0),
                                        child: Container(
                                          child: Text(
                                            "${userAddressData[index].address},${userAddressData[index].city},${userAddressData[index].postalCode},${userAddressData[index].country},${userAddressData[index].phone},",
                                            style: TextStyle(fontWeight: FontWeight.w500),
                                          ),
                                          width: MediaQuery.of(context).size.width / 1.8,
                                        ),
                                      ),
                                      Container(
                                        height: 15,
                                        width: 15,
                                        child: Padding(
                                          padding: const EdgeInsets.only(left: 0),
                                          child: Image.asset(
                                            "assets/img_60.png",
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 20.0),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          addressDeleteAPI(userAddressData[index].userId);

                                          ///updateAddressInCart(box.read(userID), userAddressData[index].id);
                                        },
                                        child: Container(
                                          height: 25,
                                          width: 25,
                                          child: Padding(
                                            padding: const EdgeInsets.only(left: 0),
                                            child: Image.asset(
                                              "assets/img_106.png",
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                        },
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 10,
                  ),

                  ///add address button
                  SizedBox(
                    height: 60,
                  ),

                  Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(60, 0, 0, 0),
                      child: Container(
                        width: MediaQuery.of(context).size.width / 1.5,
                        child: const Text(
                          "+ Add delivery instruction",
                          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800, color: Colors.green),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(
              height: 30,
            ),

            ///Preferred delivery slot
            // Container(
            //   decoration: BoxDecoration(
            //     color: Colors.white,
            //     borderRadius: BorderRadius.circular(15),
            //     boxShadow: [
            //       BoxShadow(
            //         color: Colors.grey.withOpacity(0.15),
            //         spreadRadius: 5, //spread radius
            //         blurRadius: 5, // blur radius
            //         offset: Offset(0, 3),
            //       ),
            //     ],
            //   ),
            //   width: MediaQuery.of(context).size.width / 1.1,
            //   height: 130,
            //   child: Column(
            //     children: [
            //       Padding(
            //         padding: const EdgeInsets.only(top: 15),
            //       ),
            //       Align(
            //           alignment: Alignment.centerLeft,
            //           child: Padding(
            //             padding: const EdgeInsets.only(left: 15.0),
            //             child: const Text(
            //               "Preferred delivery slot",
            //               style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black),
            //             ),
            //           )),
            //       Row(
            //         mainAxisAlignment: MainAxisAlignment.spaceAround,
            //         children: [
            //           Padding(
            //             padding: const EdgeInsets.only(left: 10.0),
            //             child: Align(
            //                 alignment: Alignment.centerLeft,
            //                 child: Container(
            //                   width: MediaQuery.of(context).size.width / 2.5,
            //                   child: const Text(
            //                     "Delivered date :",
            //                     style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black),
            //                   ),
            //                 )),
            //           ),
            //           Padding(
            //             padding: const EdgeInsets.only(left: 10.0),
            //             child: Align(
            //                 alignment: Alignment.centerRight,
            //                 child: Container(
            //                     width: MediaQuery.of(context).size.width / 2.5,
            //                     child: const Text(
            //                       "Time slot :",
            //                       style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black),
            //                     ))),
            //           ),
            //         ],
            //       ),
            //       SizedBox(
            //         height: 10,
            //       ),
            //       Container(
            //         child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            //           Padding(
            //             padding: const EdgeInsets.only(left: 8.0),
            //             child: Container(
            //               width: MediaQuery.of(context).size.width / 2.5,
            //               height: 40,
            //               decoration: BoxDecoration(
            //                   color: Colors.white,
            //                   // Red border with the width is equal to 5
            //                   border: Border.all(width: 1, color: Colors.black)),
            //               child: Row(
            //                 children: [
            //                   Container(
            //                     height: 20,
            //                     //width: 200,
            //                     child: Padding(
            //                       padding: const EdgeInsets.fromLTRB(4, 0, 7, 0),
            //                       child: Text(
            //                         "Today, 23 Sep ",
            //                         style: TextStyle(
            //                           color: Colors.black,
            //                           fontSize: 14,
            //                           fontWeight: FontWeight.w600,
            //                         ),
            //                       ),
            //                     ),
            //                   ),
            //                   Container(
            //                     height: 15,
            //                     width: 15,
            //                     child: Padding(
            //                       padding: const EdgeInsets.only(left: 0),
            //                       child: Image.asset(
            //                         "assets/ca.png",
            //                       ),
            //                     ),
            //                   ),
            //                 ],
            //               ),
            //             ),
            //           ),
            //           Container(
            //             width: MediaQuery.of(context).size.width / 2.5,
            //             height: 40,
            //             decoration: BoxDecoration(
            //                 color: Colors.white,
            //                 // Red border with the width is equal to 5
            //                 border: Border.all(width: 1, color: Colors.black)),
            //             child: Row(
            //               children: [
            //                 Padding(
            //                   padding: const EdgeInsets.fromLTRB(5, 0, 8, 0),
            //                   //width: 200,
            //                   child: Text(
            //                     "Tap to choose",
            //                     style: TextStyle(
            //                       color: Colors.black,
            //                       fontSize: 14,
            //                       fontWeight: FontWeight.w600,
            //                     ),
            //                   ),
            //                 ),
            //                 Container(
            //                   height: 15,
            //                   width: 15,
            //                   child: Padding(
            //                     padding: const EdgeInsets.only(top: 0),
            //                     child: Image.asset(
            //                       "assets/dr.png",
            //                     ),
            //                   ),
            //                 ),
            //               ],
            //             ),
            //           ),
            //         ]),
            //       )
            //     ],
            //   ),
            // ),

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

              ///height: 785,
              height: 350,
              child: Column(children: [
                Padding(
                  padding: const EdgeInsets.only(top: 40),
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
                    //height: 300,
                    height: 210,
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
                                      height: 40,
                                      width: MediaQuery.of(context).size.width / 7,
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 0),
                                        child: Image.network(
                                          paymentData[index].image,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width * 3 / 5,
                                      child: ListTile(
                                        title: Padding(
                                          padding: const EdgeInsets.only(left: 15.0),
                                          child: Text(
                                            paymentData[index].payment_type_key,
                                            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800, color: Colors.black),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 15,
                                      width: 15,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle, border: Border.all(color: kBlackColor), color: Colors.black),
                                    ),
                                  ],
                                )
                              : GestureDetector(
                                  onTap: () {
                                    paymentType = paymentData[index].payment_type_key;
                                    setState(() {
                                      value = index.toString();
                                    });
                                  },
                                  child: Row(
                                    children: [
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
                                      Container(
                                        width: MediaQuery.of(context).size.width * 3 / 5,
                                        child: ListTile(
                                          title: Padding(
                                            padding: const EdgeInsets.only(left: 15.0),
                                            child: Text(
                                              ///payment_type_key
                                              paymentData[index].payment_type_key,
                                              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800, color: Colors.black),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        height: 15,
                                        width: 15,
                                        decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: kBlackColor)),
                                      ),
                                    ],
                                  ),
                                );
                        }),
                  ),
                ),

                SizedBox(
                  height: 10,
                ),

                ///card image
                /*
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

                 */
                SizedBox(height: 20),

                ///card number
                /*
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
                 */
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
              onTap: isLoading
                  ? () {}
                  : () {
                      setState(() {
                        isLoading = true;
                      });
                      orderCreate(
                        "${box.read(userID)}",
                        widget.ownerId,
                        paymentType,
                        selectedAddress,
                        widget.grandTotal,
                      ).then((value) {
                        setState(() {
                          isLoading = false;
                        });
                      });
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
                  child: isLoading
                      ? CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : Column(
                          children: [
                            Text(
                              widget.grandTotal,
                              style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w800),
                            ),
                            Text(
                              "Place Order",
                              style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w800),
                            ),
                          ],
                        ),
                ),
              ),
            ),

            // GestureDetector(
            //   onTap: () {
            //     orderCreate("${box.read(userID)}", widget.ownerId, paymentType, selectedAddress, widget.grandTotal);
            //   },
            //   child: Container(
            //     width: MediaQuery.of(context).size.width / 1,
            //     height: 56,
            //     decoration: BoxDecoration(
            //       border: Border.all(
            //         width: 0.150,
            //         color: Colors.deepPurpleAccent,
            //       ),
            //       color: Color(0xFF9900FF),
            //       borderRadius: BorderRadius.circular(0),
            //       boxShadow: [
            //         BoxShadow(
            //           color: Colors.grey.withOpacity(0.1),
            //           spreadRadius: 5, //spread radius
            //           blurRadius: 5, // blur radius
            //           offset: Offset(0, 2),
            //         ),
            //       ],
            //     ),
            //     child: Center(
            //       child: Column(
            //         children: [
            //           Text(
            //             widget.grandTotal,
            //             style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w800),
            //           ),
            //           Text(
            //             "place order",
            //             style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w800),
            //           ),
            //         ],
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  _swAddressBottoSheet(bool isUpdate, int addrId) {
    return showModalBottomSheet(
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
                    controller: userPostalCodeController,
                    autofocus: true,
                    onChanged: (value) {},
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
                    controller: userCountryController,
                    autofocus: true,
                    onChanged: (value) {},
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
                    controller: userPhoneController,
                    keyboardType: TextInputType.phone,
                    autofocus: true,
                    onChanged: (value) {},
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
                          onPressed: () {
                            Navigator.pop(context);
                            addUserAddress(
                              "${box.read(userID)}",
                              userAddressController.text,
                              userCountryController.text,
                              userCityController.text,
                              userPostalCodeController.text,
                              userPhoneController.text,
                              isUpdate,
                              addrId,
                            );
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
  }
}

*/
