import 'dart:convert';
import 'dart:developer';

import 'package:customer_ui/components/apis.dart';
import 'package:customer_ui/components/utils.dart';
import 'package:customer_ui/dataModel/purchase_history.dart';
import 'package:customer_ui/widgets/order_item.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

//import 'Language.dart';
class OngoingOrder extends StatefulWidget {
  const OngoingOrder({Key? key}) : super(key: key);

  @override
  _OngoingOrderState createState() => _OngoingOrderState();
}

class _OngoingOrderState extends State<OngoingOrder> {
  // var transactionID = "";
  // var grandTotal = "";
  // var grand_Total = "";
  // var ownerId = 0;
  //
  // var paymentStatus = "";
  // var name = "";
  // var address = "";

  List<Data> purchaseData = [];
  bool isLoading = false;

  List all = [];
  Future<void> getPurchaseHistory() async {
    setState(
      () {
        isLoading = true;
      },
    );
    log("calling 2");

    final response6 = await get(Uri.parse("$purchaseHistory/${box.read(userID)}"), headers: {"Accept": "application/json"});

    log("Histoty Resposne ${response6.body}");

    if (response6.statusCode == 200) {
      var dataMap = jsonDecode(response6.body);
      var data = PurchaseHistory.fromJson(dataMap);

      purchaseData = data.data;
      all = purchaseData.where((element) => element.parentId == 0).toList();
      /*
      List allCategoryProducts = [];
      List<ProductsData> prodData = biscuitSweetsDataModel.data;
      allCategoryProducts = prodData.where((element) => element.userId == box.read(user_Id) || element.userId == box.read(webStoreId)).toList();
      */

      //purchaseData = data.data.skip(1).toList();
      // log("last data ${purchaseData.last.code}");

      setState(() {
        isLoading = false;
      });
    } else {
      log("data invalid");
    }

    // log("after decode $dataMap");
  }

