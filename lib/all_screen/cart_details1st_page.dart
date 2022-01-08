import 'dart:convert';
import 'dart:developer';

import 'package:customer_ui/all_screen/payment_method_address_1st_page.dart';
import 'package:customer_ui/components/apis.dart';
import 'package:customer_ui/components/styles.dart';
import 'package:customer_ui/components/utils.dart';
import 'package:customer_ui/dataModel/cart_details_model.dart';
import 'package:customer_ui/dataModel/cart_summary_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:http/http.dart' as http;

class CartDetails extends StatelessWidget {
  const CartDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final title = 'Increment Decrement Demo';
    return MaterialApp(
      title: title,
      home: NumberInputWithIncrementDecrement(),
    );
  }
}

class NumberInputWithIncrementDecrement extends StatefulWidget {
  @override
  _NumberInputWithIncrementDecrementState createState() => _NumberInputWithIncrementDecrementState();
}

class _NumberInputWithIncrementDecrementState extends State<NumberInputWithIncrementDecrement> {
  TextEditingController _controller = TextEditingController();

  var demo = [];

  int _singlePrice = 122;
  int _quantity = 1;

  int totalProducts = 0;
  var subTotal = "";
  var tax = "";
  var shipCost = "";
  var discount = "";
  var grand_Total = "";

  ///

