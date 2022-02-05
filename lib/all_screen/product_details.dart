import 'dart:convert';
import 'dart:developer';

import 'package:customer_ui/all_screen/cart_detailspage.dart';
import 'package:customer_ui/components/size_config.dart';
import 'package:customer_ui/components/styles.dart';
import 'package:customer_ui/components/utils.dart';
import 'package:customer_ui/controller/cartItemsController.dart';
import 'package:customer_ui/dataModel/breat_biscuit.dart';
import 'package:customer_ui/dataModel/product_details_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class GroceryDetails extends StatefulWidget {
  var detailsLink = "";
  var relatedProductLink = "";
  GroceryDetails({
    required this.detailsLink,
    required this.relatedProductLink,
  });

  @override
  _GroceryDetailsState createState() => _GroceryDetailsState();
}

class _GroceryDetailsState extends State<GroceryDetails> {
  var productsData = [];
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var controller = Get.put(CartItemsController());

  Future<void> addToCart(
    id,
    userId,
    quantity,
  ) async {
    log("user id $userId");
    var res = await http.post(Uri.parse("https://test.protidin.com.bd/api/v2/carts/add"),
        headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8', 'Authorization': 'Bearer ${box.read(userToken)}'},
        body: jsonEncode(<String, dynamic>{
          "id": id.toString(),
          "variant": "",
          "user_id": userId,
          "quantity": quantity,
        }));

    if (res.statusCode == 200 || res.statusCode == 201) {
      showToast("Cart Added Successfully", context: context);

      ///await updateAddressInCart(userId);
      await controller.getCartName();

      //await getCartSummary();
    } else {
      showToast("Something went wrong", context: context);
    }
  }

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
          "Product Details",
          style: TextStyle(color: kBlackColor, fontSize: 14),
        ),
        iconTheme: IconThemeData(color: kBlackColor),
        actions: [
          GestureDetector(
            onTap: () {
              if (!scaffoldKey.currentState!.isEndDrawerOpen) {
                //check if drawer is closed
                scaffoldKey.currentState!.openEndDrawer(); //open drawer
              }
            },
            child: Center(
              child: Icon(
                Icons.menu,
                color: kBlackColor,
              ),
            ),
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
                          children: const [
                            Icon(
                              Icons.share,
                              color: kBlackColor,
                            )
                          ],
                        ),
                        Center(
                          child: Image.network(
                            imagePath + productsData[index].thumbnailImage,
                            fit: BoxFit.cover,
                            height: height * 0.2,
                          ),
                        ),
                        sized30,
                        Text(
                          productsData[index].name,
                          style: TextStyle(color: kBlackColor, fontSize: block * 5, fontWeight: FontWeight.w500),
                        ),
                        sized15,
                        Text(
                          "${productsData[index].description ?? "No"} description Found",
                          style: TextStyle(color: kBlackColor.withOpacity(0.5), fontSize: block * 3.5, fontWeight: FontWeight.w300),
                        ),
                        sized15,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(productsData[index].baseDiscountedPrice,
                                    style: TextStyle(color: kBlackColor, fontSize: block * 4.5, fontWeight: FontWeight.bold)),
                                SizedBox(
                                  width: 15,
                                ),
                                Text(
                                  productsData[index].basePrice,
                                  style: TextStyle(
                                      color: kBlackColor,
                                      fontSize: block * 4,
                                      fontWeight: FontWeight.w300,
                                      decoration: TextDecoration.lineThrough),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                productsData[index].hasDiscount == true
                                    ? Container(
                                        height: height * 0.02,
                                        width: width * 0.15,
                                        decoration: BoxDecoration(color: Colors.green),
                                        child: Center(
                                          child: Text(
                                            "15% OFF",
                                            style: TextStyle(color: Colors.white, fontSize: block * 3, fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      )
                                    : Container(),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.wallet_travel_rounded,
                                  color: Colors.green,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text("BDT ${productsData[index].calculablePrice}",
                                    style: TextStyle(color: kBlackColor, fontSize: block * 4, fontWeight: FontWeight.w400)),
                              ],
                            )
                          ],
                        ),
                        sized15,
                        Container(
                          height: height * 0.05,
                          width: width,
                          padding: EdgeInsets.symmetric(horizontal: 5.0),
                          decoration: BoxDecoration(color: Colors.red[50], borderRadius: BorderRadius.circular(5.0)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Image.asset("assets/emo.png"),
                              Text(
                                "Member Price: BDT 690",
                                style: TextStyle(color: kBlackColor, fontSize: block * 3.5, fontWeight: FontWeight.w400),
                              ),
                              Text(
                                "Save BDT 20",
                                style: TextStyle(color: Colors.green, fontSize: block * 3.5, fontWeight: FontWeight.w400),
                              ),
                              Icon(
                                Icons.shopping_bag_outlined,
                                color: kBlackColor.withOpacity(0.3),
                              )
                            ],
                          ),
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
                        sized20,
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 100),
                            child: InkWell(
                              onTap: () {
                                addToCart(productsData[index].id, box.read(userID), 1);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Color(0xFF9900FF),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                height: 35,
                                width: 90,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Add",
                                      style: TextStyle(color: kWhiteColor, fontSize: block * 5, fontWeight: FontWeight.w500),
                                    ),
                                    width10,
                                    Icon(
                                      Icons.add,
                                      color: kWhiteColor,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        sized30,
                        SingleChildScrollView(
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Text("Related Product",
                                      style: TextStyle(color: kBlackColor, fontSize: block * 4.5, fontWeight: FontWeight.w700)),
                                  Text("Show more",
                                      style: TextStyle(color: kBlackColor, fontSize: block * 3.5, fontWeight: FontWeight.w500)),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                height: height,
                                width: width,
                                padding: EdgeInsets.all(10.0),
                                decoration: BoxDecoration(color: Colors.red[50], borderRadius: BorderRadius.circular(10.0)),
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.vertical,
                                    itemCount: relatedData.length,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemBuilder: (_, index) {
                                      return FittedBox(
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: const [
                                                //Text("Related", style: TextStyle(color: kBlackColor, fontSize: block * 4, fontWeight: FontWeight.bold)),
                                                //Text("Show more", style: TextStyle(color: kBlackColor, fontSize: block * 4, fontWeight: FontWeight.w300)),
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                Container(
                                                  //height: height * 0.15,
                                                  width: width,

                                                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0), color: kWhiteColor),
                                                  child: Row(
                                                    children: [
                                                      Container(
                                                        width: MediaQuery.of(context).size.width / 2.7,
                                                        child: InkWell(
                                                          onTap: () {
                                                            Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder: (context) => GroceryDetails(
                                                                          detailsLink: relatedData[index].links!.details!,
                                                                          relatedProductLink: "",
                                                                        )));
                                                          },
                                                          child: Image.network(
                                                            imagePath + relatedData[index].thumbnailImage,
                                                            fit: BoxFit.cover,
                                                            height: height * 0.2,
                                                          ),
                                                        ),
                                                      ),
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
                                                                  color: kBlackColor, fontSize: block * 4, fontWeight: FontWeight.w500),
                                                              maxLines: 2,
                                                            ),
                                                            sized5,
                                                            Container(
                                                              ///height: height * 0.02,
                                                              height: height * 0.028,
                                                              margin: EdgeInsets.only(top: 10),

                                                              ///width: width * 0.15,
                                                              width: width * 0.2,
                                                              decoration: BoxDecoration(color: Colors.green),
                                                              child: Center(
                                                                child: Text(
                                                                  "null",
                                                                  style: TextStyle(
                                                                      color: Colors.white,
                                                                      fontSize: block * 3,
                                                                      fontWeight: FontWeight.bold),
                                                                ),
                                                              ),
                                                            ),
                                                            sized5,
                                                            Row(
                                                              children: [
                                                                Row(
                                                                  children: [
                                                                    Text(relatedData[index].baseDiscountedPrice,
                                                                        style: TextStyle(
                                                                            color: kBlackColor,
                                                                            fontSize: block * 4.5,
                                                                            fontWeight: FontWeight.bold)),
                                                                    SizedBox(
                                                                      width: 10,
                                                                    ),
                                                                    Text(
                                                                      relatedData[index].basePrice,
                                                                      style: TextStyle(
                                                                          color: kBlackColor,
                                                                          fontSize: block * 4,
                                                                          fontWeight: FontWeight.w300,
                                                                          decoration: TextDecoration.lineThrough),
                                                                    )
                                                                  ],
                                                                ),
                                                                Expanded(child: Container()),
                                                                InkWell(
                                                                  onTap: () {
                                                                    addToCart(relatedData[index].id, box.read(userID), 1);
                                                                  },
                                                                  child: Container(
                                                                    padding: EdgeInsets.symmetric(horizontal: 7.0, vertical: 3.0),
                                                                    decoration: BoxDecoration(
                                                                      color: kPrimaryColor,
                                                                      borderRadius: BorderRadius.circular(20.0),
                                                                    ),
                                                                    child: Row(
                                                                      children: [
                                                                        Text("Add",
                                                                            style: TextStyle(
                                                                                color: kWhiteColor,
                                                                                fontSize: block * 4,
                                                                                fontWeight: FontWeight.bold)),
                                                                        Icon(
                                                                          Icons.add,
                                                                          color: kWhiteColor,
                                                                        )
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  width: 20,
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
                                                SizedBox(
                                                  height: 10,
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      );
                                    }),
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
      floatingActionButton: FloatingActionButton(
          elevation: 0.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //Icon(Icons.add_shopping_cart),

              Center(
                  child: Image.asset(
                "assets/pi.png",
                height: 45,
                width: 30,
              )),

              Obx(() => Text(
                    controller.cartLength.value.toString(),
                  )),
            ],
          ),
          backgroundColor: kPrimaryColor,
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => CartDetails()));
          }),
    );
  }

  Container uniteWidget(double height, double width, double block, String unit, Color borderColor) {
    return Container(
      height: height * 0.03,
      width: width * 0.13,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), border: Border.all(color: borderColor)),
      child: Center(
        child: Text(unit, style: TextStyle(color: kBlackColor, fontSize: block * 3.5, fontWeight: FontWeight.w400)),
      ),
    );
  }
}

