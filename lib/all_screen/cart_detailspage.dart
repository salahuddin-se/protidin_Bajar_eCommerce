import 'dart:convert';
import 'dart:developer';

import 'package:customer_ui/all_screen/home_screen.dart';
import 'package:customer_ui/all_screen/payment_method_address.dart';
import 'package:customer_ui/components/apis.dart';
import 'package:customer_ui/components/drawers/drawer.dart';
import 'package:customer_ui/components/size_config.dart';
import 'package:customer_ui/components/styles.dart';
import 'package:customer_ui/components/utils.dart';
import 'package:customer_ui/controller/cartItemsController.dart';
import 'package:customer_ui/dataModel/breat_biscuit.dart';
import 'package:customer_ui/dataModel/cart_summary_model.dart';
import 'package:customer_ui/dataModel/order_product_model.dart';
import 'package:customer_ui/preferences/user_preferance.dart';
import 'package:customer_ui/welcomeScreen/sigininform.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class CartDetailsPage extends StatefulWidget {
  const CartDetailsPage({Key? key}) : super(key: key);

  @override
  _CartDetailsPageState createState() => _CartDetailsPageState();
}

class _CartDetailsPageState extends State<CartDetailsPage> {
  final TextEditingController _controller = TextEditingController();
  bool isLoaded = false;

  var scaffoldKey = GlobalKey<ScaffoldState>();

  var demo = [];
  int totalProducts = 0;
  var subTotal = "";
  var tax = "";
  var shipCost = "";
  var discount = "";
  var grand_Total = "";
  var ownerId = 0;
  var _quantity = "";
  var controller = Get.put(CartItemsController());
  var cartItemsList = [].obs;
  bool value1 = false;
  String value2 = "Cashback Bonus";
  String value3 = "Coupon Bonus";
  String value4 = "Refferel Bonus";

  ///
  // Future<void> addToCart(
  //   id,
  //   userId,
  //   quantity,
  // ) async {
  //   log("user id $userId");
  //   var res;
  //   bool isLocal = false;
  //   final jsonData = jsonEncode(<String, dynamic>{
  //     "id": id.toString(),
  //     "variant": "",
  //     "user_id": userId,
  //     "quantity": quantity,
  //   });
  //   if (UserPreference.getBool(UserPreference.isLoggedIn)!) {
  //     res = await http.post(
  //       Uri.parse("http://test.protidin.com.bd:88/api/v2/carts/add"),
  //       headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8', 'Authorization': 'Bearer ${box.read(userToken)}'},
  //       body: jsonData,
  //     );
  //   } else {
  //     box.write(cart_item, jsonData);
  //     isLocal = true;
  //   }
  //
  //   if (isLocal) {
  //     showToast("Cart Added Successfully", context: context);
  //
  //     ///await updateAddressInCart(userId);
  //     await controller.getCartName();
  //   } else {
  //     if (res.statusCode == 200 || res.statusCode == 201) {
  //       showToast("Cart Added Successfully", context: context);
  //
  //       ///await updateAddressInCart(userId);
  //       await controller.getCartName();
  //
  //       //await getCartSummary();
  //     } else {
  //       showToast("Something went wrong", context: context);
  //     }
  //   }
  //
  //   /////////
  //   //box.write(add_carts, addToCart(, box.read(userID), 1));
  //   ////////
  // }