  @override
  void initState() {
    super.initState();
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
        padding: EdgeInsets.all(0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 15,
            ),
            // Padding(
            //   padding: const EdgeInsets.fromLTRB(10, 0, 7, 0),
            //   child: Container(
            //     width: MediaQuery.of(context).size.width / 1,
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //       children: [
            //         Container(
            //           decoration: BoxDecoration(
            //             borderRadius: BorderRadius.circular(10),
            //             color: Color(0xFFF5F2F5),
            //           ),
            //           width: MediaQuery.of(context).size.width / 2.6,
            //           height: 42,
            //           child: TextFormField(
            //             //textAlign: TextAlign.center,
            //             decoration: InputDecoration(
            //                 border: InputBorder.none,
            //                 focusedBorder: InputBorder.none,
            //                 contentPadding: EdgeInsets.only(left: 0, bottom: 5, top: 7, right: 5),
            //                 hintText: 'Order No',
            //                 prefixIcon: Padding(
            //                   padding: const EdgeInsets.only(left: 5),
            //                   child: Icon(Icons.search),
            //                 )),
            //           ),
            //         ),
            //         Container(
            //           decoration: BoxDecoration(
            //             borderRadius: BorderRadius.circular(10),
            //             color: Color(0xFFF5F2F5),
            //           ),
            //           height: 39,
            //           width: MediaQuery.of(context).size.width / 2.5,
            //           child: Row(
            //             mainAxisAlignment: MainAxisAlignment.spaceAround,
            //             children: [
            //               Container(
            //                 child: Image.asset(
            //                   "assets/img_187.png",
            //                   height: 22,
            //                   width: 22,
            //                 ),
            //                 height: 22,
            //                 width: 22,
            //               ),
            //               Text(
            //                 "Price",
            //                 style: TextStyle(
            //                   color: kBlackColor,
            //                   fontSize: 13,
            //                   fontWeight: FontWeight.w500,
            //                   fontFamily: 'CeraProMedium',
            //                 ),
            //               ),
            //               Container(
            //                 child: Image.asset(
            //                   "assets/img_188.png",
            //                   height: 15,
            //                   width: 15,
            //                 ),
            //                 height: 15,
            //                 width: 15,
            //               ),
            //             ],
            //           ),
            //         ),
            //         Container(
            //           child: Image.asset(
            //             "assets/img_189.png",
            //             height: 22,
            //             width: 22,
            //           ),
            //           height: 22,
            //           width: 22,
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            // SizedBox(
            //   height: 15,
            // ),
            Expanded(
              child: isLoading
                  ? Center()
                  : ListView.builder(
                      itemCount: all.length,
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (ctx, idx) => OrderItemWidget(
                        purchaseData: all[idx],
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
import 'package:customer_ui/dataModel/purchase_history.dart';
import 'package:customer_ui/widgets/order_item.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

//import 'Language.dart';
class OngoingOrder extends StatefulWidget {
  const OngoingOrder({Key? key}) : super(key: key);

  @override
  _OngoingOrderState createState() => _OngoingOrderState();
}

class _OngoingOrderState extends State<OngoingOrder> {
  // var transactionID = "";
  // var grandTotal = "";
  // var grand_Total = "";
  // var ownerId = 0;
  //
  // var paymentStatus = "";
  // var name = "";
  // var address = "";

  List<Data> purchaseData = [];
  bool isLoading = false;

  Future<void> getPurchaseHistory() async {
    setState(
      () {
        isLoading = true;
      },
    );
    log("calling 2");

    final response6 = await get(Uri.parse("$purchaseHistory/${box.read(userID)}"), headers: {"Accept": "application/json"});

    log("Histoty Resposne ${response6.body}");

    if (response6.statusCode == 200) {
      var dataMap = jsonDecode(response6.body);
      var data = PurchaseHistory.fromJson(dataMap);

      purchaseData = data.data.skip(1).toList();

      /*
      List allCategoryProducts = [];
      List<ProductsData> prodData = biscuitSweetsDataModel.data;
      allCategoryProducts = prodData.where((element) => element.userId == box.read(user_Id) || element.userId == box.read(webStoreId)).toList();

      */

      //purchaseData = data.data.skip(1).toList();
      // log("last data ${purchaseData.last.code}");

      setState(() {
        isLoading = false;
      });
    } else {
      log("data invalid");
    }

    // log("after decode $dataMap");
  }

  @override
  void initState() {
    super.initState();
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
        padding: EdgeInsets.all(0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 7, 0),
              child: Container(
                width: MediaQuery.of(context).size.width / 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color(0xFFF5F2F5),
                      ),
                      width: MediaQuery.of(context).size.width / 2.6,
                      height: 42,
                      child: TextFormField(
                        //textAlign: TextAlign.center,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            contentPadding: EdgeInsets.only(left: 0, bottom: 5, top: 7, right: 5),
                            hintText: 'Order No',
                            prefixIcon: Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: Icon(Icons.search),
                            )),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color(0xFFF5F2F5),
                      ),
                      height: 39,
                      width: MediaQuery.of(context).size.width / 2.5,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            child: Image.asset(
                              "assets/img_187.png",
                              height: 22,
                              width: 22,
                            ),
                            height: 22,
                            width: 22,
                          ),
                          Text(
                            "Price",
                            style: TextStyle(
                              color: kBlackColor,
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'CeraProMedium',
                            ),
                          ),
                          Container(
                            child: Image.asset(
                              "assets/img_188.png",
                              height: 15,
                              width: 15,
                            ),
                            height: 15,
                            width: 15,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: Image.asset(
                        "assets/img_189.png",
                        height: 22,
                        width: 22,
                      ),
                      height: 22,
                      width: 22,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Expanded(
              child: isLoading
                  ? Center()
                  : ListView.builder(
                      itemCount: purchaseData.length,
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (ctx, idx) => OrderItemWidget(
                        purchaseData: purchaseData[idx],
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
