import 'dart:convert';
import 'dart:developer';

import 'package:customer_ui/components/styles.dart';
import 'package:customer_ui/components/utils.dart';
import 'package:customer_ui/controller/cartItemsController.dart';
import 'package:customer_ui/dataModel/product_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class TabProductItemWidget extends StatefulWidget {
  const TabProductItemWidget({
    Key? key,
    required this.width,
    required this.block,
    required this.height,
    this.image,
    this.productName,
    this.off,
    this.actualPrice,
    this.discountPrice,
    this.id,
  }) : super(key: key);

  final double width;
  final double block;
  final double height;
  final String? image;
  final String? productName;
  final String? off;
  final String? actualPrice;
  final String? discountPrice;
  final int? id;

  @override
  State<TabProductItemWidget> createState() => _TabProductItemWidgetState();
}

class _TabProductItemWidgetState extends State<TabProductItemWidget> {
  var controller2 = Get.put(CartItemsController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    ///fetchProducts("link2");
  }

  Future<void> addToCart(
    id,
    userId,
    quantity,
  ) async {
    log("user id $userId");
    var res = await http.post(Uri.parse("http://test.protidin.com.bd:88/api/v2/carts/add"),
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
      await controller2.getCartName();
    } else {
      showToast("Something went wrong", context: context);
    }
  }

  List<Product> listOfProducts = [];
  Future fetchProducts(link2) async {
    listOfProducts.clear();
    log("tap link $link2");
    log("user id ${box.read(user_Id)}");
    log("web store id ${box.read(webStoreId)}");

    var response = await get(Uri.parse(link2));
    var productResponse = productMiniResponseFromJson(response.body);

    for (var ele in productResponse.products!) {
      if (ele.user_id == box.read(user_Id) || ele.user_id == box.read(webStoreId)) {
        log(" name  ${ele.name}");
        listOfProducts.add(Product(
            name: ele.name,
            thumbnail_image: ele.thumbnail_image,
            base_discounted_price: ele.base_discounted_price,
            shop_name: ele.shop_name,
            base_price: ele.base_price,
            unit: ele.unit,
            id: ele.id,
            links: ele.links!,
            discount: ele.discount!,
            has_discount: ele.has_discount,
            user_id: ele.user_id));
        log("product length ${listOfProducts.length}");
        setState(() {});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          //height: height * 0.15,
          width: widget.width,
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: Row(
            children: [
              InkWell(
                  onTap: () {
                    // Navigator.push(context, MaterialPageRoute(builder: (context) => GroceryDetails()));
                  },
                  child: Container(width: MediaQuery.of(context).size.width / 3, child: Image.network(widget.image!))),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.productName!,
                      style: TextStyle(color: kBlackColor, fontSize: widget.block * 4, fontWeight: FontWeight.w500),
                      maxLines: 2,
                    ),
                    sized5,
                    widget.discountPrice == widget.actualPrice
                        ? Text("")
                        : Container(
                            height: widget.height * 0.03,
                            margin: EdgeInsets.only(top: 10),
                            width: widget.width * 0.15,
                            decoration: BoxDecoration(color: Colors.green),
                            child: Center(
                              child: Text(
                                "${widget.off.toString()}TK OFF",
                                style: TextStyle(color: Colors.white, fontSize: widget.block * 3, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                    sized5,
                    Row(
                      //mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          //width: MediaQuery.of(context).size.width / 3,
                          child: Row(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width / 7,
                                child: Text(
                                  widget.actualPrice!,
                                  style: TextStyle(
                                    color: kBlackColor,
                                    fontSize: widget.block * 4.5,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              //Padding(padding: const EdgeInsets.only(left: 5)),
                              widget.discountPrice == widget.actualPrice
                                  ? Container(width: MediaQuery.of(context).size.width / 6, child: Text(""))
                                  : Container(
                                      width: MediaQuery.of(context).size.width / 7,
                                      child: Padding(
                                        padding: const EdgeInsets.only(right: 15.0),
                                        child: Text(widget.discountPrice!,
                                            style: TextStyle(
                                                color: kBlackColor,
                                                fontSize: widget.block * 4,
                                                fontWeight: FontWeight.w300,
                                                decoration: TextDecoration.lineThrough)),
                                      ),
                                    ),
                            ],
                          ),
                        ),

                        InkWell(
                          onTap: () {
                            ///
                            addToCart(widget.id, box.read(userID), 1);

                            ///
                            //Navigator.push(context, MaterialPageRoute(builder: (context) => CartDetails()));
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width / 5.5,
                            height: 28,
                            //padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 3.0),
                            decoration: BoxDecoration(
                              color: kPrimaryColor,
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                    width: 30,
                                    height: 15,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 2.0),
                                      child: Text("Add",
                                          style: TextStyle(color: kWhiteColor, fontSize: widget.block * 3.5, fontWeight: FontWeight.bold)),
                                    )),
                                Icon(
                                  Icons.add,
                                  color: kWhiteColor,
                                  size: 20,
                                )
                              ],
                            ),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(left: 0.0),
                        )
                        //Expanded(child: Container()),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        Divider(
          color: kBlackColor,
          thickness: 0.3,
        ),
      ],
    );
  }
}
