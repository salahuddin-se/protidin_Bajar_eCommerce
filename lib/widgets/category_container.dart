import 'dart:convert';
import 'package:customer_ui/all_screen/product_details.dart';
import 'package:customer_ui/components/size_config.dart';
import 'package:customer_ui/components/styles.dart';
import 'package:customer_ui/components/utils.dart';
import 'package:customer_ui/dataModel/breat_biscuit.dart';
import 'package:customer_ui/dataModel/category_data_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

class CategoryContainer extends StatefulWidget {
  const CategoryContainer({Key? key, required this.categoryName, required this.nameNo,
    required this.large_Banner,required this.add_banner

  })
      : super(key: key);
  final String categoryName;
  final String nameNo;
  final String large_Banner;
  final String add_banner;

  @override
  _CategoryContainerState createState() => _CategoryContainerState();
}

class _CategoryContainerState extends State<CategoryContainer> {
  var categoryData = [];
  var valueOne;
  var categoryItemData = " ";
  var relatedProductsLink = " ";
  var subCategoryProducts = [];

  Future<void> getSubCategoryProductsAfterTap(link2) async {
    //log("calling after tap");
    //String biscuitSweetsURl = "https://test.protidin.com.bd/api/v2/products/category/46";

    final response7 = await get(Uri.parse(link2), headers: {"Accept": "application/json"});

    var groceryItemDataMap = jsonDecode(response7.body);

    if (groceryItemDataMap["success"] == true) {
      //log("category data after tap $biscuitSweetsDataMap");

      //var groceryData = BiacuitSweets.fromJson(groceryItemDataMap);
      var groceryData = BreadBiscuit.fromJson(groceryItemDataMap);
      subCategoryProducts = groceryData.data;
      //relatedProductsLink=groceryProducts[0].links.products;

      setState(() {
        subCategoryProducts.length;
      });

      //log("after tap grocery data length ${subCategoryProducts.length}");
    } else {
      //log("data invalid");
    }

    // log("after decode $dataMap");
  }

  Future<void> getCategoryData({required String name}) async {
    //log("grocery data calling");
    String groceryURl = "https://test.protidin.com.bd/api/v2/sub-categories/$name";

    final response3 = await get(Uri.parse(groceryURl), headers: {"Accept": "application/json"});

    var groceryDataMap = jsonDecode(response3.body);

    if (groceryDataMap["success"] == true) {
      //log("data valid");
      var categoryDataModel = CategoryDataModel.fromJson(groceryDataMap);
      categoryData = categoryDataModel.data;
      categoryItemData = categoryDataModel.data[0].name;
      //categoryItemData = categoryDataModel.data[0].large_Banner;
      relatedProductsLink = categoryData[0].links.products;

      await getSubCategoryProductsAfterTap(categoryDataModel.data[0].links.products);
      setState(() {});
      //log("grocery data length ${categoryData.length}");
    } else {
      //log("data invalid");
    }
    // log("after decode $dataMap");
  }