  ///
  //var cartItemsList = [].obs;
  var bestProducts = [];
  Future<void> getBestSellersProduct() async {
    var res = await http.get(Uri.parse("http://test.protidin.com.bd:88/api/v2/products/best-seller"),
        headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8', 'Authorization': 'Bearer ${box.read(userToken)}'});

    log("cart Summary response= " + res.body);

    if (res.statusCode == 200) {
      var dataMap3 = jsonDecode(res.body);
      var productModel = BreadBiscuit.fromJson(dataMap3);
      bestProducts = productModel.data;
      setState(() {});
    }
  }

  Future<void> changeQuantity(id, userId, quantity) async {
    var res2 = await http.post(Uri.parse("http://test.protidin.com.bd:88/api/v2/carts/change-quantity"),
        headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8', 'Authorization': 'Bearer ${box.read(userToken)}'},
        body: jsonEncode(<String, dynamic>{"id": id, "variant": "", "user_id": userId, "quantity": quantity}));

    log("Response ${res2.body}");
    log("Response code  ${res2.statusCode}");

    if (res2.statusCode == 200 || res2.statusCode == 201) {
      await getCartSummary();
      showToast("Cart Updated Successfully", context: context);
      //getCartSummary();
    } else {
      showToast("Something went wrong", context: context);
    }
  }

  // Future<void> getCartSummary() async {
  //   var res;
  //   var localData;
  //   List<LogOutCartSummaryModel> orderItems = [];
  //   if (UserPreference.getBool(UserPreference.isLoggedIn)!) {
  //     res = await http.post(Uri.parse("$cartSummary/${box.read(userID)}"),
  //         headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8', 'Authorization': 'Bearer ${box.read(userToken)}'});
  //     // log("Response ${res.body}");
  //   } else {
  //     localData = box.read(cart_item);
  //     print('CARTDATA: $localData');
  //   }
  //   // log("Response code ${res.statusCode}");
  //   if (localData != null) {
  //     var dataMap = jsonDecode(localData);
  //     print('CARTDATA: $dataMap');
  //     orderItems = dataMap == null ? [] : List.from(dataMap.map((item) => LogOutCartSummaryModel.fromJson(item)));
  //     orderItems.forEach(
  //       (element) {
  //         cartItemsList.add(
  //           CartSummaryModel(
  //             subTotal: element.subTotal,
  //             tax: element.tax,
  //             grandTotal: element.grand_Total,
  //             discount: element.discount,
  //             shippingCost: element.shipCost,
  //             grandTotalValue: null,
  //             couponCode: '',
  //             couponApplied: null!,
  //           ),
  //         );
  //       },
  //     );
  //     // box.write(cart_length, cartLength);
  //     // log("total length ${cartItemsList.length}");
  //     // cartLength.value = cartItemsList.length;
  //   } else if (res != null) {
  //     if (res.statusCode == 200 || res.statusCode == 201) {
  //       var dataMap = jsonDecode(res.body);
  //       var cartSummaryModel = CartSummaryModel.fromJson(dataMap);
  //       subTotal = cartSummaryModel.subTotal;
  //       tax = cartSummaryModel.tax;
  //       shipCost = cartSummaryModel.shippingCost;
  //       discount = cartSummaryModel.discount;
  //       grand_Total = cartSummaryModel.grandTotal;
  //
  //       //await addToCart("", "", "");
  //       setState(() {});
  //       await controller.getCartName();
  //     }
  //   } else {
  //     //cartItemsList.value = [];
  //     //cartLength.value = 0;
  //   }
  // }

  // Future<void> getCartSummary() async {
  //   var res = await http.get(Uri.parse("$cartSummary/${box.read(userID)}"),
  //       headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8', 'Authorization': 'Bearer ${box.read(userToken)}'});
  //
  //   log("cart Summary response= " + res.body);
  //
  //   if (res.statusCode == 200) {
  //     var dataMap = jsonDecode(res.body);
  //     var cartSummaryModel = CartSummaryModel.fromJson(dataMap);
  //     subTotal = cartSummaryModel.subTotal;
  //     tax = cartSummaryModel.tax;
  //     shipCost = cartSummaryModel.shippingCost;
  //     discount = cartSummaryModel.discount;
  //     grand_Total = cartSummaryModel.grandTotal;
  //     //await addToCart("", "", "");
  //     setState(() {});
  //     await controller.getCartName();
  //   }
  // }

  Future<void> getCartSummary() async {
    var res = await http.get(Uri.parse("$cartSummary/${box.read(userID)}"),
        headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8', 'Authorization': 'Bearer ${box.read(userToken)}'});

    log("cart Summary response= " + res.body);

    if (res.statusCode == 200) {
      var dataMap = jsonDecode(res.body);
      var cartSummaryModel = CartSummaryModel.fromJson(dataMap);
      subTotal = cartSummaryModel.subTotal;
      tax = cartSummaryModel.tax;
      shipCost = cartSummaryModel.shippingCost;
      discount = cartSummaryModel.discount;
      grand_Total = cartSummaryModel.grandTotal;

      //await addToCart("", "", "");
      await controller.getCartName();

      setState(() {});
      // await getBestSellersProduct();
    }
  }

  _getLocalCartSummary(List<dynamic> cartItems) {
    int _subTotal = 0;
    int discountTotal = 0;
    int _grandTotal = 0;
    //int _shipCost = 0;

    for (var cartItem in cartItems) {
      _subTotal += cartItem.price as int;
      discountTotal += cartItem.discount as int;
      //_shipCost += cartItem.shipCost as int;
    }
    _grandTotal = _subTotal - discountTotal;

    subTotal = _subTotal.toString() + 'TK';
    tax = '0TK';
    //shipCost = _shipCost as String;
    discount = '${discountTotal}TK';
    grand_Total = _grandTotal.toString() + 'TK';
    setState(() {});
  }

  Future cartDeleteAPI(cartID) async {
    var res = await http.delete(Uri.parse("$cartDelete/$cartID"),
        headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8', 'Authorization': 'Bearer ${box.read(userToken)}'});

    if (res.statusCode == 200 || res.statusCode == 201) {
      showToast("Item delete Successfully", context: context);
      await getCartSummary();
      await controller.getCartName();
      // await Get.find<CartItemsController>().getCartName();

      setState(() {});
    }
  }

  @override

  //main
  void initState() {
    super.initState();
    _getAllData().then((value) {
      setState(() {
        isLoaded = true;
      });
    });

    setState(() {
      getBestSellersProduct();
    });
  }

  Future<void> _getAllData() async {
    getBestSellersProduct();
    if (UserPreference.getBool(UserPreference.isLoggedIn)!) {
      await getCartSummary();
    } else {
      _getLocalCartSummary(controller.cartItemsList);
    }
    _controller.text = "1"; // Setting the initial value for the field.

    await controller.getCartName();
  }

  final GlobalKey<ScaffoldState>? _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var width = SizeConfig.screenWidth;
    var height = SizeConfig.screenHeight;
    return Scaffold(
      key: scaffoldKey,
      endDrawer: SelectDrawer(),
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => CategoryHomeScreen()));
              },
              child: Image.asset(
                "assets/img_209.png",
                height: 15,
                width: 20,
              ),
            ),
            Text(
              "Cart",
              style: TextStyle(color: Color(0xFF515151), fontSize: 18, fontWeight: FontWeight.w700, fontFamily: "CeraProMedium"),
            ),
            InkWell(
              // onTap: () {
              //   if (!scaffoldKey.currentState!.isEndDrawerOpen) {
              //     //check if drawer is closed
              //     scaffoldKey.currentState!.openEndDrawer(); //open drawer
              //   }
              // },

              onTap: () {
                if (!_scaffoldKey!.currentState!.isEndDrawerOpen) {
                  //check if drawer is closed
                  _scaffoldKey!.currentState!.openEndDrawer(); //open drawer
                }
              },

              child: Center(
                  // child: Icon(
                  //   Icons.menu,
                  //   color: kBlackColor,
                  // ),
                  ),
            ),
          ],
        ),
        iconTheme: IconThemeData(color: kBlackColor),
        actions: [
          SizedBox(
            width: 10,
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: RefreshIndicator(
        onRefresh: () async {
          _getLocalCartSummary(controller.cartItemsList);
          setState(() {});
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              controller.cartItemsList.length != 0
                  ? Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        height: 50,
                        //width: 200,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15.0),
                          child: Text(
                            "Cart details",
                            style:
                                TextStyle(color: Color(0xFF515151), fontSize: 24, fontWeight: FontWeight.w400, fontFamily: "ceraProMedium"),
                          ),
                        ),
                      ),
                    )
                  : Text(("")),

              ///listview builder
              controller.cartItemsList.length != 0
                  ? isLoaded
                      ? Obx(
                          () => Container(
                            // height: MediaQuery.of(context).size.height / 1,
                            child: ListView.builder(
                              itemCount: controller.cartItemsList.length,
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (_, index) {
                                //var data=demo[index].product_name;
                                //return Text(demo[index].productName);
                                return Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(image: AssetImage("assets/img_40.png"), fit: BoxFit.cover),
                                    color: Colors.indigo[100],
                                    borderRadius: BorderRadius.circular(5),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.10),
                                        spreadRadius: 5, //spread radius
                                        blurRadius: 5, // blur radius
                                        offset: Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  height: 140,
                                  width: MediaQuery.of(context).size.width / 1.1,
                                  //color: Colors.cyan,
                                  child: FittedBox(
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(left: 10.0),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Stack(
                                          children: [
                                            InkWell(
                                              //ProductSinglePage1
                                              onTap: () {
                                                //Navigator.push(context, MaterialPageRoute(builder: (context) => GroceryDetails()));
                                              },
                                              child: Container(
                                                ///120
                                                height: 130,
                                                width: MediaQuery.of(context).size.width / 2.5,
                                                child: Image.network(
                                                  imagePath + controller.cartItemsList[index].productThumbnailImage,
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                              top: 5,
                                              //bottom: 20,
                                              left: 0,
                                              //right: 5,
                                              child: controller.cartItemsList[index].discount != null
                                                  ? Align(
                                                      alignment: Alignment.centerLeft,
                                                      child: controller.cartItemsList[index].discount == 0
                                                          ? Text("")
                                                          : Container(
                                                              decoration: BoxDecoration(
                                                                //color: Colors.indigo[100],
                                                                borderRadius: BorderRadius.circular(5),

                                                                boxShadow: const [
                                                                  BoxShadow(
                                                                    color: Colors.green,
                                                                  ),
                                                                ],
                                                              ),
                                                              //color: Colors.green,
                                                              height: 25,
                                                              width: 75,
                                                              child: Padding(
                                                                padding: const EdgeInsets.all(0),
                                                                child: Center(
                                                                  child: Text(
                                                                    "${controller.cartItemsList[index].discount.toString()}TK OFF",
                                                                    // "15% OFF",
                                                                    style: TextStyle(
                                                                        color: Colors.white, fontSize: 12, fontWeight: FontWeight.w900),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                    )
                                                  : Align(
                                                      alignment: Alignment.centerLeft,
                                                      child: Container(
                                                        decoration: BoxDecoration(
                                                          //color: Colors.indigo[100],
                                                          borderRadius: BorderRadius.circular(5),

                                                          boxShadow: const [
                                                            BoxShadow(
                                                              color: Colors.green,
                                                            ),
                                                          ],
                                                        ),
                                                        //color: Colors.green,
                                                        height: 25,
                                                        width: 75,
                                                        child: Padding(
                                                          padding: const EdgeInsets.all(0),
                                                          child: Center(
                                                            child: Text(
                                                              "15% OFF",
                                                              // "15% OFF",
                                                              style:
                                                                  TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w900),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                            ),
                                          ],
                                        ),
                                        Container(
                                          width: MediaQuery.of(context).size.width / 2.2,
                                          child: Column(
                                            children: [
                                              SizedBox(
                                                height: 5,
                                              ),

                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: Container(
                                                  height: 55,
                                                  //width: 200,
                                                  child: Text(
                                                    controller.cartItemsList[index].productName,
                                                    style: TextStyle(
                                                        color: Color(0xFF515151),
                                                        fontSize: 16,
                                                        fontWeight: FontWeight.w700,
                                                        fontFamily: "ceraProMedium"),
                                                  ),
                                                ),
                                              ),

                                              // dekhte hobe
                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: Container(
                                                  //color: Colors.green,
                                                  height: 20,
                                                  width: 90,
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(0),
                                                    child: Align(
                                                        alignment: Alignment.centerLeft,
                                                        child: controller.cartItemsList[index].unit != null
                                                            ? Text(
                                                                controller.cartItemsList[index].unit,
                                                                // "15% OFF",
                                                                style: TextStyle(
                                                                  color: Color(0xFF515151),
                                                                  fontSize: 16,
                                                                  fontWeight: FontWeight.w400,
                                                                  fontFamily: "ceraProMedium",
                                                                ),
                                                              )
                                                            : Text(
                                                                (""),
                                                              )),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    //'${_totalPrice}'
                                                    Container(
                                                      height: 25,
                                                      //width: 50,
                                                      child: Padding(
                                                        padding: const EdgeInsets.only(top: 3),
                                                        child: Row(
                                                          children: [
                                                            // Text(
                                                            //   "৳220",
                                                            //   style: TextStyle(
                                                            //       color: Color(0xFFA299A8),
                                                            //       fontSize: 18,
                                                            //       fontWeight: FontWeight.w400,
                                                            //       fontFamily: 'CeraProMedium',
                                                            //       decoration: TextDecoration.lineThrough),
                                                            // ),
                                                            Padding(
                                                              padding: const EdgeInsets.only(left: 4.0),
                                                              child: Text(
                                                                //"${demo[index].price}",
                                                                "${controller.cartItemsList[index].currencySymbol}${controller.cartItemsList[index].price}",
                                                                style: TextStyle(
                                                                    color: Colors.black,
                                                                    fontSize: 18,
                                                                    fontWeight: FontWeight.w700,
                                                                    fontFamily: "ceraProMedium"),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),

                                              //Padding(padding: const EdgeInsets.only(left: 50.0),),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Column(
                                          children: [
                                            SizedBox(
                                              height: 35,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(left: 60.0),
                                              child: Align(
                                                alignment: Alignment.centerRight,
                                                child: GestureDetector(
                                                  onTap: () => cartDeleteAPI(controller.cartItemsList[index].id),
                                                  child: Container(
                                                    child: Image.asset(
                                                      "assets/img_106.png",
                                                    ),
                                                    height: 40,
                                                    width: 40,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.fromLTRB(0, 40, 10, 20),
                                              child: Align(
                                                alignment: Alignment.bottomRight,
                                                child: Container(
                                                  width: MediaQuery.of(context).size.width / 3.6,
                                                  height: 40,
                                                  decoration: BoxDecoration(
                                                    color: Color(0xFFEFEFEF),
                                                    borderRadius: BorderRadius.circular(20),
                                                  ),
                                                  child: Center(
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      children: <Widget>[
                                                        FittedBox(
                                                          child: Container(
                                                            child: MaterialButton(
                                                                child: Icon(
                                                                  Icons.remove,
                                                                  color: Color(0xFF515151),
                                                                ),
                                                                onPressed: () {
                                                                  log("add click");
                                                                  controller.cartItemsList[index].quantity--;
                                                                  changeQuantity(controller.cartItemsList[index].id, "${box.read(userID)}",
                                                                      controller.cartItemsList[index].quantity);
                                                                  setState(
                                                                    () {},
                                                                  );
                                                                }),
                                                            width: MediaQuery.of(context).size.width / 10,
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding: const EdgeInsets.only(left: 10.0),
                                                          child: FittedBox(
                                                            child: Container(
                                                                width: 20,
                                                                child: Center(
                                                                    child: Text(
                                                                  "${controller.cartItemsList[index].quantity}",
                                                                  style: TextStyle(
                                                                      fontSize: 16,
                                                                      color: Color(0xFF9900FF),
                                                                      fontWeight: FontWeight.w700,
                                                                      fontFamily: "ceraProMedium"),
                                                                ))),
                                                          ),
                                                        ),
                                                        FittedBox(
                                                          child: Container(
                                                            child: MaterialButton(
                                                              child: Icon(
                                                                Icons.add,
                                                                color: Color(0xFF515151),
                                                              ),
                                                              onPressed: () {
                                                                log("add click");
                                                                controller.cartItemsList[index].quantity++;
                                                                changeQuantity(controller.cartItemsList[index].id, "${box.read(userID)}",
                                                                    controller.cartItemsList[index].quantity);
                                                                setState(() {});
                                                              },
                                                            ),
                                                            width: MediaQuery.of(context).size.width / 10,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        )
                      : Container()
                  : isLoaded
                      ? Container(
                          child: Column(
                            children: [
                              Container(
                                child: Image.asset(
                                  "assets/img_212.png",
                                ),
                                height: MediaQuery.of(context).size.height / 4.5,
                                width: MediaQuery.of(context).size.width / 2,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 0.0),
                                child: Center(
                                  child: Text(
                                    "no item in cart",
                                    style: TextStyle(
                                        color: Color(0xFF515151), fontSize: 24, fontWeight: FontWeight.w700, fontFamily: "ceraProMedium"),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 0.0),
                                child: Container(
                                  child: Center(
                                    child: Text(
                                      "all your favourite items are waiting for you at great discount ",
                                      style: TextStyle(
                                          color: Color(0xFFA299A8), fontSize: 16, fontWeight: FontWeight.w400, fontFamily: "ceraProMedium"),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  width: MediaQuery.of(context).size.width / 1.3,
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 0.0),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => CategoryHomeScreen()));
                                  },
                                  child: Container(
                                    child: Center(
                                      child: Text(
                                        "Start Shopping",
                                        style: TextStyle(
                                            color: Color(0xFFFFFFFF),
                                            fontSize: 20,
                                            fontWeight: FontWeight.w400,
                                            fontFamily: "ceraProMedium"),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    width: MediaQuery.of(context).size.width / 2.2,
                                    height: 35,
                                    decoration: BoxDecoration(
                                      color: Color(0xFF9900FF),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                            ],
                          ),
                        )
                      : Container(),

              /*
              Future.delayed(
      Duration(seconds: 3),
      () {
        // controller.getCartName().then((value) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CategoryHomeScreen(),
          ),
        );
        // });
      },
    );
              */

              SizedBox(
                height: 10,
              ),

              // ///congrates
              // Container(
              //   color: Colors.grey[100],
              //   width: MediaQuery.of(context).size.width / 1.1,
              //   child: Column(
              //     children: [
              //       Row(
              //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //         children: [
              //           Container(
              //             height: 40,
              //             width: MediaQuery.of(context).size.width / 4.5,
              //             child: Padding(
              //               padding: const EdgeInsets.only(top: 3),
              //               child: Image.asset(
              //                 "assets/img_102.png",
              //               ),
              //             ),
              //           ),
              //           Container(
              //             height: 68,
              //             width: MediaQuery.of(context).size.width / 1.7,
              //             child: Padding(
              //               padding: const EdgeInsets.only(top: 7),
              //               child: Text(
              //                 "Congratulations! your order is adjusted with ৳96 from your Protidin wallet. Spend more to adjust wallet !",
              //                 style: TextStyle(
              //                   color: Colors.black,
              //                   fontSize: 13,
              //                   fontWeight: FontWeight.w700,
              //                 ),
              //               ),
              //             ),
              //           ),
              //         ],
              //       ),
              //       Align(
              //         alignment: Alignment.centerLeft,
              //         child: Container(
              //           height: 28,
              //           width: MediaQuery.of(context).size.width / 3,
              //           child: Padding(
              //             padding: const EdgeInsets.fromLTRB(20, 5, 0, 0),
              //             child: Text(
              //               "Adjusted: ৳96 ",
              //               style: TextStyle(
              //                 color: Colors.black,
              //                 fontSize: 13,
              //                 fontWeight: FontWeight.w900,
              //               ),
              //             ),
              //           ),
              //         ),
              //       ),
              //       Align(
              //         alignment: Alignment.centerLeft,
              //         child: Container(
              //           height: 28,
              //           width: MediaQuery.of(context).size.width * 3 / 4,
              //           child: Padding(
              //             padding: const EdgeInsets.fromLTRB(20, 5, 0, 0),
              //             child: Text(
              //               "Walet balace after adjustment : ৳6304",
              //               style: TextStyle(
              //                 color: Colors.grey[400],
              //                 fontSize: 13,
              //                 fontWeight: FontWeight.w800,
              //               ),
              //             ),
              //           ),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),

              ///you may also like
              Container(
                width: MediaQuery.of(context).size.width / 1,
                color: Color(0xFFFAF2FF),
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        height: 35,
                        width: 280,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                          child: Text(
                            "You may also like",
                            style: TextStyle(
                              color: Color(0xFF515151),
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              fontFamily: "ceraProMedium",
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      height: 200,
                      width: double.infinity,
                      child: ListView.builder(
                          itemCount: bestProducts.length,
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (_, index) {
                            return Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Container(
                                height: 195,
                                width: 125,
                                child: Column(
                                  children: [
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Row(
                                        children: [
                                          bestProducts[index].discount == 0
                                              ? Text("")
                                              : Align(
                                                  alignment: Alignment.centerLeft,
                                                  child: Padding(
                                                    padding: const EdgeInsets.only(right: 30.0),
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        //color: Colors.indigo[100],
                                                        borderRadius: BorderRadius.circular(5),

                                                        boxShadow: const [
                                                          BoxShadow(
                                                            color: Colors.green,
                                                          ),
                                                        ],
                                                      ),
                                                      //color: Colors.green,
                                                      height: 22,
                                                      width: 75,
                                                      child: Padding(
                                                        padding: const EdgeInsets.all(0),
                                                        child: Center(
                                                          child: Text(
                                                            "${bestProducts[index].discount.toString()}TK OFF",
                                                            style:
                                                                TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w900),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                          //Padding(padding: const EdgeInsets.only(left: 75.0),),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10.0),
                                      child: Container(
                                        height: 90,
                                        width: 110,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: NetworkImage(imagePath + bestProducts[index].thumbnailImage), fit: BoxFit.cover),
                                        ),
                                        child: Align(
                                          alignment: Alignment.bottomRight,
                                          child: Container(
                                            height: 20,
                                            width: 40,
                                            //padding: const EdgeInsets.only(top: 0),
                                            child: InkWell(
                                              onTap: () async {
                                                await controller.addToCart(
                                                  OrderItemModel(
                                                    productId: bestProducts[index].id,
                                                    price: int.tryParse(
                                                        bestProducts[index].baseDiscountedPrice!.toString().replaceAll('৳', '')),
                                                    productThumbnailImage: bestProducts[index].thumbnailImage,
                                                    productName: bestProducts[index].name,
                                                    quantity: 1,
                                                    userId: box.read(userID),
                                                    variant: '',
                                                    discountType: bestProducts[index].discountType,
                                                    discount: bestProducts[index].discount,
                                                    unit: int.tryParse(bestProducts[index].unit!.toString()),
                                                  ),
                                                  context,
                                                );
                                                if (UserPreference.getBool(UserPreference.isLoggedIn)!) {
                                                  await getCartSummary();
                                                } else {
                                                  _getLocalCartSummary(controller.cartItemsList);
                                                }
                                              },
                                              child: Container(
                                                child: Image.asset(
                                                  "assets/img_104.png",
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
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
                                              bestProducts[index].name,
                                              style: TextStyle(
                                                  color: Color(0xFF515151),
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w700,
                                                  fontFamily: "ceraProMedium"),
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
                                            child: Text(
                                              bestProducts[index].unit,
                                              style: TextStyle(
                                                  color: Color(0xFF515151),
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.w700,
                                                  fontFamily: "ceraProMedium"),
                                            ),
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
                                              bestProducts[index].baseDiscountedPrice,
                                              style: TextStyle(
                                                  color: Color(0xFF515151),
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.w400,
                                                  fontFamily: "ceraProMedium"),
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
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),

              SizedBox(
                height: 20,
              ),

              ///order summary
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
                            "MRP (${box.read(cart_length) ?? 0} products)",
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
                              subTotal,
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
                              shipCost,
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
                              discount,
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

              SizedBox(
                height: 10,
              ),

              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage("assets/img_110.png"), fit: BoxFit.cover),

                  //color: Colors.white,
                  //borderRadius: BorderRadius.circular(20),
                ),
                height: 40,
                width: MediaQuery.of(context).size.width / 1.1,
                //color: Colors.cyan,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    width: MediaQuery.of(context).size.width / 4.5,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: Center(
                        child: Text(
                          grand_Total,
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
                ),
              ),

              SizedBox(
                height: 15,
              ),

              /// bonus box
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: DottedBorder(
                  color: Colors.black, //color of dotted/dash line
                  strokeWidth: 1.5, //thickness of dash/dots
                  dashPattern: [10, 6],

                  //color: Colors.black,
                  //gap: 3,
                  //strokeWidth: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width / 5,
                                child: Column(
                                  children: [
                                    CircleAvatar(
                                      radius: 35,
                                      backgroundColor: Color(0xFFF4EFF5),
                                      child: Image.asset(
                                        "assets/img_207.png",
                                        height: 25,
                                        width: 25,
                                        //color: Colors.grey,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Container(
                                      child: Text(
                                        "Registration Bonus",
                                        style: TextStyle(
                                          color: Color(0xFFA299A8),
                                          fontSize: 12,
                                          fontWeight: FontWeight.w700,
                                          fontFamily: 'CeraProMedium',
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width / 5,
                                child: Column(
                                  children: [
                                    CircleAvatar(
                                      radius: 35,
                                      backgroundColor: Color(0xFFF4EFF5),
                                      child: Image.asset(
                                        "assets/mo.png",
                                        height: 25,
                                        width: 25,
                                        //color: Colors.grey,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Container(
                                      child: Text(
                                        "Cashback Bonus",
                                        style: TextStyle(
                                          color: Color(0xFFA299A8),
                                          fontSize: 12,
                                          fontWeight: FontWeight.w700,
                                          fontFamily: 'CeraProMedium',
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width / 5,
                                child: Column(
                                  children: [
                                    CircleAvatar(
                                      radius: 35,
                                      backgroundColor: Color(0xFFF4EFF5),
                                      child: Image.asset(
                                        "assets/tic.png",
                                        height: 25,
                                        width: 25,
                                        //color: Colors.grey,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Container(
                                      child: Text(
                                        "Coupon Bonus",
                                        style: TextStyle(
                                          color: Color(0xFFA299A8),
                                          fontSize: 12,
                                          fontWeight: FontWeight.w700,
                                          fontFamily: 'CeraProMedium',
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width / 5,
                                child: Column(
                                  children: [
                                    CircleAvatar(
                                      radius: 35,
                                      backgroundColor: Color(0xFFF4EFF5),
                                      child: Image.asset(
                                        "assets/Users.png",
                                        height: 25,
                                        width: 25,
                                        //color: Colors.grey,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Container(
                                      child: Text(
                                        "Refferel Bonus",
                                        style: TextStyle(
                                          color: Color(0xFFA299A8),
                                          fontSize: 12,
                                          fontWeight: FontWeight.w700,
                                          fontFamily: 'CeraProMedium',
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                            child: Container(
                              color: Colors.white,
                              child: Row(
                                children: [
                                  Container(
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
                                    width: MediaQuery.of(context).size.width / 1.25,
                                    child: Row(
                                      children: [
                                        Container(
                                          width: MediaQuery.of(context).size.width / 1.7,
                                          child: Align(
                                            alignment: Alignment.centerRight,
                                            child: TextFormField(
                                              textAlign: TextAlign.center,
                                              decoration: InputDecoration(
                                                //border: InputBorder.none,
                                                //focusedBorder: InputBorder.none,
                                                //contentPadding: EdgeInsets.only(left: 5, bottom: 0, top: 0, right: 15),
                                                hintText: 'Enter Coupon Code',
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 15.0),
                                          child: Align(
                                            alignment: Alignment.centerRight,
                                            child: Container(
                                              //width: MediaQuery.of(context).size.width / 2,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(5),
                                                color: Color(0xFFF4EFF5),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  "Submit",
                                                  style: TextStyle(
                                                    color: Color(0xFFA299A8),
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w700,
                                                    fontFamily: 'CeraProMedium',
                                                  ),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                              height: 30,
                                              width: 55,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(
                height: 15,
              ),

              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage("assets/img_110.png"), fit: BoxFit.cover),
                ),
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
                                grand_Total,
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
                height: 20,
              ),

              Padding(
                padding: const EdgeInsets.fromLTRB(4, 0, 4, 0),
                child: Container(
                  width: MediaQuery.of(context).size.width / 1,
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
                        width: MediaQuery.of(context).size.width / 1.35,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: Center(
                            child: Text(
                              "Cash back received (Added to walet)",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
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
                height: 10,
              ),

              Container(
                width: MediaQuery.of(context).size.width / 1,
                height: 55,
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
                child: InkWell(
                  onTap: () {
                    UserPreference.getBool(UserPreference.isLoggedIn)!
                        ? Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PaymentAddress1stPage(
                                grandTotal: grand_Total,
                                ownerId: ownerId,
                                user_address: userAddress,
                              ),
                            ),
                          )
                        : Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (ctx) => SignInPage(
                                isFromCart: true,
                                orderList: controller.orderList,
                              ),
                            ),
                          );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: UserPreference.getBool(UserPreference.isLoggedIn)!
                            ? Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20.0),
                                    child: Image.asset(
                                      "assets/img_208.png",
                                      height: 20,
                                      width: 20,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 4),
                                    child: Text(
                                      " ${box.read(cart_length) ?? 0} items | $grand_Total",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                        fontFamily: "ceraProMedium",
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 18.0),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width / 2.5,
                                      child: Align(
                                        alignment: Alignment.centerRight,
                                        child: Padding(
                                          padding: const EdgeInsets.only(left: 0.0),
                                          child: Text(
                                            "Confirm",
                                            style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 7.0),
                                    child: Container(
                                      height: 20,
                                      width: 10,
                                      child: Padding(
                                        padding: const EdgeInsets.only(right: 0),
                                        child: Image.asset(
                                          "assets/img_115.png",
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 10.0),
                                  )
                                ],
                              )
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 30.0),
                                    child: Text(
                                      "Login to continue",
                                      style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w800),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 160.0),
                                    child: Container(
                                      height: 20,
                                      width: 10,
                                      child: Padding(
                                        padding: const EdgeInsets.only(right: 0),
                                        child: Image.asset(
                                          "assets/img_115.png",
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 10.0),
                                  )
                                ],
                              ),

                        ///width: 260,
                        //height: 40,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// new
/*
import 'dart:convert';
import 'dart:developer';

import 'package:customer_ui/all_screen/home_screen.dart';
import 'package:customer_ui/all_screen/payment_method_address.dart';
import 'package:customer_ui/components/apis.dart';
import 'package:customer_ui/components/drawers/drawer.dart';
import 'package:customer_ui/components/size_config.dart';
import 'package:customer_ui/components/styles.dart';
import 'package:customer_ui/components/utils.dart';
import 'package:customer_ui/controller/cartItemsController.dart';
import 'package:customer_ui/dataModel/breat_biscuit.dart';
import 'package:customer_ui/dataModel/cart_summary_model.dart';
import 'package:customer_ui/dataModel/order_product_model.dart';
import 'package:customer_ui/preferences/user_preferance.dart';
import 'package:customer_ui/welcomeScreen/sigininform.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class CartDetailsPage extends StatefulWidget {
  const CartDetailsPage({Key? key}) : super(key: key);

  @override
  _CartDetailsPageState createState() => _CartDetailsPageState();
}

class _CartDetailsPageState extends State<CartDetailsPage> {
  final TextEditingController _controller = TextEditingController();
  bool isLoaded = false;

  var scaffoldKey = GlobalKey<ScaffoldState>();

  var demo = [];
  int totalProducts = 0;
  var subTotal = "";
  var tax = "";
  var shipCost = "";
  var discount = "";
  var grand_Total = "";
  var ownerId = 0;
  var _quantity = "";
  var controller = Get.put(CartItemsController());
  var cartItemsList = [].obs;
  bool value1 = false;
  String value2 = "Cashback Bonus";
  String value3 = "Coupon Bonus";
  String value4 = "Refferel Bonus";

  ///
  // Future<void> addToCart(
  //   id,
  //   userId,
  //   quantity,
  // ) async {
  //   log("user id $userId");
  //   var res;
  //   bool isLocal = false;
  //   final jsonData = jsonEncode(<String, dynamic>{
  //     "id": id.toString(),
  //     "variant": "",
  //     "user_id": userId,
  //     "quantity": quantity,
  //   });
  //   if (UserPreference.getBool(UserPreference.isLoggedIn)!) {
  //     res = await http.post(
  //       Uri.parse("http://test.protidin.com.bd:88/api/v2/carts/add"),
  //       headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8', 'Authorization': 'Bearer ${box.read(userToken)}'},
  //       body: jsonData,
  //     );
  //   } else {
  //     box.write(cart_item, jsonData);
  //     isLocal = true;
  //   }
  //
  //   if (isLocal) {
  //     showToast("Cart Added Successfully", context: context);
  //
  //     ///await updateAddressInCart(userId);
  //     await controller.getCartName();
  //   } else {
  //     if (res.statusCode == 200 || res.statusCode == 201) {
  //       showToast("Cart Added Successfully", context: context);
  //
  //       ///await updateAddressInCart(userId);
  //       await controller.getCartName();
  //
  //       //await getCartSummary();
  //     } else {
  //       showToast("Something went wrong", context: context);
  //     }
  //   }
  //
  //   /////////
  //   //box.write(add_carts, addToCart(, box.read(userID), 1));
  //   ////////
  // }

  ///
  //var cartItemsList = [].obs;
  var bestProducts = [];
  Future<void> getBestSellersProduct() async {
    var res = await http.get(Uri.parse("http://test.protidin.com.bd:88/api/v2/products/best-seller"),
        headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8', 'Authorization': 'Bearer ${box.read(userToken)}'});

    log("cart Summary response= " + res.body);

    if (res.statusCode == 200) {
      var dataMap3 = jsonDecode(res.body);
      var productModel = BreadBiscuit.fromJson(dataMap3);
      bestProducts = productModel.data;
      setState(() {});
    }
  }

  Future<void> changeQuantity(id, userId, quantity) async {
    var res2 = await http.post(Uri.parse("http://test.protidin.com.bd:88/api/v2/carts/change-quantity"),
        headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8', 'Authorization': 'Bearer ${box.read(userToken)}'},
        body: jsonEncode(<String, dynamic>{"id": id, "variant": "", "user_id": userId, "quantity": quantity}));

    log("Response ${res2.body}");
    log("Response code  ${res2.statusCode}");

    if (res2.statusCode == 200 || res2.statusCode == 201) {
      await getCartSummary();
      showToast("Cart Updated Successfully", context: context);
      //getCartSummary();
    } else {
      showToast("Something went wrong", context: context);
    }
  }

  // Future<void> getCartSummary() async {
  //   var res;
  //   var localData;
  //   List<LogOutCartSummaryModel> orderItems = [];
  //   if (UserPreference.getBool(UserPreference.isLoggedIn)!) {
  //     res = await http.post(Uri.parse("$cartSummary/${box.read(userID)}"),
  //         headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8', 'Authorization': 'Bearer ${box.read(userToken)}'});
  //     // log("Response ${res.body}");
  //   } else {
  //     localData = box.read(cart_item);
  //     print('CARTDATA: $localData');
  //   }
  //   // log("Response code ${res.statusCode}");
  //   if (localData != null) {
  //     var dataMap = jsonDecode(localData);
  //     print('CARTDATA: $dataMap');
  //     orderItems = dataMap == null ? [] : List.from(dataMap.map((item) => LogOutCartSummaryModel.fromJson(item)));
  //     orderItems.forEach(
  //       (element) {
  //         cartItemsList.add(
  //           CartSummaryModel(
  //             subTotal: element.subTotal,
  //             tax: element.tax,
  //             grandTotal: element.grand_Total,
  //             discount: element.discount,
  //             shippingCost: element.shipCost,
  //             grandTotalValue: null,
  //             couponCode: '',
  //             couponApplied: null!,
  //           ),
  //         );
  //       },
  //     );
  //     // box.write(cart_length, cartLength);
  //     // log("total length ${cartItemsList.length}");
  //     // cartLength.value = cartItemsList.length;
  //   } else if (res != null) {
  //     if (res.statusCode == 200 || res.statusCode == 201) {
  //       var dataMap = jsonDecode(res.body);
  //       var cartSummaryModel = CartSummaryModel.fromJson(dataMap);
  //       subTotal = cartSummaryModel.subTotal;
  //       tax = cartSummaryModel.tax;
  //       shipCost = cartSummaryModel.shippingCost;
  //       discount = cartSummaryModel.discount;
  //       grand_Total = cartSummaryModel.grandTotal;
  //
  //       //await addToCart("", "", "");
  //       setState(() {});
  //       await controller.getCartName();
  //     }
  //   } else {
  //     //cartItemsList.value = [];
  //     //cartLength.value = 0;
  //   }
  // }

  // Future<void> getCartSummary() async {
  //   var res = await http.get(Uri.parse("$cartSummary/${box.read(userID)}"),
  //       headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8', 'Authorization': 'Bearer ${box.read(userToken)}'});
  //
  //   log("cart Summary response= " + res.body);
  //
  //   if (res.statusCode == 200) {
  //     var dataMap = jsonDecode(res.body);
  //     var cartSummaryModel = CartSummaryModel.fromJson(dataMap);
  //     subTotal = cartSummaryModel.subTotal;
  //     tax = cartSummaryModel.tax;
  //     shipCost = cartSummaryModel.shippingCost;
  //     discount = cartSummaryModel.discount;
  //     grand_Total = cartSummaryModel.grandTotal;
  //     //await addToCart("", "", "");
  //     setState(() {});
  //     await controller.getCartName();
  //   }
  // }

  Future<void> getCartSummary() async {
    var res = await http.get(Uri.parse("$cartSummary/${box.read(userID)}"),
        headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8', 'Authorization': 'Bearer ${box.read(userToken)}'});

    log("cart Summary response= " + res.body);

    if (res.statusCode == 200) {
      var dataMap = jsonDecode(res.body);
      var cartSummaryModel = CartSummaryModel.fromJson(dataMap);
      subTotal = cartSummaryModel.subTotal;
      tax = cartSummaryModel.tax;
      shipCost = cartSummaryModel.shippingCost;
      discount = cartSummaryModel.discount;
      grand_Total = cartSummaryModel.grandTotal;

      //await addToCart("", "", "");
      await controller.getCartName();

      setState(() {});
      // await getBestSellersProduct();
    }
  }

  _getLocalCartSummary(List<dynamic> cartItems) {
    int _subTotal = 0;
    int discountTotal = 0;
    int _grandTotal = 0;
    //int _shipCost = 0;

    for (var cartItem in cartItems) {
      _subTotal += cartItem.price as int;
      discountTotal += cartItem.discount as int;
      //_shipCost += cartItem.shipCost as int;
    }
    _grandTotal = _subTotal - discountTotal;

    subTotal = _subTotal.toString() + 'TK';
    tax = '0TK';
    //shipCost = _shipCost as String;
    discount = '${discountTotal}TK';
    grand_Total = _grandTotal.toString() + 'TK';
    setState(() {});
  }

  Future cartDeleteAPI(cartID) async {
    var res = await http.delete(Uri.parse("$cartDelete/$cartID"),
        headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8', 'Authorization': 'Bearer ${box.read(userToken)}'});

    if (res.statusCode == 200 || res.statusCode == 201) {
      showToast("Item delete Successfully", context: context);
      await getCartSummary();
      await controller.getCartName();
      // await Get.find<CartItemsController>().getCartName();

      setState(() {});
    }
  }

  @override

  //main
  void initState() {
    super.initState();
    _getAllData().then((value) {
      setState(() {
        isLoaded = true;
      });
    });

    setState(() {
      getBestSellersProduct();
    });
  }

  Future<void> _getAllData() async {
    getBestSellersProduct();
    if (UserPreference.getBool(UserPreference.isLoggedIn)!) {
      await getCartSummary();
    } else {
      _getLocalCartSummary(controller.cartItemsList);
    }
    _controller.text = "1"; // Setting the initial value for the field.

    await controller.getCartName();
  }

  final GlobalKey<ScaffoldState>? _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var width = SizeConfig.screenWidth;
    var height = SizeConfig.screenHeight;
    return Scaffold(
      key: scaffoldKey,
      endDrawer: SelectDrawer(),
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => CategoryHomeScreen()));
              },
              child: Image.asset(
                "assets/img_209.png",
                height: 15,
                width: 20,
              ),
            ),
            Text(
              "Cart",
              style: TextStyle(color: Color(0xFF515151), fontSize: 18, fontWeight: FontWeight.w700, fontFamily: "CeraProMedium"),
            ),
            InkWell(
              // onTap: () {
              //   if (!scaffoldKey.currentState!.isEndDrawerOpen) {
              //     //check if drawer is closed
              //     scaffoldKey.currentState!.openEndDrawer(); //open drawer
              //   }
              // },

              onTap: () {
                if (!_scaffoldKey!.currentState!.isEndDrawerOpen) {
                  //check if drawer is closed
                  _scaffoldKey!.currentState!.openEndDrawer(); //open drawer
                }
              },

              child: Center(
                  // child: Icon(
                  //   Icons.menu,
                  //   color: kBlackColor,
                  // ),
                  ),
            ),
          ],
        ),
        iconTheme: IconThemeData(color: kBlackColor),
        actions: [
          SizedBox(
            width: 10,
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: RefreshIndicator(
        onRefresh: () async {
          _getLocalCartSummary(controller.cartItemsList);
          setState(() {});
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              controller.cartItemsList.length != 0
                  ? Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        height: 50,
                        //width: 200,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15.0),
                          child: Text(
                            "Cart details",
                            style:
                                TextStyle(color: Color(0xFF515151), fontSize: 24, fontWeight: FontWeight.w400, fontFamily: "ceraProMedium"),
                          ),
                        ),
                      ),
                    )
                  : Text(("")),

              ///listview builder
              controller.cartItemsList.length != 0
                  ? isLoaded
                      ? Obx(
                          () => Container(
                            // height: MediaQuery.of(context).size.height / 1,
                            child: ListView.builder(
                              itemCount: controller.cartItemsList.length,
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (_, index) {
                                //var data=demo[index].product_name;
                                //return Text(demo[index].productName);
                                return Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(image: AssetImage("assets/img_40.png"), fit: BoxFit.cover),
                                    color: Colors.indigo[100],
                                    borderRadius: BorderRadius.circular(5),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.10),
                                        spreadRadius: 5, //spread radius
                                        blurRadius: 5, // blur radius
                                        offset: Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  height: 140,
                                  width: MediaQuery.of(context).size.width / 1.1,
                                  //color: Colors.cyan,
                                  child: FittedBox(
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(left: 10.0),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Stack(
                                          children: [
                                            InkWell(
                                              //ProductSinglePage1
                                              onTap: () {
                                                //Navigator.push(context, MaterialPageRoute(builder: (context) => GroceryDetails()));
                                              },
                                              child: Container(
                                                ///120
                                                height: 130,
                                                width: MediaQuery.of(context).size.width / 2.5,
                                                child: Image.network(
                                                  imagePath + controller.cartItemsList[index].productThumbnailImage,
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                              top: 5,
                                              //bottom: 20,
                                              left: 0,
                                              //right: 5,
                                              child: controller.cartItemsList[index].discount != null
                                                  ? Align(
                                                      alignment: Alignment.centerLeft,
                                                      child: controller.cartItemsList[index].discount == 0
                                                          ? Text("")
                                                          : Container(
                                                              decoration: BoxDecoration(
                                                                //color: Colors.indigo[100],
                                                                borderRadius: BorderRadius.circular(5),

                                                                boxShadow: const [
                                                                  BoxShadow(
                                                                    color: Colors.green,
                                                                  ),
                                                                ],
                                                              ),
                                                              //color: Colors.green,
                                                              height: 25,
                                                              width: 75,
                                                              child: Padding(
                                                                padding: const EdgeInsets.all(0),
                                                                child: Center(
                                                                  child: Text(
                                                                    "${controller.cartItemsList[index].discount.toString()}TK OFF",
                                                                    // "15% OFF",
                                                                    style: TextStyle(
                                                                        color: Colors.white, fontSize: 12, fontWeight: FontWeight.w900),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                    )
                                                  : Align(
                                                      alignment: Alignment.centerLeft,
                                                      child: Container(
                                                        decoration: BoxDecoration(
                                                          //color: Colors.indigo[100],
                                                          borderRadius: BorderRadius.circular(5),

                                                          boxShadow: const [
                                                            BoxShadow(
                                                              color: Colors.green,
                                                            ),
                                                          ],
                                                        ),
                                                        //color: Colors.green,
                                                        height: 25,
                                                        width: 75,
                                                        child: Padding(
                                                          padding: const EdgeInsets.all(0),
                                                          child: Center(
                                                            child: Text(
                                                              "15% OFF",
                                                              // "15% OFF",
                                                              style:
                                                                  TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w900),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                            ),
                                          ],
                                        ),
                                        Container(
                                          width: MediaQuery.of(context).size.width / 2.2,
                                          child: Column(
                                            children: [
                                              SizedBox(
                                                height: 5,
                                              ),

                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: Container(
                                                  height: 55,
                                                  //width: 200,
                                                  child: Text(
                                                    controller.cartItemsList[index].productName,
                                                    style: TextStyle(
                                                        color: Color(0xFF515151),
                                                        fontSize: 16,
                                                        fontWeight: FontWeight.w700,
                                                        fontFamily: "ceraProMedium"),
                                                  ),
                                                ),
                                              ),

                                              // dekhte hobe
                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: Container(
                                                  //color: Colors.green,
                                                  height: 20,
                                                  width: 90,
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(0),
                                                    child: Align(
                                                        alignment: Alignment.centerLeft,
                                                        child: controller.cartItemsList[index].unit != null
                                                            ? Text(
                                                                controller.cartItemsList[index].unit,
                                                                // "15% OFF",
                                                                style: TextStyle(
                                                                  color: Color(0xFF515151),
                                                                  fontSize: 16,
                                                                  fontWeight: FontWeight.w400,
                                                                  fontFamily: "ceraProMedium",
                                                                ),
                                                              )
                                                            : Text(
                                                                (""),
                                                              )),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    //'${_totalPrice}'
                                                    Container(
                                                      height: 25,
                                                      //width: 50,
                                                      child: Padding(
                                                        padding: const EdgeInsets.only(top: 3),
                                                        child: Row(
                                                          children: [
                                                            // Text(
                                                            //   "৳220",
                                                            //   style: TextStyle(
                                                            //       color: Color(0xFFA299A8),
                                                            //       fontSize: 18,
                                                            //       fontWeight: FontWeight.w400,
                                                            //       fontFamily: 'CeraProMedium',
                                                            //       decoration: TextDecoration.lineThrough),
                                                            // ),
                                                            Padding(
                                                              padding: const EdgeInsets.only(left: 4.0),
                                                              child: Text(
                                                                //"${demo[index].price}",
                                                                "${controller.cartItemsList[index].currencySymbol}${controller.cartItemsList[index].price}",
                                                                style: TextStyle(
                                                                    color: Colors.black,
                                                                    fontSize: 18,
                                                                    fontWeight: FontWeight.w700,
                                                                    fontFamily: "ceraProMedium"),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),

                                              //Padding(padding: const EdgeInsets.only(left: 50.0),),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Column(
                                          children: [
                                            SizedBox(
                                              height: 35,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(left: 60.0),
                                              child: Align(
                                                alignment: Alignment.centerRight,
                                                child: GestureDetector(
                                                  onTap: () => cartDeleteAPI(controller.cartItemsList[index].id),
                                                  child: Container(
                                                    child: Image.asset(
                                                      "assets/img_106.png",
                                                    ),
                                                    height: 40,
                                                    width: 40,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.fromLTRB(0, 40, 10, 20),
                                              child: Align(
                                                alignment: Alignment.bottomRight,
                                                child: Container(
                                                  width: MediaQuery.of(context).size.width / 3.6,
                                                  height: 40,
                                                  decoration: BoxDecoration(
                                                    color: Color(0xFFEFEFEF),
                                                    borderRadius: BorderRadius.circular(20),
                                                  ),
                                                  child: Center(
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      children: <Widget>[
                                                        FittedBox(
                                                          child: Container(
                                                            child: MaterialButton(
                                                                child: Icon(
                                                                  Icons.remove,
                                                                  color: Color(0xFF515151),
                                                                ),
                                                                onPressed: () {
                                                                  log("add click");
                                                                  controller.cartItemsList[index].quantity--;
                                                                  changeQuantity(controller.cartItemsList[index].id, "${box.read(userID)}",
                                                                      controller.cartItemsList[index].quantity);
                                                                  setState(
                                                                    () {},
                                                                  );
                                                                }),
                                                            width: MediaQuery.of(context).size.width / 10,
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding: const EdgeInsets.only(left: 10.0),
                                                          child: FittedBox(
                                                            child: Container(
                                                                width: 20,
                                                                child: Center(
                                                                    child: Text(
                                                                  "${controller.cartItemsList[index].quantity}",
                                                                  style: TextStyle(
                                                                      fontSize: 16,
                                                                      color: Color(0xFF9900FF),
                                                                      fontWeight: FontWeight.w700,
                                                                      fontFamily: "ceraProMedium"),
                                                                ))),
                                                          ),
                                                        ),
                                                        FittedBox(
                                                          child: Container(
                                                            child: MaterialButton(
                                                              child: Icon(
                                                                Icons.add,
                                                                color: Color(0xFF515151),
                                                              ),
                                                              onPressed: () {
                                                                log("add click");
                                                                controller.cartItemsList[index].quantity++;
                                                                changeQuantity(controller.cartItemsList[index].id, "${box.read(userID)}",
                                                                    controller.cartItemsList[index].quantity);
                                                                setState(() {});
                                                              },
                                                            ),
                                                            width: MediaQuery.of(context).size.width / 10,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        )
                      : Container()
                  : Container(
                      child: Column(
                        children: [
                          Container(
                            child: Image.asset(
                              "assets/img_212.png",
                            ),
                            height: MediaQuery.of(context).size.height / 4.5,
                            width: MediaQuery.of(context).size.width / 2,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 0.0),
                            child: Center(
                              child: Text(
                                "no item in cart",
                                style: TextStyle(
                                    color: Color(0xFF515151), fontSize: 24, fontWeight: FontWeight.w700, fontFamily: "ceraProMedium"),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 0.0),
                            child: Container(
                              child: Center(
                                child: Text(
                                  "all your favourite items are waiting for you at great discount ",
                                  style: TextStyle(
                                      color: Color(0xFFA299A8), fontSize: 16, fontWeight: FontWeight.w400, fontFamily: "ceraProMedium"),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              width: MediaQuery.of(context).size.width / 1.3,
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 0.0),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => CategoryHomeScreen()));
                              },
                              child: Container(
                                child: Center(
                                  child: Text(
                                    "Start Shopping",
                                    style: TextStyle(
                                        color: Color(0xFFFFFFFF), fontSize: 20, fontWeight: FontWeight.w400, fontFamily: "ceraProMedium"),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                width: MediaQuery.of(context).size.width / 2.2,
                                height: 35,
                                decoration: BoxDecoration(
                                  color: Color(0xFF9900FF),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                        ],
                      ),
                    ),

              SizedBox(
                height: 10,
              ),

              // ///congrates
              // Container(
              //   color: Colors.grey[100],
              //   width: MediaQuery.of(context).size.width / 1.1,
              //   child: Column(
              //     children: [
              //       Row(
              //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //         children: [
              //           Container(
              //             height: 40,
              //             width: MediaQuery.of(context).size.width / 4.5,
              //             child: Padding(
              //               padding: const EdgeInsets.only(top: 3),
              //               child: Image.asset(
              //                 "assets/img_102.png",
              //               ),
              //             ),
              //           ),
              //           Container(
              //             height: 68,
              //             width: MediaQuery.of(context).size.width / 1.7,
              //             child: Padding(
              //               padding: const EdgeInsets.only(top: 7),
              //               child: Text(
              //                 "Congratulations! your order is adjusted with ৳96 from your Protidin wallet. Spend more to adjust wallet !",
              //                 style: TextStyle(
              //                   color: Colors.black,
              //                   fontSize: 13,
              //                   fontWeight: FontWeight.w700,
              //                 ),
              //               ),
              //             ),
              //           ),
              //         ],
              //       ),
              //       Align(
              //         alignment: Alignment.centerLeft,
              //         child: Container(
              //           height: 28,
              //           width: MediaQuery.of(context).size.width / 3,
              //           child: Padding(
              //             padding: const EdgeInsets.fromLTRB(20, 5, 0, 0),
              //             child: Text(
              //               "Adjusted: ৳96 ",
              //               style: TextStyle(
              //                 color: Colors.black,
              //                 fontSize: 13,
              //                 fontWeight: FontWeight.w900,
              //               ),
              //             ),
              //           ),
              //         ),
              //       ),
              //       Align(
              //         alignment: Alignment.centerLeft,
              //         child: Container(
              //           height: 28,
              //           width: MediaQuery.of(context).size.width * 3 / 4,
              //           child: Padding(
              //             padding: const EdgeInsets.fromLTRB(20, 5, 0, 0),
              //             child: Text(
              //               "Walet balace after adjustment : ৳6304",
              //               style: TextStyle(
              //                 color: Colors.grey[400],
              //                 fontSize: 13,
              //                 fontWeight: FontWeight.w800,
              //               ),
              //             ),
              //           ),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),

              ///you may also like
              Container(
                width: MediaQuery.of(context).size.width / 1,
                color: Color(0xFFFAF2FF),
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        height: 35,
                        width: 280,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                          child: Text(
                            "You may also like",
                            style: TextStyle(
                              color: Color(0xFF515151),
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              fontFamily: "ceraProMedium",
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      height: 200,
                      width: double.infinity,
                      child: ListView.builder(
                          itemCount: bestProducts.length,
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (_, index) {
                            return Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Container(
                                height: 195,
                                width: 125,
                                child: Column(
                                  children: [
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Row(
                                        children: [
                                          bestProducts[index].discount == 0
                                              ? Text("")
                                              : Align(
                                                  alignment: Alignment.centerLeft,
                                                  child: Padding(
                                                    padding: const EdgeInsets.only(right: 30.0),
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        //color: Colors.indigo[100],
                                                        borderRadius: BorderRadius.circular(5),

                                                        boxShadow: const [
                                                          BoxShadow(
                                                            color: Colors.green,
                                                          ),
                                                        ],
                                                      ),
                                                      //color: Colors.green,
                                                      height: 22,
                                                      width: 75,
                                                      child: Padding(
                                                        padding: const EdgeInsets.all(0),
                                                        child: Center(
                                                          child: Text(
                                                            "${bestProducts[index].discount.toString()}TK OFF",
                                                            style:
                                                                TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w900),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                          //Padding(padding: const EdgeInsets.only(left: 75.0),),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10.0),
                                      child: Container(
                                        height: 90,
                                        width: 110,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: NetworkImage(imagePath + bestProducts[index].thumbnailImage), fit: BoxFit.cover),
                                        ),
                                        child: Align(
                                          alignment: Alignment.bottomRight,
                                          child: Container(
                                            height: 20,
                                            width: 40,
                                            //padding: const EdgeInsets.only(top: 0),
                                            child: InkWell(
                                              onTap: () async {
                                                await controller.addToCart(
                                                  OrderItemModel(
                                                    productId: bestProducts[index].id,
                                                    price: int.tryParse(
                                                        bestProducts[index].baseDiscountedPrice!.toString().replaceAll('৳', '')),
                                                    productThumbnailImage: bestProducts[index].thumbnailImage,
                                                    productName: bestProducts[index].name,
                                                    quantity: 1,
                                                    userId: box.read(userID),
                                                    variant: '',
                                                    discountType: bestProducts[index].discountType,
                                                    discount: bestProducts[index].discount,
                                                    unit: int.tryParse(bestProducts[index].unit!.toString()),
                                                  ),
                                                  context,
                                                );
                                                if (UserPreference.getBool(UserPreference.isLoggedIn)!) {
                                                  await getCartSummary();
                                                } else {
                                                  _getLocalCartSummary(controller.cartItemsList);
                                                }
                                              },
                                              child: Container(
                                                child: Image.asset(
                                                  "assets/img_104.png",
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
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
                                              bestProducts[index].name,
                                              style: TextStyle(
                                                  color: Color(0xFF515151),
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w700,
                                                  fontFamily: "ceraProMedium"),
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
                                            child: Text(
                                              bestProducts[index].unit,
                                              style: TextStyle(
                                                  color: Color(0xFF515151),
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.w700,
                                                  fontFamily: "ceraProMedium"),
                                            ),
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
                                              bestProducts[index].baseDiscountedPrice,
                                              style: TextStyle(
                                                  color: Color(0xFF515151),
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.w400,
                                                  fontFamily: "ceraProMedium"),
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
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),

              SizedBox(
                height: 20,
              ),

              ///order summary
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
                            "MRP (${box.read(cart_length) ?? 0} products)",
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
                              subTotal,
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
                              shipCost,
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
                              discount,
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

              SizedBox(
                height: 10,
              ),

              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage("assets/img_110.png"), fit: BoxFit.cover),

                  //color: Colors.white,
                  //borderRadius: BorderRadius.circular(20),
                ),
                height: 40,
                width: MediaQuery.of(context).size.width / 1.1,
                //color: Colors.cyan,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    width: MediaQuery.of(context).size.width / 4.5,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: Center(
                        child: Text(
                          grand_Total,
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
                ),
              ),

              SizedBox(
                height: 15,
              ),

              /// bonus box
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: DottedBorder(
                  color: Colors.black, //color of dotted/dash line
                  strokeWidth: 1.5, //thickness of dash/dots
                  dashPattern: [10, 6],

                  //color: Colors.black,
                  //gap: 3,
                  //strokeWidth: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width / 5,
                                child: Column(
                                  children: [
                                    CircleAvatar(
                                      radius: 35,
                                      backgroundColor: Color(0xFFF4EFF5),
                                      child: Image.asset(
                                        "assets/img_207.png",
                                        height: 25,
                                        width: 25,
                                        //color: Colors.grey,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Container(
                                      child: Text(
                                        "Registration Bonus",
                                        style: TextStyle(
                                          color: Color(0xFFA299A8),
                                          fontSize: 12,
                                          fontWeight: FontWeight.w700,
                                          fontFamily: 'CeraProMedium',
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width / 5,
                                child: Column(
                                  children: [
                                    CircleAvatar(
                                      radius: 35,
                                      backgroundColor: Color(0xFFF4EFF5),
                                      child: Image.asset(
                                        "assets/mo.png",
                                        height: 25,
                                        width: 25,
                                        //color: Colors.grey,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Container(
                                      child: Text(
                                        "Cashback Bonus",
                                        style: TextStyle(
                                          color: Color(0xFFA299A8),
                                          fontSize: 12,
                                          fontWeight: FontWeight.w700,
                                          fontFamily: 'CeraProMedium',
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width / 5,
                                child: Column(
                                  children: [
                                    CircleAvatar(
                                      radius: 35,
                                      backgroundColor: Color(0xFFF4EFF5),
                                      child: Image.asset(
                                        "assets/tic.png",
                                        height: 25,
                                        width: 25,
                                        //color: Colors.grey,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Container(
                                      child: Text(
                                        "Coupon Bonus",
                                        style: TextStyle(
                                          color: Color(0xFFA299A8),
                                          fontSize: 12,
                                          fontWeight: FontWeight.w700,
                                          fontFamily: 'CeraProMedium',
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width / 5,
                                child: Column(
                                  children: [
                                    CircleAvatar(
                                      radius: 35,
                                      backgroundColor: Color(0xFFF4EFF5),
                                      child: Image.asset(
                                        "assets/Users.png",
                                        height: 25,
                                        width: 25,
                                        //color: Colors.grey,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Container(
                                      child: Text(
                                        "Refferel Bonus",
                                        style: TextStyle(
                                          color: Color(0xFFA299A8),
                                          fontSize: 12,
                                          fontWeight: FontWeight.w700,
                                          fontFamily: 'CeraProMedium',
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                            child: Container(
                              color: Colors.white,
                              child: Row(
                                children: [
                                  Container(
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
                                    width: MediaQuery.of(context).size.width / 1.25,
                                    child: Row(
                                      children: [
                                        Container(
                                          width: MediaQuery.of(context).size.width / 1.7,
                                          child: Align(
                                            alignment: Alignment.centerRight,
                                            child: TextFormField(
                                              textAlign: TextAlign.center,
                                              decoration: InputDecoration(
                                                //border: InputBorder.none,
                                                //focusedBorder: InputBorder.none,
                                                //contentPadding: EdgeInsets.only(left: 5, bottom: 0, top: 0, right: 15),
                                                hintText: 'Enter Coupon Code',
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 15.0),
                                          child: Align(
                                            alignment: Alignment.centerRight,
                                            child: Container(
                                              //width: MediaQuery.of(context).size.width / 2,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(5),
                                                color: Color(0xFFF4EFF5),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  "Submit",
                                                  style: TextStyle(
                                                    color: Color(0xFFA299A8),
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w700,
                                                    fontFamily: 'CeraProMedium',
                                                  ),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                              height: 30,
                                              width: 55,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(
                height: 15,
              ),

              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage("assets/img_110.png"), fit: BoxFit.cover),
                ),
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
                                grand_Total,
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
                height: 20,
              ),

              Padding(
                padding: const EdgeInsets.fromLTRB(4, 0, 4, 0),
                child: Container(
                  width: MediaQuery.of(context).size.width / 1,
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
                        width: MediaQuery.of(context).size.width / 1.35,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: Center(
                            child: Text(
                              "Cash back received (Added to walet)",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
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
                height: 10,
              ),

              Container(
                width: MediaQuery.of(context).size.width / 1,
                height: 55,
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
                child: InkWell(
                  onTap: () {
                    UserPreference.getBool(UserPreference.isLoggedIn)!
                        ? Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PaymentAddress1stPage(
                                grandTotal: grand_Total,
                                ownerId: ownerId,
                                user_address: userAddress,
                              ),
                            ),
                          )
                        : Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (ctx) => SignInPage(
                                isFromCart: true,
                                orderList: controller.orderList,
                              ),
                            ),
                          );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: UserPreference.getBool(UserPreference.isLoggedIn)!
                            ? Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20.0),
                                    child: Image.asset(
                                      "assets/img_208.png",
                                      height: 20,
                                      width: 20,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 4),
                                    child: Text(
                                      " ${box.read(cart_length) ?? 0} items | $grand_Total",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                        fontFamily: "ceraProMedium",
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20.0),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width / 2.5,
                                      child: Align(
                                        alignment: Alignment.centerRight,
                                        child: Padding(
                                          padding: const EdgeInsets.only(left: 0.0),
                                          child: Text(
                                            "Confirm",
                                            style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10.0),
                                    child: Container(
                                      height: 20,
                                      width: 10,
                                      child: Padding(
                                        padding: const EdgeInsets.only(right: 0),
                                        child: Image.asset(
                                          "assets/img_115.png",
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 10.0),
                                  )
                                ],
                              )
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 30.0),
                                    child: Text(
                                      "Login to continue",
                                      style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w800),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 160.0),
                                    child: Container(
                                      height: 20,
                                      width: 10,
                                      child: Padding(
                                        padding: const EdgeInsets.only(right: 0),
                                        child: Image.asset(
                                          "assets/img_115.png",
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 10.0),
                                  )
                                ],
                              ),

                        ///width: 260,
                        //height: 40,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

*/
