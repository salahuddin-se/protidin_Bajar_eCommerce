import 'dart:convert';
import 'dart:developer';

import 'package:customer_ui/components/apis.dart';
import 'package:customer_ui/components/utils.dart';
import 'package:customer_ui/dataModel/purchase_history_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import 'purchase_details.dart';

class HistoryOrder extends StatefulWidget {
  const HistoryOrder({Key? key}) : super(key: key);

  @override
  _HistoryOrderState createState() => _HistoryOrderState();
}

class _HistoryOrderState extends State<HistoryOrder> {
  List<PurchaseData> purchaseDataList = [];

  Future<void> getPurchaseHistoryList() async {
    log("calling 2");
    final response6 = await get(Uri.parse("$purchaseHistory/${box.read(userID)}"), headers: {"Accept": "application/json"});

    log("Histoty Resposne ${response6.body}");

    if (response6.statusCode == 200) {
      var dataMap = jsonDecode(response6.body);
      var data = UserPurchaseHistory.fromJson(dataMap);
      purchaseDataList = data.data!;

      setState(() {});
    } else {
      log("data invalid");
    }

    // log("after decode $dataMap");
  }

  @override
  void initState() {
    getPurchaseHistoryList();
    // TODO: implement initState
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: purchaseDataList.length,
        itemBuilder: (_, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: MediaQuery.of(context).size.width / 1.3,
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
                      width: MediaQuery.of(context).size.width / 1.2,
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
                                      purchaseDataList[index].code,
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
                                      purchaseDataList[index].grandTotal,
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
                                      purchaseDataList[index].paymentStatus,
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
                                purchaseDataList[index].userId.toString(),
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
                    height: 25,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Details(
                                      link: purchaseDataList[index].links.details,
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
            ),
          );
        },
      ),
    );
  }
}

/*
import 'dart:convert';
import 'dart:developer';

import 'package:customer_ui/all_screen/purchase_details.dart';
import 'package:customer_ui/components/apis.dart';
import 'package:customer_ui/components/utils.dart';
import 'package:customer_ui/dataModel/purchase_history_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class HistoryOrder extends StatefulWidget {
  const HistoryOrder({Key? key}) : super(key: key);

  @override
  _HistoryOrderState createState() => _HistoryOrderState();
}

class _HistoryOrderState extends State<HistoryOrder> {
  List<PurchaseData> purchaseDataList = [];

  Future<void> getPurchaseHistoryList() async {
    log("calling 2");
    final response6 = await get(Uri.parse("$purchaseHistory/${box.read(userID)}"), headers: {"Accept": "application/json"});

    log("Histoty Resposne ${response6.body}");

    if (response6.statusCode == 200) {
      var dataMap = jsonDecode(response6.body);
      var data = UserPurchaseHistory.fromJson(dataMap);
      purchaseDataList = data.data!;

      setState(() {});
    } else {
      log("data invalid");
    }

    // log("after decode $dataMap");
  }

  @override
  void initState() {
    getPurchaseHistoryList();
    // TODO: implement initState
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: purchaseDataList.length,
        itemBuilder: (_, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => Details(link: purchaseDataList[index].links.details)));
            },
            child: Container(
              child: Column(
                children: [Text("${purchaseDataList[index].code}")],
              ),
            ),
          );
        },
      ),
    );
  }
}

*/
