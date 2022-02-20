import 'dart:convert';
import 'dart:developer';

import 'package:customer_ui/components/utils.dart';
import 'package:customer_ui/dataModel/cart_details_model.dart';
import 'package:customer_ui/dataModel/order_product_model.dart';
import 'package:customer_ui/preferences/user_preferance.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class CartItemsController extends GetxController {
  var cartLength = 0.obs;

  var cartItemsList = [].obs;
  var orderList = [].obs;

  String testString = "Hello Text";

  Future<void> addToCart(OrderItemModel orderItemModel, BuildContext context) async {
    var res;
    bool isLocal = false;
    List<OrderItemModel> _orderList = [];
    final jsonData = {
      "id": orderItemModel.productId,
      "variant": orderItemModel.variant,
      "user_id": orderItemModel.userId,
      "quantity": orderItemModel.quantity,
    };
    if (UserPreference.getBool(UserPreference.isLoggedIn)!) {
      res = await http.post(
        Uri.parse("http://test.protidin.com.bd:88/api/v2/carts/add"),
        headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8', 'Authorization': 'Bearer ${box.read(userToken)}'},
        body: jsonEncode(jsonData),
      );
    } else {
      if (box.read(cart_item) != null && box.read(cart_item) != '') {
        var savedOrders = box.read(cart_item);
        final extractedData = jsonDecode(savedOrders);
        _orderList = List.from(extractedData.map((item) => OrderItemModel.fromJson(item)));
      }
      _orderList.add(orderItemModel);
      box.write(cart_item, jsonEncode(_orderList));
      isLocal = true;
    }

    if (isLocal) {
      showToast("Cart Added Successfully", context: context);
      print(box.read(cart_item));

      ///await updateAddressInCart(userId);
      await getCartName();
    } else {
      if (res.statusCode == 200 || res.statusCode == 201) {
        showToast("Cart Added Successfully", context: context);

        ///await updateAddressInCart(userId);
        await getCartName();

        //await getCartSummary();
      } else {
        showToast("Something went wrong", context: context);
      }
    }
  }

  Future<void> getCartName() async {
    cartItemsList.clear();
    orderList.clear();
    box.write(cartList, cartItemsList);
    log("cart length ${cartLength.value}");
    log("-----get cart items---with user ID ${box.read(userID)}--");
    var res;
    var localData;
    List<OrderItemModel> orderItems = [];
    if (UserPreference.getBool(UserPreference.isLoggedIn)!) {
      box.write(cart_item, '');
      res = await http.post(Uri.parse("http://test.protidin.com.bd:88/api/v2/carts/${box.read(userID)}"),
          headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8', 'Authorization': 'Bearer ${box.read(userToken)}'});
      // log("Response ${res.body}");
    } else {
      localData = box.read(cart_item);
      print('CARTDATA: $localData');
    }
    // log("Response code ${res.statusCode}");
    if (localData != null && localData != '') {
      var dataMap = jsonDecode(localData);
      print('CARTDATA: $dataMap');
      orderItems = dataMap == null ? [] : List.from(dataMap.map((item) => OrderItemModel.fromJson(item)));
      orderList.addAll(orderItems);
      orderItems.forEach(
        (element) {
          cartItemsList.add(
            CartItems(
                quantity: element.quantity,
                productName: element.productName,
                productThumbnailImage: element.productThumbnailImage,
                price: element.price,
                currencySymbol: '৳',
                discount: element.discount),
          );
        },
      );
      box.write(cart_length, cartLength);
      log("total length ${cartItemsList.length}");
      cartLength.value = cartItemsList.length;
    } else if (res != null) {
      if (res.statusCode == 200 || res.statusCode == 201) {
        cartItemsList.clear();
        var dataMap = jsonDecode(res.body);
        final List<CartDetailsModel> cartModel = List<CartDetailsModel>.from(dataMap.map((json) => CartDetailsModel.fromJson(json)));

        if (cartModel.isEmpty) cartLength.value = 0;

        for (var element in cartModel) {
          cartItemsList.addAll(element.cartItems);
          box.write(cart_length, cartLength);
          log("total length ${cartItemsList.length}");
          cartLength.value = cartItemsList.length;
        }
      }
    } else {
      cartItemsList.value = [];
      cartLength.value = 0;
    }
  }
}

