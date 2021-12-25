import 'dart:convert';
import 'dart:developer';
import 'package:customer_ui/HomePage/grocer_offer/grocery_offer_page.dart';
import 'package:customer_ui/HomePage/offer/offer_page.dart';
import 'package:customer_ui/OthersPage/All_offerPage.dart';
import 'package:customer_ui/OthersPage/myOrders.dart';
import 'package:customer_ui/OthersPage/myaccopunt.dart';
import 'package:customer_ui/OthersPage/requestProduct.dart';
import 'package:customer_ui/OthersPage/tarck_order.dart';
import 'package:customer_ui/OthersPage/wallet.dart';
import 'package:customer_ui/components/size_config.dart';
import 'package:customer_ui/components/styles.dart';
import 'package:customer_ui/components/utils.dart';
import 'package:customer_ui/dataModel/breat_biscuit.dart';
import 'package:customer_ui/dataModel/category_data_model.dart';
import 'package:customer_ui/dataModel/chocolate_sweet_data_model.dart';
import 'package:customer_ui/dataModel/details_model.dart';
import 'package:customer_ui/dataModel/groceryTopDeals.dart';
import 'package:customer_ui/dataModel/grocery_data_model.dart';
import 'package:customer_ui/dataModel/topdeals.dart';
//import 'package:customer_ui/dataModel/category_data_model.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart';
import '../HomePage/gorcery_item_widget.dart';
import '../HomePage/item_widget.dart';
import '../HomePage/offer_widget.dart';
import '../test_demo.dart';

class CategoryHomeScreen extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<CategoryHomeScreen> {

  var value;
  var valueOne;
  var valueTwo;
  var valueThree;
  var valueFour;

  @override
  void initState(){
    // TODO: implement initState
    getfruitsVegitable();
    getbabyMother();
    getFrouitsBeverage();
    getGrocery();
    getCategory();

  }
  ///
  var categoryData=[];
  Future<void> getCategory() async {
    log("comes");
    String productURl = "https://test.protidin.com.bd/api/v2/categories/home";

    final response = await get(Uri.parse(productURl), headers: {"Accept": "application/json"});

    var dataMap=jsonDecode(response.body);

    if(dataMap["success"]==true){
      log("data valid");

      //
      var categoryDataModel=CategoryDataModel.fromJson(dataMap);
      categoryData=categoryDataModel.data;
      await getProductsAfterTap(categoryDataModel.data[0].links.products);
      setState(() {

      });
      log("data length ${categoryData.length}");

    }else{
      log("data invalid");
    }

    // log("after decode $dataMap");

  }

  List<BuiscitData> categoryProducts=[];
  Future<void> getProductsAfterTap(link) async {
    log("calling 2");
    //String biscuitSweetsURl = "https://test.protidin.com.bd/api/v2/products/category/46";

    final response6 = await get(Uri.parse(link), headers: {"Accept": "application/json"});

    var biscuitSweetsDataMap=jsonDecode(response6.body);

    if(biscuitSweetsDataMap["success"]==true){
      //log("category data after tap $biscuitSweetsDataMap");

      setState(() {
        var biscuitSweetsDataModel= BiacuitSweets.fromJson(biscuitSweetsDataMap);
        categoryProducts=biscuitSweetsDataModel.data;

      });
      log("categoryProducts data length ${categoryProducts.length}");

    }else{
      log("data invalid");
    }

    // log("after decode $dataMap");

  }


  var groceryData=[];
  Future<void> getGrocery() async {
    log("grocery data calling");
    String groceryURl = "https://test.protidin.com.bd/api/v2/sub-categories/4";

    final response3 = await get(Uri.parse(groceryURl), headers: {"Accept": "application/json"});

    var groceryDataMap=jsonDecode(response3.body);


    if(groceryDataMap["success"]==true){
      log("data valid");

      var categoryDataModel=CategoryDataModel.fromJson(groceryDataMap);
      groceryData=categoryDataModel.data;
      await getGroceryProductsAfterTap(categoryDataModel.data[0].links.products);
      setState(() {

      });
      log("grocery data length ${groceryData.length}");

    }else{
      log("data invalid");
    }

    // log("after decode $dataMap");

  }


  var groceryProducts=[];
  Future<void> getGroceryProductsAfterTap(link2) async {
    log("calling after tap");
    //String biscuitSweetsURl = "https://test.protidin.com.bd/api/v2/products/category/46";

    final response7 = await get(Uri.parse(link2), headers: {"Accept": "application/json"});

    var groceryItemDataMap=jsonDecode(response7.body);

    if(groceryItemDataMap["success"]==true){
      //log("category data after tap $biscuitSweetsDataMap");

      setState(() {
        var groceryData= BiacuitSweets.fromJson(groceryItemDataMap);
        groceryProducts=groceryData.data;
      });
      log("after tap grocery data length ${groceryProducts.length}");

    }else{
      log("data invalid");
    }

    // log("after decode $dataMap");

  }



  var fruitBeverageData=[];
  Future<void> getFrouitsBeverage() async {
    log(" froitsBeverage calling ");
    String froitsBeverageURl = "https://test.protidin.com.bd/api/v2/sub-categories/7";

    final response8 = await get(Uri.parse(froitsBeverageURl), headers: {"Accept": "application/json"});

    var froitsBeverageItemDataMap=jsonDecode(response8.body);

    if(froitsBeverageItemDataMap["success"]==true){
      //log("category data after tap $biscuitSweetsDataMap");
      var froitsBeverageData= CategoryDataModel.fromJson(froitsBeverageItemDataMap);


      await getfruitsBeverageDataAfterTap(froitsBeverageData.data[0].links.products);

      fruitBeverageData=froitsBeverageData.data;
      setState(() {

      });
      log("after tap fruit data length ${fruitBeverageData.length}");

    }else{
      log("data invalid");
    }

    // log("after decode $dataMap");

  }


  var fruitBeverageDataAfterTap=[];
  Future<void> getfruitsBeverageDataAfterTap(link2) async {
    log("frouits and beverage after calling");
    //String biscuitSweetsURl = "https://test.protidin.com.bd/api/v2/products/category/46";

    final response8 = await get(Uri.parse(link2), headers: {"Accept": "application/json"});

    var frouitsBeverageItemDataMap=jsonDecode(response8.body);

    if(frouitsBeverageItemDataMap["success"]==true){
      //log("category data after tap $biscuitSweetsDataMap");

      setState(() {
        var froitBeverageData= BiacuitSweets.fromJson(frouitsBeverageItemDataMap);
        fruitBeverageDataAfterTap=froitBeverageData.data;
      });
      log("after tap grocery data length ${fruitBeverageDataAfterTap.length}");

    }else{
      log("data invalid");
    }

    // log("after decode $dataMap");

  }


  var babyMotherData=[];
  Future<void> getbabyMother() async {
    log(" babyMother calling ");
    String babyMotherURl = "https://test.protidin.com.bd/api/v2/sub-categories/8";

    final response8 = await get(Uri.parse(babyMotherURl), headers: {"Accept": "application/json"});

    var babyMotherItemDataMap=jsonDecode(response8.body);

    if(babyMotherItemDataMap["success"]==true){
      //log("category data after tap $biscuitSweetsDataMap");
      var froitsBeverageData= CategoryDataModel.fromJson(babyMotherItemDataMap);
      babyMotherData=froitsBeverageData.data;
      setState(() {

      });
      log("after tap babyMother length ${babyMotherData.length}");

    }else{
      log("data invalid");
    }

    // log("after decode $dataMap");

  }


  var babyMotherDataAfterTap=[];
  Future<void> getbabyMotherDataAfterTap(link2) async {
    log("baby and mother after calling");
    //String biscuitSweetsURl = "https://test.protidin.com.bd/api/v2/products/category/46";

    final response9 = await get(Uri.parse(link2), headers: {"Accept": "application/json"});

    var babyMotherDataMap=jsonDecode(response9.body);

    if(babyMotherDataMap["success"]==true){
      //log("category data after tap $biscuitSweetsDataMap");

      setState(() {
        var motherBabyData= BiacuitSweets.fromJson(babyMotherDataMap);
        babyMotherDataAfterTap=motherBabyData.data;
      });
      log("after tap grocery data length ${babyMotherDataAfterTap.length}");

    }else{
      log("data invalid");
    }

    // log("after decode $dataMap");

  }