  Future<void> addToCart(id, userId, quantity) async {
    var res = await http.post(Uri.parse("https://test.protidin.com.bd/api/v2/carts/add"),
        headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8', 'Authorization': 'Bearer $authToken'},
        body: jsonEncode(<String, dynamic>{"id": id, "variant": "", "user_id": userId, "quantity": quantity}));

    //log("Response ${res.body}");
    //log("Response code jhjk ${res.statusCode}");

    if (res.statusCode == 200 || res.statusCode == 201) {
      showToast("Cart Added Successfully", context: context);
    } else {
      showToast("Something went wrong", context: context);
    }
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCategoryData(name: widget.nameNo);
  }




  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var width = SizeConfig.screenWidth;
    var height = SizeConfig.screenHeight;
    var block = SizeConfig.block;
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width / 1,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            color: Colors.white,
          ),
          child: Column(
            children: [
              SizedBox(
                height: 25,
              ),

              SizedBox(
                width: MediaQuery.of(context).size.width / 1.1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.categoryName,
                      style:
                          TextStyle(color: Color(0xFF515151), fontSize: 22, fontWeight: FontWeight.w700, fontFamily: "CeraProBold"),
                    ),
                    Text(
                      "VIEW ALL",
                      style: TextStyle(color: Color(0xFF515151), fontSize: 12, fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),


              SizedBox(height: 5,),



              ///large_banner
              Container(
                height: 100,
                decoration: BoxDecoration(
                  //color: Colors.grey.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                //width: double.infinity,
                width: MediaQuery.of(context).size.width/1.1,
                child: Image.network(
                  imagePath + widget.large_Banner,
                  fit: BoxFit.cover,
                ),
              ),

              /*Container(
                height: 50,
                width: double.infinity,
                child: Image.network(
                  imagePath + widget.large_Banner,
                  fit: BoxFit.cover,
                ),
              ),*/

              sized20,

              Container(
                height: height * 0.22,
                width: width,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: categoryData.length,
                  itemBuilder: (_, index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          valueOne = index.toString();
                          categoryItemData = categoryData[index].name;
                          relatedProductsLink = categoryData[index].links.products;
                          getSubCategoryProductsAfterTap(categoryData[index].links.products);
                        });
                      },
                      child: valueOne.toString() != index.toString()
                          ? Container(
                              child: Container(
                                height: height * 0.2,
                                width: width * 0.35,
                                margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 5),
                                decoration: BoxDecoration(
                                  //color: Colors.grey.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Column(
                                  children: [
                                    //SizedBox(height: 15,),
                                    Container(
                                      height: height * 0.15,
                                      //width: width*0.30,
                                      width: width * 0.30,
                                      decoration: BoxDecoration(color: Color(0xFFF0E6F2), borderRadius: BorderRadius.circular(15.0)),
                                      child: Center(
                                        child: Padding(
                                          padding: const EdgeInsets.all(0),
                                          child: categoryData[index].mobileBanner.isEmpty
                                              ?

                                              //Text("OK"):
                                              Image.asset("assets/app_logo.png")
                                              : Image.network(
                                                  imagePath + categoryData[index].mobileBanner,
                                                ),
                                        ),
                                      ),
                                    ),
                                    sized5,
                                    Text(
                                      categoryData[index].name,
                                      style: TextStyle(color: Color(0xFF515151), fontSize: block * 4, fontWeight: FontWeight.w700),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : Padding(
                              padding: const EdgeInsets.only(left: 5.0),
                              child: Container(
                                  //height: height * 0.2,
                                  height: height * 0.2,
                                  width: width * 0.35,
                                  margin: EdgeInsets.symmetric(vertical: 5.0),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: Column(
                                    children: [
                                      Container(
                                        height: height * 0.15,
                                        width: width * 0.30,
                                        decoration: BoxDecoration(
                                            //color: Colors.grey.withOpacity(0.2),
                                            borderRadius: BorderRadius.circular(15.0)),
                                        child: Padding(
                                          padding: const EdgeInsets.all(0),
                                          child: Center(
                                            child: categoryData[index].mobileBanner.isEmpty
                                                ?
                                                //Text("OK"):
                                                Image.asset("assets/app_logo.png")
                                                : Image.network(
                                                    imagePath + categoryData[index].mobileBanner,
                                                  ),
                                          ),
                                        ),
                                      ),
                                      sized5,
                                      Text(
                                        categoryData[index].name,
                                        style: TextStyle(color: Color(0xFF515151), fontSize: block * 4, fontWeight: FontWeight.w700),
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  )),
                            ),
                    );
                  },
                ),
              ),

              SizedBox(
                height: 5,
              ),
              //sized20,
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    categoryItemData,
                    style: TextStyle(color: Color(0xFF515151), fontSize: 22, fontWeight: FontWeight.w700, fontFamily: "CeraProBold"),
                  ),
                ),
              ),
              sized20,
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 0, 8, 0),
                child: Container(
                  height: height * 0.32,
                  width: width,
                  child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: subCategoryProducts.length,
                      itemBuilder: (_, index) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Container(
                            decoration: BoxDecoration(color: Color(0xFFF1EDF2), borderRadius: BorderRadius.circular(15.0)),
                            //height: MediaQuery.of(context).size.height/3.2,width: MediaQuery.of(context).size.width / 2.34,
                            child: Column(
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Container(
                                    width: MediaQuery.of(context).size.width / 5,
                                    height: MediaQuery.of(context).size.height / 45,
                                    margin: EdgeInsets.only(top: 10),
                                    decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius:
                                          BorderRadius.only(topRight: Radius.circular(4.0), bottomRight: Radius.circular(4.0)),
                                    ),
                                    //

                                    child: Center(
                                      child: Text(
                                        "15% OFF",
                                        style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ),
                                ),

                                ///
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => GroceryDetails(
                                                  detailsLink: subCategoryProducts[index].links.details,
                                                  relatedProductLink: relatedProductsLink,
                                                )));
                                  },
                                  child: Container(
                                    child: Image.network(imagePath + subCategoryProducts[index].thumbnailImage),
                                    height: MediaQuery.of(context).size.height / 8,
                                    width: MediaQuery.of(context).size.width / 2.34,
                                  ),
                                ),

                                ///

                                FittedBox(
                                  child: Container(
                                    ///height: height! * 0.08,
                                    width: MediaQuery.of(context).size.width / 2.36,
                                    height: MediaQuery.of(context).size.height / 17,
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(5, 5, 5, 0),
                                      child: Text(
                                        subCategoryProducts[index].name,
                                        style: TextStyle(
                                          color: Color(0xFF515151),
                                          fontSize: 12.5,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: "CeraProBold",
                                        ),
                                        maxLines: 2,
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                ),

                                Center(
                                  child: Container(
                                    height: MediaQuery.of(context).size.height / 38,
                                    child: Text(
                                      subCategoryProducts[index].unit,
                                      style: TextStyle(color: Colors.grey.withOpacity(0.9)),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: Center(
                                    child: Container(
                                      height: MediaQuery.of(context).size.height / 32,
                                      width: MediaQuery.of(context).size.width / 2.34,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Container(
                                            child: Image.asset("assets/p.png"),
                                            height: 20,
                                            width: 22,
                                          ),
                                          Text(subCategoryProducts[index].baseDiscountedPrice.toString(),
                                              style: TextStyle(color: Color(0xFF515151), fontSize: 16, fontWeight: FontWeight.w700)),
                                          Text(subCategoryProducts[index].basePrice.toString(),
                                              style: TextStyle(
                                                  color: Color(0xFFA299A8),
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w400,
                                                  decoration: TextDecoration.lineThrough)),
                                          Padding(
                                            padding: const EdgeInsets.only(left: 10),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              addToCart(subCategoryProducts[index].id, 61, 1);
                                              //Navigator.push(context, MaterialPageRoute(builder: (context) => CartDetails()));
                                            },
                                            child: Container(
                                              height: 25,
                                              width: 25,
                                              decoration: BoxDecoration(color: kPrimaryColor, shape: BoxShape.circle),
                                              child: Center(
                                                child: Image.asset("assets/pi.png"),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  //height: height! * 0.03,
                                  height: MediaQuery.of(context).size.height / 26,
                                  width: MediaQuery.of(context).size.width / 2.34,
                                  decoration: BoxDecoration(
                                      color: Colors.lightGreen[100],
                                      borderRadius:
                                          BorderRadius.only(bottomLeft: Radius.circular(10.0), bottomRight: Radius.circular(10.0))),
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(1, 3, 1, 3),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          child: Image.asset("assets/img_42.png"),
                                          height: 17,
                                          width: 15,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(top: 2),
                                          child: Text(
                                            "  Earning +৳18",
                                            style: TextStyle(fontSize: 12, color: Colors.green, fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      }),
                ),
              ),

              SizedBox(
                height: 35,
              ),



            ],
          ),
        ),

        SizedBox(height: 32,),
        Container(
          height: 200,
          decoration: BoxDecoration(
            //color: Colors.grey.withOpacity(0.2),
            borderRadius: BorderRadius.circular(10.0),
          ),
          //width: double.infinity,
          width: MediaQuery.of(context).size.width/1.1,
          child: Image.network(
            imagePath + widget.add_banner,
            fit: BoxFit.cover,
          ),
        ),

      ],
    );

  }
}