/*
import 'dart:convert';
import 'dart:developer';

import 'package:customer_ui/all_screen/cart_detailspage.dart';
import 'package:customer_ui/components/size_config.dart';
import 'package:customer_ui/components/styles.dart';
import 'package:customer_ui/components/utils.dart';
import 'package:customer_ui/controller/cartItemsController.dart';
import 'package:customer_ui/dataModel/breat_biscuit.dart';
import 'package:customer_ui/dataModel/product_details_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:get/get.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class GroceryDetails extends StatefulWidget {
  var detailsLink = "";
  var relatedProductLink = "";
  GroceryDetails({
    required this.detailsLink,
    required this.relatedProductLink,
  });

  @override
  _GroceryDetailsState createState() => _GroceryDetailsState();
}

class _GroceryDetailsState extends State<GroceryDetails> {
  var productsData = [];
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var controller = Get.put(CartItemsController());

  Future<void> addToCart(
    id,
    userId,
    quantity,
  ) async {
    log("user id $userId");
    var res = await http.post(Uri.parse("https://test.protidin.com.bd/api/v2/carts/add"),
        headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8', 'Authorization': 'Bearer ${box.read(userToken)}'},
        body: jsonEncode(<String, dynamic>{
          "id": id.toString(),
          "variant": "",
          "user_id": userId,
          "quantity": quantity,
        }));

    if (res.statusCode == 200 || res.statusCode == 201) {
      showToast("Cart Added Successfully", context: context);

      ///await updateAddressInCart(userId);
      await controller.getCartName();

      //await getCartSummary();
    } else {
      showToast("Something went wrong", context: context);
    }
  }

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
            "Product Details",
            style: TextStyle(color: kBlackColor, fontSize: 14),
          ),
          iconTheme: IconThemeData(color: kBlackColor),
          actions: [
            GestureDetector(
              onTap: () {
                if (!scaffoldKey.currentState!.isEndDrawerOpen) {
                  //check if drawer is closed
                  scaffoldKey.currentState!.openEndDrawer(); //open drawer
                }
              },
              child: Center(
                child: Icon(
                  Icons.menu,
                  color: kBlackColor,
                ),
              ),
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
                            children: const [
                              Icon(
                                Icons.share,
                                color: kBlackColor,
                              )
                            ],
                          ),
                          Center(
                            child: Image.network(
                              imagePath + productsData[index].thumbnailImage,
                              fit: BoxFit.cover,
                              height: height * 0.2,
                            ),
                          ),
                          sized30,
                          Text(
                            productsData[index].name,
                            style: TextStyle(color: kBlackColor, fontSize: block * 5, fontWeight: FontWeight.w500),
                          ),
                          sized15,
                          Text(
                            "${productsData[index].description ?? "No"} description Found",
                            style: TextStyle(color: kBlackColor.withOpacity(0.5), fontSize: block * 3.5, fontWeight: FontWeight.w300),
                          ),
                          sized15,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text(productsData[index].baseDiscountedPrice,
                                      style: TextStyle(color: kBlackColor, fontSize: block * 4.5, fontWeight: FontWeight.bold)),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Text(
                                    productsData[index].basePrice,
                                    style: TextStyle(
                                        color: kBlackColor,
                                        fontSize: block * 4,
                                        fontWeight: FontWeight.w300,
                                        decoration: TextDecoration.lineThrough),
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  productsData[index].hasDiscount == true
                                      ? Container(
                                          height: height * 0.02,
                                          width: width * 0.15,
                                          decoration: BoxDecoration(color: Colors.green),
                                          child: Center(
                                            child: Text(
                                              "15% OFF",
                                              style: TextStyle(color: Colors.white, fontSize: block * 3, fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        )
                                      : Container(),
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.wallet_travel_rounded,
                                    color: Colors.green,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text("BDT ${productsData[index].calculablePrice}",
                                      style: TextStyle(color: kBlackColor, fontSize: block * 4, fontWeight: FontWeight.w400)),
                                ],
                              )
                            ],
                          ),
                          sized15,
                          Container(
                            height: height * 0.05,
                            width: width,
                            padding: EdgeInsets.symmetric(horizontal: 5.0),
                            decoration: BoxDecoration(color: Colors.red[50], borderRadius: BorderRadius.circular(5.0)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Image.asset("assets/emo.png"),
                                Text(
                                  "Member Price: BDT 690",
                                  style: TextStyle(color: kBlackColor, fontSize: block * 3.5, fontWeight: FontWeight.w400),
                                ),
                                Text(
                                  "Save BDT 20",
                                  style: TextStyle(color: Colors.green, fontSize: block * 3.5, fontWeight: FontWeight.w400),
                                ),
                                Icon(
                                  Icons.shopping_bag_outlined,
                                  color: kBlackColor.withOpacity(0.3),
                                )
                              ],
                            ),
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
                          sized20,
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 100),
                              child: InkWell(
                                onTap: () {
                                  addToCart(productsData[index].id, box.read(userID), 1);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Color(0xFF9900FF),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  height: 35,
                                  width: 90,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Add",
                                        style: TextStyle(color: kWhiteColor, fontSize: block * 5, fontWeight: FontWeight.w500),
                                      ),
                                      width10,
                                      Icon(
                                        Icons.add,
                                        color: kWhiteColor,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          sized30,
                          Center(
                            child: InkWell(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => CartDetails()));
                              },
                              child: CircleAvatar(
                                radius: 35,
                                backgroundColor: kPrimaryColor,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    //Icon(Icons.add_shopping_cart),

                                    Center(
                                        child: Image.asset(
                                      "assets/pi.png",
                                      height: 40,
                                      width: 40,
                                    )),

                                    Obx(() => Text(
                                          controller.cartLength.value.toString(),
                                        )),
                                  ],
                                ),
                              ),
                              /*Container(
                                height: 60,
                                width: MediaQuery.of(context).size.width / 4,
                                child: Image.asset("assets/img_160.png"),
                              ),*/
                            ),
                          ),
                          SingleChildScrollView(
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Text("Related Product",
                                        style: TextStyle(color: kBlackColor, fontSize: block * 4.5, fontWeight: FontWeight.w700)),
                                    Text("Show more",
                                        style: TextStyle(color: kBlackColor, fontSize: block * 4, fontWeight: FontWeight.w500)),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  height: height,
                                  width: width,
                                  padding: EdgeInsets.all(10.0),
                                  decoration: BoxDecoration(color: Colors.red[50], borderRadius: BorderRadius.circular(10.0)),
                                  child: ListView.builder(
                                      shrinkWrap: true,
                                      scrollDirection: Axis.vertical,
                                      itemCount: relatedData.length,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemBuilder: (_, index) {
                                        return FittedBox(
                                          child: Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: const [
                                                  //Text("Related", style: TextStyle(color: kBlackColor, fontSize: block * 4, fontWeight: FontWeight.bold)),
                                                  //Text("Show more", style: TextStyle(color: kBlackColor, fontSize: block * 4, fontWeight: FontWeight.w300)),
                                                ],
                                              ),
                                              Column(
                                                children: [
                                                  Container(
                                                    //height: height * 0.15,
                                                    width: width,
                                                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                                                    decoration:
                                                        BoxDecoration(borderRadius: BorderRadius.circular(10.0), color: kWhiteColor),
                                                    child: Row(
                                                      children: [
                                                        InkWell(
                                                          onTap: () {
                                                            Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder: (context) => GroceryDetails(
                                                                          detailsLink: relatedData[index].links!.details!,
                                                                          relatedProductLink: "",
                                                                        )));
                                                          },
                                                          child: Image.network(
                                                            imagePath + relatedData[index].thumbnailImage,
                                                            fit: BoxFit.cover,
                                                            height: height * 0.2,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        Expanded(
                                                          child: Column(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                            children: [
                                                              sized10,
                                                              Text(
                                                                relatedData[index].name,
                                                                style: TextStyle(
                                                                    color: kBlackColor, fontSize: block * 4, fontWeight: FontWeight.w500),
                                                                maxLines: 2,
                                                              ),
                                                              sized5,
                                                              Container(
                                                                height: height * 0.02,
                                                                margin: EdgeInsets.only(top: 10),
                                                                width: width * 0.15,
                                                                decoration: BoxDecoration(color: Colors.green),
                                                                child: Center(
                                                                  child: Text(
                                                                    "15% Off",
                                                                    style: TextStyle(
                                                                        color: Colors.white,
                                                                        fontSize: block * 3,
                                                                        fontWeight: FontWeight.bold),
                                                                  ),
                                                                ),
                                                              ),
                                                              sized5,
                                                              Row(
                                                                children: [
                                                                  Row(
                                                                    children: [
                                                                      Text(relatedData[index].baseDiscountedPrice,
                                                                          style: TextStyle(
                                                                              color: kBlackColor,
                                                                              fontSize: block * 4.5,
                                                                              fontWeight: FontWeight.bold)),
                                                                      SizedBox(
                                                                        width: 10,
                                                                      ),
                                                                      Text(
                                                                        relatedData[index].basePrice,
                                                                        style: TextStyle(
                                                                            color: kBlackColor,
                                                                            fontSize: block * 4,
                                                                            fontWeight: FontWeight.w300,
                                                                            decoration: TextDecoration.lineThrough),
                                                                      )
                                                                    ],
                                                                  ),
                                                                  Expanded(child: Container()),
                                                                  InkWell(
                                                                    onTap: () {
                                                                      addToCart(relatedData[index].id, box.read(userID), 1);
                                                                    },
                                                                    child: Container(
                                                                      padding: EdgeInsets.symmetric(horizontal: 7.0, vertical: 3.0),
                                                                      decoration: BoxDecoration(
                                                                        color: kPrimaryColor,
                                                                        borderRadius: BorderRadius.circular(20.0),
                                                                      ),
                                                                      child: Row(
                                                                        children: [
                                                                          Text("Add",
                                                                              style: TextStyle(
                                                                                  color: kWhiteColor,
                                                                                  fontSize: block * 4,
                                                                                  fontWeight: FontWeight.bold)),
                                                                          Icon(
                                                                            Icons.add,
                                                                            color: kWhiteColor,
                                                                          )
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    width: 20,
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
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        );
                                      }),
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
        ));
  }

  Container uniteWidget(double height, double width, double block, String unit, Color borderColor) {
    return Container(
      height: height * 0.03,
      width: width * 0.13,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), border: Border.all(color: borderColor)),
      child: Center(
        child: Text(unit, style: TextStyle(color: kBlackColor, fontSize: block * 3.5, fontWeight: FontWeight.w400)),
      ),
    );
  }
}

class RelatedMoreItems extends StatelessWidget {
  const RelatedMoreItems({
    Key? key,
    required this.width,
    required this.block,
    required this.height,
    this.image,
    this.productName,
    this.off,
    this.actualPrice,
    this.discountPrice,
  }) : super(key: key);

  final double width;
  final double block;
  final double height;
  final String? image;
  final String? productName;
  final String? off;
  final String? actualPrice;
  final String? discountPrice;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          //height: height * 0.15,
          width: width,
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0), color: kWhiteColor),
          child: Row(
            children: [
              Image.asset(image!),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    sized10,
                    Text(
                      productName!,
                      style: TextStyle(color: kBlackColor, fontSize: block * 4, fontWeight: FontWeight.w500),
                      maxLines: 2,
                    ),
                    sized5,
                    Container(
                      height: height * 0.05,
                      margin: EdgeInsets.only(top: 10),
                      width: width * 0.25,
                      decoration: BoxDecoration(color: Colors.green),
                      child: Center(
                        child: Text(
                          "$off Off",
                          style: TextStyle(color: Colors.white, fontSize: block * 3, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    sized5,
                    Row(
                      children: [
                        Row(
                          children: [
                            Text(discountPrice!, style: TextStyle(color: kBlackColor, fontSize: block * 4.5, fontWeight: FontWeight.bold)),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              actualPrice!,
                              style: TextStyle(
                                  color: kBlackColor,
                                  fontSize: block * 4,
                                  fontWeight: FontWeight.w300,
                                  decoration: TextDecoration.lineThrough),
                            )
                          ],
                        ),
                        Expanded(child: Container()),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 7.0, vertical: 3.0),
                          decoration: BoxDecoration(
                            color: kPrimaryColor,
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Row(
                            children: [
                              Text("Add", style: TextStyle(color: kWhiteColor, fontSize: block * 4, fontWeight: FontWeight.bold)),
                              Icon(
                                Icons.add,
                                color: kWhiteColor,
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 20,
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
        SizedBox(
          height: 20,
        ),
      ],
    );
  }
}

*/