  var fruitsVegitableData=[];
  Future<void> getfruitsVegitable() async {
    log(" fruit and vegetable calling ");
    String fruitsVegitableURl = "https://test.protidin.com.bd/api/v2/sub-categories/9";

    final response9 = await get(Uri.parse(fruitsVegitableURl), headers: {"Accept": "application/json"});

    var fruitsVegitableDataMap=jsonDecode(response9.body);

    if(fruitsVegitableDataMap["success"]==true){
      //log("category data after tap $biscuitSweetsDataMap");
      var froitsBeverageData= CategoryDataModel.fromJson(fruitsVegitableDataMap);
      fruitsVegitableData=froitsBeverageData.data;
      setState(() {

      });
      log("after tap fruit and vegetable length ${fruitsVegitableData.length}");

    }else{
      log("data invalid");
    }

    // log("after decode $dataMap");

  }


  var fruitsVegAfterTap=[];
  Future<void> getfrouitsVegitableDataAfterTap(link2) async {
    log("baby and mother after calling");
    //String biscuitSweetsURl = "https://test.protidin.com.bd/api/v2/products/category/46";

    final response10 = await get(Uri.parse(link2), headers: {"Accept": "application/json"});

    var fruitVegitableItemDataMap=jsonDecode(response10.body);

    if(fruitVegitableItemDataMap["success"]==true){
      //log("category data after tap $biscuitSweetsDataMap");

      setState(() {
        var fruitVegitable= BiacuitSweets.fromJson(fruitVegitableItemDataMap);
        fruitsVegAfterTap=fruitVegitable.data;
      });
      log("after tap grocery data length ${fruitsVegAfterTap.length}");

    }else{
      log("data invalid");
    }

    // log("after decode $dataMap");

  }



  var scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    SizeConfig().init(context);
    var width = SizeConfig.screenWidth;
    var height = SizeConfig.screenHeight;
    var block = SizeConfig.block;

