import 'dart:convert';
import 'dart:developer';

import 'package:customer_ui/components/utils.dart';
import 'package:customer_ui/dataModel/cart_details_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class CartItemsController extends GetxController {
  var cartLength = 0.obs;

  var cartItemsList = [].obs;

  Future<void> getCartName() async {
    cartItemsList.clear();
    log("cart length ${cartLength.value}");
    log("-----get cart items---with user ID ${box.read(userID)}--");

    var res = await http.post(Uri.parse("https://test.protidin.com.bd/api/v2/carts/${box.read(userID)}"),
        headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8', 'Authorization': 'Bearer ${box.read(userToken)}'});
    // log("Response ${res.body}");
    log("Response code ${res.statusCode}");

    if (res.statusCode == 200 || res.statusCode == 201) {
      var dataMap = jsonDecode(res.body);
      final List<CartDetailsModel> cartModel = List<CartDetailsModel>.from(dataMap.map((json) => CartDetailsModel.fromJson(json)));

      if (cartModel.isEmpty) cartLength.value = 0;

      for (var element in cartModel) {
        for (var element2 in element.cartItems) {
          cartItemsList.add(CartItems(
              id: element2.id,
              ownerId: element2.ownerId,
              userId: element2.userId,
              productId: element2.productId,
              productName: element2.productName,
              productThumbnailImage: element2.productThumbnailImage,
              variation: element2.variation,
              price: element2.price,
              currencySymbol: element2.currencySymbol,
              tax: element2.tax,
              shippingCost: element2.shippingCost,
              quantity: element2.quantity,
              lowerLimit: element2.lowerLimit,
              upperLimit: element2.upperLimit));

          box.write(cart_length, cartLength);
          log("total length ${cartItemsList.length}");
          cartLength.value = cartItemsList.length;
        }
        //log("cart items inside model length ${element.cartItems.length}");
      }
    }
  }
}

///List<String> streetsList = new List<String>.from(streetsFromJson);

/*
import 'dart:convert';
import 'dart:developer';

import 'package:customer_ui/components/utils.dart';
import 'package:customer_ui/dataModel/cart_details_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class CartItemsController extends GetxController {
  var cartLength = 0.obs;

  var cartItemsList = [].obs;

  Future<void> getCartName() async {
    cartItemsList.clear();
    log("-----get cart items---with user ID ${box.read(userID)}--");

    var res = await http.post(Uri.parse("https://test.protidin.com.bd/api/v2/carts/${box.read(userID)}"),
        headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8', 'Authorization': 'Bearer ${box.read(userToken)}'});
    // log("Response ${res.body}");
    log("Response code ${res.statusCode}");

    if (res.statusCode == 200 || res.statusCode == 201) {
      var dataMap = jsonDecode(res.body);
      final cartModel = dataMap.map((json) => CartDetailsModel.fromJson(json)).toList();

      //log("cart items ${cartModel.length}");
      for (var element in cartModel) {
        for (var element2 in element.cartItems) {
          cartItemsList.add(CartItems(
              id: element2.id,
              ownerId: element2.ownerId,
              userId: element2.userId,
              productId: element2.productId,
              productName: element2.productName,
              productThumbnailImage: element2.productThumbnailImage,
              variation: element2.variation,
              price: element2.price,
              currencySymbol: element2.currencySymbol,
              tax: element2.tax,
              shippingCost: element2.shippingCost,
              quantity: element2.quantity,
              lowerLimit: element2.lowerLimit,
              upperLimit: element2.upperLimit));
          cartLength.value = cartItemsList.length;
          box.write(cart_length, cartLength);
          log("total length ${cartItemsList.length}");
        }
        //log("cart items inside model length ${element.cartItems.length}");
      }
    }
  }
}

///List<String> streetsList = new List<String>.from(streetsFromJson);
*/