/*
import 'dart:convert';
import 'dart:developer';
import 'package:customer_ui/HomePage/grocer_offer/product_details.dart';
import 'package:customer_ui/components/size_config.dart';
import 'package:customer_ui/components/styles.dart';
import 'package:customer_ui/components/utils.dart';
import 'package:customer_ui/dataModel/category_data_model.dart';
import 'package:customer_ui/dataModel/chocolate_sweet_data_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;


class CategoryContainer extends StatefulWidget {
  const CategoryContainer({Key? key, required this.categoryName, required this.nameNo}) : super(key: key);
  final String categoryName;
  final String nameNo;


  @override
  _CategoryContainerState createState() => _CategoryContainerState();
}

class _CategoryContainerState extends State<CategoryContainer> {
  var categoryData = [];
  var valueOne;
  var categoryItemData = " ";
  var relatedProductsLink=" ";
  var subCategoryProducts = [];

  Future<void> getSubCategoryProductsAfterTap(link2) async {
    log("calling after tap");
    //String biscuitSweetsURl = "https://test.protidin.com.bd/api/v2/products/category/46";

    final response7 = await get(Uri.parse(link2), headers: {"Accept": "application/json"});

    var groceryItemDataMap = jsonDecode(response7.body);

    if (groceryItemDataMap["success"] == true) {
      //log("category data after tap $biscuitSweetsDataMap");


      var groceryData = BiacuitSweets.fromJson(groceryItemDataMap);
      subCategoryProducts = groceryData.data;
      //relatedProductsLink=groceryProducts[0].links.products;

      setState(() {
        subCategoryProducts.length;
      });

      log("after tap grocery data length ${subCategoryProducts.length}");
    } else {
      log("data invalid");
    }

    // log("after decode $dataMap");
  }

  Future<void> getCategoryData({required String name}) async {
    log("grocery data calling");
    String groceryURl = "https://test.protidin.com.bd/api/v2/sub-categories/$name";

    final response3 = await get(Uri.parse(groceryURl), headers: {"Accept": "application/json"});

    var groceryDataMap = jsonDecode(response3.body);

    if (groceryDataMap["success"] == true) {
      log("data valid");

      var categoryDataModel = CategoryDataModel.fromJson(groceryDataMap);
      categoryData = categoryDataModel.data;
      categoryItemData = categoryDataModel.data[0].name;
      relatedProductsLink= categoryData[0].links.products;

      await getSubCategoryProductsAfterTap(categoryDataModel.data[0].links.products);
      setState(() {});
      log("grocery data length ${categoryData.length}");
    } else {
      log("data invalid");
    }

    // log("after decode $dataMap");
  }

  Future<void> addToCart(id,userId,quantity)async{
    var res = await http.post(Uri.parse("https://test.protidin.com.bd/api/v2/carts/add"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $authToken'
        },
        body: jsonEncode(<String, dynamic>{"id": id,"variant":"",
          "user_id":userId,"quantity":quantity}));


    log("Response ${res.body}");
    log("Response code jhjk ${res.statusCode}");

    if(res.statusCode==200 || res.statusCode==201){
      showToast("Cart Added Successfully",context:context);
    }else{
      showToast("Something went wrong",context:context);
    }



  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCategoryData(name: widget.nameNo);
  }
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var width = SizeConfig.screenWidth;
    var height = SizeConfig.screenHeight;
    var block = SizeConfig.block;
    return Container(
      width: MediaQuery.of(context).size.width / 1,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        color: Colors.white,
      ),
      child: Column(
        children: [
          SizedBox(
            height: 25,
          ),

          SizedBox(
            width: MediaQuery.of(context).size.width / 1.1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children:  [
                Text(
                  widget.categoryName,
                  style: TextStyle(color: Color(0xFF515151), fontSize: 22, fontWeight: FontWeight.w700, fontFamily: "CeraProBold"),
                ),
                Text(
                  "VIEW ALL",
                  style: TextStyle(color: Color(0xFF515151), fontSize: 12, fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ),

          sized20,

          Stack(children: [
            Image.network(categoryData[0].largeBanner.toString()),
            Positioned(
              bottom: 10,
              left: 10,
              child: Row(
                children: [
                  Text(
                    "Shop for daily needs",
                    style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700, fontFamily: "CeraProBold"),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Container(
                      height: 15,
                      width: 15,
                      child: Image.asset("assets/v.png"),
                    ),
                  )
                ],
              ),
            )
          ]),
          sized20,
          Container(
            height: height * 0.22,
            width: width,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: categoryData.length,
              itemBuilder: (_, index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      valueOne = index.toString();
                      categoryItemData = categoryData[index].name;
                      relatedProductsLink= categoryData[index].links.products;
                      getSubCategoryProductsAfterTap(categoryData[index].links.products);
                    });
                  },
                  child: valueOne.toString() != index.toString()
                      ? Container(
                    child: Container(
                      height: height * 0.2,
                      width: width * 0.35,
                      margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 5),
                      decoration: BoxDecoration(
                        //color: Colors.grey.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Column(
                        children: [
                          //SizedBox(height: 15,),
                          Container(
                            height: height * 0.15,
                            //width: width*0.30,
                            width: width * 0.30,
                            decoration: BoxDecoration(color: Color(0xFFF0E6F2), borderRadius: BorderRadius.circular(15.0)),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(0),
                                child: categoryData[index].mobileBanner.isEmpty
                                    ?

                                //Text("OK"):
                                Image.asset("assets/app_logo.png")
                                    : Image.network(
                                  imagePath + categoryData[index].mobileBanner,
                                ),
                              ),
                            ),
                          ),
                          sized5,
                          Text(
                            categoryData[index].name,
                            style: TextStyle(color: Color(0xFF515151), fontSize: block * 4, fontWeight: FontWeight.w700),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  )
                      : Padding(
                    padding: const EdgeInsets.only(left: 5.0),
                    child: Container(
                      //height: height * 0.2,
                        height: height * 0.2,
                        width: width * 0.35,
                        margin: EdgeInsets.symmetric(vertical: 5.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Column(
                          children: [
                            Container(
                              height: height * 0.15,
                              width: width * 0.30,
                              decoration: BoxDecoration(
                                //color: Colors.grey.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(15.0)),
                              child: Padding(
                                padding: const EdgeInsets.all(0),
                                child: Center(
                                  child: categoryData[index].mobileBanner.isEmpty
                                      ?

                                  //Text("OK"):
                                  Image.asset("assets/app_logo.png")
                                      : Image.network(
                                    imagePath + categoryData[index].mobileBanner,
                                  ),
                                ),
                              ),
                            ),
                            sized5,
                            Text(
                              categoryData[index].name,
                              style: TextStyle(color: Color(0xFF515151), fontSize: block * 4, fontWeight: FontWeight.w700),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        )),
                  ),
                );
              },
            ),
          ),

          SizedBox(
            height: 5,
          ),
          //sized20,
          Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                categoryItemData,
                style: TextStyle(color: Color(0xFF515151), fontSize: 22, fontWeight: FontWeight.w700, fontFamily: "CeraProBold"),
              ),
            ),
          ),
          sized20,
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 0, 8, 0),
            child: Container(
              height: height * 0.32,
              width: width,
              child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: subCategoryProducts.length,
                  itemBuilder: (_, index) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Container(
                        decoration: BoxDecoration(color: Color(0xFFF1EDF2), borderRadius: BorderRadius.circular(15.0)),
                        //height: MediaQuery.of(context).size.height/3.2,width: MediaQuery.of(context).size.width / 2.34,
                        child: Column(
                          children: [

                            Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                width: MediaQuery.of(context).size.width / 5,
                                height: MediaQuery.of(context).size.height / 45,
                                margin: EdgeInsets.only(top: 10),
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius:
                                  BorderRadius.only(topRight: Radius.circular(4.0), bottomRight: Radius.circular(4.0)),
                                ),
                                //

                                child: Center(
                                  child: Text(
                                    "15% OFF",
                                    style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ),
                            ),

                            ///
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => GroceryDetails(
                                          detailsLink: subCategoryProducts[index].links.details,
                                          relatedProductLink: relatedProductsLink,
                                        )
                                    )
                                );
                              },
                              child: Container(
                                child: Image.network(imagePath + subCategoryProducts[index].thumbnailImage),
                                height: MediaQuery.of(context).size.height / 8,
                                width: MediaQuery.of(context).size.width / 2.34,
                              ),
                            ),
                            ///

                            FittedBox(
                              child: Container(
                                ///height: height! * 0.08,
                                width: MediaQuery.of(context).size.width / 2.36,
                                height: MediaQuery.of(context).size.height / 17,
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(5, 5, 5, 0),
                                  child: Text(
                                    subCategoryProducts[index].name,
                                    style: TextStyle(
                                      color: Color(0xFF515151),
                                      fontSize: 12.5,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: "CeraProBold",
                                    ),
                                    maxLines: 2,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),

                            Center(
                              child: Container(
                                height: MediaQuery.of(context).size.height / 38,
                                child: Text(
                                  subCategoryProducts[index].unit,
                                  style: TextStyle(color: Colors.grey.withOpacity(0.9)),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                              child: Center(
                                child: Container(
                                  height: MediaQuery.of(context).size.height / 32,
                                  width: MediaQuery.of(context).size.width / 2.34,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Container(
                                        child: Image.asset("assets/p.png"),
                                        height: 20,
                                        width: 22,
                                      ),
                                      Text(subCategoryProducts[index].baseDiscountedPrice.toString(),
                                          style: TextStyle(color: Color(0xFF515151), fontSize: 16, fontWeight: FontWeight.w700)),
                                      Text(subCategoryProducts[index].basePrice.toString(),
                                          style: TextStyle(
                                              color: Color(0xFFA299A8),
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400,
                                              decoration: TextDecoration.lineThrough)),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 10),
                                      ),
                                      InkWell(
                                        onTap: () {
                                         addToCart(subCategoryProducts[index].id, 61, 1);
                                          //Navigator.push(context, MaterialPageRoute(builder: (context) => CartDetails()));
                                        },
                                        child: Container(
                                          height: 25,
                                          width: 25,
                                          decoration: BoxDecoration(color: kPrimaryColor, shape: BoxShape.circle),
                                          child: Center(
                                            child: Image.asset("assets/pi.png"),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              //height: height! * 0.03,
                              height: MediaQuery.of(context).size.height / 26,
                              width: MediaQuery.of(context).size.width / 2.34,
                              decoration: BoxDecoration(
                                  color: Colors.lightGreen[100],
                                  borderRadius:
                                  BorderRadius.only(bottomLeft: Radius.circular(10.0), bottomRight: Radius.circular(10.0))),
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(1, 3, 1, 3),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      child: Image.asset("assets/img_42.png"),
                                      height: 17,
                                      width: 15,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 2),
                                      child: Text(
                                        "  Earning +৳18",
                                        style: TextStyle(fontSize: 12, color: Colors.green, fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )

                          ],
                        ),
                      ),
                    );
                  }),
            ),
          ),
          SizedBox(
            height: 35,
          ),
        ],
      ),
    );
  }
}

*/