  Future<void> getCartName() async {
    var res = await http.post(Uri.parse("https://test.protidin.com.bd/api/v2/carts/61"),
        headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8', 'Authorization': 'Bearer $authToken'});
    // log("Response ${res.body}");
    log("Response code ${res.statusCode}");

    var dataMap = jsonDecode(res.body);
    log(dataMap[0].toString());
    var cartModel = CartDetailsModel.fromJson(dataMap[0]);
    demo = cartModel.cartItems;
    totalProducts = cartModel.cartItems.length;
    log("length ${cartModel.cartItems.length}");
    //demo=dataMap;
    setState(() {});
    //log("demo length "+demo.length.toString());
  }

  Future<void> changeQuantity(id, userId, quantity) async {
    var res2 = await http.post(Uri.parse("https://test.protidin.com.bd/api/v2/carts/change-quantity"),
        headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8', 'Authorization': 'Bearer $authToken'},
        body: jsonEncode(<String, dynamic>{"id": id, "variant": "", "user_id": userId, "quantity": quantity}));

    log("Response ${res2.body}");
    log("Response code  ${res2.statusCode}");

    if (res2.statusCode == 200 || res2.statusCode == 201) {
      showToast("Cart Updated Successfully", context: context);
      getCartSummary();
    } else {
      showToast("Something went wrong", context: context);
    }
  }

  Future<void> getCartSummary() async {
    var res = await http.get(Uri.parse("$cartSummary/$userId"),
        headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8', 'Authorization': 'Bearer $authToken'});

    log("cart Summary response= " + res.body);

    if (res.statusCode == 200) {
      var dataMap = jsonDecode(res.body);
      var cartSummaryModel = CartSummaryModel.fromJson(dataMap);
      subTotal = cartSummaryModel.subTotal;
      tax = cartSummaryModel.tax;
      shipCost = cartSummaryModel.shippingCost;
      discount = cartSummaryModel.discount;
      grand_Total = cartSummaryModel.grandTotal;
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    getCartName();
    getCartSummary();
    _controller.text = "1"; // Setting the initial value for the field.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: kWhiteColor,
        centerTitle: true,
        title: Text(
          "Cart",
          style: TextStyle(color: kBlackColor, fontSize: 14),
        ),
        iconTheme: IconThemeData(color: kBlackColor),
        actions: const [
          Center(
            child: Icon(
              Icons.menu,
              color: kBlackColor,
            ),
          ),
          SizedBox(
            width: 10,
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            ///listview builder
            Container(
              height: MediaQuery.of(context).size.height / 3,
              child: ListView.builder(
                itemCount: demo.length,
                scrollDirection: Axis.vertical,
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
                          InkWell(
                            //ProductSinglePage1
                            onTap: () {
                              //Navigator.push(context, MaterialPageRoute(builder: (context) => GroceryDetails()));
                            },
                            child: Container(
                              height: 120,
                              width: MediaQuery.of(context).size.width / 3,
                              child: Image.network(
                                imagePath + demo[index].productThumbnailImage,
                              ),
                            ),
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
                                    height: 70,
                                    //width: 200,
                                    child: Text(
                                      demo[index].productName,
                                      style: TextStyle(color: Colors.grey, fontSize: 16, fontWeight: FontWeight.w800),
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Align(
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
                                      width: 90,
                                      child: Padding(
                                        padding: const EdgeInsets.all(0),
                                        child: Center(
                                          child: Text(
                                            "20% Offer",
                                            style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w900),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
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
                                          child: Text(
                                            //"${demo[index].price}",
                                            "${demo[index].currencySymbol} ${demo[index].price}",
                                            style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w900),
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
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 50, 10, 0),
                            child: Align(
                              alignment: Alignment.bottomRight,
                              child: Container(
                                width: MediaQuery.of(context).size.width / 4,
                                height: 35,
                                decoration: BoxDecoration(
                                  color: Color(0xFF9900FF),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: <Widget>[
                                      FittedBox(
                                        child: Container(
                                          child: MaterialButton(
                                              child: Icon(Icons.remove, color: Colors.white),
                                              onPressed: () {
                                                demo[index].quantity--;
                                                changeQuantity(demo[index].id, 61, demo[index].quantity);
                                                setState(() {});
                                              }),
                                          width: MediaQuery.of(context).size.width / 30,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 15.0),
                                        child: FittedBox(
                                          child: Container(
                                              width: 36,
                                              child: Center(
                                                  child: Text(
                                                "${demo[index].quantity}",
                                                style: TextStyle(fontSize: 18, color: kWhiteColor),
                                              ))),
                                        ),
                                      ),
                                      FittedBox(
                                        child: Container(
                                          child: MaterialButton(
                                              child: Icon(
                                                Icons.add,
                                                color: Colors.white,
                                              ),
                                              onPressed: () {
                                                demo[index].quantity++;
                                                changeQuantity(demo[index].id, 61, demo[index].quantity);
                                                setState(() {});
                                              }),
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
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              height: 30,
            ),

            ///congrates
            Container(
              color: Colors.grey[100],
              width: MediaQuery.of(context).size.width / 1.1,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      //Padding(padding: const EdgeInsets.only(left: 16)),
                      Container(
                        height: 40,
                        width: MediaQuery.of(context).size.width / 4.5,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 3),
                          child: Image.asset(
                            "assets/img_102.png",
                          ),
                        ),
                      ),
                      Container(
                        height: 68,
                        width: MediaQuery.of(context).size.width / 1.7,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 7),
                          child: Text(
                            "Congratulations! your order is adjusted with ৳96 from your Protidin wallet. Spend more to adjust wallet !",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      height: 28,
                      width: MediaQuery.of(context).size.width / 3,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 5, 0, 0),
                        child: Text(
                          "Adjusted: ৳96 ",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 13,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      height: 28,
                      width: MediaQuery.of(context).size.width * 3 / 4,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 5, 0, 0),
                        child: Text(
                          "Walet balace after adjustment : ৳6304",
                          style: TextStyle(
                            color: Colors.grey[400],
                            fontSize: 13,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            ///you may also like
            Container(
              width: MediaQuery.of(context).size.width / 1.1,
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      height: 35,
                      width: 280,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                        child: Text(
                          "You may also like",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 200,
                    width: double.infinity,
                    child: ListView.builder(
                        itemCount: 1,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (_, index) {
                          return Container(
                              height: 195,
                              width: 120,
                              child: Column(
                                children: [
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(left: 0.0),
                                        ),
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                //color: Colors.indigo[100],
                                                borderRadius: BorderRadius.circular(5),

                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.green,
                                                  ),
                                                ],
                                              ),
                                              //color: Colors.green,
                                              height: 25,
                                              width: 70,
                                              child: Padding(
                                                padding: const EdgeInsets.all(0),
                                                child: Center(
                                                  child: Text(
                                                    "20% Off",
                                                    style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w900),
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
                                  Container(
                                    height: 90,
                                    width: 100,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(image: AssetImage("assets/img_103.png"), fit: BoxFit.cover),
                                    ),
                                    child: Align(
                                      alignment: Alignment.bottomRight,
                                      child: Container(
                                        height: 20,
                                        width: 40,
                                        //padding: const EdgeInsets.only(top: 0),
                                        child: Image.asset(
                                          "assets/img_104.png",
                                        ),
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.center,
                                    child: Container(
                                      height: 25,
                                      width: 110,
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                                        child: Text(
                                          "ACI Soyabin Oil",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w900,
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
                                        padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                                        child: Text(
                                          "5 lit",
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
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
                                        padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                                        child: Text(
                                          "৳700",
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ));
                        }),
                  ),
                ],
              ),
            ),

            ///

            ///order summary
            SizedBox(
              height: 10,
            ),
            Container(
              height: 10,
              width: MediaQuery.of(context).size.width / 1.1,
              child: Padding(
                padding: const EdgeInsets.only(top: 0),
                child: Image.asset(
                  "assets/img_107.png",
                ),
              ),
            ),

            SizedBox(
              height: 20,
            ),

            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                //height: 35,
                //width: 200,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 5, 0, 0),
                  child: Text(
                    "Order Summary",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(
              height: 15,
            ),

            Align(
              alignment: Alignment.centerRight,
              child: Container(
                width: MediaQuery.of(context).size.width / 1.1,
                child: Row(
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
                          "MRP ($totalProducts products)",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
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
                        width: MediaQuery.of(context).size.width / 2.4,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: Text(
                            subTotal,
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Align(
              alignment: Alignment.centerRight,
              child: Container(
                width: MediaQuery.of(context).size.width / 1.1,
                child: Row(
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
                          "Applicable VAT,tax",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
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
                        width: MediaQuery.of(context).size.width / 2.4,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: Text(
                            tax,
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
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
                  width: MediaQuery.of(context).size.width / 2,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 40, 0),
                    child: Center(
                      child: Text(
                        grand_Total,
                        style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w900),
                      ),
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(
              height: 30,
            ),

            ///
            Container(
              height: 90,
              width: MediaQuery.of(context).size.width / 1.1,
              decoration: BoxDecoration(
                  color: Colors.white,
                  // Red border with the width is equal to 5
                  border: Border.all(width: 1, color: Colors.black)),
              child: Column(
                children: [
                  SizedBox(
                    height: 14,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      width: MediaQuery.of(context).size.width / 1.1,
                      child: Row(
                        children: [
                          /*Padding(
                              padding: const EdgeInsets.fromLTRB(20,0,00,0),
                            ),*/

                          Container(
                            height: 20,
                            width: MediaQuery.of(context).size.width / 7,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 0),
                              child: Image.asset(
                                "assets/img_111.png",
                              ),
                            ),
                          ),
                          Container(
                            height: 20,
                            width: MediaQuery.of(context).size.width / 2.8,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                              child: Text(
                                "Protidin Discount",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            height: 20,
                            width: MediaQuery.of(context).size.width / 2.5,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                              child: Text(
                                discount,
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
                  Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      width: MediaQuery.of(context).size.width / 1.1,
                      child: Row(
                        children: [
                          /*Padding(
                              padding: const EdgeInsets.fromLTRB(20,0,00,0),
                            ),*/

                          Container(
                            height: 20,
                            width: MediaQuery.of(context).size.width / 7,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 0),
                              child: Image.asset(
                                "assets/img_165.png",
                              ),
                            ),
                          ),
                          Container(
                            height: 20,
                            width: MediaQuery.of(context).size.width / 2.8,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                              child: Text(
                                "Walet adjustment",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),

                          /*Padding(
                              padding: const EdgeInsets.fromLTRB(10,0,70,0),
                            ),*/

                          Container(
                            height: 20,
                            width: MediaQuery.of(context).size.width / 2.5,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                              child: Text(
                                "- ৳96.00",
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
                  Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      width: MediaQuery.of(context).size.width / 1.1,
                      child: Row(
                        children: [
                          /*Padding(
                              padding: const EdgeInsets.fromLTRB(20,0,00,0),
                            ),*/

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
                            width: MediaQuery.of(context).size.width / 2.8,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                              child: Text(
                                "Delivery charge",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),

                          /*Padding(
                              padding: const EdgeInsets.fromLTRB(10,0,70,0),
                            ),*/

                          Container(
                            height: 20,
                            width: MediaQuery.of(context).size.width / 2.5,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                              child: Text(
                                "free",
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
                ],
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
                  width: MediaQuery.of(context).size.width / 2,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 35, 0),
                    child: Center(
                      child: Text(
                        subTotal,
                        style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w900),
                      ),
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(
              height: 20,
            ),

            Container(
              width: MediaQuery.of(context).size.width / 1.1,
              child: Row(
                children: [
                  Container(
                    height: 20,
                    width: MediaQuery.of(context).size.width / 7,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 0),
                      child: Image.asset(
                        "assets/img_167.png",
                      ),
                    ),
                  ),
                  Container(
                    height: 40,
                    width: MediaQuery.of(context).size.width / 2.8,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                      child: Text(
                        "Cash back received\n(Added to walet)",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 20,
                    width: MediaQuery.of(context).size.width / 2.5,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                      child: Text(
                        "- ৳96.00",
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
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Payment_Address1stPage()));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      child: Center(
                        child: Text(
                          "Payment method & Address",
                          style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w800),
                        ),
                      ),
                      width: 260,
                      //height: 40,
                    ),
                    Container(
                      height: 20,
                      width: 10,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 0),
                        child: Image.asset(
                          "assets/img_115.png",
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            ///Listview.builder
          ],
        ),
      ),
    );
  }
}

/*

import 'dart:convert';
import 'dart:developer';

import 'package:customer_ui/OthersPage/payment_method_address_1st_page.dart';
import 'package:customer_ui/components/apis.dart';
import 'package:customer_ui/components/styles.dart';
import 'package:customer_ui/components/utils.dart';
import 'package:customer_ui/dataModel/cart_details_model.dart';
import 'package:customer_ui/dataModel/cart_summary_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:http/http.dart' as http;


class CartDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final title = 'Increment Decrement Demo';
    return MaterialApp(
      title: title,
      home: NumberInputWithIncrementDecrement(),
    );
  }
}

class NumberInputWithIncrementDecrement extends StatefulWidget {
  @override
  _NumberInputWithIncrementDecrementState createState() => _NumberInputWithIncrementDecrementState();
}

class _NumberInputWithIncrementDecrementState extends State<NumberInputWithIncrementDecrement> {
  TextEditingController _controller = TextEditingController();

  var demo = [];

  int _singlePrice = 122;
  int _quantity = 1;

  int totalProducts=0;
  var subTotal="";
  var tax="";
  var shipCost="";
  var discount="";
  var grand_Total="";

  ///

  Future<void> getCartName() async {
    var res = await http.post(Uri.parse("https://test.protidin.com.bd/api/v2/carts/61"),
        headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8', 'Authorization': 'Bearer $authToken'});
    // log("Response ${res.body}");
    log("Response code ${res.statusCode}");

    var dataMap = jsonDecode(res.body);
    log(dataMap[0].toString());
    var cartModel = CartDetailsModel.fromJson(dataMap[0]);
    demo = cartModel.cartItems;
    totalProducts=cartModel.cartItems.length;
    log("length ${cartModel.cartItems.length}");
    //demo=dataMap;
    setState(() {});
    //log("demo length "+demo.length.toString());
  }

  Future<void> changeQuantity(id, userId, quantity) async {
    var res2 = await http.post(Uri.parse("https://test.protidin.com.bd/api/v2/carts/change-quantity"),
        headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8', 'Authorization': 'Bearer $authToken'},
        body: jsonEncode(<String, dynamic>{"id": id, "variant": "", "user_id": userId, "quantity": quantity}));

    log("Response ${res2.body}");
    log("Response code  ${res2.statusCode}");

    if (res2.statusCode == 200 || res2.statusCode == 201) {
      showToast("Cart Updated Successfully", context: context);
    } else {
      showToast("Something went wrong", context: context);
    }
  }

  Future<void> getCartSummary()async{
    var res = await http.get(Uri.parse("$cartSummary/$userId"),
        headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8', 'Authorization': 'Bearer $authToken'});

    log("cart Summary response= "+res.body);

    if(res.statusCode==200){
      var dataMap=jsonDecode(res.body);
      var cartSummaryModel=CartSummaryModel.fromJson(dataMap);
      subTotal=cartSummaryModel.subTotal;
      tax=cartSummaryModel.tax;
      shipCost=cartSummaryModel.shippingCost;
      discount=cartSummaryModel.discount;
      grand_Total=cartSummaryModel.grandTotal;
    }

  }

  @override
  void initState() {
    super.initState();
    getCartName();
    getCartSummary();
    _controller.text = "1"; // Setting the initial value for the field.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: kWhiteColor,
        centerTitle: true,
        title: Text(
          "Cart",
          style: TextStyle(color: kBlackColor, fontSize: 14),
        ),
        iconTheme: IconThemeData(color: kBlackColor),
        actions: const [
          Center(
            child: Icon(
              Icons.menu,
              color: kBlackColor,
            ),
          ),
          SizedBox(
            width: 10,
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 1,
              child: ListView.builder(
                itemCount: demo.length,
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
                          InkWell(
                            //ProductSinglePage1
                            onTap: () {
                              //Navigator.push(context, MaterialPageRoute(builder: (context) => GroceryDetails()));
                            },
                            child: Container(
                              height: 120,
                              width: MediaQuery.of(context).size.width / 3,
                              child: Image.network(
                                imagePath + demo[index].productThumbnailImage,
                              ),
                            ),
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
                                    height: 70,
                                    //width: 200,
                                    child: Text(
                                      demo[index].productName,
                                      style: TextStyle(color: Colors.grey, fontSize: 16, fontWeight: FontWeight.w800),
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Align(
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
                                      width: 90,
                                      child: Padding(
                                        padding: const EdgeInsets.all(0),
                                        child: Center(
                                          child: Text(
                                            "20% Offer",
                                            style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w900),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
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
                                          child: Text(
                                            "${demo[index].price}",
                                            style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w900),
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
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 50, 10, 0),
                            child: Align(
                              alignment: Alignment.bottomRight,
                              child: Container(
                                width: MediaQuery.of(context).size.width / 4,
                                height: 35,
                                decoration: BoxDecoration(
                                  color: Color(0xFF9900FF),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: <Widget>[
                                      FittedBox(
                                        child: Container(
                                          child: MaterialButton(
                                              child: Icon(Icons.remove, color: Colors.white),
                                              onPressed: () {
                                                /*if (_quantity < 10) {
                                                  _quantity--;
                                                  setState(() {});
                                                }*/
                                              }),
                                          width: MediaQuery.of(context).size.width / 30,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 15.0),
                                        child: FittedBox(
                                          child: Container(
                                              width: 36,
                                              child: Center(
                                                  child: Text(
                                                    "${demo[index].quantity}",
                                                    style: TextStyle(
                                                        fontSize: 18,color: kWhiteColor
                                                    ),
                                                  ))),
                                        ),
                                      ),
                                      FittedBox(
                                        child: Container(
                                          child: MaterialButton(
                                              child: Icon(
                                                Icons.add,
                                                color: Colors.white,
                                              ),
                                              onPressed: () {
                                                demo[index].quantity++;
                                                changeQuantity(demo[index].id, 61, demo[index].quantity);
                                                setState(() {});
                                                /*if (_quantity < 10) {
                                                  _quantity++;
                                                  setState(() {});
                                                }*/
                                              }),
                                          width: MediaQuery.of(context).size.width / 10,
                                        ),
                                      ),

                                      /*
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[


                                    ],
                                  ),
                                  Spacer(
                                    flex: 2,
                                  ),
                                 */
                                    ],
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
            ),

            SizedBox(
              height: 30,
            ),

            ///
            Container(
              color: Colors.grey[100],
              width: MediaQuery.of(context).size.width / 1.1,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      //Padding(padding: const EdgeInsets.only(left: 16)),
                      Container(
                        height: 40,
                        width: MediaQuery.of(context).size.width / 4.5,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 3),
                          child: Image.asset(
                            "assets/img_102.png",
                          ),
                        ),
                      ),
                      Container(
                        height: 68,
                        width: MediaQuery.of(context).size.width / 1.7,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 7),
                          child: Text(
                            "Congratulations! your order is adjusted with ৳96 from your Protidin wallet. Spend more to adjust wallet !",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      height: 28,
                      width: MediaQuery.of(context).size.width / 3,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 5, 0, 0),
                        child: Text(
                          "Adjusted: ৳96 ",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 13,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      height: 28,
                      width: MediaQuery.of(context).size.width * 3 / 4,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 5, 0, 0),
                        child: Text(
                          "Walet balace after adjustment : ৳6304",
                          style: TextStyle(
                            color: Colors.grey[400],
                            fontSize: 13,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            ///you may also like
            Container(
              width: MediaQuery.of(context).size.width / 1.1,
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      height: 35,
                      width: 280,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                        child: Text(
                          "You may also like",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 200,
                    width: double.infinity,
                    child: ListView.builder(
                        itemCount: 1,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (_, index) {
                          return Container(
                              height: 195,
                              width: 120,
                              child: Column(
                                children: [
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(left: 0.0),
                                        ),
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                //color: Colors.indigo[100],
                                                borderRadius: BorderRadius.circular(5),

                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.green,
                                                  ),
                                                ],
                                              ),
                                              //color: Colors.green,
                                              height: 25,
                                              width: 70,
                                              child: Padding(
                                                padding: const EdgeInsets.all(0),
                                                child: Center(
                                                  child: Text(
                                                    "20% Off",
                                                    style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w900),
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
                                  Container(
                                    height: 90,
                                    width: 100,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(image: AssetImage("assets/img_103.png"), fit: BoxFit.cover),
                                    ),
                                    child: Align(
                                      alignment: Alignment.bottomRight,
                                      child: Container(
                                        height: 20,
                                        width: 40,
                                        //padding: const EdgeInsets.only(top: 0),
                                        child: Image.asset(
                                          "assets/img_104.png",
                                        ),
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.center,
                                    child: Container(
                                      height: 25,
                                      width: 110,
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                                        child: Text(
                                          "ACI Soyabin Oil",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w900,
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
                                        padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                                        child: Text(
                                          "5 lit",
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
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
                                        padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                                        child: Text(
                                          "৳700",
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ));
                        }),
                  ),
                ],
              ),
            ),

            ///

            ///order summary
            SizedBox(
              height: 10,
            ),
            Container(
              height: 10,
              width: MediaQuery.of(context).size.width / 1.1,
              child: Padding(
                padding: const EdgeInsets.only(top: 0),
                child: Image.asset(
                  "assets/img_107.png",
                ),
              ),
            ),

            SizedBox(
              height: 20,
            ),

            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                //height: 35,
                //width: 200,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 5, 0, 0),
                  child: Text(
                    "Order Summary",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(
              height: 15,
            ),

            Align(
              alignment: Alignment.centerRight,
              child: Container(
                width: MediaQuery.of(context).size.width / 1.1,
                child: Row(
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
                          "MRP ($totalProducts products)",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
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
                        width: MediaQuery.of(context).size.width / 2.4,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: Text(
                            subTotal,
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Align(
              alignment: Alignment.centerRight,
              child: Container(
                width: MediaQuery.of(context).size.width / 1.1,
                child: Row(
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
                          "Applicable VAT,tax",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
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
                        width: MediaQuery.of(context).size.width / 2.4,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: Text(
                            "+ ৳83.00",
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
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
                  width: MediaQuery.of(context).size.width / 2,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 40, 0),
                    child: Center(
                      child: Text(
                        "৳913.00",
                        style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w900),
                      ),
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(
              height: 30,
            ),

            ///
            Container(
              height: 90,
              width: MediaQuery.of(context).size.width / 1.1,
              decoration: BoxDecoration(
                  color: Colors.white,
                  // Red border with the width is equal to 5
                  border: Border.all(width: 1, color: Colors.black)),
              child: Column(
                children: [
                  SizedBox(
                    height: 14,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      width: MediaQuery.of(context).size.width / 1.1,
                      child: Row(
                        children: [
                          /*Padding(
                              padding: const EdgeInsets.fromLTRB(20,0,00,0),
                            ),*/

                          Container(
                            height: 20,
                            width: MediaQuery.of(context).size.width / 7,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 0),
                              child: Image.asset(
                                "assets/img_111.png",
                              ),
                            ),
                          ),
                          Container(
                            height: 20,
                            width: MediaQuery.of(context).size.width / 2.8,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                              child: Text(
                                "Protidin Discount",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),

                          /*Padding(
                              padding: const EdgeInsets.fromLTRB(10,0,70,0),
                            ),*/

                          Container(
                            height: 20,
                            width: MediaQuery.of(context).size.width / 2.5,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                              child: Text(
                                "- ৳110.00",
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
                  Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      width: MediaQuery.of(context).size.width / 1.1,
                      child: Row(
                        children: [
                          /*Padding(
                              padding: const EdgeInsets.fromLTRB(20,0,00,0),
                            ),*/

                          Container(
                            height: 20,
                            width: MediaQuery.of(context).size.width / 7,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 0),
                              child: Image.asset(
                                "assets/img_165.png",
                              ),
                            ),
                          ),
                          Container(
                            height: 20,
                            width: MediaQuery.of(context).size.width / 2.8,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                              child: Text(
                                "Walet adjustment",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),

                          /*Padding(
                              padding: const EdgeInsets.fromLTRB(10,0,70,0),
                            ),*/

                          Container(
                            height: 20,
                            width: MediaQuery.of(context).size.width / 2.5,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                              child: Text(
                                "- ৳96.00",
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
                  Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      width: MediaQuery.of(context).size.width / 1.1,
                      child: Row(
                        children: [
                          /*Padding(
                              padding: const EdgeInsets.fromLTRB(20,0,00,0),
                            ),*/

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
                            width: MediaQuery.of(context).size.width / 2.8,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                              child: Text(
                                "Delivery charge",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),

                          /*Padding(
                              padding: const EdgeInsets.fromLTRB(10,0,70,0),
                            ),*/

                          Container(
                            height: 20,
                            width: MediaQuery.of(context).size.width / 2.5,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                              child: Text(
                                "free",
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
                ],
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
                  width: MediaQuery.of(context).size.width / 2,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 35, 0),
                    child: Center(
                      child: Text(
                        "৳707.00",
                        style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w900),
                      ),
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(
              height: 20,
            ),

            Container(
              width: MediaQuery.of(context).size.width / 1.1,
              child: Row(
                children: [
                  /*Padding(
                            padding: const EdgeInsets.fromLTRB(20,0,00,0),
                          ),*/

                  Container(
                    height: 20,
                    width: MediaQuery.of(context).size.width / 7,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 0),
                      child: Image.asset(
                        "assets/img_167.png",
                      ),
                    ),
                  ),
                  Container(
                    height: 40,
                    width: MediaQuery.of(context).size.width / 2.8,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                      child: Text(
                        "Cash back received\n(Added to walet)",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 20,
                    width: MediaQuery.of(context).size.width / 2.5,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                      child: Text(
                        "- ৳96.00",
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
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Payment_Address1stPage()));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      child: Center(
                        child: Text(
                          "Payment method & Address",
                          style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w800),
                        ),
                      ),
                      width: 260,
                      //height: 40,
                    ),
                    Container(
                      height: 20,
                      width: 10,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 0),
                        child: Image.asset(
                          "assets/img_115.png",
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            ///Listview.builder
          ],
        ),
      ),
    );
  }
}



*/