/*
import 'dart:convert';
import 'dart:developer';

import 'package:customer_ui/components/utils.dart';
import 'package:customer_ui/dataModel/cart_details_model.dart';
import 'package:customer_ui/dataModel/order_product_model.dart';
import 'package:customer_ui/preferences/user_preferance.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class CartItemsController extends GetxController {
  var cartLength = 0.obs;

  var cartItemsList = [].obs;

  String testString = "Hello Text";

  Future<void> addToCart(OrderItemModel orderItemModel, BuildContext context) async {
    var res;
    bool isLocal = false;
    List<OrderItemModel> orderList = [];
    final jsonData = {
      "id": orderItemModel.productId,
      "variant": orderItemModel.variant,
      "user_id": orderItemModel.userId,
      "quantity": orderItemModel.quantity,
    };
    if (UserPreference.getBool(UserPreference.isLoggedIn)!) {
      res = await http.post(
        Uri.parse("http://test.protidin.com.bd:88/api/v2/carts/add"),
        headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8', 'Authorization': 'Bearer ${box.read(userToken)}'},
        body: jsonEncode(jsonData),
      );
    } else {
      if (box.read(cart_item) != null) {
        var savedOrders = box.read(cart_item);
        final extractedData = jsonDecode(savedOrders);
        orderList = List.from(extractedData.map((item) => OrderItemModel.fromJson(item)));
      }
      orderList.add(orderItemModel);
      box.write(cart_item, jsonEncode(orderList));
      isLocal = true;
    }

    if (isLocal) {
      showToast("Cart Added Successfully", context: context);
      print(box.read(cart_item));

      ///await updateAddressInCart(userId);
      await getCartName();
    } else {
      if (res.statusCode == 200 || res.statusCode == 201) {
        showToast("Cart Added Successfully", context: context);

        ///await updateAddressInCart(userId);
        await getCartName();

        //await getCartSummary();
      } else {
        showToast("Something went wrong", context: context);
      }
    }
  }

  Future<void> getCartName() async {
    cartItemsList.clear();
    box.write(cartList, cartItemsList);
    log("cart length ${cartLength.value}");
    log("-----get cart items---with user ID ${box.read(userID)}--");
    var res;
    var localData;
    List<OrderItemModel> orderItems = [];
    if (UserPreference.getBool(UserPreference.isLoggedIn)!) {
      res = await http.post(Uri.parse("http://test.protidin.com.bd:88/api/v2/carts/${box.read(userID)}"),
          headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8', 'Authorization': 'Bearer ${box.read(userToken)}'});
      // log("Response ${res.body}");
    } else {
      localData = box.read(cart_item);
      print('CARTDATA: $localData');
    }
    // log("Response code ${res.statusCode}");

    if (localData != null) {
      var dataMap = jsonDecode(localData);
      print('CARTDATA: $dataMap');
      orderItems = dataMap == null ? [] : List.from(dataMap.map((item) => OrderItemModel.fromJson(item)));
      orderItems.forEach(
        (element) {
          cartItemsList.add(
            CartItems(
              quantity: element.quantity,
              productName: element.productName,
              productThumbnailImage: element.productThumbnailImage,
              price: element.price,
              currencySymbol: '৳',
            ),
          );
        },
      );

      box.write(cart_length, cartLength);
      log("total length ${cartItemsList.length}");
      cartLength.value = cartItemsList.length;
    } else if (res != null) {
      if (res.statusCode == 200 || res.statusCode == 201) {
        var dataMap = jsonDecode(res.body);
        final List<CartDetailsModel> cartModel = List<CartDetailsModel>.from(dataMap.map((json) => CartDetailsModel.fromJson(json)));

        if (cartModel.isEmpty) cartLength.value = 0;

        for (var element in cartModel) {
          cartItemsList.addAll(element.cartItems);

          box.write(cart_length, cartLength);
          log("total length ${cartItemsList.length}");
          cartLength.value = cartItemsList.length;
        }
      }
    } else {
      cartItemsList.value = [];
      cartLength.value = 0;
    }
  }
}

 */

