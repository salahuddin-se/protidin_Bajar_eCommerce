import 'dart:convert';
import 'dart:developer';

import 'package:customer_ui/all_screen/cart_detailspage.dart';
import 'package:customer_ui/components/size_config.dart';
import 'package:customer_ui/components/styles.dart';
import 'package:customer_ui/components/utils.dart';
import 'package:customer_ui/controller/cartItemsController.dart';
import 'package:customer_ui/dataModel/breat_biscuit.dart';
import 'package:customer_ui/dataModel/order_product_model.dart';
import 'package:customer_ui/dataModel/product_details_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';

class ProductDetails extends StatefulWidget {
  var detailsLink = "";
  var relatedProductLink = "";
  ProductDetails({
    required this.detailsLink,
    required this.relatedProductLink,
  });

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  var productsData = [];
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var controller = Get.put(CartItemsController());

  Future<void> getProductsDetails() async {
    final response = await get(Uri.parse(widget.detailsLink), headers: {"Accept": "application/json"});

    var dataMap = jsonDecode(response.body);

    if (dataMap["success"] == true) {
      log("data $dataMap");

      var productsDataMap = ProductDetailsDataModel.fromJson(dataMap);
      productsData = productsDataMap.data;
      setState(() {});
    } else {
      log("data invalid");
    }
  }

  var relatedData = [];
  Future<void> getRelatedProducts(link) async {
    log("get related product $link");
    log("calling 2");
    //String biscuitSweetsURl = "https://test.protidin.com.bd/api/v2/products/category/46";

    final response6 = await get(Uri.parse(link), headers: {"Accept": "application/json"});

    var biscuitSweetsDataMap = jsonDecode(response6.body);

    if (biscuitSweetsDataMap["success"] == true) {
      //log("category data after tap $biscuitSweetsDataMap");

      setState(() {
        //var biscuitSweetsDataModel = BiacuitSweets.fromJson(biscuitSweetsDataMap);
        var biscuitSweetsDataModel = BreadBiscuit.fromJson(biscuitSweetsDataMap);
        relatedData = biscuitSweetsDataModel.data;
      });
      log("categoryProducts data length ${relatedData.length}");
    } else {
      log("data invalid");
    }
    // log("after decode $dataMap");
  }