/*
import 'dart:convert';
import 'dart:developer';
import 'package:customer_ui/HomePage/grocer_offer/product_details.dart';
import 'package:customer_ui/components/size_config.dart';
import 'package:customer_ui/components/styles.dart';
import 'package:customer_ui/components/utils.dart';
import 'package:customer_ui/dataModel/category_data_model.dart';
import 'package:customer_ui/dataModel/chocolate_sweet_data_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;


class CategoryContainer extends StatefulWidget {
  const CategoryContainer({Key? key, required this.categoryName, required this.nameNo}) : super(key: key);
  final String categoryName;
  final String nameNo;

  @override
  _CategoryContainerState createState() => _CategoryContainerState();
}

class _CategoryContainerState extends State<CategoryContainer> {
  var categoryData = [];
  var valueOne;
  var categoryItemData = " ";
  var relatedProductsLink=" ";
  var subCategoryProducts = [];

  Future<void> getSubCategoryProductsAfterTap(link2) async {
    log("calling after tap");
    //String biscuitSweetsURl = "https://test.protidin.com.bd/api/v2/products/category/46";

    final response7 = await get(Uri.parse(link2), headers: {"Accept": "application/json"});

    var groceryItemDataMap = jsonDecode(response7.body);

    if (groceryItemDataMap["success"] == true) {
      //log("category data after tap $biscuitSweetsDataMap");


      var groceryData = BiacuitSweets.fromJson(groceryItemDataMap);
      subCategoryProducts = groceryData.data;
      //relatedProductsLink=groceryProducts[0].links.products;

      setState(() {

      });

      log("after tap grocery data length ${subCategoryProducts.length}");
    } else {
      log("data invalid");
    }

    // log("after decode $dataMap");
  }

  Future<void> getCategoryData({required String name}) async {
    log("grocery data calling");
    String groceryURl = "https://test.protidin.com.bd/api/v2/sub-categories/$name";

    final response3 = await get(Uri.parse(groceryURl), headers: {"Accept": "application/json"});

    var groceryDataMap = jsonDecode(response3.body);

    if (groceryDataMap["success"] == true) {
      log("data valid");

      var categoryDataModel = CategoryDataModel.fromJson(groceryDataMap);
      categoryData = categoryDataModel.data;
      categoryItemData = categoryDataModel.data[0].name;
      relatedProductsLink= categoryData[0].links.products;

      await getSubCategoryProductsAfterTap(categoryDataModel.data[0].links.products);
      setState(() {});
      log("grocery data length ${categoryData.length}");
    } else {
      log("data invalid");
    }

    // log("after decode $dataMap");
  }

  Future<void> addToCart(id,userId,quantity)async{
    var res = await http.post(Uri.parse("https://test.protidin.com.bd/api/v2/carts/add"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $authToken'
        },
        body: jsonEncode(<String, dynamic>{"id": id,"variant":"",
          "user_id":userId,"quantity":quantity}));


    log("Response ${res.body}");
    log("Response code jhjk ${res.statusCode}");

    if(res.statusCode==200 || res.statusCode==201){
      showToast("Cart Added Successfully",context:context);
    }else{
      showToast("Something went wrong",context:context);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCategoryData(name: widget.nameNo);
  }
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var width = SizeConfig.screenWidth;
    var height = SizeConfig.screenHeight;
    var block = SizeConfig.block;
    return Container(
      width: MediaQuery.of(context).size.width / 1,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        color: Colors.white,
      ),
      child: Column(
        children: [
          SizedBox(
            height: 25,
          ),

          SizedBox(
            width: MediaQuery.of(context).size.width / 1.1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children:  [
                Text(
                  widget.categoryName,
                  style: TextStyle(color: Color(0xFF515151), fontSize: 22, fontWeight: FontWeight.w700, fontFamily: "CeraProBold"),
                ),
                Text(
                  "VIEW ALL",
                  style: TextStyle(color: Color(0xFF515151), fontSize: 12, fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ),

          sized20,

          Stack(children: [
            Image.asset("assets/posterone.png"),
            Positioned(
              bottom: 10,
              left: 10,
              child: Row(
                children: [
                  Text(
                    "Shop for daily needs",
                    style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700, fontFamily: "CeraProBold"),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Container(
                      height: 15,
                      width: 15,
                      child: Image.asset("assets/v.png"),
                    ),
                  )
                ],
              ),
            )
          ]),
          sized20,
          Container(
            height: height * 0.22,
            width: width,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: categoryData.length,
              itemBuilder: (_, index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      valueOne = index.toString();
                      categoryItemData = categoryData[index].name;
                      relatedProductsLink= categoryData[index].links.products;
                      getSubCategoryProductsAfterTap(categoryData[index].links.products);
                    });
                  },
                  child: valueOne.toString() != index.toString()
                      ? Container(
                    child: Container(
                      height: height * 0.2,
                      width: width * 0.35,
                      margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 5),
                      decoration: BoxDecoration(
                        //color: Colors.grey.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Column(
                        children: [
                          //SizedBox(height: 15,),
                          Container(
                            height: height * 0.15,
                            //width: width*0.30,
                            width: width * 0.30,
                            decoration: BoxDecoration(color: Color(0xFFF0E6F2), borderRadius: BorderRadius.circular(15.0)),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(0),
                                child: categoryData[index].mobileBanner.isEmpty
                                    ?

                                //Text("OK"):
                                Image.asset("assets/app_logo.png")
                                    : Image.network(
                                  imagePath + categoryData[index].mobileBanner,
                                ),
                              ),
                            ),
                          ),
                          sized5,
                          Text(
                            categoryData[index].name,
                            style: TextStyle(color: Color(0xFF515151), fontSize: block * 4, fontWeight: FontWeight.w700),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  )
                      : Padding(
                    padding: const EdgeInsets.only(left: 5.0),
                    child: Container(
                      //height: height * 0.2,
                        height: height * 0.2,
                        width: width * 0.35,
                        margin: EdgeInsets.symmetric(vertical: 5.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Column(
                          children: [
                            Container(
                              height: height * 0.15,
                              width: width * 0.30,
                              decoration: BoxDecoration(
                                //color: Colors.grey.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(15.0)),
                              child: Padding(
                                padding: const EdgeInsets.all(0),
                                child: Center(
                                  child: categoryData[index].mobileBanner.isEmpty
                                      ?

                                  //Text("OK"):
                                  Image.asset("assets/app_logo.png")
                                      : Image.network(
                                    imagePath + categoryData[index].mobileBanner,
                                  ),
                                ),
                              ),
                            ),
                            sized5,
                            Text(
                              categoryData[index].name,
                              style: TextStyle(color: Color(0xFF515151), fontSize: block * 4, fontWeight: FontWeight.w700),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        )),
                  ),
                );
              },
            ),
          ),

          SizedBox(
            height: 5,
          ),
          //sized20,
          Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                categoryItemData,
                style: TextStyle(color: Color(0xFF515151), fontSize: 22, fontWeight: FontWeight.w700, fontFamily: "CeraProBold"),
              ),
            ),
          ),
          sized20,
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 0, 8, 0),
            child: Container(
              height: height * 0.32,
              width: width,
              child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: subCategoryProducts.length,
                  itemBuilder: (_, index) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Container(
                        decoration: BoxDecoration(color: Color(0xFFF1EDF2), borderRadius: BorderRadius.circular(15.0)),
                        //height: MediaQuery.of(context).size.height/3.2,width: MediaQuery.of(context).size.width / 2.34,
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                width: MediaQuery.of(context).size.width / 5,
                                height: MediaQuery.of(context).size.height / 45,
                                margin: EdgeInsets.only(top: 10),
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius:
                                  BorderRadius.only(topRight: Radius.circular(4.0), bottomRight: Radius.circular(4.0)),
                                ),
                                //

                                child: Center(
                                  child: Text(
                                    "15% OFF",
                                    style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ),
                            ),

                            ///
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => GroceryDetails(
                                          detailsLink: subCategoryProducts[index].links.details,
                                          relatedProductLink: relatedProductsLink,
                                        )
                                    )
                                );
                              },
                              child: Container(
                                child: Image.network(imagePath + subCategoryProducts[index].thumbnailImage),
                                height: MediaQuery.of(context).size.height / 8,
                                width: MediaQuery.of(context).size.width / 2.34,
                              ),
                            ),

                            ///

                            FittedBox(
                              child: Container(
                                ///height: height! * 0.08,
                                width: MediaQuery.of(context).size.width / 2.36,
                                height: MediaQuery.of(context).size.height / 17,
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(5, 5, 5, 0),
                                  child: Text(
                                    subCategoryProducts[index].name,
                                    style: TextStyle(
                                      color: Color(0xFF515151),
                                      fontSize: 12.5,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: "CeraProBold",
                                    ),
                                    maxLines: 2,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                            Center(
                              child: Container(
                                height: MediaQuery.of(context).size.height / 38,
                                child: Text(
                                  subCategoryProducts[index].unit,
                                  style: TextStyle(color: Colors.grey.withOpacity(0.9)),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                              child: Center(
                                child: Container(
                                  height: MediaQuery.of(context).size.height / 32,
                                  width: MediaQuery.of(context).size.width / 2.34,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Container(
                                        child: Image.asset("assets/p.png"),
                                        height: 20,
                                        width: 22,
                                      ),
                                      Text(subCategoryProducts[index].baseDiscountedPrice.toString(),
                                          style: TextStyle(color: Color(0xFF515151), fontSize: 16, fontWeight: FontWeight.w700)),
                                      Text(subCategoryProducts[index].basePrice.toString(),
                                          style: TextStyle(
                                              color: Color(0xFFA299A8),
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400,
                                              decoration: TextDecoration.lineThrough)),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 10),
                                      ),
                                      InkWell(
                                        onTap: () {
                                         addToCart(subCategoryProducts[index].id, 61, 1);
                                          //Navigator.push(context, MaterialPageRoute(builder: (context) => CartDetails()));
                                        },
                                        child: Container(
                                          height: 25,
                                          width: 25,
                                          decoration: BoxDecoration(color: kPrimaryColor, shape: BoxShape.circle),
                                          child: Center(
                                            child: Image.asset("assets/pi.png"),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              //height: height! * 0.03,
                              height: MediaQuery.of(context).size.height / 26,
                              width: MediaQuery.of(context).size.width / 2.34,
                              decoration: BoxDecoration(
                                  color: Colors.lightGreen[100],
                                  borderRadius:
                                  BorderRadius.only(bottomLeft: Radius.circular(10.0), bottomRight: Radius.circular(10.0))),
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(1, 3, 1, 3),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      child: Image.asset("assets/img_42.png"),
                                      height: 17,
                                      width: 15,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 2),
                                      child: Text(
                                        "  Earning +৳18",
                                        style: TextStyle(fontSize: 12, color: Colors.green, fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  }),
            ),
          ),
          SizedBox(
            height: 35,
          ),
        ],
      ),
    );
  }
}

*/

