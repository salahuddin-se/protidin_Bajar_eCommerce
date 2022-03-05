import 'dart:developer';

import 'package:customer_ui/components/styles.dart';
import 'package:customer_ui/components/utils.dart';
import 'package:customer_ui/controller/cartItemsController.dart';
import 'package:customer_ui/dataModel/order_product_model.dart';
import 'package:customer_ui/dataModel/product_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
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
    this.unit,
    this.discountPrice,
    this.id,
  }) : super(key: key);

  final double width;
  final double block;
  final double height;
  final String? image;
  final String? productName;
  final String? unit;
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
        //Text("HI"),

        Stack(
          children: [
            Container(
              //height: height * 0.15,
              width: widget.width,
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                children: [
                  Stack(children: [
                    InkWell(
                      onTap: () {
                        // Navigator.push(context, MaterialPageRoute(builder: (context) => GroceryDetails()));
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width / 3.2,
                        child: Image.network(widget.image!),
                      ),
                    ),
                    // widget.discountPrice == widget.actualPrice
                    //     ? Text("")
                    //     : Container(
                    //   height: widget.height * 0.03,
                    //   margin: EdgeInsets.only(top: 10),
                    //   width: widget.width * 0.16,
                    //   decoration: BoxDecoration(
                    //     color: Colors.green,
                    //     borderRadius: BorderRadius.circular(3),
                    //   ),
                    //   child: Center(
                    //     child: Text(
                    //       "${widget.off.toString()}TK OFF",
                    //       style: TextStyle(color: Colors.white, fontSize: widget.block * 3, fontWeight: FontWeight.bold),
                    //     ),
                    //   ),
                    // ),
                  ]),
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
                          style: TextStyle(
                            color: Color(0xFF515151),
                            fontSize: 16,
                            fontFamily: 'CeraProMedium',
                            fontWeight: FontWeight.w500,
                          ),
                          maxLines: 2,
                        ),
                        SizedBox(height: 5),
                        sized5,
                        widget.discountPrice == widget.actualPrice
                            ? Text("")
                            : Align(
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  height: widget.height * 0.03,
                                  margin: EdgeInsets.only(top: 10),
                                  width: widget.width * 0.16,
                                  decoration: BoxDecoration(
                                    //color: Colors.green,
                                    borderRadius: BorderRadius.circular(3),
                                  ),
                                  child: Text(
                                    widget.unit.toString(),
                                    style: TextStyle(color: Colors.black, fontSize: widget.block * 3, fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                        sized5,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                            Container(
                              //width: MediaQuery.of(context).size.width / 3,
                              child: Row(
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width / 5.5,
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 0.0),
                                      child: Text(
                                        widget.actualPrice!,
                                        style: TextStyle(
                                          color: Color(0xFF515151),
                                          fontSize: 22,
                                          fontFamily: 'CeraProMedium',
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  ),
                                  //Padding(padding: const EdgeInsets.only(left: 5)),
                                  widget.discountPrice == widget.actualPrice
                                      ? Container(width: MediaQuery.of(context).size.width / 6.5, child: Text(""))
                                      : Container(
                                          width: MediaQuery.of(context).size.width / 6.5,
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                                            child: Text(
                                              widget.discountPrice!,
                                              style: TextStyle(
                                                  color: kBlackColor,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400,
                                                  fontFamily: 'CeraProMedium',
                                                  decoration: TextDecoration.lineThrough),
                                            ),
                                          ),
                                        ),
                                ],
                              ),
                            ),

                            InkWell(
                              onTap: () {
                                ///
                                controller2.addToCart(
                                    OrderItemModel(
                                      productId: widget.id,
                                      price: int.tryParse(widget.discountPrice!.toString().replaceAll('৳', '')),
                                      productThumbnailImage: widget.image,
                                      productName: widget.productName,
                                      quantity: 1,
                                      userId: box.read(userID),
                                      variant: '',
                                      discount: int.tryParse(widget.off!.replaceAll('TK OFF', '')),
                                      discountType: '',
                                      unit: int.tryParse(widget.unit!.toString()),
                                    ),
                                    context);

                                ///
                                //Navigator.push(context, MaterialPageRoute(builder: (context) => CartDetails()));
                              },
                              child: Container(
                                width: 32,
                                height: 40,
                                //padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 3.0),
                                decoration: BoxDecoration(
                                  //color: kPrimaryColor,
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      "assets/img_193.png",
                                      height: 40,
                                      width: 32,
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            //Expanded(child: Container()),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            widget.discountPrice == widget.actualPrice
                ? Text("")
                : Container(
                    height: widget.height * 0.03,
                    margin: EdgeInsets.only(top: 10),
                    width: widget.width * 0.16,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(3),
                    ),
                    child: Center(
                      child: Text(
                        "${widget.off.toString()}TK OFF",
                        style: TextStyle(color: Colors.white, fontSize: widget.block * 3, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
          ],
        ),
        Divider(
          color: kBlackColor,
          thickness: 0.2,
        ),

        SizedBox(
          height: 15,
        )
      ],
    );
  }
}
