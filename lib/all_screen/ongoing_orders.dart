import 'dart:convert';
import 'dart:developer';

import 'package:customer_ui/all_screen/purchase_details.dart';
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
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "You have 1 (one) delivery in progress",
              style: TextStyle(color: Colors.grey),
            ),
            Container(
              padding: EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.2),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Transaction ID",
                            style: TextStyle(color: Colors.grey),
                          ),
                          Text(
                            purchaseData.last.code,
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Amount",
                            style: TextStyle(color: Colors.grey),
                          ),
                          Text(
                            purchaseData.last.grandTotal,
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Payment status",
                            style: TextStyle(color: Colors.grey),
                          ),
                          Text(
                            purchaseData.last.paymentStatus,
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
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
                                purchaseData.last.userId.toString(),
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
                    padding: const EdgeInsets.only(left: 15.0),
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
                            Align(
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
                  Align(
                    alignment: Alignment.center,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Details(
                                      link: purchaseData.last.links.details,
                                    )));

                        ///Navigator.push(context, MaterialPageRoute(builder: (context) => TrackOrder()));
                      },
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
                        height: 45,
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
                ],
              ),
            )
          ],
        ),
      ),
      /* body: SingleChildScrollView(
            child: Column(children: [
          SizedBox(
            height: 35,
          ),
          Center(
            child: Container(
              height: 25,
              //width: 230,
              child: Text(
                "My Orders",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.black),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              //height: 25,
              //width: 230,
              width: MediaQuery.of(context).size.width / 1.2,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                child: Text(
                  "You have 1(one) delivery in-Progress.",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.grey),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            width: MediaQuery.of(context).size.width / 1.2,
            height: 290,
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width / 1.3,
                    child: FittedBox(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            //width: MediaQuery.of(context).size.width / 3,
                            width: MediaQuery.of(context).size.width / 2.5,
                            child: Column(
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Transaction ID",
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
                                    "$transactionID",
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
                          Container(
                            width: MediaQuery.of(context).size.width / 4,
                            child: Column(
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Amount",
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
                                    grandTotal,
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
                          Container(
                            width: MediaQuery.of(context).size.width / 4,
                            child: Column(
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Payment",
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
                                    paymentStatus,
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
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
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
                              name,
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
                  padding: const EdgeInsets.only(left: 15.0),
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
                          Align(
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
                    onTap: () {
                      ///Navigator.push(context, MaterialPageRoute(builder: (context) => TrackOrder()));
                    },
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
                      height: 50,
                      width: MediaQuery.of(context).size.width / 1.7,
                      child: Padding(
                        padding: const EdgeInsets.all(0),
                        child: Center(
                          child: Text(
                            "Track Order",
                            style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w900),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ]))*/
    );
  }
}
