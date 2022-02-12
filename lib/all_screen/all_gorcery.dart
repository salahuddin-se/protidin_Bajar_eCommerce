import 'dart:developer';

import 'package:customer_ui/components/size_config.dart';
import 'package:customer_ui/components/styles.dart';
import 'package:customer_ui/components/utils.dart';
import 'package:customer_ui/dataModel/product_response.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import 'grocery.dart';

class AllGrocery extends StatefulWidget {
  const AllGrocery({Key? key, required this.link}) : super(key: key);

  final String link;

  @override
  _AllGroceryState createState() => _AllGroceryState();
}

class _AllGroceryState extends State<AllGrocery> {
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
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchProducts(widget.link);
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var width = SizeConfig.screenWidth;
    var height = SizeConfig.screenHeight;
    var block = SizeConfig.block;
    return Scaffold(
      body: SizedBox(
        height: height,
        width: width,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              sized20,
              Expanded(
                child: ListView.builder(
                  itemBuilder: (BuildContext context, int index) {
                    return TabProductItemWidget(
                      width: width,
                      block: block,
                      height: height,
                      //Image.network(imagePath + listOfProducts[index].thumbnail_image.toString()),
                      image: imagePath + listOfProducts[index].thumbnail_image.toString(),
                      productName: listOfProducts[index].name.toString(),
                      discountPrice: listOfProducts[index].base_price,
                      actualPrice: listOfProducts[index].base_discounted_price,
                      id: listOfProducts[index].id,
                      off: listOfProducts[index].discount.toString(),
                    );
                  },
                  itemCount: listOfProducts.length,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/*

import 'dart:developer';

import 'package:customer_ui/components/size_config.dart';
import 'package:customer_ui/components/styles.dart';
import 'package:customer_ui/components/utils.dart';
import 'package:customer_ui/dataModel/product_response.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import 'grocery.dart';

class AllGrocery extends StatefulWidget {
  const AllGrocery({Key? key, required this.link}) : super(key: key);

  final String link;

  @override
  _AllGroceryState createState() => _AllGroceryState();
}

class _AllGroceryState extends State<AllGrocery> {
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
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchProducts(widget.link);
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var width = SizeConfig.screenWidth;
    var height = SizeConfig.screenHeight;
    var block = SizeConfig.block;
    return Scaffold(
      body: SizedBox(
        height: height,
        width: width,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("1454 offer found"),
                  Row(
                    children: const [
                      Icon(Icons.filter_list_outlined),
                      SizedBox(
                        width: 5,
                      ),
                      Text("Top Deal"),
                      SizedBox(
                        width: 5,
                      ),
                      Icon(Icons.keyboard_arrow_down)
                    ],
                  ),
                  Icon(Icons.category_outlined)
                ],
              ),
              sized20,
              Expanded(
                child: ListView.builder(
                  itemBuilder: (BuildContext context, int index) {
                    return TabProductItemWidget(
                      width: width,
                      block: block,
                      height: height,
                      image: '',
                      productName: listOfProducts[index].name.toString(),
                      actualPrice: "BDT 130",
                      discountPrice: "BDT 110",
                    );
                  },
                  itemCount: listOfProducts.length,
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