  Future<void> getrelatedData() async {
    final response2 = await get(Uri.parse(widget.relatedProductLink), headers: {"Accept": "application/json"});

    var dataMap2 = jsonDecode(response2.body);

    if (dataMap2["success"] == true) {
      log("data $dataMap2");

      //var productsDataMap2=BreadBiscuit.fromJson(dataMap2);
      var productsDataMap2 = BreadBiscuit.fromJson(dataMap2);
      relatedData = productsDataMap2.data;
      setState(() {});
    } else {
      log("data invalid");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    log("details Link ${widget.detailsLink} related link ${widget.relatedProductLink}");
    getProductsDetails();
    getRelatedProducts(widget.relatedProductLink);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var width = SizeConfig.screenWidth;
    var height = SizeConfig.screenHeight;
    var block = SizeConfig.block;
    return Scaffold(
      backgroundColor: kWhiteColor,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: kWhiteColor,
        centerTitle: true,
        title: Text(
          //"Product Details",
          "",
          style: TextStyle(color: kBlackColor, fontSize: 14),
        ),
        iconTheme: IconThemeData(color: kBlackColor),
        actions: [
          Icon(
            Icons.search,
            color: kBlackColor,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
          ),
          Icon(
            Icons.share,
            color: kBlackColor,
          ),
          SizedBox(
            width: 10,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: height,
              width: width,
              child: ListView.builder(
                itemCount: productsData.length,
                itemBuilder: (_, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 13.0, vertical: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: const [],
                        ),

                        SizedBox(
                          height: 5,
                        ),

                        Center(
                          child: Container(
                            width: MediaQuery.of(context).size.width / 1.3,
                            height: height * 0.32,
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 0.150,
                                color: Colors.grey,
                              ),
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.1),
                                  spreadRadius: 5, //spread radius
                                  blurRadius: 5, // blur radius
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 10,
                                ),
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Container(
                                    height: height * 0.035,
                                    width: width * 0.28,
                                    decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.circular(3),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "20% OFF",
                                        //"-৳ ${listOfProducts[index].discount.toString()}",
                                        style: TextStyle(color: Colors.white, fontSize: block * 3, fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                                Center(
                                  child: Image.network(
                                    imagePath + productsData[index].thumbnailImage,
                                    fit: BoxFit.cover,
                                    height: height * 0.25,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        sized30,
                        Text(
                          productsData[index].name,
                          style: TextStyle(color: kBlackColor, fontSize: block * 5, fontWeight: FontWeight.w500),
                        ),
                        sized20,
                        Row(
                          children: [
                            Text("Unit:", style: TextStyle(color: kBlackColor, fontSize: block * 3.5, fontWeight: FontWeight.w400)),
                            SizedBox(
                              width: 10.0,
                            ),
                            width10,
                            uniteWidget(height, width, block, productsData[index].unit, kPrimaryColor),
                          ],
                        ),
                        sized15,
                        productsData[index].description == null
                            ? Text("")
                            : Text(
                                productsData[index].description,
                                style: TextStyle(color: kBlackColor.withOpacity(0.5), fontSize: block * 3.5, fontWeight: FontWeight.w300),
                              ),
                        sized15,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  child: Image.asset(
                                    "assets/p.png",
                                    height: 30,
                                  ),
                                  height: 30,
                                  width: 30,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 4.0),
                                  child: Text(productsData[index].baseDiscountedPrice,
                                      style: TextStyle(
                                          color: Color(0xFF515151),
                                          fontSize: 22,
                                          fontWeight: FontWeight.w700,
                                          fontFamily: "CeraProMedium")),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                productsData[index].basePrice == productsData[index].baseDiscountedPrice
                                    ? Text("")
                                    : Text(
                                        productsData[index].basePrice,
                                        style: TextStyle(
                                            color: Color(0xFF515151),
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700,
                                            decoration: TextDecoration.lineThrough),
                                      ),
                                SizedBox(
                                  width: 15,
                                ),
                                // productsData[index].hasDiscount == true
                                //     ? Container(
                                //         height: height * 0.02,
                                //         width: width * 0.15,
                                //         decoration: BoxDecoration(color: Colors.green),
                                //         child: Center(
                                //           child: Text(
                                //             "15% off",
                                //             //"-৳ ${listOfProducts[index].discount.toString()}",
                                //             style: TextStyle(color: Colors.white, fontSize: block * 3, fontWeight: FontWeight.bold),
                                //           ),
                                //         ),
                                //       )
                                //     : Container(),
                              ],
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 4),
                                  child: Container(
                                    child: Image.asset(
                                      "assets/img_42.png",
                                      height: 24,
                                    ),
                                    height: 29,
                                    width: 22,
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text("৳12",
                                    style: TextStyle(
                                        color: Color(0xFF10AA2A), fontSize: 22, fontWeight: FontWeight.w700, fontFamily: "CeraProMedium")),
                                SizedBox(
                                  width: 10,
                                ),
                                Text("Earning",
                                    style: TextStyle(color: Color(0xFF10AA2A), fontSize: block * 4, fontWeight: FontWeight.w400)),
                              ],
                            )
                          ],
                        ),
                        // sized15,
                        // Container(
                        //   height: height * 0.05,
                        //   width: width,
                        //   padding: EdgeInsets.symmetric(horizontal: 5.0),
                        //   decoration: BoxDecoration(color: Color(0xFFF4EFF5), borderRadius: BorderRadius.circular(5.0)),
                        //   child: Row(
                        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //     children: [
                        //       Image.asset("assets/emo.png"),
                        //       Text(
                        //         "Member Price: ৳680",
                        //         style: TextStyle(color: kBlackColor, fontSize: block * 3.5, fontWeight: FontWeight.w400),
                        //       ),
                        //       Text(
                        //         "Save ৳20",
                        //         style: TextStyle(color: Colors.green, fontSize: block * 3.5, fontWeight: FontWeight.w400),
                        //       ),
                        //       Icon(
                        //         Icons.shopping_bag_outlined,
                        //         color: kBlackColor.withOpacity(0.3),
                        //       )
                        //     ],
                        //   ),
                        // ),
                        sized20,
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: InkWell(
                                onTap: () {
                                  controller.addToCart(
                                      OrderItemModel(
                                          productId: productsData[index].id,
                                          price: int.tryParse(productsData[index].basePrice!.toString().replaceAll('৳', '')),
                                          productThumbnailImage: productsData[index].thumbnailImage,
                                          productName: productsData[index].name,
                                          quantity: 1,
                                          userId: box.read(userID),
                                          variant: '',
                                          discount: productsData[index].discount,
                                          discountType: productsData[index].discountType,
                                          unit: productsData[index].unit),
                                      context);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Color(0xFF9900FF),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  height: 45,
                                  width: MediaQuery.of(context).size.width / 1.45,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Add to cart",
                                        style: TextStyle(
                                            color: Color(0xFFFFFFFF),
                                            fontSize: 20,
                                            fontWeight: FontWeight.w700,
                                            fontFamily: "CeraProMedium"),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(5, 0, 0, 4),
                              child: Container(
                                child: Image.asset(
                                  "assets/img_203.png",
                                  height: 45,
                                ),
                                height: 45,
                                width: MediaQuery.of(context).size.width / 7,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5), //border corner radius
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.2), //color of shadow
                                      spreadRadius: 5, //spread radius
                                      blurRadius: 7, // blur radius
                                      offset: Offset(0, 2), // changes position of shadow
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        sized30,
                        SingleChildScrollView(
                          child: Column(
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                height: height,
                                width: width,
                                padding: EdgeInsets.all(10.0),
                                decoration: BoxDecoration(color: Color(0xFFF4EFF5), borderRadius: BorderRadius.circular(10.0)),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text("Related",
                                              style: TextStyle(
                                                  color: kBlackColor,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w700,
                                                  fontFamily: "ceraProMedium")),
                                        ),
                                        Text(""),
                                        Text(""),
                                        Text(""),
                                        Text(""),
                                        Text("Show more",
                                            style: TextStyle(color: kBlackColor, fontSize: block * 3.5, fontWeight: FontWeight.w500)),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Expanded(
                                      child: ListView.builder(
                                          shrinkWrap: true,
                                          scrollDirection: Axis.vertical,
                                          itemCount: relatedData.length,
                                          //physics: NeverScrollableScrollPhysics(),
                                          physics: ScrollPhysics(),
                                          itemBuilder: (_, index) {
                                            return FittedBox(
                                              child: Stack(children: [
                                                Column(
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                                                      child: Container(
                                                        //height: height * 0.15,
                                                        width: width,
                                                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                                                        decoration:
                                                            BoxDecoration(borderRadius: BorderRadius.circular(10.0), color: kWhiteColor),
                                                        child: Row(
                                                          children: [
                                                            Stack(children: [
                                                              Container(
                                                                width: MediaQuery.of(context).size.width / 2.7,
                                                                child: InkWell(
                                                                  onTap: () {
                                                                    Navigator.push(
                                                                      context,
                                                                      MaterialPageRoute(
                                                                        builder: (context) => ProductDetails(
                                                                          detailsLink: relatedData[index].links!.details!,
                                                                          relatedProductLink: widget.relatedProductLink,
                                                                        ),
                                                                      ),
                                                                    );
                                                                  },
                                                                  child: Image.network(
                                                                    imagePath + relatedData[index].thumbnailImage,
                                                                    fit: BoxFit.cover,
                                                                    //height: height * 0.2,
                                                                    height: height * 0.2,
                                                                  ),
                                                                ),
                                                              ),
                                                              // Positioned(
                                                              //   top: 5,
                                                              //   //bottom: 20,
                                                              //   left: 0,
                                                              //   //right: 5,
                                                              //   child: relatedData[index].basePrice == relatedData[index].baseDiscountedPrice
                                                              //       ? Text("")
                                                              //       : Padding(
                                                              //           padding: const EdgeInsets.only(right: 0.0),
                                                              //           child: Align(
                                                              //             alignment: Alignment.centerLeft,
                                                              //             child: Container(
                                                              //               ///height: height * 0.02,
                                                              //               height: height * 0.035,
                                                              //               margin: EdgeInsets.only(top: 10),
                                                              //
                                                              //               ///width: width * 0.15,
                                                              //               width: width * 0.22,
                                                              //               decoration: BoxDecoration(color: Colors.green),
                                                              //               child: Center(
                                                              //                 child: Text(
                                                              //                   //"null",
                                                              //                   "${relatedData[index].discount.toString()}TK OFF",
                                                              //                   style: TextStyle(
                                                              //                       color: Colors.white,
                                                              //                       fontSize: block * 4,
                                                              //                       fontWeight: FontWeight.bold),
                                                              //                 ),
                                                              //               ),
                                                              //             ),
                                                              //           ),
                                                              //         ),
                                                              // ),
                                                            ]),
                                                            SizedBox(
                                                              width: 10,
                                                            ),
                                                            Container(
                                                              width: MediaQuery.of(context).size.width * 3 / 5.5,
                                                              child: Column(
                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                children: [
                                                                  sized10,
                                                                  Text(
                                                                    relatedData[index].name,
                                                                    style: TextStyle(
                                                                        color: Color(0xFF515151),
                                                                        fontSize: 17,
                                                                        fontWeight: FontWeight.w500,
                                                                        fontFamily: "CeraProMedium"),
                                                                    maxLines: 2,
                                                                  ),
                                                                  sized5,
                                                                  relatedData[index].basePrice == relatedData[index].baseDiscountedPrice
                                                                      ? Text("")
                                                                      : Container(
                                                                          ///height: height * 0.02,
                                                                          height: height * 0.028,
                                                                          margin: EdgeInsets.only(top: 10),

                                                                          ///width: width * 0.15,
                                                                          width: width * 0.2,

                                                                          child: Text(
                                                                            //"null",
                                                                            relatedData[index].unit,
                                                                            style: TextStyle(
                                                                                color: Color(0xFF515151),
                                                                                fontSize: 16,
                                                                                fontWeight: FontWeight.w400,
                                                                                fontFamily: "CeraProMedium"),
                                                                          ),
                                                                        ),
                                                                  sized5,
                                                                  Row(
                                                                    children: [
                                                                      Container(
                                                                        child: Image.asset(
                                                                          "assets/p.png",
                                                                          height: 22,
                                                                          width: 22,
                                                                        ),
                                                                        height: 22,
                                                                        width: 22,
                                                                      ),
                                                                      SizedBox(
                                                                        width: 5,
                                                                      ),
                                                                      Row(
                                                                        children: [
                                                                          Text(relatedData[index].baseDiscountedPrice,
                                                                              style: TextStyle(
                                                                                  color: Color(0xFF515151),
                                                                                  fontSize: 22,
                                                                                  fontWeight: FontWeight.w700,
                                                                                  fontFamily: "CeraProMedium")),
                                                                          SizedBox(
                                                                            width: 10,
                                                                          ),
                                                                          relatedData[index].basePrice ==
                                                                                  relatedData[index].baseDiscountedPrice
                                                                              ? Text("")
                                                                              : Text(
                                                                                  relatedData[index].basePrice,
                                                                                  style: TextStyle(
                                                                                      color: Color(0xFF515151),
                                                                                      fontSize: 14,
                                                                                      fontWeight: FontWeight.w400,
                                                                                      fontFamily: "CeraProMedium",
                                                                                      decoration: TextDecoration.lineThrough),
                                                                                ),
                                                                        ],
                                                                      ),
                                                                      Expanded(child: Container()),
                                                                      InkWell(
                                                                        onTap: () {
                                                                          controller.addToCart(
                                                                              OrderItemModel(
                                                                                  productId: relatedData[index].id,
                                                                                  price: int.tryParse(relatedData[index]
                                                                                      .basePrice!
                                                                                      .toString()
                                                                                      .replaceAll('৳', '')),
                                                                                  productThumbnailImage: relatedData[index].thumbnailImage,
                                                                                  productName: relatedData[index].name,
                                                                                  quantity: 1,
                                                                                  userId: box.read(userID),
                                                                                  variant: '',
                                                                                  discount: relatedData[index].discount,
                                                                                  discountType: relatedData[index].discountType,
                                                                                  unit: int.tryParse(relatedData[index].unit!.toString())),
                                                                              context);
                                                                        },
                                                                        child: Container(
                                                                          height: 39,
                                                                          width: 39,
                                                                          //decoration: BoxDecoration(color: kPrimaryColor, shape: BoxShape.circle),
                                                                          child: Center(
                                                                            child: Image.asset(
                                                                              "assets/img_193.png",
                                                                              height: 39,
                                                                              width: 39,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      SizedBox(
                                                                        width: 5,
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  sized10,
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Positioned(
                                                  top: 5,
                                                  //bottom: 20,
                                                  left: 0,
                                                  //right: 5,
                                                  child: relatedData[index].basePrice == relatedData[index].baseDiscountedPrice
                                                      ? Text("")
                                                      : Padding(
                                                          padding: const EdgeInsets.only(right: 0.0),
                                                          child: Align(
                                                            alignment: Alignment.centerLeft,
                                                            child: Container(
                                                              ///height: height * 0.02,
                                                              height: height * 0.035,
                                                              margin: EdgeInsets.only(top: 10),

                                                              ///width: width * 0.15,
                                                              width: width * 0.22,
                                                              decoration: BoxDecoration(color: Colors.green),
                                                              child: Center(
                                                                child: Text(
                                                                  //"null",
                                                                  "${relatedData[index].discount.toString()}TK OFF",
                                                                  style: TextStyle(
                                                                      color: Colors.white,
                                                                      fontSize: block * 4,
                                                                      fontWeight: FontWeight.bold),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                ),
                                              ]),
                                            );
                                          }),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              height: 20,
            )
          ],
        ),
      ),
      floatingActionButton: Container(
        // height: 85,
        // width: 85,
        height: 70,
        width: 70,
        child: FloatingActionButton(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //Icon(Icons.add_shopping_cart),

                Center(
                    child: Padding(
                  //padding: const EdgeInsets.fromLTRB(25, 0, 0, 0),
                  padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                  child: Image.asset(
                    "assets/cat.png",
                    height: 29,
                  ),
                )),

                Obx(() => Align(
                      alignment: Alignment.topRight,
                      child: CircleAvatar(
                        radius: 10.5,
                        backgroundColor: Colors.green[500],
                        child: Text(
                          controller.cartLength.value.toString(),
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800),
                        ),
                      ),
                    )),
              ],
            ),
            backgroundColor: Color(0xFF9900FF),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => CartDetailsPage()));
            }),
      ),
    );
  }

  Container uniteWidget(double height, double width, double block, String unit, Color borderColor) {
    return Container(
      height: height * 0.04,
      width: width * 0.16,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), border: Border.all(color: borderColor)),
      child: Center(
        child: Text(unit, style: TextStyle(color: Color(0xFF9900FF), fontSize: block * 3.5, fontWeight: FontWeight.w400)),
      ),
    );
  }
}
