import 'dart:convert';
import 'dart:developer';

import 'package:customer_ui/components/utils.dart';
import 'package:customer_ui/dataModel/cart_details_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class CartItemsController extends GetxController {
  var cartLength = 0.obs;

  Future<void> getCartName() async {
    log("-----get cart items---with user ID ${box.read(userID)}--");

    var res = await http.post(Uri.parse("https://test.protidin.com.bd/api/v2/carts/${box.read(userID)}"),
        headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8', 'Authorization': 'Bearer ${box.read(userToken)}'});
    // log("Response ${res.body}");
    log("Response code ${res.statusCode}");

    var dataMap = jsonDecode(res.body);

    ///log(dataMap[0].toString());
    var cartModel = CartDetailsModel.fromJson(dataMap[0]);
    cartLength.value = cartModel.cartItems.length;
    log("cart added ${cartModel.cartItems.length} product");
    //demo=dataMap;
    //setState(() {});
    //log("demo length "+demo.length.toString());
  }
}
