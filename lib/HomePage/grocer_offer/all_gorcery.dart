/*import 'dart:convert';
import 'dart:developer';

import 'package:customer_ui/HomePage/offer/grocery.dart';
import 'package:customer_ui/components/size_config.dart';
import 'package:customer_ui/components/styles.dart';
import 'package:customer_ui/components/utils.dart';
import 'package:customer_ui/dataModel/breat_biscuit.dart';
import 'package:customer_ui/dataModel/category_data_model.dart';
import 'package:customer_ui/dataModel/chocolate_sweet_data_model.dart';
import 'package:customer_ui/dataModel/grocery_product.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';


/*var screenTwoName="";
var screenTwoAddress="";
var screenTwoProfession="";

ScreenTwo({required this.screenTwoName,required this.screenTwoAddress,required this.screenTwoProfession});*/

class AllGrocery extends StatefulWidget {
  const AllGrocery({Key? key}) : super(key: key);

  @override
  _AllGroceryState createState() => _AllGroceryState();
}

class _AllGroceryState extends State<AllGrocery> {


  @override
  void initState() {
    // TODO: implement initState
    getGroceryProduct();

  }

  //var groceryProducts = [];
  List<GroceryProduct> groceryProducts = [];

  Future<void> getGroceryProduct() async {
    log("grocery data calling");
    //String groceryURl = "https://test.protidin.com.bd/api/v2/sub-categories/4";
    String groceryURl = "https://test.protidin.com.bd/api/v2/products/category/4";

    final response3 = await get(Uri.parse(groceryURl), headers: {"Accept": "application/json"});

    var groceryDataMap = jsonDecode(response3.body);

    if (groceryDataMap["success"] == true) {
      log("data valid");
      /*
      var categoryDataModel = CategoryDataModel.fromJson(groceryDataMap);
      groceryData = categoryDataModel.data;
      groceryItemData = categoryDataModel.data[0].name;
       */
      var groceryProductDataModel = GroceryProduct.fromJson(groceryDataMap);
      groceryProducts = groceryProductDataModel.data.cast<GroceryProduct>();
      setState(() {});
      log("grocery data length ${groceryProducts.length}");
    } else {
      log("data invalid");
    }

    // log("after decode $dataMap");
  }


  /*var groceryProducts = [];

  Future<void> getGroceryProductsAfterTap(link2) async {
    log("calling after tap");
    //String biscuitSweetsURl = "https://test.protidin.com.bd/api/v2/products/category/46";

    final response7 = await get(Uri.parse(link2), headers: {"Accept": "application/json"});

    var groceryItemDataMap = jsonDecode(response7.body);

    if (groceryItemDataMap["success"] == true) {
      //log("category data after tap $biscuitSweetsDataMap");

      setState(() {
        var groceryData = BiacuitSweets.fromJson(groceryItemDataMap);
        groceryProducts = groceryData.data;
      });
      log("after tap grocery data length ${groceryProducts.length}");
    } else {
      log("data invalid");
    }

    // log("after decode $dataMap");
  }*/


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
        child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: groceryProducts.length,
            itemBuilder: (_, index) {
              return Column(
                children: [
                  Container(
                    //height: height * 0.15,
                    width: width,
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    child: Row(
                      children: [
                        InkWell(
                            /*onTap: () {
                              // Navigator.push(context, MaterialPageRoute(builder: (context) => GroceryDetails()));
                            },*/
                          child: groceryProducts[index].isEmpty
                              ?

                          //Text("OK"):
                          Image.asset("assets/app_logo.png")
                              : Image.network(
                            imagePath + fruitBeverageData[index].mobileBanner,
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
                              Text(
                                groceryProducts[index].name,
                                style: TextStyle(color: kBlackColor, fontSize: block * 4, fontWeight: FontWeight.w500),
                                maxLines: 2,
                              ),
                              sized5,
                              Container(
                                height: height * 0.03,
                                margin: EdgeInsets.only(top: 10),
                                width: width * 0.15,
                                decoration: BoxDecoration(color: Colors.green),
                                child: Center(
                                  child: Text(
                                    "15% Off",
                                    style: TextStyle(color: Colors.white, fontSize: block * 3, fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              sized5,
                              Row(
                                children: [
                                  Row(
                                    children: [
                                      Text(groceryProducts[index].,
                                          style: TextStyle(color: kBlackColor, fontSize: block * 4.5, fontWeight: FontWeight.bold)),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                          groceryProducts[index].basePrice.toString(),
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
                                    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 3.0),
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
                  )
                ],
              );
            }
        ),
      ),
    );
  }
}*/



import 'package:customer_ui/HomePage/offer/grocery.dart';
import 'package:customer_ui/components/size_config.dart';
import 'package:customer_ui/components/styles.dart';
import 'package:flutter/material.dart';

class AllGrocery extends StatefulWidget {
  const AllGrocery({Key? key}) : super(key: key);

  @override
  _AllGroceryState createState() => _AllGroceryState();
}

class _AllGroceryState extends State<AllGrocery> {
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
                      SizedBox(width: 5,),
                      Text("Top Deal"),
                      SizedBox(width: 5,),
                      Icon(Icons.keyboard_arrow_down)
                    ],
                  ),
                  Icon(Icons.category_outlined)
                ],
              ),
              sized20,
              Expanded(
                child: ListView(
                  children: [
                    TabProductItemWidget(
                      width: width,
                      block: block,
                      height: height,
                      image: "assets/lays.png",
                      productName: "Lays Premium Chips Orange Flavor- 65g",
                      actualPrice: "BDT 130",
                      discountPrice: "BDT 110",
                    ),
                    TabProductItemWidget(
                      width: width,
                      block: block,
                      height: height,
                      image: "assets/dove.png",
                      productName: "Dove Alovera Moyesture Lotions - 500g",
                      actualPrice: "BDT 550",
                      discountPrice: "BDT 410",
                    ),
                    TabProductItemWidget(
                      width: width,
                      block: block,
                      height: height,
                      image: "assets/oil.png",
                      productName: "Aci Pure 100% Healthy Soyabin Oil - 5 litre",
                      actualPrice: "BDT 650",
                      discountPrice: "BDT 590",
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
