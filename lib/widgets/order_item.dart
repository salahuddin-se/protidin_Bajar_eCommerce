import 'package:customer_ui/all_screen/order_details.dart';
import 'package:customer_ui/dataModel/purchase_history.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class OrderItemWidget extends StatefulWidget {
  const OrderItemWidget({Key? key, required this.purchaseData}) : super(key: key);
  final Data purchaseData;

  @override
  _OrderItemWidgetState createState() => _OrderItemWidgetState();
}

class _OrderItemWidgetState extends State<OrderItemWidget> {
  @override
  Widget build(BuildContext context) {
    var upDate = int.parse(widget.purchaseData.date.substring(0, 2)) + 1;
    print("Date Change :$upDate");
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 5, 0, 10),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OrderDetails(
                purchaseData: widget.purchaseData,
              ),
            ),
          );
        },
        child: Container(
          width: MediaQuery.of(context).size.width / 1.0,
          decoration: BoxDecoration(
            color: Color(0xFFF5F2F5),
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(08.0),
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
                        "Order No #${widget.purchaseData.code}",
                        style: TextStyle(color: Color(0xFF515151), fontSize: 16, fontWeight: FontWeight.w500, fontFamily: "CeraProMedium"),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Color(0xFF515151),
                          borderRadius: BorderRadius.circular(7),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(8, 6, 8, 6),
                          child: Text(
                            widget.purchaseData.paymentStatus,
                            style:
                                TextStyle(color: Color(0xFFFFFFFF), fontSize: 16, fontWeight: FontWeight.w500, fontFamily: "CeraProMedium"),
                          ),
                        ),
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
                        widget.purchaseData.date,
                        style: TextStyle(color: Color(0xFF515151), fontSize: 12, fontWeight: FontWeight.w500, fontFamily: "CeraProMedium"),
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
                    "TK ${widget.purchaseData.grandTotal}",
                    style: TextStyle(color: Color(0xFF515151), fontSize: 16, fontWeight: FontWeight.w500, fontFamily: "CeraProMedium"),
                  ),
                ),

                // Container(
                //   width: MediaQuery.of(context).size.width / 1.2,
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.center,
                //     children: [
                //       Image.asset(
                //         "assets/img_197.png",
                //         height: 15,
                //         width: 15,
                //       ),
                //       Text(
                //         "- - - - - -",
                //         style: TextStyle(color: Color(0xFF9900FF), fontSize: 16, fontWeight: FontWeight.w600),
                //       ),
                //       Image.asset(
                //         "assets/img_197.png",
                //         height: 15,
                //         width: 15,
                //       ),
                //       Text(
                //         "- - - - - -",
                //         style: TextStyle(color: Color(0xFF9900FF), fontSize: 16, fontWeight: FontWeight.w600),
                //       ),
                //       Image.asset(
                //         "assets/img_197.png",
                //         height: 15,
                //         width: 15,
                //       ),
                //       Text(
                //         "- - - - - -",
                //         style: TextStyle(color: Color(0xFF9900FF), fontSize: 16, fontWeight: FontWeight.w600),
                //       ),
                //       Image.asset(
                //         "assets/img_197.png",
                //         height: 15,
                //         width: 15,
                //       ),
                //       Text(
                //         "- - - - - -",
                //         style: TextStyle(color: Color(0xFF9900FF), fontSize: 16, fontWeight: FontWeight.w600),
                //       ),
                //       Image.asset(
                //         "assets/img_197.png",
                //         height: 15,
                //         width: 15,
                //         color: Colors.grey,
                //       ),
                //     ],
                //   ),
                // ),
                //
                // Align(
                //   alignment: Alignment.centerLeft,
                //   child: Text(
                //     "3 items",
                //     style: TextStyle(color: Color(0xFF515151), fontSize: 12, fontWeight: FontWeight.w400, fontFamily: "CeraProMedium"),
                //   ),
                // ),

                SizedBox(
                  height: 10,
                ),

                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => OrderDetails(
                              purchaseData: widget.purchaseData,
                            ),
                          ),
                        );
                      },
                      child: Container(
                        child: DottedBorder(
                          color: Colors.grey, //color of dotted/dash line
                          strokeWidth: 1, //thickness of dash/dots
                          //10,6
                          dashPattern: [10, 6],
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                            child: Container(
                              //width: MediaQuery.of(context).size.width / 2.3,
                              width: MediaQuery.of(context).size.width / 2.35,
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 15.0),
                                    child: Image.asset(
                                      "assets/img_210.png",
                                      height: 35,
                                      width: 35,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          widget.purchaseData.date,
                                          style: TextStyle(
                                              color: Color(0xFFA299A8),
                                              fontSize: 10,
                                              fontWeight: FontWeight.w500,
                                              fontFamily: "CeraProMedium"),
                                          textAlign: TextAlign.left,
                                        ),
                                        Text(
                                          //widget.purchaseData.deliveryStatus,
                                          "On The Way",
                                          style: TextStyle(
                                              color: Color(0xFF10AA2A),
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              fontFamily: "CeraProMedium"),
                                          textAlign: TextAlign.left,
                                        ),
                                        // Text(
                                        //   widget.purchaseData.grandTotal,
                                        //   style: TextStyle(
                                        //       color: Color(0xFFA299A8),
                                        //       fontSize: 11,
                                        //       fontWeight: FontWeight.w500,
                                        //       fontFamily: "CeraProMedium"),
                                        //   textAlign: TextAlign.left,
                                        // ),
                                        // Text(
                                        //   "1 items",
                                        //   style: TextStyle(
                                        //       color: Color(0xFFA299A8),
                                        //       fontSize: 11,
                                        //       fontWeight: FontWeight.w400,
                                        //       fontFamily: "CeraProMedium"),
                                        //   textAlign: TextAlign.left,
                                        // ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(4, 0, 4, 0),
                    ),
                    DottedBorder(
                      color: Colors.grey, //color of dotted/dash line
                      strokeWidth: 1, //thickness of dash/dots
                      dashPattern: [10, 6],
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                        child: Container(
                          //width: MediaQuery.of(context).size.width / 2.3,
                          width: MediaQuery.of(context).size.width / 2.35,
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 15.0),
                                child: Image.asset(
                                  "assets/img_211.png",
                                  height: 35,
                                  width: 35,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 20.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      widget.purchaseData.date.replaceRange((upDate.toString()).length == 1 ? 1 : 0, 2, upDate.toString()),
                                      style: TextStyle(
                                          color: Color(0xFFA299A8), fontSize: 10, fontWeight: FontWeight.w500, fontFamily: "CeraProMedium"),
                                      textAlign: TextAlign.left,
                                    ),
                                    Text(
                                      //widget.purchaseData.deliveryStatus,
                                      "Picked",
                                      style: TextStyle(
                                          color: Color(0xFF515151), fontSize: 14, fontWeight: FontWeight.w500, fontFamily: "CeraProMedium"),
                                      textAlign: TextAlign.left,
                                    ),
                                    // Text(
                                    //   widget.purchaseData.grandTotal,
                                    //   style: TextStyle(
                                    //       color: Color(0xFFA299A8), fontSize: 11, fontWeight: FontWeight.w500, fontFamily: "CeraProMedium"),
                                    //   textAlign: TextAlign.left,
                                    // ),
                                    // Text(
                                    //   "1 items",
                                    //   style: TextStyle(
                                    //       color: Color(0xFFA299A8), fontSize: 11, fontWeight: FontWeight.w400, fontFamily: "CeraProMedium"),
                                    //   textAlign: TextAlign.left,
                                    // ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
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
    );
  }
}
