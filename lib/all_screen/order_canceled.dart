import 'dart:convert';
import 'dart:developer';

import 'package:customer_ui/components/apis.dart';
import 'package:customer_ui/components/styles.dart';
import 'package:customer_ui/components/utils.dart';
import 'package:customer_ui/dataModel/purchase_history.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class OrderCanceled extends StatefulWidget {
  const OrderCanceled({Key? key}) : super(key: key);

  @override
  _OrderCanceledState createState() => _OrderCanceledState();
}

class _OrderCanceledState extends State<OrderCanceled> {
  List purchaseDataList = [];

  Future<void> getPurchaseHistoryList() async {
    log("calling 2");
    final response6 = await get(Uri.parse("$purchaseHistory/${box.read(userID)}"), headers: {"Accept": "application/json"});

    log("History Resposne ${response6.body}");

    if (response6.statusCode == 200) {
      var dataMap = jsonDecode(response6.body);
      var data = PurchaseHistory.fromJson(dataMap);
      purchaseDataList = data.data;

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
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width / 1,
        padding: EdgeInsets.all(0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 10,
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
            // Container(
            //   width: MediaQuery.of(context).size.width / 1.0,
            //   decoration: BoxDecoration(
            //     color: Color(0xFFF5F2F5),
            //     borderRadius: BorderRadius.circular(15.0),
            //   ),
            //   child: Padding(
            //     padding: const EdgeInsets.all(08.0),
            //     child: Column(
            //       children: [
            //         SizedBox(
            //           height: 15,
            //         ),
            //
            //         Padding(
            //           padding: const EdgeInsets.only(left: 4.0),
            //           child: Row(
            //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //             children: [
            //               Text(
            //                 "Order No #${purchaseData.last.code}",
            //                 style: TextStyle(
            //                     color: Color(0xFF515151), fontSize: 16, fontWeight: FontWeight.w500, fontFamily: "CeraProMedium"),
            //               ),
            //               Container(
            //                 decoration: BoxDecoration(
            //                   color: Color(0xFF515151),
            //                   borderRadius: BorderRadius.circular(7),
            //                 ),
            //                 child: Padding(
            //                   padding: const EdgeInsets.fromLTRB(8, 6, 8, 6),
            //                   child: Text(
            //                     purchaseData.last.paymentStatus,
            //                     style: TextStyle(
            //                         color: Color(0xFFFFFFFF), fontSize: 16, fontWeight: FontWeight.w500, fontFamily: "CeraProMedium"),
            //                   ),
            //                 ),
            //               ),
            //             ],
            //           ),
            //         ),
            //         SizedBox(
            //           height: 10,
            //         ),
            //         Row(
            //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //           children: [
            //             Container(
            //               width: MediaQuery.of(context).size.width / 3,
            //               child: Text(
            //                 purchaseData.last.date,
            //                 style: TextStyle(
            //                     color: Color(0xFF515151), fontSize: 12, fontWeight: FontWeight.w500, fontFamily: "CeraProMedium"),
            //               ),
            //             ),
            //             Padding(
            //               padding: const EdgeInsets.only(left: 75.0),
            //             ),
            //             Row(
            //               mainAxisAlignment: MainAxisAlignment.end,
            //               children: [
            //                 Container(
            //                   width: MediaQuery.of(context).size.width / 10,
            //                   child: Image.asset(
            //                     "assets/img_194.png",
            //                     height: 20,
            //                     width: 20,
            //                   ),
            //                 ),
            //                 Container(
            //                   width: MediaQuery.of(context).size.width / 10,
            //                   child: Padding(
            //                     padding: const EdgeInsets.all(0.0),
            //                     child: Image.asset(
            //                       "assets/img_196.png",
            //                       height: 20,
            //                       width: 20,
            //                     ),
            //                   ),
            //                 ),
            //               ],
            //             ),
            //           ],
            //         ),
            //         SizedBox(
            //           height: 10,
            //         ),
            //         Align(
            //           alignment: Alignment.centerLeft,
            //           child: Text(
            //             "TK ${purchaseData.last.grandTotal}",
            //             style:
            //                 TextStyle(color: Color(0xFF515151), fontSize: 16, fontWeight: FontWeight.w500, fontFamily: "CeraProMedium"),
            //           ),
            //         ),
            //
            //         // Container(
            //         //   width: MediaQuery.of(context).size.width / 1.2,
            //         //   child: Row(
            //         //     mainAxisAlignment: MainAxisAlignment.center,
            //         //     children: [
            //         //       Image.asset(
            //         //         "assets/img_197.png",
            //         //         height: 15,
            //         //         width: 15,
            //         //       ),
            //         //       Text(
            //         //         "- - - - - -",
            //         //         style: TextStyle(color: Color(0xFF9900FF), fontSize: 16, fontWeight: FontWeight.w600),
            //         //       ),
            //         //       Image.asset(
            //         //         "assets/img_197.png",
            //         //         height: 15,
            //         //         width: 15,
            //         //       ),
            //         //       Text(
            //         //         "- - - - - -",
            //         //         style: TextStyle(color: Color(0xFF9900FF), fontSize: 16, fontWeight: FontWeight.w600),
            //         //       ),
            //         //       Image.asset(
            //         //         "assets/img_197.png",
            //         //         height: 15,
            //         //         width: 15,
            //         //       ),
            //         //       Text(
            //         //         "- - - - - -",
            //         //         style: TextStyle(color: Color(0xFF9900FF), fontSize: 16, fontWeight: FontWeight.w600),
            //         //       ),
            //         //       Image.asset(
            //         //         "assets/img_197.png",
            //         //         height: 15,
            //         //         width: 15,
            //         //       ),
            //         //       Text(
            //         //         "- - - - - -",
            //         //         style: TextStyle(color: Color(0xFF9900FF), fontSize: 16, fontWeight: FontWeight.w600),
            //         //       ),
            //         //       Image.asset(
            //         //         "assets/img_197.png",
            //         //         height: 15,
            //         //         width: 15,
            //         //         color: Colors.grey,
            //         //       ),
            //         //     ],
            //         //   ),
            //         // ),
            //
            //         Align(
            //           alignment: Alignment.centerLeft,
            //           child: Text(
            //             "3 (items)",
            //             style:
            //                 TextStyle(color: Color(0xFF515151), fontSize: 12, fontWeight: FontWeight.w400, fontFamily: "CeraProMedium"),
            //           ),
            //         ),
            //
            //         SizedBox(
            //           height: 10,
            //         ),
            //
            //         // Container(
            //         //   width: MediaQuery.of(context).size.width / 1,
            //         //   child: Row(
            //         //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //         //     children: [
            //         //       Text(
            //         //         purchaseData.last.deliveryStatus,
            //         //         style: TextStyle(
            //         //             color: Color(0xFF515151), fontSize: 12, fontWeight: FontWeight.w500, fontFamily: "CeraProMedium"),
            //         //       ),
            //         //       Padding(
            //         //         padding: const EdgeInsets.only(right: 15.0),
            //         //         child: Text(purchaseData.last.deliveryStatus,
            //         //             style: TextStyle(
            //         //                 color: Color(0xFF515151), fontSize: 12, fontWeight: FontWeight.w500, fontFamily: "CeraProMedium")),
            //         //       ),
            //         //       Padding(
            //         //         padding: const EdgeInsets.only(right: 18.0),
            //         //         child: Text(purchaseData.last.deliveryStatus,
            //         //             style: TextStyle(
            //         //                 color: Color(0xFF515151), fontSize: 12, fontWeight: FontWeight.w500, fontFamily: "CeraProMedium")),
            //         //       ),
            //         //       Padding(
            //         //         padding: const EdgeInsets.only(left: 0.0),
            //         //         child: Text(purchaseData.last.deliveryStatus,
            //         //             style: TextStyle(
            //         //                 color: Color(0xFF515151), fontSize: 12, fontWeight: FontWeight.w500, fontFamily: "CeraProMedium")),
            //         //       ),
            //         //       Text(purchaseData.last.deliveryStatus,
            //         //           style: TextStyle(
            //         //               color: Color(0xFF515151), fontSize: 12, fontWeight: FontWeight.w500, fontFamily: "CeraProMedium")),
            //         //     ],
            //         //   ),
            //         // ),
            //
            //         Row(
            //           children: [
            //             DottedBorder(
            //               color: Colors.grey, //color of dotted/dash line
            //               strokeWidth: 1, //thickness of dash/dots
            //               //10,6
            //               dashPattern: [10, 6],
            //               child: Padding(
            //                 padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
            //                 child: Container(
            //                   width: MediaQuery.of(context).size.width / 2.3,
            //                   child: Row(
            //                     children: [
            //                       Padding(
            //                         padding: const EdgeInsets.only(left: 15.0),
            //                         child: Image.asset(
            //                           "assets/img_210.png",
            //                           height: 35,
            //                           width: 35,
            //                         ),
            //                       ),
            //                       Padding(
            //                         padding: const EdgeInsets.only(left: 20.0),
            //                         child: Column(
            //                           crossAxisAlignment: CrossAxisAlignment.start,
            //                           children: [
            //                             Text(
            //                               purchaseData.last.date,
            //                               style: TextStyle(
            //                                   color: Color(0xFFA299A8),
            //                                   fontSize: 10,
            //                                   fontWeight: FontWeight.w500,
            //                                   fontFamily: "CeraProMedium"),
            //                               textAlign: TextAlign.left,
            //                             ),
            //                             Text(
            //                               purchaseData.last.deliveryStatus,
            //                               style: TextStyle(
            //                                   color: Color(0xFF10AA2A),
            //                                   fontSize: 14,
            //                                   fontWeight: FontWeight.w500,
            //                                   fontFamily: "CeraProMedium"),
            //                               textAlign: TextAlign.left,
            //                             ),
            //                             Text(
            //                               purchaseData.last.grandTotal,
            //                               style: TextStyle(
            //                                   color: Color(0xFFA299A8),
            //                                   fontSize: 11,
            //                                   fontWeight: FontWeight.w500,
            //                                   fontFamily: "CeraProMedium"),
            //                               textAlign: TextAlign.left,
            //                             ),
            //                             Text(
            //                               "1 items",
            //                               style: TextStyle(
            //                                   color: Color(0xFFA299A8),
            //                                   fontSize: 11,
            //                                   fontWeight: FontWeight.w400,
            //                                   fontFamily: "CeraProMedium"),
            //                               textAlign: TextAlign.left,
            //                             ),
            //                           ],
            //                         ),
            //                       )
            //                     ],
            //                   ),
            //                 ),
            //               ),
            //             ),
            //             Padding(
            //               padding: const EdgeInsets.fromLTRB(4.5, 0, 4.5, 0),
            //             ),
            //             DottedBorder(
            //               color: Colors.grey, //color of dotted/dash line
            //               strokeWidth: 1, //thickness of dash/dots
            //               dashPattern: [10, 6],
            //               child: Padding(
            //                 padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
            //                 child: Container(
            //                   width: MediaQuery.of(context).size.width / 2.3,
            //                   child: Row(
            //                     children: [
            //                       Padding(
            //                         padding: const EdgeInsets.only(left: 15.0),
            //                         child: Image.asset(
            //                           "assets/img_211.png",
            //                           height: 35,
            //                           width: 35,
            //                         ),
            //                       ),
            //                       Padding(
            //                         padding: const EdgeInsets.only(left: 20.0),
            //                         child: Column(
            //                           crossAxisAlignment: CrossAxisAlignment.start,
            //                           children: [
            //                             Text(
            //                               purchaseData.last.date,
            //                               style: TextStyle(
            //                                   color: Color(0xFFA299A8),
            //                                   fontSize: 10,
            //                                   fontWeight: FontWeight.w500,
            //                                   fontFamily: "CeraProMedium"),
            //                               textAlign: TextAlign.left,
            //                             ),
            //                             Text(
            //                               purchaseData.last.deliveryStatus,
            //                               style: TextStyle(
            //                                   color: Color(0xFF10AA2A),
            //                                   fontSize: 14,
            //                                   fontWeight: FontWeight.w500,
            //                                   fontFamily: "CeraProMedium"),
            //                               textAlign: TextAlign.left,
            //                             ),
            //                             Text(
            //                               purchaseData.last.grandTotal,
            //                               style: TextStyle(
            //                                   color: Color(0xFFA299A8),
            //                                   fontSize: 11,
            //                                   fontWeight: FontWeight.w500,
            //                                   fontFamily: "CeraProMedium"),
            //                               textAlign: TextAlign.left,
            //                             ),
            //                             Text(
            //                               "1 items",
            //                               style: TextStyle(
            //                                   color: Color(0xFFA299A8),
            //                                   fontSize: 11,
            //                                   fontWeight: FontWeight.w400,
            //                                   fontFamily: "CeraProMedium"),
            //                               textAlign: TextAlign.left,
            //                             ),
            //                           ],
            //                         ),
            //                       )
            //                     ],
            //                   ),
            //                 ),
            //               ),
            //             ),
            //           ],
            //         ),
            //
            //         // Align(
            //         //   alignment: Alignment.center,
            //         //   child: InkWell(
            //         //     // onTap: () {
            //         //     //   Navigator.push(
            //         //     //       context,
            //         //     //       MaterialPageRoute(
            //         //     //           builder: (context) => Details(
            //         //     //                 link: purchaseData.last.links.details,
            //         //     //               )));
            //         //     //
            //         //     //   ///Navigator.push(context, MaterialPageRoute(builder: (context) => TrackOrder()));
            //         //     // },
            //         //     child: Container(
            //         //       decoration: BoxDecoration(
            //         //         color: Colors.purpleAccent[700],
            //         //         borderRadius: BorderRadius.circular(25),
            //         //         boxShadow: const [
            //         //           BoxShadow(
            //         //             color: Colors.white,
            //         //           ),
            //         //         ],
            //         //       ),
            //         //       //color: Colors.green,
            //         //       height: 40,
            //         //       width: MediaQuery.of(context).size.width / 1.7,
            //         //       child: Padding(
            //         //         padding: const EdgeInsets.all(0),
            //         //         child: Center(
            //         //           child: Text(
            //         //             "Details",
            //         //             style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w900),
            //         //           ),
            //         //         ),
            //         //       ),
            //         //     ),
            //         //   ),
            //         // ),
            //         SizedBox(
            //           height: 15,
            //         ),
            //       ],
            //     ),
            //   ),
            // )
          ],
        ),
      ),
      // body: ListView.builder(
      //   itemCount: purchaseDataList.length,
      //   itemBuilder: (_, index) {
      //     return Padding(
      //       padding: const EdgeInsets.all(8.0),
      //       child: Container(
      //         width: MediaQuery.of(context).size.width / 1.3,
      //         decoration: BoxDecoration(
      //           color: Colors.grey.withOpacity(0.2),
      //           borderRadius: BorderRadius.circular(10.0),
      //         ),
      //         child: Column(
      //           children: [
      //             SizedBox(
      //               height: 20,
      //             ),
      //             Center(
      //               child: Container(
      //                 width: MediaQuery.of(context).size.width / 1.2,
      //                 child: FittedBox(
      //                   child: Row(
      //                     mainAxisAlignment: MainAxisAlignment.spaceAround,
      //                     children: [
      //                       Container(
      //                         //width: MediaQuery.of(context).size.width / 3,
      //                         width: MediaQuery.of(context).size.width / 2.5,
      //                         child: Column(
      //                           children: [
      //                             Align(
      //                               alignment: Alignment.centerLeft,
      //                               child: Text(
      //                                 "Transaction ID",
      //                                 style: TextStyle(
      //                                   color: Colors.grey,
      //                                   fontSize: 14,
      //                                   fontWeight: FontWeight.w400,
      //                                 ),
      //                               ),
      //                             ),
      //                             SizedBox(
      //                               height: 5,
      //                             ),
      //                             Align(
      //                               alignment: Alignment.centerLeft,
      //                               child: Text(
      //                                 purchaseDataList[index].code,
      //                                 style: TextStyle(
      //                                   color: Colors.black,
      //                                   fontSize: 14,
      //                                   fontWeight: FontWeight.w900,
      //                                 ),
      //                               ),
      //                             )
      //                           ],
      //                         ),
      //                       ),
      //                       Padding(
      //                         padding: const EdgeInsets.only(left: 5.0),
      //                         child: Container(
      //                           width: MediaQuery.of(context).size.width / 4,
      //                           child: Column(
      //                             children: [
      //                               Align(
      //                                 alignment: Alignment.centerLeft,
      //                                 child: Padding(
      //                                   padding: const EdgeInsets.only(left: 8.0),
      //                                   child: Text(
      //                                     "Amount",
      //                                     style: TextStyle(
      //                                       color: Colors.grey,
      //                                       fontSize: 14,
      //                                       fontWeight: FontWeight.w400,
      //                                     ),
      //                                   ),
      //                                 ),
      //                               ),
      //                               SizedBox(
      //                                 height: 5,
      //                               ),
      //                               Align(
      //                                 alignment: Alignment.centerLeft,
      //                                 child: Padding(
      //                                   padding: const EdgeInsets.only(left: 8.0),
      //                                   child: Text(
      //                                     purchaseDataList[index].grandTotal,
      //                                     style: TextStyle(
      //                                       color: Colors.black,
      //                                       fontSize: 14,
      //                                       fontWeight: FontWeight.w900,
      //                                     ),
      //                                   ),
      //                                 ),
      //                               )
      //                             ],
      //                           ),
      //                         ),
      //                       ),
      //                       Container(
      //                         width: MediaQuery.of(context).size.width / 4,
      //                         child: Column(
      //                           children: [
      //                             Align(
      //                               alignment: Alignment.centerLeft,
      //                               child: Text(
      //                                 "Payment",
      //                                 style: TextStyle(
      //                                   color: Colors.grey,
      //                                   fontSize: 14,
      //                                   fontWeight: FontWeight.w400,
      //                                 ),
      //                               ),
      //                             ),
      //                             SizedBox(
      //                               height: 5,
      //                             ),
      //                             Align(
      //                               alignment: Alignment.centerLeft,
      //                               child: Text(
      //                                 purchaseDataList[index].paymentStatus,
      //                                 style: TextStyle(
      //                                   color: Colors.black,
      //                                   fontSize: 14,
      //                                   fontWeight: FontWeight.w900,
      //                                 ),
      //                               ),
      //                             )
      //                           ],
      //                         ),
      //                       ),
      //                     ],
      //                   ),
      //                 ),
      //               ),
      //             ),
      //             SizedBox(
      //               height: 15,
      //             ),
      //             Padding(
      //               padding: const EdgeInsets.only(left: 15.0),
      //               child: Align(
      //                 alignment: Alignment.centerLeft,
      //                 child: Container(
      //                   width: MediaQuery.of(context).size.width / 2,
      //                   child: Column(
      //                     children: [
      //                       Align(
      //                         alignment: Alignment.centerLeft,
      //                         child: Text(
      //                           "Buyer",
      //                           style: TextStyle(
      //                             color: Colors.grey,
      //                             fontSize: 14,
      //                             fontWeight: FontWeight.w400,
      //                           ),
      //                         ),
      //                       ),
      //                       SizedBox(
      //                         height: 5,
      //                       ),
      //                       Align(
      //                         alignment: Alignment.centerLeft,
      //                         child: Text(
      //                           box.read(userName),
      //                           style: TextStyle(
      //                             color: Colors.black,
      //                             fontSize: 14,
      //                             fontWeight: FontWeight.w900,
      //                           ),
      //                         ),
      //                       )
      //                     ],
      //                   ),
      //                 ),
      //               ),
      //             ),
      //             SizedBox(
      //               height: 15,
      //             ),
      //             Padding(
      //               padding: const EdgeInsets.only(left: 15.0),
      //               child: Align(
      //                 alignment: Alignment.centerLeft,
      //                 child: Container(
      //                   width: MediaQuery.of(context).size.width / 2,
      //                   child: Column(
      //                     children: [
      //                       Align(
      //                         alignment: Alignment.centerLeft,
      //                         child: Text(
      //                           "Address",
      //                           style: TextStyle(
      //                             color: Colors.grey,
      //                             fontSize: 14,
      //                             fontWeight: FontWeight.w400,
      //                           ),
      //                         ),
      //                       ),
      //                       SizedBox(
      //                         height: 5,
      //                       ),
      //                       box.read(account_userAddress) == null
      //                           ? Align(
      //                               alignment: Alignment.centerLeft,
      //                               child: Text(
      //                                 "",
      //                                 style: TextStyle(
      //                                   color: Colors.black,
      //                                   fontSize: 14,
      //                                   fontWeight: FontWeight.w900,
      //                                 ),
      //                               ),
      //                             )
      //                           : Align(
      //                               alignment: Alignment.centerLeft,
      //                               child: Text(
      //                                 box.read(account_userAddress),
      //                                 style: TextStyle(
      //                                   color: Colors.black,
      //                                   fontSize: 14,
      //                                   fontWeight: FontWeight.w900,
      //                                 ),
      //                               ),
      //                             ),
      //                     ],
      //                   ),
      //                 ),
      //               ),
      //             ),
      //             SizedBox(
      //               height: 25,
      //             ),
      //             Align(
      //               alignment: Alignment.center,
      //               child: InkWell(
      //                 // onTap: () {
      //                 //   Navigator.push(
      //                 //       context,
      //                 //       MaterialPageRoute(
      //                 //           builder: (context) => Details(
      //                 //                 link: purchaseDataList[index].links.details,
      //                 //               )));
      //                 //
      //                 //   ///Navigator.push(context, MaterialPageRoute(builder: (context) => TrackOrder()));
      //                 // },
      //                 child: Container(
      //                   decoration: BoxDecoration(
      //                     color: Colors.purpleAccent[700],
      //                     borderRadius: BorderRadius.circular(25),
      //                     boxShadow: const [
      //                       BoxShadow(
      //                         color: Colors.white,
      //                       ),
      //                     ],
      //                   ),
      //                   //color: Colors.green,
      //                   height: 45,
      //                   width: MediaQuery.of(context).size.width / 1.7,
      //                   child: Padding(
      //                     padding: const EdgeInsets.all(0),
      //                     child: Center(
      //                       child: Text(
      //                         "Details",
      //                         style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w900),
      //                       ),
      //                     ),
      //                   ),
      //                 ),
      //               ),
      //             ),
      //             SizedBox(
      //               height: 20,
      //             )
      //           ],
      //         ),
      //       ),
      //     );
      //   },
      // ),
    );
  }
}
