import 'dart:convert';
import 'dart:developer';

import 'package:customer_ui/components/apis.dart';
import 'package:customer_ui/components/utils.dart';
import 'package:customer_ui/dataModel/purchase_history_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

//import 'Language.dart';

class OngoingOrder extends StatefulWidget {
  const OngoingOrder({Key? key}) : super(key: key);

  @override
  _OngoingOrderState createState() => _OngoingOrderState();
}

class _OngoingOrderState extends State<OngoingOrder> {
  var transactionID = "";
  var grandTotal = "";
  var paymentStatus = "";
  var name = "";
  var address = "";
  List<PurchaseData> purchaseData = [];

  Future<void> getPurchaseHistory() async {
    log("calling 2");

    final response6 = await get(Uri.parse("$purchaseHistory/${box.read(userID)}"), headers: {"Accept": "application/json"});

    log("Histoty Resposne ${response6.body}");

    if (response6.statusCode == 200) {
      var dataMap = jsonDecode(response6.body);
      var data = UserPurchaseHistory.fromJson(dataMap);
      purchaseData = data.data!;
      log("last data ${purchaseData.last.code}");

      setState(() {});
    } else {
      log("data invalid");
    }

    // log("after decode $dataMap");
  }

  @override
  void initState() {
    getPurchaseHistory();
    // TODO: implement initState
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width / 1,
          padding: EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10,
              ),
              Container(
                width: MediaQuery.of(context).size.width / 1.0,
                decoration: BoxDecoration(
                  color: Color(0xFFF5F2F5),
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 4.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Order No #${purchaseData.last.code}",
                              style: TextStyle(
                                  color: Color(0xFF515151), fontSize: 16, fontWeight: FontWeight.w500, fontFamily: "CeraProMedium"),
                            ),
                            Text(
                              purchaseData.last.paymentStatus,
                              style: TextStyle(
                                  color: Color(0xFFFFB200), fontSize: 16, fontWeight: FontWeight.w500, fontFamily: "CeraProMedium"),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width / 3,
                            child: Text(
                              purchaseData.last.date,
                              style: TextStyle(
                                  color: Color(0xFF515151), fontSize: 12, fontWeight: FontWeight.w500, fontFamily: "CeraProMedium"),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 75.0),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width / 10,
                                child: Image.asset(
                                  "assets/img_194.png",
                                  height: 20,
                                  width: 20,
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width / 10,
                                child: Padding(
                                  padding: const EdgeInsets.all(0.0),
                                  child: Image.asset(
                                    "assets/img_196.png",
                                    height: 20,
                                    width: 20,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "TK ${purchaseData.last.grandTotal}",
                          style:
                              TextStyle(color: Color(0xFF515151), fontSize: 16, fontWeight: FontWeight.w500, fontFamily: "CeraProMedium"),
                        ),
                      ),

                      SizedBox(
                        height: 10,
                      ),

                      Container(
                        width: MediaQuery.of(context).size.width / 1.2,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              "assets/img_197.png",
                              height: 15,
                              width: 15,
                            ),
                            Text(
                              "- - - - - -",
                              style: TextStyle(color: Color(0xFF9900FF), fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                            Image.asset(
                              "assets/img_197.png",
                              height: 15,
                              width: 15,
                            ),
                            Text(
                              "- - - - - -",
                              style: TextStyle(color: Color(0xFF9900FF), fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                            Image.asset(
                              "assets/img_197.png",
                              height: 15,
                              width: 15,
                            ),
                            Text(
                              "- - - - - -",
                              style: TextStyle(color: Color(0xFF9900FF), fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                            Image.asset(
                              "assets/img_197.png",
                              height: 15,
                              width: 15,
                            ),
                            Text(
                              "- - - - - -",
                              style: TextStyle(color: Color(0xFF9900FF), fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                            Image.asset(
                              "assets/img_197.png",
                              height: 15,
                              width: 15,
                              color: Colors.grey,
                            ),
                          ],
                        ),
                      ),

                      SizedBox(
                        height: 10,
                      ),

                      Container(
                        width: MediaQuery.of(context).size.width / 1,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              purchaseData.last.deliveryStatus,
                              style: TextStyle(
                                  color: Color(0xFF515151), fontSize: 12, fontWeight: FontWeight.w500, fontFamily: "CeraProMedium"),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 15.0),
                              child: Text(purchaseData.last.deliveryStatus,
                                  style: TextStyle(
                                      color: Color(0xFF515151), fontSize: 12, fontWeight: FontWeight.w500, fontFamily: "CeraProMedium")),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 18.0),
                              child: Text(purchaseData.last.deliveryStatus,
                                  style: TextStyle(
                                      color: Color(0xFF515151), fontSize: 12, fontWeight: FontWeight.w500, fontFamily: "CeraProMedium")),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 0.0),
                              child: Text(purchaseData.last.deliveryStatus,
                                  style: TextStyle(
                                      color: Color(0xFF515151), fontSize: 12, fontWeight: FontWeight.w500, fontFamily: "CeraProMedium")),
                            ),
                            Text(purchaseData.last.deliveryStatus,
                                style: TextStyle(
                                    color: Color(0xFF515151), fontSize: 12, fontWeight: FontWeight.w500, fontFamily: "CeraProMedium")),
                          ],
                        ),
                      ),

                      // Align(
                      //   alignment: Alignment.center,
                      //   child: InkWell(
                      //     // onTap: () {
                      //     //   Navigator.push(
                      //     //       context,
                      //     //       MaterialPageRoute(
                      //     //           builder: (context) => Details(
                      //     //                 link: purchaseData.last.links.details,
                      //     //               )));
                      //     //
                      //     //   ///Navigator.push(context, MaterialPageRoute(builder: (context) => TrackOrder()));
                      //     // },
                      //     child: Container(
                      //       decoration: BoxDecoration(
                      //         color: Colors.purpleAccent[700],
                      //         borderRadius: BorderRadius.circular(25),
                      //         boxShadow: const [
                      //           BoxShadow(
                      //             color: Colors.white,
                      //           ),
                      //         ],
                      //       ),
                      //       //color: Colors.green,
                      //       height: 40,
                      //       width: MediaQuery.of(context).size.width / 1.7,
                      //       child: Padding(
                      //         padding: const EdgeInsets.all(0),
                      //         child: Center(
                      //           child: Text(
                      //             "Details",
                      //             style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w900),
                      //           ),
                      //         ),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      SizedBox(
                        height: 15,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }
}

/*
import 'dart:convert';
import 'dart:developer';

import 'package:customer_ui/components/apis.dart';
import 'package:customer_ui/components/utils.dart';
import 'package:customer_ui/dataModel/purchase_history_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

//import 'Language.dart';

class OngoingOrder extends StatefulWidget {
  const OngoingOrder({Key? key}) : super(key: key);

  @override
  _OngoingOrderState createState() => _OngoingOrderState();
}

class _OngoingOrderState extends State<OngoingOrder> {
  var transactionID = "";
  var grandTotal = "";
  var paymentStatus = "";
  var name = "";
  var address = "";
  List<PurchaseData> purchaseData = [];

  Future<void> getPurchaseHistory() async {
    log("calling 2");

    final response6 = await get(Uri.parse("$purchaseHistory/${box.read(userID)}"), headers: {"Accept": "application/json"});

    log("Histoty Resposne ${response6.body}");

    if (response6.statusCode == 200) {
      var dataMap = jsonDecode(response6.body);
      var data = UserPurchaseHistory.fromJson(dataMap);
      purchaseData = data.data!;
      log("last data ${purchaseData.last.code}");

      setState(() {});
    } else {
      log("data invalid");
    }

    // log("after decode $dataMap");
  }

  @override
  void initState() {
    getPurchaseHistory();
    // TODO: implement initState
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width / 1,
          padding: EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10,
              ),
              Text(
                "You have 1 (one) delivery in progress",
                style: TextStyle(color: Colors.grey),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: MediaQuery.of(context).size.width / 1.0,
                padding: EdgeInsets.all(5.0),
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 4.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Transaction ID",
                                style: TextStyle(color: Colors.grey),
                              ),
                              Text(
                                purchaseData.last.code,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(5, 3, 5, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Amount",
                                style: TextStyle(color: Colors.grey),
                              ),
                              Text(
                                purchaseData.last.grandTotal,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 2.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Payment status",
                                style: TextStyle(color: Colors.grey),
                              ),
                              Text(
                                purchaseData.last.paymentStatus,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          width: MediaQuery.of(context).size.width / 2,
                          child: Column(
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Buyer",
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  box.read(userName),
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          width: MediaQuery.of(context).size.width / 2,
                          child: Column(
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Address",
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              box.read(account_userAddress) == null
                                  ? Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w900,
                                        ),
                                      ),
                                    )
                                  : Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        box.read(account_userAddress),
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w900,
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
                    Align(
                      alignment: Alignment.center,
                      child: InkWell(
                        // onTap: () {
                        //   Navigator.push(
                        //       context,
                        //       MaterialPageRoute(
                        //           builder: (context) => Details(
                        //                 link: purchaseData.last.links.details,
                        //               )));
                        //
                        //   ///Navigator.push(context, MaterialPageRoute(builder: (context) => TrackOrder()));
                        // },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.purpleAccent[700],
                            borderRadius: BorderRadius.circular(25),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.white,
                              ),
                            ],
                          ),
                          //color: Colors.green,
                          height: 40,
                          width: MediaQuery.of(context).size.width / 1.7,
                          child: Padding(
                            padding: const EdgeInsets.all(0),
                            child: Center(
                              child: Text(
                                "Details",
                                style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w900),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }
}

*/