/*
import 'dart:convert';
import 'dart:developer';

import 'package:customer_ui/components/utils.dart';
import 'package:customer_ui/dataModel/cart_details_model.dart';
import 'package:customer_ui/dataModel/order_product_model.dart';
import 'package:customer_ui/preferences/user_preferance.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class CartItemsController extends GetxController {
  var cartLength = 0.obs;

  var cartItemsList = [].obs;

  String testString = "Hello Text";

  Future<void> addToCart(OrderItemModel orderItemModel, BuildContext context) async {
    var res;
    bool isLocal = false;
    List<OrderItemModel> orderList = [];
    final jsonData = {
      "id": orderItemModel.productId,
      "variant": orderItemModel.variant,
      "user_id": orderItemModel.userId,
      "quantity": orderItemModel.quantity,
    };
    if (UserPreference.getBool(UserPreference.isLoggedIn)!) {
      res = await http.post(
        Uri.parse("http://test.protidin.com.bd:88/api/v2/carts/add"),
        headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8', 'Authorization': 'Bearer ${box.read(userToken)}'},
        body: jsonEncode(jsonData),
      );
    } else {
      if (box.read(cart_item) != null) {
        var savedOrders = box.read(cart_item);
        final extractedData = jsonDecode(savedOrders);
        orderList = List.from(extractedData.map((item) => OrderItemModel.fromJson(item)));
      }
      orderList.add(orderItemModel);
      box.write(cart_item, jsonEncode(orderList));
      isLocal = true;
    }

    if (isLocal) {
      showToast("Cart Added Successfully", context: context);
      print(box.read(cart_item));

      ///await updateAddressInCart(userId);
      await getCartName();
    } else {
      if (res.statusCode == 200 || res.statusCode == 201) {
        showToast("Cart Added Successfully", context: context);

        ///await updateAddressInCart(userId);
        await getCartName();

        //await getCartSummary();
      } else {
        showToast("Something went wrong", context: context);
      }
    }
  }

  Future<void> getCartName() async {
    cartItemsList.clear();
    box.write(cartList, cartItemsList);
    log("cart length ${cartLength.value}");
    log("-----get cart items---with user ID ${box.read(userID)}--");
    var res;
    var localData;
    List<OrderItemModel> orderItems = [];
    if (UserPreference.getBool(UserPreference.isLoggedIn)!) {
      res = await http.post(Uri.parse("http://test.protidin.com.bd:88/api/v2/carts/${box.read(userID)}"),
          headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8', 'Authorization': 'Bearer ${box.read(userToken)}'});
      // log("Response ${res.body}");
    } else {
      localData = box.read(cart_item);
      print('CARTDATA: $localData');
    }
    // log("Response code ${res.statusCode}");

    if (localData != null) {
      var dataMap = jsonDecode(localData);
      print('CARTDATA: $dataMap');
      orderItems = dataMap == null ? [] : List.from(dataMap.map((item) => OrderItemModel.fromJson(item)));
      orderItems.forEach(
        (element) {
          cartItemsList.add(
            CartItems(
              quantity: element.quantity,
              productName: element.productName,
              productThumbnailImage: element.productThumbnailImage,
              price: element.price,
              currencySymbol: '৳',
            ),
          );
        },
      );

      box.write(cart_length, cartLength);
      log("total length ${cartItemsList.length}");
      cartLength.value = cartItemsList.length;
    } else if (res != null) {
      if (res.statusCode == 200 || res.statusCode == 201) {
        var dataMap = jsonDecode(res.body);
        final List<CartDetailsModel> cartModel = List<CartDetailsModel>.from(dataMap.map((json) => CartDetailsModel.fromJson(json)));

        if (cartModel.isEmpty) cartLength.value = 0;

        for (var element in cartModel) {
          cartItemsList.addAll(element.cartItems);

          box.write(cart_length, cartLength);
          log("total length ${cartItemsList.length}");
          cartLength.value = cartItemsList.length;
        }
      }
    } else {
      cartItemsList.value = [];
      cartLength.value = 0;
    }
  }
}

*/