    return SafeArea(
      child: Scaffold(
          key: scaffoldKey,
          ///
          drawer: Drawer(

            child: ListView(
              // Important: Remove any padding from the ListView.
              padding: EdgeInsets.zero,
              children: <Widget>[
                DrawerHeader(
                  child: Container(

                    height: 200,
                    width: MediaQuery.of(context).size.width/1.2,
                    child: Column(
                        children: [

                          SizedBox(height: 20,),

                          Row(
                            //mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                //color: Colors.white,
                                height: 60,
                                width: 60,
                                child: Image.asset("assets/img_135.png",),
                              ),
                              Padding(padding: const EdgeInsets.fromLTRB(20,0,0,0),),
                              Container(
                                width: 120,
                                child: Column(
                                  children: [
                                    Align(
                                      alignment:Alignment.centerLeft,
                                      child: Text(
                                        "Welcome ",style: TextStyle(color: Colors.white,fontSize: 14,fontWeight: FontWeight.w400,),
                                      ),
                                    ),
                                    SizedBox(height: 5,),
                                    Align(
                                      alignment:Alignment.centerLeft,
                                      child:Text(
                                        "Md. Abcdef ghijkl",style: TextStyle(color: Colors.white,fontSize: 14,fontWeight: FontWeight.w900,),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],

                          ),
                        ]
                    ),

                  ),        decoration: BoxDecoration(
                  color: Color(0xFF9900FF),
                ),
                ),
                ListTile(
                  title: Row(
                    children: [
                      Container(
                        //color: Colors.white,
                        height: 20,
                        width: 20,
                        child: Image.asset("assets/img_149.png",color: Colors.black,),
                      ),
                      Padding(padding: const EdgeInsets.fromLTRB(20,0,0,0),),
                      Text('Track Order',style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.w700,),),

                    ],
                  ),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => TrackOrder()));
                  },
                ),
                ListTile(
                  title: Row(
                    children: [
                      Container(
                        //color: Colors.white,
                        height: 20,
                        width: 20,
                        child: Image.asset("assets/img_150.png",color: Colors.black,),
                      ),
                      Padding(padding: const EdgeInsets.fromLTRB(20,0,0,0),),
                      Text('My Orders',style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.w700,),),

                    ],
                  ),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => MyOrder()));
                  },
                ),
                ListTile(
                  title: Row(
                    children: [
                      Container(
                        //color: Colors.white,
                        height: 20,
                        width: 20,
                        child: Image.asset("assets/img_151.png",color: Colors.black,),
                      ),
                      Padding(padding: const EdgeInsets.fromLTRB(20,0,0,0),),
                      Text('Categories',style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.w700,),),

                    ],
                  ),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) =>GroceryOfferPage()));
                  },
                ),

                ListTile(
                  title: Row(
                    children: [
                      Container(
                        //color: Colors.white,
                        height: 20,
                        width: 20,
                        child: Image.asset("assets/img_152.png",color: Colors.black,),
                      ),
                      Padding(padding: const EdgeInsets.fromLTRB(20,0,0,0),),
                      Text('Wallet',style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.w700,),),

                    ],
                  ),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => MyWallet()));
                  },
                ),

                ListTile(
                  title: Row(
                    children: [
                      Container(
                        //color: Colors.white,
                        height: 20,
                        width: 20,
                        child: Image.asset("assets/img_153.png",color: Colors.black,),
                      ),
                      Padding(padding: const EdgeInsets.fromLTRB(20,0,0,0),),
                      Text('Request a product',style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.w700,),),

                    ],
                  ),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ReqquestPage()));
                  },
                ),

                ListTile(
                  title: Row(
                    children: [
                      Container(
                        //color: Colors.white,
                        height: 20,
                        width: 20,
                        child: Image.asset("assets/img_149.png",color: Colors.black,),
                      ),
                      Padding(padding: const EdgeInsets.fromLTRB(20,0,0,0),),
                      Text('Call to order',style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.w700,),),

                    ],
                  ),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => TrackOrder()));
                  },
                ),

                ListTile(
                  title: Row(
                    children: [
                      Container(
                        //color: Colors.white,
                        height: 20,
                        width: 20,
                        child: Image.asset("assets/img_154.png",color: Colors.black,),
                      ),
                      Padding(padding: const EdgeInsets.fromLTRB(20,0,0,0),),
                      Text('My Account',style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.w700,),),

                    ],
                  ),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => MyAccountPage()));
                  },
                ),
              ],
            ),
          ),
          ///



          backgroundColor: Color(0xFFE5E5E5),
          //backgroundColor: Colors.indigo[50],
          body: SingleChildScrollView(
              child: Padding(
                //padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
                padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 15.0),
                child: Column(children: [

                  Center(
                    child: Container(
                      width: MediaQuery.of(context).size.width/1.1,
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 0.150,
                          color: Colors.cyan,
                        ),
                        color: Color(0xFF9900FF),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            spreadRadius: 5, //spread radius
                            blurRadius: 5, // blur radius
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),

                      //width: 330,
                      //width: MediaQuery.of(context).size.width/1.1,
                      height: 45,

                      child: Row(
                        children: [
                          SizedBox(
                            height: 20,
                            //width: 80,
                            width: MediaQuery.of(context).size.width/7,
                            child: Image.asset("assets/img_27.png"),
                          ),

                          SizedBox(
                            height: 20,
                            //width: 230,
                            width: MediaQuery.of(context).size.width*4/6.5,
                            child: Image.asset("assets/img_29.png"),
                          ),


                          SizedBox(
                            width: MediaQuery.of(context).size.width/7,
                            height: 20,
                            //width: 100,
                            child: InkWell(
                              onTap: () {
                                //Navigator.push(context, MaterialPageRoute(builder: (context) => GroceryOfferPage()));
                                if(!scaffoldKey.currentState!.isDrawerOpen){ //check if drawer is closed
                                  scaffoldKey.currentState!.openDrawer(); //open drawer
                                }
                              },
                              child: Container(
                                  child: Image.asset("assets/img_184.png")),
                            ),
                          ),


                        ],
                      ),
                    ),
                  ),


                  sized10,
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: SizedBox(
                        height: 40,
                        //width: 200,
                        width: MediaQuery.of(context).size.width / 1.2,
                        child: Row(
                          children: [
                            SizedBox(height: 17, child: Image.asset("assets/img_49.png")),
                            Text(
                              "  Protidin PG Store, Shahbag  ",
                              style: TextStyle(color: Color(0xFF515151), fontSize: 13, fontWeight: FontWeight.w700,fontFamily: "CeraProBold",),
                            ),
                            Container(
                                height: 10,
                                child: Image.asset(
                                  "assets/img_50.png",
                                  height: 5,)
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 5,
                  ),

                  ///
                  Container(
                    //width: 320.0,
                    width: MediaQuery.of(context).size.width / 1,
                    height: 185.0,
                    decoration:
                    const BoxDecoration(image: DecorationImage(image: AssetImage("assets/img_32.png"), fit: BoxFit.cover)),

                    child: Row(
                      children: [

                        Padding(
                          padding: const EdgeInsets.only(left: 15),
                        ),
                        Container(
                            width: MediaQuery.of(context).size.width /2.5,
                            child: Image.asset("assets/img_33.png")
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15),
                        ),
                        Center(
                          child: Container(
                            width: MediaQuery.of(context).size.width /2,
                            child: SizedBox(
                              height: 105,
                              child: Row(
                                children: [
                                  Column(
                                    children: [
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      const Text(
                                        "Enjoy buy 1 get one offer\n throughout september",
                                        style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w500),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          Navigator.push(context, MaterialPageRoute(builder: (context) => AllOfferPage()));
                                        },
                                        child: SizedBox(
                                          height: 55,
                                          width: 95,
                                          child: Image.asset("assets/img_35.png"),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),


                      ],
                    ),
                  ),

                  ///

                  SizedBox(
                    height: 20,
                  ),

                  SizedBox(
                    width: MediaQuery.of(context).size.width / 1.1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [

                        Expanded(
                          child: Text(
                            "Offer for you",
                            style: TextStyle(color: Color(0xFF515151), fontSize: 22, fontWeight: FontWeight.w700,fontFamily: "CeraProBold"),
                          ),
                        ),

                        InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => AllOfferPage()));
                          },
                          child: Text(
                            "VIEW ALL",
                            style: TextStyle(color: Color(0xFF515151), fontSize: 12, fontWeight: FontWeight.w400),
                          ),
                        ),

                      ],
                    ),
                  ),
                  //sized10,

                  SizedBox(height: 15,),

                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: FittedBox(
                        child: SizedBox(
                          //width: MediaQuery.of(context).size.width/1.1,
                          child: Row(
                            children: <Widget>[
                              InkWell(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => OfferPage()));
                                },
                                child: OfferWidget(
                                  color: Colors.blue[400],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 15),
                              ),
                              OfferWidget(
                                color: Colors.blue[400],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 15),
                              ),
                              OfferWidget(
                                color: Colors.blue[400],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 15),
                              ),
                              OfferWidget(
                                color: Colors.blue[400],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 15),
                              ),
                              OfferWidget(
                                color: Colors.blue[400],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 15),
                              ),
                              OfferWidget(
                                color: Colors.blue[400],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 15),
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



                  Container(
                    ///height: height,
                    width: MediaQuery.of(context).size.width/1,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      color: Colors.white,
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: 25,),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          //height: 685,
                          width: MediaQuery.of(context).size.width / 1.1,
                          child: Column(children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Shop By Category",
                                style: TextStyle(color: Color(0xFF515151), fontSize: 22, fontWeight: FontWeight.w700,fontFamily: "CeraProBold"),
                              ),
                            ),

                            SizedBox(height: 12,),



                            Container(
                              height: height*0.24,
                              width: width,
                              child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: categoryData.length,
                                itemBuilder: (_,index){
                                  if (value.toString()!=index.toString()) {
                                    return GestureDetector(
                                      onTap: (){
                                        setState(() {
                                          value=index.toString();
                                          log(categoryData[index].links.products);
                                          getProductsAfterTap(categoryData[index].links.products);
                                        });
                                      },
                                      child: Container(

                                        width: width*0.35,
                                        margin: EdgeInsets.symmetric(horizontal: 5,vertical: 10),
                                        decoration: BoxDecoration(
                                          color: Colors.grey.withOpacity(0.2),
                                          borderRadius: BorderRadius.circular(5.0),

                                        ),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            //sized10,
                                            SizedBox(height: 15,),



                                            Expanded(

                                                child: Image.network(imagePath+categoryData[index].largeBanner)

                                            ),


                                            ///Expanded(child: Image.network(imagePath+categoryData[index].largeBanner)),



                                            sized10,
                                            Padding(
                                              padding: const EdgeInsets.fromLTRB(2,2,0,5,),
                                              child: Container(
                                                //height: MediaQuery.of(context).size.height/20,
                                                height: MediaQuery.of(context).size.height/14,
                                                child: Text(
                                                  categoryData[index].name,
                                                  style: TextStyle(color: Color(0xFF515151), fontWeight: FontWeight.w700, fontSize:16),textAlign: TextAlign.center,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  } else {
                                    return Container(

                                      width: width*0.35,
                                      margin: EdgeInsets.symmetric(horizontal: 5,vertical: 10),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(5.0),

                                      ),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          //sized10,
                                          SizedBox(height: 15,),
                                          Expanded(child: Image.network(imagePath+categoryData[index].largeBanner)),
                                          sized10,
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(2,2,0,5,),
                                            child: Container(
                                              //height: MediaQuery.of(context).size.height/20,
                                              height: MediaQuery.of(context).size.height/14,
                                              child: Text(
                                                categoryData[index].name,
                                                style: TextStyle(color: Color(0xFF515151), fontWeight: FontWeight.w700, fontSize:16),textAlign: TextAlign.center,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    );
                                  }
                                },
                              ),
                            ),

                            ///

                            ///

                            SizedBox(height: 10,),

                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Essentials- Top Deals",
                                style: TextStyle(color: Color(0xFF515151), fontSize: 22, fontWeight: FontWeight.w700,fontFamily: "CeraProBold"),
                              ),
                            ),

                            SizedBox(height: 20,),



                            ////////////////////////////////////////////////////////
                            Container(
                              height: MediaQuery.of(context).size.height/3,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                itemCount:categoryProducts.length,
                                itemBuilder: (_,index){
                                  return GestureDetector(

                                    onTap: (){
                                      //log(categoryProducts[index].links.details);
                                      /*setState(() {
                                        value=index.toString();

                                        getProductsAfterTap(categoryData[index].links.products);
                                      });*/
                                    },

                                    child: Padding(
                                      padding: const EdgeInsets.only(right: 8.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: Color(0xFFF1EDF2),
                                            borderRadius: BorderRadius.circular(15.0)
                                        ),
                                        //height: MediaQuery.of(context).size.height/3.2,
                                        width: MediaQuery.of(context).size.width/2.34,
                                        child: Column(
                                          children: [
                                            Align(
                                              alignment: Alignment.centerLeft,
                                              child: Container(
                                                width: MediaQuery.of(context).size.width/5,
                                                height: MediaQuery.of(context).size.height/45,
                                                margin: EdgeInsets.only(top: 10),
                                                decoration: BoxDecoration(
                                                  color: Colors.green,
                                                  borderRadius: BorderRadius.only(
                                                      topRight: Radius.circular(4.0),
                                                      bottomRight: Radius.circular(4.0)
                                                  ),

                                                ),
                                                //

                                                child: Center(
                                                  child: Text(
                                                    "15% OFF",
                                                    style: TextStyle(color: Colors.white,
                                                        fontSize: 12,
                                                        fontWeight: FontWeight.w500),
                                                  ),
                                                ),
                                              ),
                                            ),


                                            Container(
                                              child: Image.network(imagePath+categoryProducts[index].thumbnailImage),
                                              height: MediaQuery.of(context).size.height/8,
                                              width: MediaQuery.of(context).size.width/2.34,
                                            ),


                                            FittedBox(
                                              child: Container(
                                                ///height: height! * 0.08,
                                                width: MediaQuery.of(context).size.width/2.36,
                                                height: MediaQuery.of(context).size.height/20,
                                                child: Padding(
                                                  padding: const EdgeInsets.fromLTRB(5,5,5,0),
                                                  child: Text(
                                                    categoryProducts[index].name,
                                                    style: TextStyle(color: Color(0xFF515151), fontSize: 12.5, fontWeight: FontWeight.w600,fontFamily: "CeraProBold",),maxLines: 2,
                                                    textAlign: TextAlign.center,

                                                  ),
                                                ),
                                              ),
                                            ),



                                            Center(
                                              child: Container(
                                                height: MediaQuery.of(context).size.height/38,
                                                child: Text(
                                                  "5 lit",
                                                  style: TextStyle(color: Colors.grey.withOpacity(0.9)),
                                                ),
                                              ),
                                            ),


                                            Padding(
                                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                              child: Center(
                                                child: Container(
                                                  height: MediaQuery.of(context).size.height/32,
                                                  width: MediaQuery.of(context).size.width/2.34,
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                    children: [

                                                      Container(
                                                        child: Image.asset("assets/p.png"),
                                                        height: 20,
                                                        width: 22,
                                                      ),
                                                      Text(categoryProducts[index].basePrice.toString(),style: TextStyle(
                                                          color: Color(0xFF515151),
                                                          fontSize: 16,
                                                          fontWeight: FontWeight.w700)
                                                      ),
                                                      Text(categoryProducts[index].baseDiscountedPrice.toString(),
                                                          style: TextStyle(
                                                              color: Color(0xFFA299A8),
                                                              fontSize: 12,
                                                              fontWeight: FontWeight.w400,
                                                              decoration: TextDecoration.lineThrough)
                                                      ),
                                                      Container(
                                                        height: 25,
                                                        width: 25,
                                                        decoration: BoxDecoration(

                                                            color: kPrimaryColor,shape: BoxShape.circle),
                                                        child: Center(
                                                          child: Icon(
                                                            Icons.shopping_cart_rounded,
                                                            color: Colors.white,

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
                                              height: MediaQuery.of(context).size.height/26,
                                              width: MediaQuery.of(context).size.width/2.34,
                                              decoration: BoxDecoration(
                                                  color: Colors.lightGreen[100],
                                                  borderRadius: BorderRadius.only(
                                                      bottomLeft: Radius.circular(10.0),
                                                      bottomRight: Radius.circular(10.0))
                                              ),
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
                                                        style: TextStyle(fontSize: 12,
                                                            color: Colors.green,
                                                            fontWeight: FontWeight.w600),

                                                      ),
                                                    ),

                                                  ],
                                                ),
                                              ),
                                            )


                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            /////////////////////////////////////////////////////////


                            SizedBox(height: 35,),


                          ]),
                        ),

                      ],
                    ),
                  ),


                  ///



                  sized20,
                  SizedBox(height: 5,),
                  Container(
                    width: MediaQuery.of(context).size.width/1,
                    //margin: EdgeInsets.symmetric(horizontal: 5.0),
                    decoration: BoxDecoration(color: kPrimaryColor, borderRadius: BorderRadius.circular(10.0)),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children:
                            [
                              Text(
                                "1-99 Store",
                                style: TextStyle(fontFamily: "CeraProBold", fontSize: 22,color: Colors.white,fontWeight: FontWeight.w700),
                              ),
                              Text(
                                "VIEW ALL",
                                style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                          sized10,
                          Center(
                            child: Stack(
                              children: [
                                Image.asset("assets/posterfive.png"),
                                Positioned(
                                  bottom: 10,
                                  left: 10,
                                  child: Row(
                                    children: [
                                      Text(
                                        "Everything under ৳99",
                                        style: TextStyle(color: Colors.white, fontSize:16, fontWeight:FontWeight.w700,fontFamily: "CeraProBold"),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 10),
                                        child: Container(
                                          height: 15,
                                          width: 15,
                                          child: Image.asset("assets/v.png"),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          sized10,
                          Padding(
                            padding: const EdgeInsets.only(left: 2.0),
                            child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(children: [
                                  ProductItemsWidget(
                                    height: height,
                                    width: width,
                                    block: block,
                                    image: "assets/img_89.png",
                                    productName: "ACI Healthy 100%\npure soyabean oil",
                                    productWeight: "5 lit",
                                    productActualPrice: "৳125",
                                    productOfferPrice: "৳100",
                                  ),
                                  Padding(padding: const EdgeInsets.only(left: 8.0),),
                                  ProductItemsWidget(
                                    height: height,
                                    width: width,
                                    block: block,
                                    image: "assets/lays.png",
                                    productName: "Lays Premium taste\nChips orange",
                                    productWeight: "60g",
                                    productActualPrice: "৳400",
                                    productOfferPrice: "৳300",
                                  ),
                                  Padding(padding: const EdgeInsets.only(left: 8.0),),
                                  ProductItemsWidget(
                                    height: height,
                                    width: width,
                                    block: block,
                                    image: "assets/cadebry.png",
                                    productName: "Cadbery Chocolate \nMilk Candy",
                                    productWeight: "20g",
                                    productActualPrice: "৳120",
                                    productOfferPrice: "৳110",
                                  ),
                                ]
                                )
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  sized20,



                  Container(
                    width: MediaQuery.of(context).size.width/1,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      color: Colors.white,
                    ),
                    child: Column(
                      children: [

                        SizedBox(height: 25,),

                        Container(
                          width: MediaQuery.of(context).size.width/1.1,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Grocery",
                                style: TextStyle(color: Color(0xFF515151), fontSize: 22, fontWeight:FontWeight.w700,fontFamily: "CeraProBold"),
                              ),
                              Text(
                                "VIEW ALL",
                                style: TextStyle(color: Color(0xFF515151), fontSize: 12, fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                        ),

                        sized20,

                        Stack(
                            children: [
                              Image.asset("assets/posterone.png"),
                              Positioned(
                                bottom: 10,
                                left: 10,
                                child: Row(
                                  children: [
                                    Text(
                                      "Shop for daily needs",
                                      style: TextStyle(color: Colors.white, fontSize: 16, fontWeight:FontWeight.w700,fontFamily: "CeraProBold"),
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
                            ]
                        ),
                        sized20,
                        Container(
                          height: height*0.22,
                          width: width,
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: groceryData.length,
                            itemBuilder: (_,index){
                              return GestureDetector(
                                onTap: (){
                                  setState(() {
                                    valueOne=index.toString();
                                    getGroceryProductsAfterTap(groceryData[index].links.products);
                                  });
                                },
                                child:valueOne.toString()!=index.toString()?Container(
                                  child: Container(
                                    height: height * 0.2,
                                    width: width*0.35,
                                    margin: EdgeInsets.symmetric(vertical: 5.0,horizontal: 5),
                                    decoration: BoxDecoration(
                                      //color: Colors.grey.withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(10.0),

                                    ),
                                    child: Column(
                                      children: [
                                        //SizedBox(height: 15,),
                                        Container(
                                          height: height*0.15,
                                          //width: width*0.30,
                                          width: width*0.30,
                                          decoration: BoxDecoration(
                                              color: Color(0xFFF0E6F2),
                                              borderRadius: BorderRadius.circular(15.0)
                                          ),
                                          child: Center(
                                            child:Padding(
                                              padding: const EdgeInsets.fromLTRB(5,0,5,0),
                                              child: Image.network(
                                                imagePath+groceryData[index].mobileBanner,
                                              ),
                                            ),
                                          ),
                                        ),
                                        sized5,
                                        Text(
                                          groceryData[index].name,
                                          style: TextStyle(color: Color(0xFF515151), fontSize: block * 4, fontWeight: FontWeight.w700),
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    ),
                                  ),
                                ):Padding(
                                  padding: const EdgeInsets.only(left: 5.0),
                                  child: Container(
                                    //height: height * 0.2,
                                      height: height * 0.2,
                                      width: width*0.35,
                                      margin: EdgeInsets.symmetric(vertical: 5.0),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10.0),

                                      ),
                                      child: Column(
                                        children: [
                                          Container(
                                            height: height*0.15,
                                            width: width*0.30,
                                            decoration: BoxDecoration(
                                              //color: Colors.grey.withOpacity(0.2),
                                                borderRadius: BorderRadius.circular(15.0)
                                            ),
                                            child: Center(
                                              child:Image.network(imagePath+groceryData[index].mobileBanner,
                                              ),
                                            ),
                                          ),
                                          sized5,
                                          Text(
                                            groceryData[index].name,
                                            style: TextStyle(color: Color(0xFF515151), fontSize: block * 4, fontWeight: FontWeight.w700),
                                            textAlign: TextAlign.center,
                                          ),
                                        ],
                                      )
                                  ),
                                ),
                              );
                            },
                          ),
                        ),

                        SizedBox(height: 5,),
                        //sized20,
                        Padding(
                          padding: const EdgeInsets.only(left: 15.0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Grocery- Top Deals",
                              style: TextStyle(color: Color(0xFF515151), fontSize: 22, fontWeight:FontWeight.w700,fontFamily: "CeraProBold"),
                            ),
                          ),
                        ),
                        sized20,
                        Padding(
                          padding: const EdgeInsets.fromLTRB(15,0,8,0),
                          child: Container(
                            height: height*0.31,
                            width: width,
                            child: ListView.builder(
                                shrinkWrap:true,
                                scrollDirection: Axis.horizontal,
                                itemCount: groceryProducts.length,
                                itemBuilder: (_,index){
                                  return Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Color(0xFFF1EDF2),
                                          borderRadius: BorderRadius.circular(15.0)
                                      ),
                                      //height: MediaQuery.of(context).size.height/3.2,
                                      width: MediaQuery.of(context).size.width/2.34,
                                      child: Column(
                                        children: [
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: Container(
                                              width: MediaQuery.of(context).size.width/5,
                                              height: MediaQuery.of(context).size.height/45,
                                              margin: EdgeInsets.only(top: 10),
                                              decoration: BoxDecoration(
                                                color: Colors.green,
                                                borderRadius: BorderRadius.only(
                                                    topRight: Radius.circular(4.0),
                                                    bottomRight: Radius.circular(4.0)
                                                ),

                                              ),
                                              //

                                              child: Center(
                                                child: Text(
                                                  "15% OFF",
                                                  style: TextStyle(color: Colors.white,
                                                      fontSize: 12,
                                                      fontWeight: FontWeight.w500),
                                                ),
                                              ),
                                            ),
                                          ),


                                          Container(
                                            child: Image.network(imagePath+groceryProducts[index].thumbnailImage),
                                            height: MediaQuery.of(context).size.height/8,
                                            width: MediaQuery.of(context).size.width/2.34,
                                          ),


                                          FittedBox(
                                            child: Container(
                                              ///height: height! * 0.08,
                                              width: MediaQuery.of(context).size.width/2.36,
                                              height: MediaQuery.of(context).size.height/20,
                                              child: Padding(
                                                padding: const EdgeInsets.fromLTRB(5,5,5,0),
                                                child: Text(
                                                  groceryProducts[index].name,
                                                  style: TextStyle(color: Color(0xFF515151), fontSize: 12.5, fontWeight: FontWeight.w600,fontFamily: "CeraProBold",),maxLines: 2,
                                                  textAlign: TextAlign.center,

                                                ),
                                              ),
                                            ),
                                          ),


                                          Center(
                                            child: Container(
                                              height: MediaQuery.of(context).size.height/38,
                                              child: Text(
                                                "5 lit",
                                                style: TextStyle(color: Colors.grey.withOpacity(0.9)),
                                              ),
                                            ),
                                          ),


                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                            child: Center(
                                              child: Container(
                                                height: MediaQuery.of(context).size.height/32,
                                                width: MediaQuery.of(context).size.width/2.34,
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                  children: [

                                                    Container(
                                                      child: Image.asset("assets/p.png"),
                                                      height: 20,
                                                      width: 22,
                                                    ),
                                                    Text(groceryProducts[index].basePrice.toString(),style: TextStyle(
                                                        color: Color(0xFF515151),
                                                        fontSize: 16,
                                                        fontWeight: FontWeight.w700)
                                                    ),
                                                    Text(groceryProducts[index].baseDiscountedPrice.toString(),
                                                        style: TextStyle(
                                                            color: Color(0xFFA299A8),
                                                            fontSize: 12,
                                                            fontWeight: FontWeight.w400,
                                                            decoration: TextDecoration.lineThrough)
                                                    ),
                                                    Container(
                                                      height: 25,
                                                      width: 25,
                                                      decoration: BoxDecoration(

                                                          color: kPrimaryColor,shape: BoxShape.circle),
                                                      child: Center(
                                                        child: Icon(
                                                          Icons.shopping_cart_rounded,
                                                          color: Colors.white,

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
                                            height: MediaQuery.of(context).size.height/26,
                                            width: MediaQuery.of(context).size.width/2.34,
                                            decoration: BoxDecoration(
                                                color: Colors.lightGreen[100],
                                                borderRadius: BorderRadius.only(
                                                    bottomLeft: Radius.circular(10.0),
                                                    bottomRight: Radius.circular(10.0))
                                            ),
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
                                                      style: TextStyle(fontSize: 12,
                                                          color: Colors.green,
                                                          fontWeight: FontWeight.w600),

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
                                }
                            ),
                          ),
                        ),
                        SizedBox(height: 35,),
                      ],
                    ),
                  ),

                  sized20,
                  SizedBox(height: 5,),
                  InkWell(

                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => OfferPage ()));
                    },

                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(image: AssetImage("assets/img_61.png"), fit: BoxFit.cover),
                        color: Colors.blue[400],
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.15),
                            spreadRadius: 5, //spread radius
                            blurRadius: 5, // blur radius
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      height: 200,
                      width: MediaQuery.of(context).size.width / 1.1,
                      child: Image.asset("assets/img_62.png"),
                    ),
                  ),
                  sized20,

                  Container(
                    width: MediaQuery.of(context).size.width/1,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      color: Colors.white,
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: 25,),
                        Container(
                          width: MediaQuery.of(context).size.width/1.1,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Beverages",
                                style: TextStyle(color: Color(0xFF515151), fontSize: 22,fontWeight:FontWeight.w700,fontFamily: "CeraProBold"),
                              ),
                              Text(
                                "VIEW ALL",
                                style: TextStyle(color: Color(0xFF515151), fontSize: 12, fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                        ),

                        sized20,

                        Stack(
                          children: [
                            Image.asset("assets/postertwo.png"),
                            Positioned(
                              bottom: 10,
                              left: 10,
                              child: Row(
                                children: [
                                  Text(
                                    "Sip it up",
                                    style: TextStyle(color: Colors.white, fontSize:16, fontWeight:FontWeight.w700,fontFamily: "CeraProBold"),
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
                          ],
                        ),
                        sized20,
                        Container(
                          height: height*0.2,
                          width: width,
                          //width: width*0.4,
                          //height: height * 0.2,
                          //width: width*0.35,
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: fruitBeverageData.length,
                            itemBuilder: (_,index){
                              return GestureDetector(
                                onTap: (){
                                  setState(() {
                                    valueTwo=index.toString();
                                    getfruitsBeverageDataAfterTap(fruitBeverageData[index].links.products);
                                  });
                                },
                                child: valueTwo.toString()!=index.toString()?Padding(
                                  padding: const EdgeInsets.only(left: 5.0),
                                  child: Container(
                                    //height: height * 0.2,
                                      height: height * 0.2,
                                      width: width*0.35,
                                      margin: EdgeInsets.symmetric(vertical: 5.0),
                                      decoration: BoxDecoration(
                                        //color: Colors.white,
                                        borderRadius: BorderRadius.circular(10.0),

                                      ),
                                      child: Column(
                                        children: [
                                          Container(
                                            height: height*0.15,
                                            width: width*0.30,
                                            decoration: BoxDecoration(
                                                color: Color(0xFFF0E6F2),
                                                borderRadius: BorderRadius.circular(15.0)
                                            ),
                                            child: Center(
                                              child:Padding(
                                                padding: const EdgeInsets.fromLTRB(5,0,5,0),
                                                child: Image.network(imagePath+fruitBeverageData[index].mobileBanner,
                                                ),
                                              ),
                                            ),
                                          ),
                                          sized5,
                                          Text(
                                            fruitBeverageData[index].name,
                                            style: TextStyle(color: Color(0xFF515151), fontSize: block * 4, fontWeight: FontWeight.w700),
                                            textAlign: TextAlign.center,
                                          ),
                                        ],
                                      )
                                  ),
                                ):Padding(
                                  padding: const EdgeInsets.only(left: 5.0),
                                  child: Container(
                                    //height: height * 0.2,
                                      height: height * 0.2,
                                      width: width*0.35,
                                      margin: EdgeInsets.symmetric(vertical: 5.0),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10.0),

                                      ),
                                      child: Column(
                                        children: [
                                          Container(
                                            height: height*0.15,
                                            width: width*0.30,
                                            decoration: BoxDecoration(
                                              //color: Color(0xFFF0E6F2),
                                                borderRadius: BorderRadius.circular(15.0)
                                            ),
                                            child: Center(
                                              child:Image.network(imagePath+fruitBeverageData[index].mobileBanner,
                                              ),
                                            ),
                                          ),
                                          sized5,
                                          Text(
                                            fruitBeverageData[index].name,
                                            style: TextStyle(color: Color(0xFF515151), fontSize: block * 4, fontWeight: FontWeight.w700),
                                            textAlign: TextAlign.center,
                                          ),
                                        ],
                                      )
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        sized5,
                        Padding(
                          padding: const EdgeInsets.only(left: 15.0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Grocery- Top Deals",
                              style: TextStyle(color: Color(0xFF515151), fontSize: 22, fontWeight:FontWeight.w700,fontFamily: "CeraProBold"),
                            ),
                          ),
                        ),
                        sized20,

                        Padding(
                          padding: const EdgeInsets.fromLTRB(15,0,8,0),
                          child: Container(
                            height: height*0.31,
                            width: width,
                            child: ListView.builder(
                                shrinkWrap:true,
                                scrollDirection: Axis.horizontal,
                                itemCount: fruitBeverageDataAfterTap.length,
                                itemBuilder: (_,index){
                                  return Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Color(0xFFF1EDF2),
                                          borderRadius: BorderRadius.circular(15.0)
                                      ),
                                      //height: MediaQuery.of(context).size.height/3.2,
                                      width: MediaQuery.of(context).size.width/2.34,
                                      child: Column(
                                        children: [
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: Container(
                                              width: MediaQuery.of(context).size.width/5,
                                              height: MediaQuery.of(context).size.height/45,
                                              margin: EdgeInsets.only(top: 10),
                                              decoration: BoxDecoration(
                                                color: Colors.green,
                                                borderRadius: BorderRadius.only(
                                                    topRight: Radius.circular(4.0),
                                                    bottomRight: Radius.circular(4.0)
                                                ),

                                              ),
                                              //

                                              child: Center(
                                                child: Text(
                                                  "15% OFF",
                                                  style: TextStyle(color: Colors.white,
                                                      fontSize: 12,
                                                      fontWeight: FontWeight.w500),
                                                ),
                                              ),
                                            ),
                                          ),


                                          Container(
                                            child: Image.network(imagePath+fruitBeverageDataAfterTap[index].thumbnailImage),
                                            height: MediaQuery.of(context).size.height/8,
                                            width: MediaQuery.of(context).size.width/2.34,
                                          ),


                                          FittedBox(
                                            child: Container(
                                              ///height: height! * 0.08,
                                              width: MediaQuery.of(context).size.width/2.36,
                                              height: MediaQuery.of(context).size.height/20,
                                              child: Padding(
                                                padding: const EdgeInsets.fromLTRB(5,5,5,0),
                                                child: Text(
                                                  fruitBeverageDataAfterTap[index].name,
                                                  style: TextStyle(color: Color(0xFF515151), fontSize: 12.5, fontWeight: FontWeight.w600,fontFamily: "CeraProBold",),maxLines: 2,
                                                  textAlign: TextAlign.center,

                                                ),
                                              ),
                                            ),
                                          ),



                                          Center(
                                            child: Container(
                                              height: MediaQuery.of(context).size.height/38,
                                              child: Text(
                                                "5 lit",
                                                style: TextStyle(color: Colors.grey.withOpacity(0.9)),
                                              ),
                                            ),
                                          ),


                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                            child: Center(
                                              child: Container(
                                                height: MediaQuery.of(context).size.height/32,
                                                width: MediaQuery.of(context).size.width/2.34,
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                  children: [

                                                    Container(
                                                      child: Image.asset("assets/p.png"),
                                                      height: 20,
                                                      width: 22,
                                                    ),
                                                    Text(fruitBeverageDataAfterTap[index].basePrice.toString(),style: TextStyle(
                                                        color: Color(0xFF515151),
                                                        fontSize: 16,
                                                        fontWeight: FontWeight.w700)
                                                    ),
                                                    Text(fruitBeverageDataAfterTap[index].baseDiscountedPrice.toString(),
                                                        style: TextStyle(
                                                            color: Color(0xFFA299A8),
                                                            fontSize: 12,
                                                            fontWeight: FontWeight.w400,
                                                            decoration: TextDecoration.lineThrough)
                                                    ),
                                                    Container(
                                                      height: 25,
                                                      width: 25,
                                                      decoration: BoxDecoration(

                                                          color: kPrimaryColor,shape: BoxShape.circle),
                                                      child: Center(
                                                        child: Icon(
                                                          Icons.shopping_cart_rounded,
                                                          color: Colors.white,

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
                                            height: MediaQuery.of(context).size.height/26,
                                            width: MediaQuery.of(context).size.width/2.34,
                                            decoration: BoxDecoration(
                                                color: Colors.lightGreen[100],
                                                borderRadius: BorderRadius.only(
                                                    bottomLeft: Radius.circular(10.0),
                                                    bottomRight: Radius.circular(10.0))
                                            ),
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
                                                      style: TextStyle(fontSize: 12,
                                                          color: Colors.green,
                                                          fontWeight: FontWeight.w600),

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
                                }
                            ),
                          ),
                        ),
                        SizedBox(height: 35,),
                      ],
                    ),
                  ),


                  //sized20,
                  SizedBox(height: 25,),
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(image: AssetImage("assets/img_65.png"), fit: BoxFit.cover),
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.15),
                          spreadRadius: 5, //spread radius
                          blurRadius: 5, // blur radius
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    height: 420,
                    width: MediaQuery.of(context).size.width / 1.1,
                    child: Image.asset("assets/img_66.png"),
                  ),

                  SizedBox(
                    height: 7,
                  ),

                  ///
                  sized20,

                  Container(
                    width: MediaQuery.of(context).size.width/1,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      color: Colors.white,
                    ),
                    child: Column(
                      children: [

                        SizedBox(height: 25,),
                        Container(
                          width: MediaQuery.of(context).size.width/1.1,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Baby and kids",
                                style: TextStyle(color: Color(0xFF515151), fontSize: 22, fontWeight:FontWeight.w700,fontFamily: "CeraProBold"),
                              ),
                              Text(
                                "VIEW ALL",
                                style: TextStyle(color:
                                Color(0xFF515151), fontSize: 13, fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                        ),


                        sized20,

                        Stack(
                          children: [
                            Image.asset("assets/postertwo.png"),
                            Positioned(
                              bottom: 10,
                              left: 10,
                              child: Row(
                                children: [
                                  Text(
                                    "Sip it up",
                                    style: TextStyle(color: Colors.white, fontSize:16, fontWeight:FontWeight.w700,fontFamily: "CeraProBold"),
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.only(left: 15),
                                    child: Container(
                                      height: 15,
                                      width: 15,
                                      child: Image.asset("assets/v.png"),
                                    ),
                                  ),

                                  /*Icon(
                          Icons.arrow_right,
                          color: Colors.white,
                          size: block * 6,
                        )*/
                                ],
                              ),
                            )
                          ],
                        ),
                        sized20,
                        Container(
                          height: height*0.2,
                          width: width,
                          //width: width*0.4,
                          //height: height * 0.2,
                          //width: width*0.35,
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: babyMotherData.length,
                            itemBuilder: (_,index){
                              return GestureDetector(
                                onTap: (){
                                  setState(() {
                                    valueThree=index.toString();
                                    getbabyMotherDataAfterTap(babyMotherData[index].links.products);
                                  });
                                },
                                child: valueThree.toString()!=index.toString()?Padding(
                                  padding: const EdgeInsets.only(left: 5.0),
                                  child: Container(
                                    //height: height * 0.2,
                                      height: height * 0.2,
                                      width: width*0.35,
                                      margin: EdgeInsets.symmetric(vertical: 5.0),
                                      decoration: BoxDecoration(
                                        //color: Colors.white,
                                        borderRadius: BorderRadius.circular(10.0),

                                      ),
                                      child: Column(
                                        children: [
                                          Container(
                                            height: height*0.15,
                                            width: width*0.30,
                                            decoration: BoxDecoration(
                                                color: Color(0xFFF0E6F2),
                                                borderRadius: BorderRadius.circular(15.0)
                                            ),
                                            child: Center(
                                              child:Padding(
                                                padding: const EdgeInsets.fromLTRB(5,0,5,0),
                                                child: Image.network(imagePath+babyMotherData[index].mobileBanner,
                                                ),
                                              ),
                                            ),
                                          ),
                                          sized5,
                                          Text(
                                            babyMotherData[index].name,
                                            style: TextStyle(color: Color(0xFF515151), fontSize: block * 4, fontWeight: FontWeight.w700),
                                            textAlign: TextAlign.center,
                                          ),
                                        ],
                                      )
                                  ),
                                ):Padding(
                                  padding: const EdgeInsets.only(left: 5.0),
                                  child: Container(
                                    //height: height * 0.2,
                                      height: height * 0.2,
                                      width: width*0.35,
                                      margin: EdgeInsets.symmetric(vertical: 5.0),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10.0),

                                      ),
                                      child: Column(
                                        children: [
                                          Container(
                                            height: height*0.15,
                                            width: width*0.30,
                                            decoration: BoxDecoration(
                                              //color: Color(0xFFF0E6F2),
                                                borderRadius: BorderRadius.circular(15.0)
                                            ),
                                            child: Center(
                                              child:Image.network(imagePath+babyMotherData[index].mobileBanner,
                                              ),
                                            ),
                                          ),
                                          sized5,
                                          Text(
                                            babyMotherData[index].name,
                                            style: TextStyle(color: Color(0xFF515151), fontSize: block * 4, fontWeight: FontWeight.w700),
                                            textAlign: TextAlign.center,
                                          ),
                                        ],
                                      )
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        sized5,
                        Padding(
                          padding: const EdgeInsets.only(left: 15.0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Grocery- Top Deals",
                              style: TextStyle(color: Color(0xFF515151), fontSize: 22, fontWeight:FontWeight.w700,fontFamily: "CeraProBold"),
                            ),
                          ),
                        ),
                        sized20,
                        //SizedBox(height: 5,),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(15,0,8,0),
                          child: Container(
                            height: height*0.31,
                            width: width,
                            child: ListView.builder(
                                shrinkWrap:true,
                                scrollDirection: Axis.horizontal,
                                itemCount: babyMotherDataAfterTap.length,
                                itemBuilder: (_,index){
                                  return Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Color(0xFFF1EDF2),
                                          borderRadius: BorderRadius.circular(15.0)
                                      ),
                                      //height: MediaQuery.of(context).size.height/3.2,
                                      width: MediaQuery.of(context).size.width/2.34,
                                      child: Column(
                                        children: [
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: Container(
                                              width: MediaQuery.of(context).size.width/5,
                                              height: MediaQuery.of(context).size.height/45,
                                              margin: EdgeInsets.only(top: 10),
                                              decoration: BoxDecoration(
                                                color: Colors.green,
                                                borderRadius: BorderRadius.only(
                                                    topRight: Radius.circular(4.0),
                                                    bottomRight: Radius.circular(4.0)
                                                ),

                                              ),
                                              //

                                              child: Center(
                                                child: Text(
                                                  "15% OFF",
                                                  style: TextStyle(color: Colors.white,
                                                      fontSize: 12,
                                                      fontWeight: FontWeight.w500),
                                                ),
                                              ),
                                            ),
                                          ),


                                          Container(
                                            child: Image.network(imagePath+babyMotherDataAfterTap[index].thumbnailImage),
                                            height: MediaQuery.of(context).size.height/8,
                                            width: MediaQuery.of(context).size.width/2.34,
                                          ),


                                          FittedBox(
                                            child: Container(
                                              ///height: height! * 0.08,
                                              width: MediaQuery.of(context).size.width/2.36,
                                              height: MediaQuery.of(context).size.height/20,
                                              child: Padding(
                                                padding: const EdgeInsets.fromLTRB(5,5,5,0),
                                                child: Text(
                                                  babyMotherDataAfterTap[index].name,
                                                  style: TextStyle(color: Color(0xFF515151), fontSize: 12.5, fontWeight: FontWeight.w600,fontFamily: "CeraProBold",),maxLines: 2,
                                                  textAlign: TextAlign.center,

                                                ),
                                              ),
                                            ),
                                          ),



                                          Center(
                                            child: Container(
                                              height: MediaQuery.of(context).size.height/38,
                                              child: Text(
                                                "5 lit",
                                                style: TextStyle(color: Colors.grey.withOpacity(0.9)),
                                              ),
                                            ),
                                          ),


                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                            child: Center(
                                              child: Container(
                                                height: MediaQuery.of(context).size.height/32,
                                                width: MediaQuery.of(context).size.width/2.34,
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                  children: [

                                                    Container(
                                                      child: Image.asset("assets/p.png"),
                                                      height: 20,
                                                      width: 22,
                                                    ),
                                                    Text(babyMotherDataAfterTap[index].basePrice.toString(),style: TextStyle(
                                                        color: Color(0xFF515151),
                                                        fontSize: 16,
                                                        fontWeight: FontWeight.w700)
                                                    ),
                                                    Text(babyMotherDataAfterTap[index].baseDiscountedPrice.toString(),
                                                        style: TextStyle(
                                                            color: Color(0xFFA299A8),
                                                            fontSize: 12,
                                                            fontWeight: FontWeight.w400,
                                                            decoration: TextDecoration.lineThrough)
                                                    ),
                                                    Container(
                                                      height: 25,
                                                      width: 25,
                                                      decoration: BoxDecoration(

                                                          color: kPrimaryColor,shape: BoxShape.circle),
                                                      child: Center(
                                                        child: Icon(
                                                          Icons.shopping_cart_rounded,
                                                          color: Colors.white,

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
                                            height: MediaQuery.of(context).size.height/26,
                                            width: MediaQuery.of(context).size.width/2.34,
                                            decoration: BoxDecoration(
                                                color: Colors.lightGreen[100],
                                                borderRadius: BorderRadius.only(
                                                    bottomLeft: Radius.circular(10.0),
                                                    bottomRight: Radius.circular(10.0))
                                            ),
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
                                                      style: TextStyle(fontSize: 12,
                                                          color: Colors.green,
                                                          fontWeight: FontWeight.w600),

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
                                }
                            ),
                          ),
                        ),

                        SizedBox(height: 35,),

                      ],
                    ),
                  ),

                  //sized20,

                  SizedBox(height: 20,),

                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(image: AssetImage("assets/img_69.png"), fit: BoxFit.cover),//69
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.15),
                          spreadRadius: 5, //spread radius
                          blurRadius: 5, // blur radius
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    height: 190,
                    width: MediaQuery.of(context).size.width / 1.1,
                    child: Image.asset("assets/img_70.png"),
                  ),

                  sized20,

                  Container(
                    width: MediaQuery.of(context).size.width/1,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      color: Colors.white,
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: 25,),
                        Container(
                          width: MediaQuery.of(context).size.width/1.1,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Fruits & Vegetables",
                                style: TextStyle(color: kBlackColor, fontSize:22, fontWeight:FontWeight.w700,fontFamily: "CeraProBold"),
                              ),
                              Text(
                                "VIEW ALL",
                                style: TextStyle(color: Color(0xFF515151), fontSize: 14, fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                        ),


                        sized20,

                        Stack(
                          children: [
                            Image.asset("assets/postertwo.png"),
                            Positioned(
                              bottom: 10,
                              left: 10,
                              child: Row(
                                children: [
                                  Text(
                                    "Sip it up",
                                    style: TextStyle(color: Colors.white, fontSize: 16, fontWeight:FontWeight.w700,fontFamily: "CeraProBold"),
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
                          ],
                        ),
                        sized20,
                        Container(
                          height: height*0.2,
                          width: width,
                          //width: width*0.4,
                          //height: height * 0.2,
                          //width: width*0.35,
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: fruitsVegitableData.length,
                            itemBuilder: (_,index){
                              return GestureDetector(
                                onTap: (){
                                  setState(() {
                                    valueFour=index.toString();
                                    getfrouitsVegitableDataAfterTap(fruitsVegitableData[index].links.products);
                                  });
                                },
                                child: valueFour.toString()!=index.toString()?Padding(
                                  padding: const EdgeInsets.only(left: 5.0),
                                  child: Container(
                                    //height: height * 0.2,
                                      height: height * 0.2,
                                      width: width*0.35,
                                      margin: EdgeInsets.symmetric(vertical: 5.0),
                                      decoration: BoxDecoration(
                                        //color: Colors.white,
                                        borderRadius: BorderRadius.circular(10.0),

                                      ),
                                      child: Column(
                                        children: [
                                          Container(
                                            height: height*0.15,
                                            width: width*0.30,
                                            decoration: BoxDecoration(
                                                color: Color(0xFFF0E6F2),
                                                borderRadius: BorderRadius.circular(15.0)
                                            ),
                                            child: Center(
                                              child:Padding(
                                                padding: const EdgeInsets.fromLTRB(5,0,5,0),
                                                child: Image.network(imagePath+fruitsVegitableData[index].mobileBanner,
                                                ),
                                              ),
                                            ),
                                          ),
                                          sized5,
                                          Text(
                                            fruitsVegitableData[index].name,
                                            style: TextStyle(color: Color(0xFF515151), fontSize: block * 4, fontWeight: FontWeight.w700),
                                            textAlign: TextAlign.center,
                                          ),
                                        ],
                                      )
                                  ),
                                ):Padding(
                                  padding: const EdgeInsets.only(left: 5.0),
                                  child: Container(
                                    //height: height * 0.2,
                                      height: height * 0.2,
                                      width: width*0.35,
                                      margin: EdgeInsets.symmetric(vertical: 5.0),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10.0),

                                      ),
                                      child: Column(
                                        children: [
                                          Container(
                                            height: height*0.15,
                                            width: width*0.30,
                                            decoration: BoxDecoration(
                                              //color: Color(0xFFF0E6F2),
                                                borderRadius: BorderRadius.circular(15.0)
                                            ),
                                            child: Center(
                                              child:Image.network(imagePath+fruitsVegitableData[index].mobileBanner,
                                              ),
                                            ),
                                          ),
                                          sized5,
                                          Text(
                                            fruitsVegitableData[index].name,
                                            style: TextStyle(color: Color(0xFF515151), fontSize: block * 4, fontWeight: FontWeight.w700),
                                            textAlign: TextAlign.center,
                                          ),
                                        ],
                                      )
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        sized5,
                        Padding(
                          padding: const EdgeInsets.only(left: 15.0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Grocery- Top Deals",
                              style: TextStyle(color: Color(0xFF515151), fontSize: 22, fontWeight:FontWeight.w700,fontFamily: "CeraProBold"),
                            ),
                          ),
                        ),
                        //sized20,
                        SizedBox(height: 10,),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(15,0,8,0),
                          child: Container(
                            height: height*0.31,
                            width: width,
                            child: ListView.builder(
                                shrinkWrap:true,
                                scrollDirection: Axis.horizontal,
                                itemCount: fruitsVegAfterTap.length,
                                itemBuilder: (_,index){
                                  return Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Color(0xFFF1EDF2),
                                          borderRadius: BorderRadius.circular(15.0)
                                      ),
                                      //height: MediaQuery.of(context).size.height/3.2,
                                      width: MediaQuery.of(context).size.width/2.34,
                                      child: Column(
                                        children: [
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: Container(
                                              width: MediaQuery.of(context).size.width/5,
                                              height: MediaQuery.of(context).size.height/45,
                                              margin: EdgeInsets.only(top: 10),
                                              decoration: BoxDecoration(
                                                color: Colors.green,
                                                borderRadius: BorderRadius.only(
                                                    topRight: Radius.circular(4.0),
                                                    bottomRight: Radius.circular(4.0)
                                                ),

                                              ),
                                              //

                                              child: Center(
                                                child: Text(
                                                  "15% OFF",
                                                  style: TextStyle(color: Colors.white,
                                                      fontSize: 12,
                                                      fontWeight: FontWeight.w500),
                                                ),
                                              ),
                                            ),
                                          ),


                                          Container(
                                            child: Image.network(imagePath+fruitsVegAfterTap[index].thumbnailImage),
                                            height: MediaQuery.of(context).size.height/8,
                                            width: MediaQuery.of(context).size.width/2.34,
                                          ),


                                          FittedBox(
                                            child: Container(
                                              ///height: height! * 0.08,
                                              width: MediaQuery.of(context).size.width/2.36,
                                              height: MediaQuery.of(context).size.height/20,
                                              child: Padding(
                                                padding: const EdgeInsets.fromLTRB(3,5,3,0),
                                                child: Text(
                                                  fruitsVegAfterTap[index].name,
                                                  style: TextStyle(color: Color(0xFF515151), fontSize: 12.5, fontWeight: FontWeight.w600,fontFamily: "CeraProBold",),maxLines: 2,
                                                  textAlign: TextAlign.center,

                                                ),
                                              ),
                                            ),
                                          ),


                                          Center(
                                            child: Container(
                                              height: MediaQuery.of(context).size.height/38,
                                              child: Text(
                                                "5 lit",
                                                style: TextStyle(color: Colors.grey.withOpacity(0.9)),
                                              ),
                                            ),
                                          ),


                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                            child: Center(
                                              child: Container(
                                                height: MediaQuery.of(context).size.height/32,
                                                width: MediaQuery.of(context).size.width/2.34,
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                  children: [

                                                    Container(
                                                      child: Image.asset("assets/p.png"),
                                                      height: 20,
                                                      width: 22,
                                                    ),
                                                    Text(fruitsVegAfterTap[index].basePrice.toString(),style: TextStyle(
                                                        color: Color(0xFF515151),
                                                        fontSize: 16,
                                                        fontWeight: FontWeight.w700)
                                                    ),
                                                    Text(fruitsVegAfterTap[index].baseDiscountedPrice.toString(),
                                                        style: TextStyle(
                                                            color: Color(0xFFA299A8),
                                                            fontSize: 12,
                                                            fontWeight: FontWeight.w400,
                                                            decoration: TextDecoration.lineThrough)
                                                    ),
                                                    Container(
                                                      height: 25,
                                                      width: 25,
                                                      decoration: BoxDecoration(

                                                          color: kPrimaryColor,shape: BoxShape.circle),
                                                      child: Center(
                                                        child: Icon(
                                                          Icons.shopping_cart_rounded,
                                                          color: Colors.white,

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
                                            height: MediaQuery.of(context).size.height/26,
                                            width: MediaQuery.of(context).size.width/2.34,
                                            decoration: BoxDecoration(
                                                color: Colors.lightGreen[100],
                                                borderRadius: BorderRadius.only(
                                                    bottomLeft: Radius.circular(10.0),
                                                    bottomRight: Radius.circular(10.0))
                                            ),
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
                                                      style: TextStyle(fontSize: 12,
                                                          color: Colors.green,
                                                          fontWeight: FontWeight.w600),

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
                                }
                            ),
                          ),
                        ),

                        SizedBox(height: 35,),

                      ],
                    ),
                  ),


                  sized20,


                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      image: DecorationImage(image: AssetImage("assets/img_72.png"), fit: BoxFit.cover),
                      color: Colors.white,
                    ),
                    height: 130,
                    width: MediaQuery.of(context).size.width / 1.1,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(5,0,5,0),
                      child: Image.asset("assets/img_73.png"),
                    ),
                  ),

                  SizedBox(
                    height: 20,
                  ),

                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Didn't find\nwhat you\nwere looking for?",
                        style: TextStyle(color:Color(0xFFB99DCB), fontSize: 28, fontWeight: FontWeight.bold,fontFamily: "CeraProBold"),
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 20,
                  ),

                  TextFormField(
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        contentPadding: EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                        hintText: 'Search Here',
                        prefixIcon: Icon(Icons.search)),
                  ),

                  SizedBox(
                    height: 20,
                  ),

                  Container(
                    height: height * 0.11,
                    //width: width,
                    width: MediaQuery.of(context).size.width/1.1,
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.call,
                          color: kBlackColor,
                          size: block * 10,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Call for query:",
                              style: TextStyle(color: kBlackColor, fontSize: block * 7),
                            ),
                            Text(
                              "01812-3456789",
                              style: TextStyle(color: kBlackColor, fontSize: block * 7, fontWeight: FontWeight.bold),
                            )
                          ],
                        )
                      ],
                    ),
                  ),

                  SizedBox(
                    height: 40,
                  ),
                ]),
              ))),
    );

  }

}