/*
import 'dart:convert';
import 'dart:developer';
import 'package:customer_ui/HomePage/grocer_offer/product_details.dart';
import 'package:customer_ui/components/size_config.dart';
import 'package:customer_ui/components/styles.dart';
import 'package:customer_ui/components/utils.dart';
import 'package:customer_ui/dataModel/category_data_model.dart';
import 'package:customer_ui/dataModel/chocolate_sweet_data_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

class CategoryContainer extends StatefulWidget {
  const CategoryContainer({Key? key, required this.categoryName, required this.nameNo, required this.large_Banner})
      : super(key: key);
  final String categoryName;
  final String nameNo;
  final String large_Banner;

  @override
  _CategoryContainerState createState() => _CategoryContainerState();
}

class _CategoryContainerState extends State<CategoryContainer> {
  var categoryData = [];
  var valueOne;
  var categoryItemData = " ";
  var relatedProductsLink = " ";
  var subCategoryProducts = [];

  Future<void> getSubCategoryProductsAfterTap(link2) async {
    //log("calling after tap");
    //String biscuitSweetsURl = "https://test.protidin.com.bd/api/v2/products/category/46";

    final response7 = await get(Uri.parse(link2), headers: {"Accept": "application/json"});

    var groceryItemDataMap = jsonDecode(response7.body);

    if (groceryItemDataMap["success"] == true) {
      //log("category data after tap $biscuitSweetsDataMap");

      var groceryData = BiacuitSweets.fromJson(groceryItemDataMap);
      subCategoryProducts = groceryData.data;
      //relatedProductsLink=groceryProducts[0].links.products;

      setState(() {
        subCategoryProducts.length;
      });

      //log("after tap grocery data length ${subCategoryProducts.length}");
    } else {
      //log("data invalid");
    }

    // log("after decode $dataMap");
  }

  Future<void> getCategoryData({required String name}) async {
    //log("grocery data calling");
    String groceryURl = "https://test.protidin.com.bd/api/v2/sub-categories/$name";

    final response3 = await get(Uri.parse(groceryURl), headers: {"Accept": "application/json"});

    var groceryDataMap = jsonDecode(response3.body);

    if (groceryDataMap["success"] == true) {
      //log("data valid");
      var categoryDataModel = CategoryDataModel.fromJson(groceryDataMap);
      categoryData = categoryDataModel.data;
      categoryItemData = categoryDataModel.data[0].name;
      //categoryItemData = categoryDataModel.data[0].large_Banner;
      relatedProductsLink = categoryData[0].links.products;

      await getSubCategoryProductsAfterTap(categoryDataModel.data[0].links.products);
      setState(() {});
      //log("grocery data length ${categoryData.length}");
    } else {
      //log("data invalid");
    }
    // log("after decode $dataMap");
  }

  Future<void> addToCart(id, userId, quantity) async {
    var res = await http.post(Uri.parse("https://test.protidin.com.bd/api/v2/carts/add"),
        headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8', 'Authorization': 'Bearer $authToken'},
        body: jsonEncode(<String, dynamic>{"id": id, "variant": "", "user_id": userId, "quantity": quantity}));

    //log("Response ${res.body}");
    //log("Response code jhjk ${res.statusCode}");

    if (res.statusCode == 200 || res.statusCode == 201) {
      showToast("Cart Added Successfully", context: context);
    } else {
      showToast("Something went wrong", context: context);
    }
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCategoryData(name: widget.nameNo);
  }




  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var width = SizeConfig.screenWidth;
    var height = SizeConfig.screenHeight;
    var block = SizeConfig.block;
    return Container(
      width: MediaQuery.of(context).size.width / 1,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        color: Colors.white,
      ),
      child: Column(
        children: [
          SizedBox(
            height: 25,
          ),

          SizedBox(
            width: MediaQuery.of(context).size.width / 1.1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.categoryName,
                  style:
                      TextStyle(color: Color(0xFF515151), fontSize: 22, fontWeight: FontWeight.w700, fontFamily: "CeraProBold"),
                ),
                Text(
                  "VIEW ALL",
                  style: TextStyle(color: Color(0xFF515151), fontSize: 12, fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ),

          sized20,

          //Image.network(widget.banner),

          /*
          categoryData[0].mobileBanner.isEmpty
              ?

          //Text("OK"):
          Image.asset("assets/app_logo.png")
              : Image.network(
            imagePath + categoryData[0].largeBanner,
          ),
          */

          ///large_banner
          Container(
            height: 100,
            decoration: BoxDecoration(
              //color: Colors.grey.withOpacity(0.2),
              borderRadius: BorderRadius.circular(10.0),
            ),
            //width: double.infinity,
            width: MediaQuery.of(context).size.width/1.1,
            child: Image.network(
              imagePath + widget.large_Banner,
              fit: BoxFit.cover,
            ),
          ),

          /*Container(
            height: 50,
            width: double.infinity,
            child: Image.network(
              imagePath + widget.large_Banner,
              fit: BoxFit.cover,
            ),
          ),*/

          sized20,
          Container(
            height: height * 0.22,
            width: width,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: categoryData.length,
              itemBuilder: (_, index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      valueOne = index.toString();
                      categoryItemData = categoryData[index].name;
                      relatedProductsLink = categoryData[index].links.products;
                      getSubCategoryProductsAfterTap(categoryData[index].links.products);
                    });
                  },
                  child: valueOne.toString() != index.toString()
                      ? Container(
                          child: Container(
                            height: height * 0.2,
                            width: width * 0.35,
                            margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 5),
                            decoration: BoxDecoration(
                              //color: Colors.grey.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Column(
                              children: [
                                //SizedBox(height: 15,),
                                Container(
                                  height: height * 0.15,
                                  //width: width*0.30,
                                  width: width * 0.30,
                                  decoration: BoxDecoration(color: Color(0xFFF0E6F2), borderRadius: BorderRadius.circular(15.0)),
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(0),
                                      child: categoryData[index].mobileBanner.isEmpty
                                          ?

                                          //Text("OK"):
                                          Image.asset("assets/app_logo.png")
                                          : Image.network(
                                              imagePath + categoryData[index].mobileBanner,
                                            ),
                                    ),
                                  ),
                                ),
                                sized5,
                                Text(
                                  categoryData[index].name,
                                  style: TextStyle(color: Color(0xFF515151), fontSize: block * 4, fontWeight: FontWeight.w700),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.only(left: 5.0),
                          child: Container(
                              //height: height * 0.2,
                              height: height * 0.2,
                              width: width * 0.35,
                              margin: EdgeInsets.symmetric(vertical: 5.0),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    height: height * 0.15,
                                    width: width * 0.30,
                                    decoration: BoxDecoration(
                                        //color: Colors.grey.withOpacity(0.2),
                                        borderRadius: BorderRadius.circular(15.0)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(0),
                                      child: Center(
                                        child: categoryData[index].mobileBanner.isEmpty
                                            ?
                                            //Text("OK"):
                                            Image.asset("assets/app_logo.png")
                                            : Image.network(
                                                imagePath + categoryData[index].mobileBanner,
                                              ),
                                      ),
                                    ),
                                  ),
                                  sized5,
                                  Text(
                                    categoryData[index].name,
                                    style: TextStyle(color: Color(0xFF515151), fontSize: block * 4, fontWeight: FontWeight.w700),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              )),
                        ),
                );
              },
            ),
          ),

          SizedBox(
            height: 5,
          ),
          //sized20,
          Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                categoryItemData,
                style: TextStyle(color: Color(0xFF515151), fontSize: 22, fontWeight: FontWeight.w700, fontFamily: "CeraProBold"),
              ),
            ),
          ),
          sized20,
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 0, 8, 0),
            child: Container(
              height: height * 0.32,
              width: width,
              child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: subCategoryProducts.length,
                  itemBuilder: (_, index) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Container(
                        decoration: BoxDecoration(color: Color(0xFFF1EDF2), borderRadius: BorderRadius.circular(15.0)),
                        //height: MediaQuery.of(context).size.height/3.2,width: MediaQuery.of(context).size.width / 2.34,
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                width: MediaQuery.of(context).size.width / 5,
                                height: MediaQuery.of(context).size.height / 45,
                                margin: EdgeInsets.only(top: 10),
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius:
                                      BorderRadius.only(topRight: Radius.circular(4.0), bottomRight: Radius.circular(4.0)),
                                ),
                                //

                                child: Center(
                                  child: Text(
                                    "15% OFF",
                                    style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ),
                            ),

                            ///
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => GroceryDetails(
                                              detailsLink: subCategoryProducts[index].links.details,
                                              relatedProductLink: relatedProductsLink,
                                            )));
                              },
                              child: Container(
                                child: Image.network(imagePath + subCategoryProducts[index].thumbnailImage),
                                height: MediaQuery.of(context).size.height / 8,
                                width: MediaQuery.of(context).size.width / 2.34,
                              ),
                            ),

                            ///

                            FittedBox(
                              child: Container(
                                ///height: height! * 0.08,
                                width: MediaQuery.of(context).size.width / 2.36,
                                height: MediaQuery.of(context).size.height / 17,
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(5, 5, 5, 0),
                                  child: Text(
                                    subCategoryProducts[index].name,
                                    style: TextStyle(
                                      color: Color(0xFF515151),
                                      fontSize: 12.5,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: "CeraProBold",
                                    ),
                                    maxLines: 2,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),

                            Center(
                              child: Container(
                                height: MediaQuery.of(context).size.height / 38,
                                child: Text(
                                  subCategoryProducts[index].unit,
                                  style: TextStyle(color: Colors.grey.withOpacity(0.9)),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                              child: Center(
                                child: Container(
                                  height: MediaQuery.of(context).size.height / 32,
                                  width: MediaQuery.of(context).size.width / 2.34,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Container(
                                        child: Image.asset("assets/p.png"),
                                        height: 20,
                                        width: 22,
                                      ),
                                      Text(subCategoryProducts[index].baseDiscountedPrice.toString(),
                                          style: TextStyle(color: Color(0xFF515151), fontSize: 16, fontWeight: FontWeight.w700)),
                                      Text(subCategoryProducts[index].basePrice.toString(),
                                          style: TextStyle(
                                              color: Color(0xFFA299A8),
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400,
                                              decoration: TextDecoration.lineThrough)),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 10),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          addToCart(subCategoryProducts[index].id, 61, 1);
                                          //Navigator.push(context, MaterialPageRoute(builder: (context) => CartDetails()));
                                        },
                                        child: Container(
                                          height: 25,
                                          width: 25,
                                          decoration: BoxDecoration(color: kPrimaryColor, shape: BoxShape.circle),
                                          child: Center(
                                            child: Image.asset("assets/pi.png"),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              //height: height! * 0.03,
                              height: MediaQuery.of(context).size.height / 26,
                              width: MediaQuery.of(context).size.width / 2.34,
                              decoration: BoxDecoration(
                                  color: Colors.lightGreen[100],
                                  borderRadius:
                                      BorderRadius.only(bottomLeft: Radius.circular(10.0), bottomRight: Radius.circular(10.0))),
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(1, 3, 1, 3),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      child: Image.asset("assets/img_42.png"),
                                      height: 17,
                                      width: 15,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 2),
                                      child: Text(
                                        "  Earning +৳18",
                                        style: TextStyle(fontSize: 12, color: Colors.green, fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  }),
            ),
          ),
          SizedBox(
            height: 35,
          ),

          /*Container(
            height: 100,
            decoration: BoxDecoration(
              //color: Colors.grey.withOpacity(0.2),
              borderRadius: BorderRadius.circular(10.0),
            ),
            //width: double.infinity,
            width: MediaQuery.of(context).size.width/1.1,
            child: Image.network(
              imagePath + widget.large_Banner,
              fit: BoxFit.cover,
            ),
          ),*/

        ],
      ),
    );

  }
}


*/