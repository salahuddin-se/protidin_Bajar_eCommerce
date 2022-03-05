import 'dart:convert';
import 'dart:developer';

import 'package:customer_ui/components/styles.dart';
import 'package:customer_ui/components/utils.dart';
import 'package:customer_ui/dataModel/purchase_history.dart' as purHistory;
import 'package:customer_ui/dataModel/purchase_history_details.dart' as purHistDetails;
import 'package:customer_ui/dataModel/purchase_history_items.dart' as purDetailsData;
import 'package:customer_ui/dataModel/single_products.dart' as singleProduct;
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class OrderDetails extends StatefulWidget {
  const OrderDetails({
    Key? key,
    required this.purchaseData,
  }) : super(key: key);
  final purHistory.Data purchaseData;

  @override
  _OrderDetailsState createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> with SingleTickerProviderStateMixin {
  TabController? controller2;
  //var controller = Get.put(CartItemsController());

  ///widget.purchaseData.date

  @override
  void initState() {
    // TODO: implement initState
    controller2 = TabController(length: 2, vsync: this);
    fetPurchaseHistoryDetails(historyId: widget.purchaseData.id);
    getPurchaseHistoryItems().then(
      (value) {
        filterPurchaseProducts();
      },
    );
  }

  purHistDetails.Data? purchaseHistoryData;
  List<purDetailsData.Data> physicalList = [];
  List<purDetailsData.Data> cloudList = [];
  List<purDetailsData.Data> purchaseProducts = [];
  bool isLoading = false;

  Future<void> fetPurchaseHistoryDetails({required int historyId}) async {
    log("widget name $historyId");

    String groceryURl = "http://test.protidin.com.bd:88/api/v2/purchase-history-details/$historyId";

    final response3 = await get(Uri.parse(groceryURl), headers: {"Accept": "application/json"});

    log("Get purchase history: " + response3.body);

    var purchaseHistoryDataMap = jsonDecode(response3.body);

    box.write(daTe, widget.purchaseData.date);

    if (purchaseHistoryDataMap["success"] == true) {
      var purchaseHistory = purHistDetails.PurchaseHistoryDetails.fromJson(purchaseHistoryDataMap);
      purchaseHistoryData = purchaseHistory.data[0];

      setState(() {});
    } else {}
    log("Get purchase history historyDataItem: ");
  }

  Future<void> getPurchaseHistoryItems() async {
    log("calling 2");
    String hisItemUrl = "http://test.protidin.com.bd:88/api/v2/purchase-history-items";

    final response6 = await get(Uri.parse("$hisItemUrl/${widget.purchaseData.id}"),
        headers: {"Accept": "application/json", 'Authorization': 'Bearer ${box.read(userToken)}'});

    log("History Resposne ${response6.body}");

    if (response6.statusCode == 200) {
      var dataMap = jsonDecode(response6.body);
      var purchaseData = purDetailsData.PurchaseHistoryItems.fromJson(dataMap);
      purchaseProducts = purchaseData.data;
      setState(() {});
    } else {
      log("data invalid");
    }
    // log("after decode $dataMap");
  }

  Future<singleProduct.Data?> fetchProductById(int id) async {
    String productUrl = "http://test.protidin.com.bd:88/api/v2/products";
    final response =
        await get(Uri.parse("$productUrl/$id"), headers: {"Accept": "application/json", 'Authorization': 'Bearer ${box.read(userToken)}'});
    singleProduct.Data? product;
    if (response.statusCode == 200) {
      var dataMap = jsonDecode(response.body);
      product = singleProduct.SingleProduct.fromJson(dataMap).data[0];
    } else {
      log("data invalid");
    }
    setState(
      () {
        isLoading = false;
      },
    );
    return product;
  }

  filterPurchaseProducts() async {
    setState(
      () {
        isLoading = true;
      },
    );
    purchaseProducts.forEach(
      (element) async {
        singleProduct.Data? data = await fetchProductById(element.productId);
        if (data != null) {
          if (data.shopName.contains('P_')) {
            physicalList.add(element);
          } else if (data.shopName.contains('C_')) {
            cloudList.add(element);
          }
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF4EFF5),
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: kWhiteColor,
        centerTitle: true,
        title: Text(
          "Order Details",
          style: TextStyle(color: Color(0xFF515151), fontSize: 18, fontWeight: FontWeight.w700, fontFamily: "ceraProMedium"),
        ),
        iconTheme: IconThemeData(color: kBlackColor),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(0.0),
              child: Container(
                decoration: BoxDecoration(
                  //color: Colors.white,
                  //borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.15),
                      spreadRadius: 5, //spread radius
                      blurRadius: 5, // blur radius
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                width: MediaQuery.of(context).size.width / 1,

                ///height: 785,
                //height: 390,
                height: 565,
                child: Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Column(children: [
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Order No #${widget.purchaseData.code}",
                                  style: TextStyle(
                                      color: Color(0xFF515151), fontSize: 16, fontWeight: FontWeight.w500, fontFamily: "CeraProMedium"),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Color(0xFF515151),
                                    borderRadius: BorderRadius.circular(7),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(8, 3, 8, 6),
                                    child: Text(
                                      widget.purchaseData.paymentStatus,
                                      style: TextStyle(
                                          color: Color(0xFFFFFFFF), fontSize: 16, fontWeight: FontWeight.w500, fontFamily: "CeraProMedium"),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width / 3,
                                  child: Text(
                                    widget.purchaseData.date,
                                    style: TextStyle(
                                        color: Color(0xFF515151), fontSize: 12, fontWeight: FontWeight.w500, fontFamily: "CeraProMedium"),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 75.0),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "TK ${widget.purchaseData.grandTotal}",
                                        style: TextStyle(
                                            color: Color(0xFF515151),
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                            fontFamily: "CeraProMedium"),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Container(
                                        //width: MediaQuery.of(context).size.width / 6,
                                        child: Padding(
                                          padding: const EdgeInsets.only(bottom: 0.0),
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              //"${box.read(cart_length) ?? 0} items",
                                              "${purchaseProducts.length} items",
                                              style: TextStyle(
                                                  color: Color(0xFF515151),
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w400,
                                                  fontFamily: "CeraProMedium"),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(right: 5.0),
                                      child: Text(
                                        ///box.write(userName, userDataModel.user.name);///datacount.read('count')
                                        box.read(userName),
                                        style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16, color: Colors.black),
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                                          child: Container(
                                            width: MediaQuery.of(context).size.width / 1.8,
                                            //height: 72,
                                            child: box.read(account_userAddress) == null
                                                ? Align(
                                                    alignment: Alignment.centerRight,
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
                                                    alignment: Alignment.centerRight,
                                                    child: Text(
                                                      //box.read(account_userAddress) ?? "No address",
                                                      box.read(account_userAddress),
                                                      style: TextStyle(
                                                        color: Colors.grey,
                                                        fontSize: 14,
                                                        fontWeight: FontWeight.w500,
                                                      ),
                                                      textAlign: TextAlign.right,
                                                    ),
                                                  ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      height: 135,
                      //height: 105,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(0),
                          topLeft: Radius.circular(0),
                          bottomRight: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
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
                          color: Colors.white,
                          border: Border(
                            bottom: BorderSide(
                              //                   <--- left side
                              color: Colors.grey,
                              width: 1.5,
                            ),
                          ),
                        ),
                        //height: 300,
                        height: 54,
                        width: MediaQuery.of(context).size.width / 1,
                        child: TabBar(
                          isScrollable: true,
                          indicatorWeight: 4,
                          indicatorColor: kPrimaryColor,
                          controller: controller2,
                          tabs: [
                            Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: Container(
                                child: Padding(
                                  padding: EdgeInsets.only(top: 0.0),
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
                                              widget.purchaseData.date,
                                              style: TextStyle(
                                                  color: Color(0xFFA299A8),
                                                  fontSize: 12,
                                                  fontFamily: "ceraProMedium",
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            Text(
                                              "On The Way",
                                              style: TextStyle(
                                                  color: Colors.green,
                                                  fontSize: 14,
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
                            ),
                            Container(
                              child: Padding(
                                padding: EdgeInsets.only(top: 10.0),
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
                                            "09-03-2022",
                                            style: TextStyle(
                                                color: Color(0xFFA299A8),
                                                fontSize: 12,
                                                fontFamily: "ceraProMedium",
                                                fontWeight: FontWeight.w500),
                                          ),
                                          Text(
                                            "Picked",
                                            style: TextStyle(
                                                color: Color(0xFF515151),
                                                fontSize: 14,
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
                    //Text("data"),
                    Expanded(
                      child: TabBarView(
                        controller: controller2,
                        children: [
                          isLoading ? Container() : physical(physicalList),
                          isLoading ? Container() : cloud(cloudList),
                          // cloud(),
                        ],
                      ),
                    ),

                    // Padding(
                    //   padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                    //   child: Container(
                    //     decoration: BoxDecoration(
                    //         color: Colors.white,
                    //         borderRadius: BorderRadius.only(
                    //           bottomLeft: Radius.circular(10),
                    //           bottomRight: Radius.circular(10),
                    //         )),
                    //     child: Padding(
                    //       padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                    //       child: Column(
                    //         crossAxisAlignment: CrossAxisAlignment.start,
                    //         children: [
                    //           SizedBox(
                    //             height: 20,
                    //           ),
                    //           Text(
                    //             "est delivery Today, 2 P.M",
                    //             style: TextStyle(
                    //               color: Color(0xFF515151),
                    //               fontWeight: FontWeight.w400,
                    //               fontFamily: "CeraProMedium",
                    //               fontSize: 12,
                    //               fontStyle: FontStyle.italic,
                    //             ),
                    //           ),
                    //           SizedBox(
                    //             height: 5,
                    //           ),
                    //           Row(
                    //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //             children: [
                    //               Row(
                    //                 children: [
                    //                   CircleAvatar(
                    //                     radius: 25,
                    //                     backgroundColor: Color(0xFFC4C4C4),
                    //                   ),
                    //                   Padding(
                    //                     padding: const EdgeInsets.only(left: 15.0),
                    //                     child: Column(
                    //                       crossAxisAlignment: CrossAxisAlignment.start,
                    //                       children: [
                    //                         Row(
                    //                           children: [
                    //                             Text(
                    //                               "Asif Iqbal",
                    //                               style: TextStyle(
                    //                                 color: Color(0xFF515151),
                    //                                 fontWeight: FontWeight.w500,
                    //                                 fontFamily: "ceraProMedium",
                    //                                 fontSize: 17,
                    //                               ),
                    //                             ),
                    //                             Text(
                    //                               "${totalPrice(physicalList).toDouble()}",
                    //                               style: TextStyle(
                    //                                   color: Color(0xFF515151),
                    //                                   fontSize: 11,
                    //                                   fontWeight: FontWeight.w400,
                    //                                   fontFamily: "ceraProMedium"),
                    //                             ),
                    //                           ],
                    //                         ),
                    //                         Row(
                    //                           children: [
                    //                             Image.asset("assets/img_215.png"),
                    //                             Padding(
                    //                               padding: const EdgeInsets.only(left: 7.0),
                    //                               child: Text("4.5 (230)"),
                    //                             ),
                    //                             Padding(
                    //                               padding: const EdgeInsets.only(left: 5.0),
                    //                               child: Container(
                    //                                 width: MediaQuery.of(context).size.width / 10,
                    //                                 child: Image.asset(
                    //                                   "assets/img_194.png",
                    //                                   height: 20,
                    //                                   width: 20,
                    //                                 ),
                    //                               ),
                    //                             ),
                    //                             Container(
                    //                               width: MediaQuery.of(context).size.width / 10,
                    //                               child: Padding(
                    //                                 padding: const EdgeInsets.all(0.0),
                    //                                 child: Image.asset(
                    //                                   "assets/img_196.png",
                    //                                   height: 20,
                    //                                   width: 20,
                    //                                 ),
                    //                               ),
                    //                             ),
                    //                           ],
                    //                         ),
                    //                       ],
                    //                     ),
                    //                   ),
                    //                 ],
                    //               ),
                    //               Column(
                    //                 children: [
                    //                   //Text("${box.read(cart_length) ?? 0} Items"),
                    //                   Text(
                    //                     "${physicalList.length} items",
                    //                     style: TextStyle(
                    //                         fontSize: 12,
                    //                         fontWeight: FontWeight.w500,
                    //                         fontFamily: "ceraProMedium",
                    //                         color: Color(0xFF515151)),
                    //                   ),
                    //                   Text(
                    //                     widget.purchaseData.grandTotal,
                    //                     style: TextStyle(
                    //                         fontSize: 24,
                    //                         fontWeight: FontWeight.w700,
                    //                         fontFamily: "ceraProMedium",
                    //                         color: Color(0xFF515151)),
                    //                   ),
                    //                 ],
                    //               ),
                    //             ],
                    //           ),
                    //           SizedBox(
                    //             height: 15,
                    //           ),
                    //         ],
                    //       ),
                    //     ),
                    //   ),
                    // )
                  ]),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10),
                  topLeft: Radius.circular(10),
                  bottomRight: Radius.circular(0),
                  bottomLeft: Radius.circular(0),
                ),
                color: Color(0xFFFFF5DD),
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 5, 0, 0),
                        child: Text(
                          "Order Summary",
                          style: TextStyle(
                            color: Color(0xFF515151),
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            fontFamily: "ceraProMedium",
                          ),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 15,
                  ),

                  // Order Summary
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      width: MediaQuery.of(context).size.width / 1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            height: 20,
                            width: MediaQuery.of(context).size.width / 7,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 0),
                              child: Image.asset(
                                "assets/img_108.png",
                              ),
                            ),
                          ),
                          Container(
                            height: 20,
                            width: MediaQuery.of(context).size.width / 3,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                              child: Text(
                                ///"MRP ($totalProducts products)",
                                "MRP (${purchaseProducts.length} products)",
                                style: TextStyle(
                                  color: Color(0xFF515151),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: "ceraProMedium",
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(00, 0, 0, 0),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Container(
                              height: 20,
                              //2.4
                              width: MediaQuery.of(context).size.width / 3.5,
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(20, 0, 25, 0),
                                child: Text(
                                  "${purchaseHistoryData != null ? purchaseHistoryData!.subtotal : 0}",
                                  style: TextStyle(
                                    color: Color(0xFF515151),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: "ceraProMedium",
                                  ),
                                  textAlign: TextAlign.right,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      width: MediaQuery.of(context).size.width / 1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            height: 20,
                            width: MediaQuery.of(context).size.width / 7,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 0),
                              child: Image.asset(
                                "assets/img_166.png",
                              ),
                            ),
                          ),
                          Container(
                            height: 20,
                            width: MediaQuery.of(context).size.width / 3,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                              child: Text(
                                ///"MRP ($totalProducts products)",
                                "Delivery Charge",
                                style: TextStyle(
                                  color: Color(0xFF515151),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: "ceraProMedium",
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(00, 0, 0, 0),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Container(
                              height: 20,
                              //2.4
                              width: MediaQuery.of(context).size.width / 3.5,
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(20, 0, 25, 0),
                                child: Text(
                                  "${purchaseHistoryData != null ? purchaseHistoryData!.shippingCost : 0}",
                                  style: TextStyle(
                                    color: Color(0xFF515151),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: "ceraProMedium",
                                  ),
                                  textAlign: TextAlign.right,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      width: MediaQuery.of(context).size.width / 1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            height: 20,
                            width: MediaQuery.of(context).size.width / 7,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 0),
                              child: Image.asset(
                                "assets/img_164.png",
                              ),
                            ),
                          ),
                          Container(
                            height: 20,
                            width: MediaQuery.of(context).size.width / 3,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                              child: Text(
                                "Protidin Discount",
                                style: TextStyle(
                                  color: Color(0xFF515151),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: "ceraProMedium",
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(00, 0, 0, 0),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Container(
                              height: 20,
                              width: MediaQuery.of(context).size.width / 3.5,
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(20, 0, 25, 0),
                                child: Text(
                                  purchaseHistoryData != null ? purchaseHistoryData!.couponDiscount.toString() : "0",
                                  style: TextStyle(
                                    color: Colors.green,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: "ceraProMedium",
                                  ),
                                  textAlign: TextAlign.right,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  Container(
                    decoration: BoxDecoration(color: Color(0xFFFFFAEE)),
                    height: 40,
                    width: MediaQuery.of(context).size.width / 1.1,
                    //color: Colors.cyan,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        width: MediaQuery.of(context).size.width / 1.1,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width / 2,
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 15.0),
                                    child: Text(
                                      "Total Payable",
                                      style: TextStyle(
                                        color: Color(0xFF515151),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700,
                                        fontFamily: "ceraProMedium",
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width / 4,
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    "${purchaseHistoryData != null ? purchaseHistoryData!.grandTotal : 0}",
                                    style: TextStyle(
                                      color: Color(0xFF515151),
                                      fontSize: 24,
                                      fontWeight: FontWeight.w700,
                                      fontFamily: "ceraProMedium",
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 5,
                  ),

                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 4, 0),
                    child: Container(
                      width: MediaQuery.of(context).size.width / 1.05,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            height: 20,
                            width: MediaQuery.of(context).size.width / 14,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 0),
                              child: Image.asset(
                                "assets/img_167.png",
                              ),
                            ),
                          ),
                          Container(
                            height: 40,
                            width: MediaQuery.of(context).size.width / 1.5,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                              child: Center(
                                child: Text(
                                  "Cash back received (Added to walet)",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 13, fontWeight: FontWeight.w600, fontFamily: "ceraProMedium"),
                                ),
                              ),
                            ),
                          ),
                          Text(""),
                          Text(""),
                          Container(
                            height: 20,
                            width: MediaQuery.of(context).size.width / 7,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                              child: Text(
                                "0.00",
                                style: TextStyle(
                                  color: Color(0xFF9900FF),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 5,
                  ),

                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Row(
                      children: [
                        Text(
                          "Payment Method : ",
                          style: TextStyle(
                            fontSize: 18,
                            fontFamily: "ceraProMedium",
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF515151),
                          ),
                        ),
                        Text(
                          "Cash On Delivery",
                          style: TextStyle(
                            fontSize: 18,
                            fontFamily: "ceraProMedium",
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF515151),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  num totalPrice(List<dynamic> items) {
    num sum = 0;
    num discountTotal = 0;
    for (var item in items) {
      num price2 = int.parse(item.price.toString().replaceAll("৳", "").replaceAll(",", ""));
      num discount2 = int.parse(item.couponDiscount.toString().replaceAll("৳", "").replaceAll(",", ""));
      //print("DISCOUNT: ${item.discount}");
      sum += (price2 * item.quantity);
      discountTotal += (discount2 * item.quantity);
    }
    return sum - discountTotal;
  }

  //controller.cartItemsList[index].productName
  physical(List<purDetailsData.Data> physicalList) {
    return SingleChildScrollView(
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            SizedBox(
              height: 15,
            ),
            Container(
              //color: Colors.white,
              width: MediaQuery.of(context).size.width / 1.1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/img_216.png",
                    height: 15,
                    width: 15,
                  ),
                  Text(
                    "- - - - - -",
                    style: TextStyle(color: Colors.green, fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  Image.asset(
                    "assets/img_217.png",
                    height: 15,
                    width: 15,
                  ),
                  Text(
                    "- - - - - -",
                    style: TextStyle(color: Color(0xFFA299A8), fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  Image.asset(
                    "assets/img_217.png",
                    height: 15,
                    width: 15,
                  ),
                  Text(
                    "- - - - - -",
                    style: TextStyle(color: Color(0xFFA299A8), fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  Image.asset(
                    "assets/img_217.png",
                    height: 15,
                    width: 15,
                  ),
                  Text(
                    "- - - - - -",
                    style: TextStyle(color: Color(0xFFA299A8), fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  Image.asset(
                    "assets/img_217.png",
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
              width: MediaQuery.of(context).size.width / 1.15,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Confirmed",
                    style: TextStyle(color: Color(0xFF515151), fontSize: 12, fontWeight: FontWeight.w500, fontFamily: "CeraProMedium"),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 15.0),
                    child: Text("Picked",
                        style: TextStyle(color: Color(0xFF515151), fontSize: 12, fontWeight: FontWeight.w500, fontFamily: "CeraProMedium")),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 14.0),
                    child: Text("Started",
                        style: TextStyle(color: Color(0xFF515151), fontSize: 12, fontWeight: FontWeight.w500, fontFamily: "CeraProMedium")),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 0.0),
                    child: Text("Arrived",
                        style: TextStyle(color: Color(0xFF515151), fontSize: 12, fontWeight: FontWeight.w500, fontFamily: "CeraProMedium")),
                  ),
                  Text("Delivered",
                      style: TextStyle(color: Color(0xFF515151), fontSize: 12, fontWeight: FontWeight.w500, fontFamily: "CeraProMedium")),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Divider(
              height: 2,
              thickness: 2,
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: MediaQuery.of(context).size.width / 1,
              //height: MediaQuery.of(context).size.height / 1,
              color: Color(0xFFFFFFFF),
              child: Column(
                children: [
                  Container(
                    height: 200,
                    width: double.infinity,
                    child: ListView.builder(
                        itemCount: physicalList.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (_, index) {
                          return Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Container(
                              //height: 290,
                              width: 100,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(),
                                  // Container(
                                  //   ///120
                                  //   height: 70,
                                  //   width: MediaQuery.of(context).size.width / 2.5,
                                  //   child: Image.network(
                                  //     imagePath + physicalProducts[index].productThumbnailImage,
                                  //   ),
                                  // ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        height: 20,
                                        width: MediaQuery.of(context).size.width / 1.7,
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(15, 4, 5, 0),
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              physicalList[index].productName,
                                              style: TextStyle(
                                                  color: Color(0xFF515151),
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500,
                                                  fontFamily: "ceraProMedium"),
                                              textAlign: TextAlign.left,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        height: 20,
                                        width: MediaQuery.of(context).size.width / 4,
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(0, 4, 25, 0),
                                          child: Row(
                                            children: [
                                              Text(
                                                "${physicalList[index].price.toString()}",
                                                style: TextStyle(
                                                    color: Color(0xFF515151),
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                    fontFamily: "ceraProMedium"),
                                                textAlign: TextAlign.right,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Divider(
                                    color: Colors.grey,
                                    thickness: .1,
                                  )

                                  // Align(
                                  //   alignment: Alignment.center,
                                  //   child: Container(
                                  //     height: 10,
                                  //     width: 60,
                                  //     child: Padding(
                                  //       padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  //       child: Center(
                                  //         child: physicalProducts[index].unit != null
                                  //             ? Text(
                                  //                 physicalProducts[index].unit,
                                  //                 style: TextStyle(
                                  //                     color: Color(0xFF515151),
                                  //                     fontSize: 11,
                                  //                     fontWeight: FontWeight.w700,
                                  //                     fontFamily: "ceraProMedium"),
                                  //               )
                                  //             : Text(""),
                                  //       ),
                                  //     ),
                                  //   ),
                                  // ),
                                  // Align(
                                  //   alignment: Alignment.center,
                                  //   child: Container(
                                  //     height: 20,
                                  //     width: 50,
                                  //     child: Padding(
                                  //       padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  //       child: Center(
                                  //         child: Text(
                                  //           "${physicalProducts[index].currencySymbol}${physicalProducts[index].price}",
                                  //           style: TextStyle(
                                  //               color: Color(0xFF515151), fontSize: 11, fontWeight: FontWeight.w400, fontFamily: "ceraProMedium"),
                                  //         ),
                                  //       ),
                                  //     ),
                                  //   ),
                                  // ),
                                ],
                              ),
                            ),
                          );
                        }),
                  ),

                  // Padding(
                  //   padding: const EdgeInsets.fromLTRB(15, 0, 15, 5),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //     children: [
                  //       Text(
                  //         "Estimated Delivery :",
                  //         style:
                  //             TextStyle(fontSize: 10, color: Color(0xFF515151), fontFamily: "ceraProMedium", fontWeight: FontWeight.w500),
                  //       ),
                  //       Text(
                  //         "${box.read(cart_length) ?? 0} items",
                  //         style:
                  //             TextStyle(fontSize: 10, color: Color(0xFF515151), fontFamily: "ceraProMedium", fontWeight: FontWeight.w700),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  // Padding(
                  //   padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //     children: [
                  //       Text(
                  //         "3 p.m Thursday, Dec 15",
                  //         style:
                  //             TextStyle(fontSize: 12, color: Color(0xFF515151), fontFamily: "ceraProMedium", fontWeight: FontWeight.w500),
                  //       ),
                  //       // Text(
                  //       //   totalPrice(physicalProducts).toString(),
                  //       //   style: TextStyle(fontSize: 24, color: Color(0xFF515151), fontFamily: "ceraProMedium", fontWeight: FontWeight.w700),
                  //       // ),
                  //     ],
                  //   ),
                  // ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    )),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 15.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Estimated Delivery :",
                                      style: TextStyle(
                                          fontSize: 10, color: Color(0xFF515151), fontFamily: "ceraProMedium", fontWeight: FontWeight.w500),
                                    ),
                                    Text(
                                      widget.purchaseData.date,
                                      style: TextStyle(
                                        color: Color(0xFF515151),
                                        fontWeight: FontWeight.w500,
                                        fontFamily: "CeraProMedium",
                                        fontSize: 16,
                                        fontStyle: FontStyle.italic,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              //Text("${box.read(cart_length) ?? 0} Items"),
                              Text(
                                "${physicalList.length} items",
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.w500, fontFamily: "ceraProMedium", color: Color(0xFF515151)),
                              ),

                              Text(
                                "${totalPrice(physicalList).toString()} TK",
                                style: TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.w700, fontFamily: "ceraProMedium", color: Color(0xFF515151)),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15,
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

  cloud(List<purDetailsData.Data> cloudList) {
    return SingleChildScrollView(
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            SizedBox(
              height: 15,
            ),
            Container(
              //color: Colors.white,
              width: MediaQuery.of(context).size.width / 1.1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/img_216.png",
                    height: 15,
                    width: 15,
                  ),
                  Text(
                    "- - - - - -",
                    style: TextStyle(color: Colors.green, fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  Image.asset(
                    "assets/img_217.png",
                    height: 15,
                    width: 15,
                  ),
                  Text(
                    "- - - - - -",
                    style: TextStyle(color: Color(0xFFA299A8), fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  Image.asset(
                    "assets/img_217.png",
                    height: 15,
                    width: 15,
                  ),
                  Text(
                    "- - - - - -",
                    style: TextStyle(color: Color(0xFFA299A8), fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  Image.asset(
                    "assets/img_217.png",
                    height: 15,
                    width: 15,
                  ),
                  Text(
                    "- - - - - -",
                    style: TextStyle(color: Color(0xFFA299A8), fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  Image.asset(
                    "assets/img_217.png",
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
              width: MediaQuery.of(context).size.width / 1.15,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Confirmed",
                    style: TextStyle(color: Color(0xFF515151), fontSize: 12, fontWeight: FontWeight.w500, fontFamily: "CeraProMedium"),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 15.0),
                    child: Text("Picked",
                        style: TextStyle(color: Color(0xFF515151), fontSize: 12, fontWeight: FontWeight.w500, fontFamily: "CeraProMedium")),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 14.0),
                    child: Text("Started",
                        style: TextStyle(color: Color(0xFF515151), fontSize: 12, fontWeight: FontWeight.w500, fontFamily: "CeraProMedium")),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 0.0),
                    child: Text("Arrived",
                        style: TextStyle(color: Color(0xFF515151), fontSize: 12, fontWeight: FontWeight.w500, fontFamily: "CeraProMedium")),
                  ),
                  Text("Delivered",
                      style: TextStyle(color: Color(0xFF515151), fontSize: 12, fontWeight: FontWeight.w500, fontFamily: "CeraProMedium")),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Divider(
              height: 2,
              thickness: 2,
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: MediaQuery.of(context).size.width / 1,
              //height: MediaQuery.of(context).size.height / 1,
              color: Color(0xFFFFFFFF),
              child: Column(
                children: [
                  Container(
                    height: 200,
                    width: double.infinity,
                    child: ListView.builder(
                        itemCount: cloudList.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (_, index) {
                          return Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Container(
                              //height: 290,
                              width: 100,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(),
                                  // Container(
                                  //   ///120
                                  //   height: 70,
                                  //   width: MediaQuery.of(context).size.width / 2.5,
                                  //   child: Image.network(
                                  //     imagePath + physicalProducts[index].productThumbnailImage,
                                  //   ),
                                  // ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        height: 20,
                                        width: MediaQuery.of(context).size.width / 1.7,
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(15, 4, 5, 0),
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              cloudList[index].productName,
                                              style: TextStyle(
                                                  color: Color(0xFF515151),
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500,
                                                  fontFamily: "ceraProMedium"),
                                              textAlign: TextAlign.left,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        height: 20,
                                        width: MediaQuery.of(context).size.width / 4,
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(0, 4, 25, 0),
                                          child: Row(
                                            children: [
                                              Text(
                                                "${cloudList[index].price.toString()}",
                                                style: TextStyle(
                                                    color: Color(0xFF515151),
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                    fontFamily: "ceraProMedium"),
                                                textAlign: TextAlign.right,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Divider(
                                    color: Colors.grey,
                                    thickness: .1,
                                  )

                                  // Align(
                                  //   alignment: Alignment.center,
                                  //   child: Container(
                                  //     height: 10,
                                  //     width: 60,
                                  //     child: Padding(
                                  //       padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  //       child: Center(
                                  //         child: physicalProducts[index].unit != null
                                  //             ? Text(
                                  //                 physicalProducts[index].unit,
                                  //                 style: TextStyle(
                                  //                     color: Color(0xFF515151),
                                  //                     fontSize: 11,
                                  //                     fontWeight: FontWeight.w700,
                                  //                     fontFamily: "ceraProMedium"),
                                  //               )
                                  //             : Text(""),
                                  //       ),
                                  //     ),
                                  //   ),
                                  // ),
                                  // Align(
                                  //   alignment: Alignment.center,
                                  //   child: Container(
                                  //     height: 20,
                                  //     width: 50,
                                  //     child: Padding(
                                  //       padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  //       child: Center(
                                  //         child: Text(
                                  //           "${physicalProducts[index].currencySymbol}${physicalProducts[index].price}",
                                  //           style: TextStyle(
                                  //               color: Color(0xFF515151), fontSize: 11, fontWeight: FontWeight.w400, fontFamily: "ceraProMedium"),
                                  //         ),
                                  //       ),
                                  //     ),
                                  //   ),
                                  // ),
                                ],
                              ),
                            ),
                          );
                        }),
                  ),

                  // Padding(
                  //   padding: const EdgeInsets.fromLTRB(15, 0, 15, 5),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //     children: [
                  //       Text(
                  //         "Estimated Delivery :",
                  //         style:
                  //             TextStyle(fontSize: 10, color: Color(0xFF515151), fontFamily: "ceraProMedium", fontWeight: FontWeight.w500),
                  //       ),
                  //       Text(
                  //         "${box.read(cart_length) ?? 0} items",
                  //         style:
                  //             TextStyle(fontSize: 10, color: Color(0xFF515151), fontFamily: "ceraProMedium", fontWeight: FontWeight.w700),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  // Padding(
                  //   padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //     children: [
                  //       Text(
                  //         "3 p.m Thursday, Dec 15",
                  //         style:
                  //             TextStyle(fontSize: 12, color: Color(0xFF515151), fontFamily: "ceraProMedium", fontWeight: FontWeight.w500),
                  //       ),
                  //       // Text(
                  //       //   totalPrice(physicalProducts).toString(),
                  //       //   style: TextStyle(fontSize: 24, color: Color(0xFF515151), fontFamily: "ceraProMedium", fontWeight: FontWeight.w700),
                  //       // ),
                  //     ],
                  //   ),
                  // ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      // Text(
                      //   "est delivery Today, 2 P.M",
                      //   style: TextStyle(
                      //     color: Color(0xFF515151),
                      //     fontWeight: FontWeight.w400,
                      //     fontFamily: "CeraProMedium",
                      //     fontSize: 12,
                      //     fontStyle: FontStyle.italic,
                      //   ),
                      // ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 15.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Estimated Delivery :",
                                          style: TextStyle(
                                            fontSize: 10,
                                            color: Color(0xFF515151),
                                            fontFamily: "ceraProMedium",
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        Text(
                                          "09-03-2022",
                                          style: TextStyle(
                                            color: Color(0xFF515151),
                                            fontWeight: FontWeight.w500,
                                            fontFamily: "CeraProMedium",
                                            fontSize: 16,
                                            fontStyle: FontStyle.italic,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              //Text("${box.read(cart_length) ?? 0} Items"),

                              Text(
                                "${cloudList.length} items",
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.w500, fontFamily: "ceraProMedium", color: Color(0xFF515151)),
                              ),

                              Text(
                                "${totalPrice(cloudList).toString()} TK",
                                style: TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.w700, fontFamily: "ceraProMedium", color: Color(0xFF515151)),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
