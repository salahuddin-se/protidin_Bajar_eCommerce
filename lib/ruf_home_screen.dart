import 'dart:convert';
import 'dart:developer';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:customer_ui/HomePage/grocer_offer/grocery_offer_page.dart';
import 'package:customer_ui/HomePage/offer/offer_page.dart';
import 'package:customer_ui/OthersPage/all_offerpage.dart';
import 'package:customer_ui/OthersPage/cart_details1st_page.dart';
import 'package:customer_ui/OthersPage/myOrders.dart';
import 'package:customer_ui/OthersPage/myaccopunt.dart';
import 'package:customer_ui/OthersPage/requestProduct.dart';
import 'package:customer_ui/OthersPage/tarck_order.dart';
import 'package:customer_ui/OthersPage/wallet.dart';
import 'package:customer_ui/components/size_config.dart';
import 'package:customer_ui/components/styles.dart';
import 'package:customer_ui/components/utils.dart';
import 'package:customer_ui/dataModel/category_data_model.dart';
import 'package:customer_ui/dataModel/chocolate_sweet_data_model.dart';
import 'package:customer_ui/dataModel/one_ninetynine_data_model.dart';
import 'package:customer_ui/widgets/category_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dropdown/flutter_dropdown.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'HomePage/grocer_offer/grocery_details.dart';
import 'dataModel/cart_details_model.dart';
import 'dataModel/city_model.dart';

class CategoryHomeScreenRuf extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<CategoryHomeScreenRuf> {

  var value;
  var Cart;


  Future<dynamic> buildShowDialog(BuildContext context, List<String> areaName,List<String> cityName) {
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    return showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            backgroundColor: Color(0xFFF4EFF5),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Container(
              height: 215,
              padding: EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Container(
                          width: MediaQuery.of(context).size.width / 6,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Text(
                              "City",
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Color(0xFF515151)),
                            ),
                          )),
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width / 1.8,
                          //width: 100,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Color(0xFFFFFFFF)),
                          child: Padding(
                            padding: const EdgeInsets.only(right: 10.0),
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: DropDown(
                                items:cityName,
                                hint: Text(
                                  "",
                                ),
                                icon: Padding(
                                  padding: const EdgeInsets.only(left: 100.0),
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Icon(
                                      Icons.expand_more,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                //onChanged: print,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Container(
                          width: MediaQuery.of(context).size.width / 6,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Text(
                              "Area",
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Color(0xFF515151)),
                            ),
                          )),
                      Container(
                        width: MediaQuery.of(context).size.width / 1.8,
                        height: 50,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Color(0xFFFFFFFF)),
                        child: Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: DropDown(
                              items: areaName,
                              hint: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                    color: Colors.teal,
                                    child: Text(
                                      " ",
                                    )),
                              ),
                              icon: Padding(
                                padding: const EdgeInsets.only(left: 70.0),
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Icon(
                                    Icons.expand_more,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              onChanged: print,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Container(
                          width: MediaQuery.of(context).size.width / 6,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Text(""),
                          )),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width / 1.8,
                          height: 50,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Color(0xFF9900FF)),
                          child: Center(
                              child: Text(
                            "Submit",
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          )),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }


  @override
  void initState() {
    // TODO: implement initState
    getCartName();
    getCityName();
    getCategory();
    getOneTo99Data();
  }


  var demo=[];
  Future<void> getCartName() async {
    var res = await http.post(Uri.parse("https://test.protidin.com.bd/api/v2/carts/61"),
        headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8', 'Authorization': 'Bearer $authToken'});
    // log("Response ${res.body}");
    log("Response code ${res.statusCode}");

    var dataMap=jsonDecode(res.body);
    log(dataMap[0].toString());
    var cartModel=CartDetailsModel.fromJson(dataMap[0]);
    demo=cartModel.cartItems;
    log("cart added ${cartModel.cartItems.length} product");
    //demo=dataMap;
    setState(() {

    });
    //log("demo length "+demo.length.toString());
  }


  List<String> cityData = [];
  var selectDhaka = " ";

  List<String> areaName=[];
  List<String> cityName=[];

  Future<void> getCityName()async{
    areaName.clear();
    cityName.clear();

    var response = await get(Uri.parse("https://test.protidin.com.bd/api/v2/cities"),
        headers: <String, String>{
          'Accept': 'application/json',

        });

    log(response.body);

    var dataMap=jsonDecode(response.body);

    var areaModel=CityModel.fromJson(dataMap);
    for(var element in areaModel.data){
      areaName.add(element.area);
      cityName.add(element.name);
    }
    buildShowDialog(context, areaName,cityName);
    setState(() {

    });
    log("area2 name $areaName");
    log("city2 name $cityName");


  }

 /* Future<void> getCityName() async {
    String productURl = "https://test.protidin.com.bd/api/v2/cities";

    final response = await get(Uri.parse(productURl), headers: {"Accept": "application/json"});

    var dataMap = jsonDecode(response.body);

    if (dataMap["success"] == true) {
      log("data valid");
      //
      var cityModel = CityModel.fromJson(dataMap);

      //cityData=cityModel.data;
      for (var element in cityModel.data) {
        cityData.add(element.area);
      }
      selectDhaka = cityModel.data[0].name;
      //cityData.removeAt(0);

      setState(() {});

      //log("city data length ${cityData.length}");
      log("AREA NAME $selectDhaka");
      buildShowDialog(context, selectDhaka);
    } else {
      log("data invalid");
    }
  }*/


  var relatedProductsLink = " ";
  Future<void> addToCart(id, userId, quantity) async {
    var res = await http.post(Uri.parse("https://test.protidin.com.bd/api/v2/carts/add"),
        headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8', 'Authorization': 'Bearer $authToken'},
        body: jsonEncode(<String, dynamic>{"id": id, "variant": "", "user_id": userId, "quantity": quantity}));
    log("Response ${res.body}");
    log("Response code jhjk ${res.statusCode}");

  }


  var categoryData = [];
  var categoryDataItem = " ";
  var groceryLargeBanner="";
  var chocolateLargeBanner="";
  var breadLargeBanner="";
  Future<void> getCategory() async {
    log("comes");
    String productURl = "https://test.protidin.com.bd/api/v2/categories/home";

    final response = await get(Uri.parse(productURl), headers: {"Accept": "application/json"});

    var dataMap = jsonDecode(response.body);

    if (dataMap["success"] == true) {
      log("data valid");

      //
      var categoryDataModel = CategoryDataModel.fromJson(dataMap);
      categoryData = categoryDataModel.data;
      categoryDataItem = categoryDataModel.data[0].name;
      for(var ele in categoryDataModel.data){
        if(ele.name=="Grocery"){
          groceryLargeBanner = ele.largeBanner!;
          log("Banner Image $groceryLargeBanner");
        }else if(ele.name=="Chocolate & Sweets"){
          chocolateLargeBanner=ele.largeBanner!;
        }else if(ele.name=="Bread Biscuit & Snacks"){
          breadLargeBanner=ele.largeBanner!;
        }
      }
      await getProductsAfterTap(categoryDataModel.data[0].links.products);
      setState(() {});
      log("data length ${categoryData.length}");
    } else {
      log("data invalid");
    }

    // log("after decode $dataMap");
  }


  List<BuiscitData> categoryProducts = [];
  Future<void> getProductsAfterTap(link) async {
    log("calling 2");
    //String biscuitSweetsURl = "https://test.protidin.com.bd/api/v2/products/category/46";

    final response6 = await get(Uri.parse(link), headers: {"Accept": "application/json"});

    var biscuitSweetsDataMap = jsonDecode(response6.body);

    if (biscuitSweetsDataMap["success"] == true) {
      //log("category data after tap $biscuitSweetsDataMap");

      setState(() {
        var biscuitSweetsDataModel = BiacuitSweets.fromJson(biscuitSweetsDataMap);
        categoryProducts = biscuitSweetsDataModel.data;
      });
      log("categoryProducts data length ${categoryProducts.length}");
    } else {
      log("data invalid");
    }

    // log("after decode $dataMap");
  }


  var groceryProducts = [];
  Future<void> getGroceryProductsAfterTap(link2) async {
    log("calling after tap");
    //String biscuitSweetsURl = "https://test.protidin.com.bd/api/v2/products/category/46";

    final response7 = await get(Uri.parse(link2), headers: {"Accept": "application/json"});

    var groceryItemDataMap = jsonDecode(response7.body);

    if (groceryItemDataMap["success"] == true) {
      //log("category data after tap $biscuitSweetsDataMap");

      var groceryData = BiacuitSweets.fromJson(groceryItemDataMap);
      groceryProducts = groceryData.data;
      //relatedProductsLink=groceryProducts[0].links.products;

      setState(() {});

      log("after tap grocery data length ${groceryProducts.length}");
    } else {
      log("data invalid");
    }

    // log("after decode $dataMap");
  }


  List<OneToNinentyNineDataModel> oneTwoNinentyNineData = [];
  Future<void> getOneTo99Data() async {
    log("1 to 99 data");

    final response12 =
        await get(Uri.parse("https://test.protidin.com.bd/api/v2/products/category/4"), headers: {"Accept": "application/json"});

    var oneTwoNinentyNineItemDataMap = jsonDecode(response12.body);

    if (oneTwoNinentyNineItemDataMap["success"] == true) {
      //log("category data after tap $biscuitSweetsDataMap");

      setState(() {
        var onToNinetyNine = BiacuitSweets.fromJson(oneTwoNinentyNineItemDataMap);

        //oneTwoNinentyNineData=onToNinetyNine.data;

        for (var i = 0; i < onToNinetyNine.data.length; i++) {
          if (int.parse(onToNinetyNine.data[i].basePrice.substring(1)) <= 99) {
            log("price between 1-99: ${onToNinetyNine.data[i].basePrice}");

            oneTwoNinentyNineData.add(OneToNinentyNineDataModel(
              name: onToNinetyNine.data[i].name,
              basePrice: onToNinetyNine.data[i].basePrice,
              disCountPrice: onToNinetyNine.data[i].baseDiscountedPrice,
              image: onToNinetyNine.data[i].thumbnailImage,
              id: onToNinetyNine.data[i].id,
              discount: onToNinetyNine.data[i].discount,
              unit: onToNinetyNine.data[i].unit,
            ));
          } else {
            // log("price not between 1-99: ${onToNinetyNine.data[i].basePrice}");
          }
        }
      });
      //log("1-99 data length ${oneTwoNinentyNineData.length}");

    } else {
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

    return Material(
        //backgroundColor: Colors.indigo[50],
        child: Scaffold(
          backgroundColor: Color(0xFFE5E5E5),
          drawer: Drawer(
            child: ListView(
              // Important: Remove any padding from the ListView.
              padding: EdgeInsets.zero,
              children: <Widget>[
                DrawerHeader(
                  child: Container(
                    height: 200,
                    width: MediaQuery.of(context).size.width / 1.2,
                    child: Column(children: [
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        //mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            //color: Colors.white,
                            height: 60,
                            width: 60,
                            child: Image.asset(
                              "assets/img_135.png",
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                          ),
                          Container(
                            width: 120,
                            child: Column(
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Welcome ",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Md. Abcdef ghijkl",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ]),
                  ),
                  decoration: BoxDecoration(
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
                        child: Image.asset(
                          "assets/img_149.png",
                          color: Colors.black,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                      ),
                      Text(
                        'Track Order',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
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
                        child: Image.asset(
                          "assets/img_150.png",
                          color: Colors.black,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                      ),
                      Text(
                        'My Orders',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
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
                        child: Image.asset(
                          "assets/img_151.png",
                          color: Colors.black,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                      ),
                      Text(
                        'Categories',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => GroceryOfferPage()));
                  },
                ),
                ListTile(
                  title: Row(
                    children: [
                      Container(
                        //color: Colors.white,
                        height: 20,
                        width: 20,
                        child: Image.asset(
                          "assets/img_152.png",
                          color: Colors.black,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                      ),
                      Text(
                        'Wallet',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
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
                        child: Image.asset(
                          "assets/img_153.png",
                          color: Colors.black,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                      ),
                      Text(
                        'Request a product',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
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
                        child: Image.asset(
                          "assets/img_149.png",
                          color: Colors.black,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                      ),
                      Text(
                        'Call to order',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
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
                        child: Image.asset(
                          "assets/img_154.png",
                          color: Colors.black,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                      ),
                      Text(
                        'My Account',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => MyAccountPage()));
                  },
                ),
              ],
            ),
          ),
          body: SingleChildScrollView(
              child: Padding(
            //padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 15.0),
            padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical:15.0),
            child: Column(children: [
              //_buildList(),
              Center(
                child: Container(
                  width: MediaQuery.of(context).size.width / 1.1,
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

                      ///
                      /*
                      SizedBox(
                          height: 20,
                          //width: 80,
                          width: MediaQuery.of(context).size.width / 7,

                          child: IconButton(
                            icon: _searchIcon,
                            onPressed: _searchPressed,
                          ),
                      ),
                       */
                      ///

                      SizedBox(
                        height: 20,
                        //width: 80,
                        width: MediaQuery.of(context).size.width / 7,

                        child: Image.asset("assets/img_27.png")//
                      ),

                      SizedBox(
                        height: 20,
                        //width: 230,
                        width: MediaQuery.of(context).size.width * 4 / 6.5,
                        child: Image.asset("assets/img_29.png"),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 7,
                        height: 20,
                        //width: 100,
                        child: InkWell(
                          onTap: () {
                            //Navigator.push(context, MaterialPageRoute(builder: (context) => GroceryOfferPage()));
                            if (!scaffoldKey.currentState!.isDrawerOpen) {
                              //check if drawer is closed
                              scaffoldKey.currentState!.openDrawer(); //open drawer
                            }
                          },
                          child: Container(child: Image.asset("assets/img_184.png")),
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
                          style: TextStyle(
                            color: Color(0xFF515151),
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            fontFamily: "CeraProBold",
                          ),
                        ),
                        Container(
                            height: 10,
                            child: Image.asset(
                              "assets/img_50.png",
                              height: 5,
                            )),
                      ],
                    ),
                  ),
                ),
              ),

              SizedBox(
                height: 5,
              ),

              // top banner
              Container(
                //width: 320.0,
                width: MediaQuery.of(context).size.width / 1,
                height: 185.0,
                decoration: const BoxDecoration(image: DecorationImage(image: AssetImage("assets/img_32.png"), fit: BoxFit.cover)),

                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                    ),
                    Container(width: MediaQuery.of(context).size.width / 2.5, child: Image.asset("assets/img_33.png")),
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                    ),
                    Center(
                      child: Container(
                        width: MediaQuery.of(context).size.width / 2,
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

              SizedBox(
                height: 20,
              ),

              // Offer For you
              SizedBox(
                width: MediaQuery.of(context).size.width / 1.1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Text(
                        "Offer for you",
                        style: TextStyle(color: Color(0xFF515151), fontSize: 22, fontWeight: FontWeight.w700, fontFamily: "CeraProBold"),
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
              SizedBox(
                height: 15,
              ),



              /*
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
              */



              Padding(
                padding: const EdgeInsets.fromLTRB(5,5,5,0),
                child: Container(

                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(15),
                  ),
                    width: MediaQuery.of(context).size.width/1.1,
                    //height: MediaQuery.of(context).size.height/3.5,
                   // height: MediaQuery.of(context).size.height/3.6,
                    child: Carousel(
                        images: [
                          Image.asset("assets/p1.jpg"),
                          Image.asset("assets/p2.jpg"),
                          Image.asset("assets/p3.jpg"),
                          Image.asset("assets/p4.jpg"),
                          Image.asset("assets/p5.jpg"),
                          Image.asset("assets/p6.jpg"),
                          Image.asset("assets/p7.jpg"),

                        ],

                        autoplay: true,
                        dotSize: 0,
                        dotSpacing: 0,
                        //dotColor: Colors.lightGreenAccent,
                        indicatorBgPadding: 0,
                        //dotBgColor: Colors.purple.withOpacity(0.5),
                        borderRadius: false,
                        //moveIndicatorFromBottom: 180.0,
                        overlayShadow: false,
                        autoplayDuration: const Duration(seconds: 4)


                    )
                ),
              ),


              /*
              options: CarouselOptions(
      height: 400,
      aspectRatio: 16/9,
      viewportFraction: 0.8,
      initialPage: 0,
      enableInfiniteScroll: true,
      reverse: false,
      autoPlay: true,
      autoPlayInterval: Duration(seconds: 3),
      autoPlayAnimationDuration: Duration(milliseconds: 800),
      autoPlayCurve: Curves.fastOutSlowIn,
      enlargeCenterPage: true,
      onPageChanged: callbackFunction,
      scrollDirection: Axis.horizontal,
   )
              */


              /*
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
              */



              SizedBox(
                height: 30,
              ),
              // shop by category
              Container(
                ///height: height,
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
                            style:
                                TextStyle(color: Color(0xFF515151), fontSize: 22, fontWeight: FontWeight.w700, fontFamily: "CeraProBold"),
                          ),
                        ),

                        SizedBox(
                          height: 12,
                        ),

                        Container(
                          height: height * 0.24,
                          width: width,
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: categoryData.length,
                            itemBuilder: (_, index) {
                              if (value.toString() != index.toString()) {
                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      value = index.toString();
                                      categoryDataItem = categoryData[index].name;
                                      log(categoryData[index].links.products);
                                      getProductsAfterTap(categoryData[index].links.products);
                                    });
                                  },
                                  child: Container(
                                    width: width * 0.35,
                                    margin: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                                    decoration: BoxDecoration(
                                      color: Colors.grey.withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        //sized10,
                                        SizedBox(
                                          height: 15,
                                        ),

                                        Expanded(
                                            child: categoryData[index].mobileBanner.isEmpty
                                                ?
                                                //Text("OK"):
                                                Image.asset("assets/app_logo.png")
                                                : Image.network(imagePath + categoryData[index].mobileBanner)),

                                        ///Expanded(child: Image.network(imagePath+categoryData[index].largeBanner)),

                                        sized10,
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                            2,
                                            2,
                                            0,
                                            5,
                                          ),
                                          child: Container(
                                            //height: MediaQuery.of(context).size.height/20,
                                            height: MediaQuery.of(context).size.height / 14,
                                            child: Text(
                                              categoryData[index].name,
                                              style: TextStyle(color: Color(0xFF515151), fontWeight: FontWeight.w700, fontSize: 16),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              } else {
                                return Container(
                                  width: width * 0.35,
                                  margin: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      //sized10,
                                      SizedBox(
                                        height: 15,
                                      ),

                                      Expanded(
                                          child: categoryData[index].mobileBanner.isEmpty
                                              ?
                                              //Text("OK"):
                                              Image.asset("assets/app_logo.png")
                                              : Image.network(imagePath + categoryData[index].mobileBanner)),
                                      sized10,
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                          2,
                                          2,
                                          0,
                                          5,
                                        ),
                                        child: Container(
                                          //height: MediaQuery.of(context).size.height/20,
                                          height: MediaQuery.of(context).size.height / 14,
                                          child: Text(
                                            categoryData[index].name,
                                            style: TextStyle(color: Color(0xFF515151), fontWeight: FontWeight.w700, fontSize: 16),
                                            textAlign: TextAlign.center,
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

                        SizedBox(
                          height: 10,
                        ),

                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "$categoryDataItem",
                            style:
                                TextStyle(color: Color(0xFF515151), fontSize: 22, fontWeight: FontWeight.w700, fontFamily: "CeraProBold"),
                          ),
                        ),

                        SizedBox(
                          height: 20,
                        ),

                        ////////////////////////////////////////////////////////
                        Container(
                          height: MediaQuery.of(context).size.height / 3,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemCount: categoryProducts.length,
                            itemBuilder: (_, index) {
                              return GestureDetector(
                                onTap: () {
                                  //log(categoryProducts[index].links.details);
                                  /*setState(() {
                                        value=index.toString();

                                        getProductsAfterTap(categoryData[index].links.products);
                                      });*/
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: Container(
                                    decoration: BoxDecoration(color: Color(0xFFF1EDF2), borderRadius: BorderRadius.circular(15.0)),
                                    //height: MediaQuery.of(context).size.height/3.2,
                                    width: MediaQuery.of(context).size.width / 2.34,
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
                                        InkWell(
                                          onTap: () {
                                            Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) => GroceryDetails(
                                                          detailsLink: groceryProducts[index].links.details,
                                                          relatedProductLink: relatedProductsLink,
                                                        )));
                                          },
                                          child: Container(
                                            child: Image.network(imagePath + categoryProducts[index].thumbnailImage),
                                            height: MediaQuery.of(context).size.height / 8,
                                            width: MediaQuery.of(context).size.width / 2.34,
                                          ),
                                        ),
                                        FittedBox(
                                          child: Container(
                                            ///height: height! * 0.08,
                                            width: MediaQuery.of(context).size.width / 2.36,
                                            height: MediaQuery.of(context).size.height / 16,
                                            child: Padding(
                                              padding: const EdgeInsets.fromLTRB(5, 5, 5, 0),
                                              child: Text(
                                                categoryProducts[index].name,
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
                                              "5 lit",
                                              style: TextStyle(color: Colors.grey.withOpacity(0.9)),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                          child: Center(
                                            child: Container(
                                              //height: MediaQuery.of(context).size.height/32,
                                              height: MediaQuery.of(context).size.height / 31.5,
                                              width: MediaQuery.of(context).size.width / 2.34,
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                children: [
                                                  Container(
                                                    child: Image.asset("assets/p.png"),
                                                    height: 20,
                                                    width: 22,
                                                  ),
                                                  Text(categoryProducts[index].basePrice.toString(),
                                                      style:
                                                          TextStyle(color: Color(0xFF515151), fontSize: 16, fontWeight: FontWeight.w700)),
                                                  Text(categoryProducts[index].baseDiscountedPrice.toString(),
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
                                                      Navigator.push(context, MaterialPageRoute(builder: (context) => CartDetails()));
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
                                          //height: MediaQuery.of(context).size.height/26,
                                          height: MediaQuery.of(context).size.height / 21,
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
                                ),
                              );
                            },
                          ),
                        ),
                        /////////////////////////////////////////////////////////

                        SizedBox(
                          height: 35,
                        ),
                      ]),
                    ),
                  ],
                ),
              ),

              SizedBox(
                height: 30,
              ),
              //1-99 store
              Container(
                width: MediaQuery.of(context).size.width / 1,
                //margin: EdgeInsets.symmetric(horizontal: 5.0),
                decoration: BoxDecoration(color: kPrimaryColor, borderRadius: BorderRadius.circular(10.0)),
                child: Padding(
                  //padding: const EdgeInsets.all(10),
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "1-99 Store",
                            style: TextStyle(fontFamily: "CeraProBold", fontSize: 22, color: Colors.white, fontWeight: FontWeight.w700),
                          ),
                          Text(
                            "VIEW ALL",
                            style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                      sized10,
                      Container(
                        //width: MediaQuery.of(context).size.width/1,
                        child: Center(
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
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700, fontFamily: "CeraProBold"),
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
                      ),
                      sized10,
                      Padding(
                        padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                        child: Container(
                          //height: height*0.31,
                          height: height * 0.33,
                          width: width,
                          child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: oneTwoNinentyNineData.length,
                              itemBuilder: (_, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: Container(
                                    decoration: BoxDecoration(color: Color(0xFFF1EDF2), borderRadius: BorderRadius.circular(15.0)),
                                    //height: MediaQuery.of(context).size.height/3.2,
                                    width: MediaQuery.of(context).size.width / 2.34,
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
                                        InkWell(
                                          onTap: () {},
                                          child: InkWell(
                                            /*onTap: (){
                                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => GroceryDetails(
                                                detailsLink:  oneTwoNinentyNineData[index].links.details ,
                                              )));
                                            },*/
                                            child: Container(
                                              child: Image.network(imagePath + oneTwoNinentyNineData[index].image.toString()),
                                              height: MediaQuery.of(context).size.height / 8,
                                              width: MediaQuery.of(context).size.width / 2.34,
                                            ),
                                          ),
                                        ),
                                        FittedBox(
                                          child: Container(
                                            ///height: height! * 0.08,
                                            width: MediaQuery.of(context).size.width / 2.36,
                                            height: MediaQuery.of(context).size.height / 17,
                                            child: Padding(
                                              padding: const EdgeInsets.fromLTRB(5, 5, 5, 0),
                                              child: Text(
                                                oneTwoNinentyNineData[index].name.toString(),
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
                                              "5 lit",
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
                                                  Text(oneTwoNinentyNineData[index].disCountPrice.toString(),
                                                      style:
                                                          TextStyle(color: Color(0xFF515151), fontSize: 16, fontWeight: FontWeight.w700)),
                                                  Text(oneTwoNinentyNineData[index].basePrice.toString(),
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
                                                      Navigator.push(context, MaterialPageRoute(builder: (context) => CartDetails()));
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
                                          height: MediaQuery.of(context).size.height / 21,
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
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(
                height: 30,
              ),
              CategoryContainer(categoryName: "Grocery",
                  nameNo: '4',large_Banner: groceryLargeBanner),

              SizedBox(
                height: 30,
              ),
              CategoryContainer(categoryName: "Dairy & Beverage", nameNo: '7',large_Banner: ""),

              //big sale banner
              SizedBox(
                height: 30,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => OfferPage()));
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

              SizedBox(
                height: 30,
              ),
              CategoryContainer(categoryName: "Mother & Baby", nameNo: '8',large_Banner: ""),

              SizedBox(
                height: 30,
              ),
              CategoryContainer(categoryName: "Fruits & Vegetables", nameNo: '9',large_Banner: ""),

              SizedBox(
                height: 30,
              ),
              //combo offer banner
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage("assets/img_69.png"), fit: BoxFit.cover), //69
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

              SizedBox(
                height: 30,
              ),
              CategoryContainer(categoryName: "Personal Care", nameNo: '10',large_Banner: ""),

              SizedBox(
                height: 30,
              ),
              CategoryContainer(categoryName: "Bread Biscuit & Snacks", nameNo: '11',large_Banner: breadLargeBanner),

              SizedBox(
                height: 30,
              ),
              //mega deal banner
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
                height: 30,
              ),
              CategoryContainer(categoryName: "Household", nameNo: '13',large_Banner: ""),

              SizedBox(
                height: 30,
              ),
              CategoryContainer(categoryName: "Chocolate & Sweets", nameNo: '46',large_Banner: ""),

              SizedBox(
                height: 30,
              ),
              //big sale offer
              InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => OfferPage()));
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

              SizedBox(
                height: 30,
              ),
              CategoryContainer(categoryName: "Toys & Gift", nameNo: '14',large_Banner: ""),

              SizedBox(
                height: 30,
              ),
              CategoryContainer(categoryName: "Stationery", nameNo: '199',large_Banner: ""),

              SizedBox(
                height: 35,
              ),

              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  image: DecorationImage(image: AssetImage("assets/img_72.png"), fit: BoxFit.cover),
                  color: Colors.white,
                ),
                height: 130,
                width: MediaQuery.of(context).size.width / 1.1,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                  child: Image.asset("assets/img_73.png"),
                ),
              ),

              sized20,

              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Didn't find\nwhat you\nwere looking for?",
                    style: TextStyle(color: Color(0xFFB99DCB), fontSize: 28, fontWeight: FontWeight.bold, fontFamily: "CeraProBold"),
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
                height: height * 0.14,
                //width: width,
                width: MediaQuery.of(context).size.width / 1.1,
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
          )),

          floatingActionButton: FloatingActionButton(
              elevation: 0.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //Icon(Icons.add_shopping_cart),

                  Center(child: Image.asset("assets/pi.png",)),


                  Text(demo.length.toString(),

                  ),
                ],
              ),
              backgroundColor: kPrimaryColor,
              onPressed: () {

                Navigator.push(context, MaterialPageRoute(builder: (context) => CartDetails()));
              }
          ),
        ),



             );
  }
}











/*
import 'dart:convert';
import 'dart:developer';
import 'package:customer_ui/HomePage/grocer_offer/grocery_offer_page.dart';
import 'package:customer_ui/HomePage/offer/offer_page.dart';
import 'package:customer_ui/OthersPage/all_offerpage.dart';
import 'package:customer_ui/OthersPage/cart_details1st_page.dart';
import 'package:customer_ui/OthersPage/myOrders.dart';
import 'package:customer_ui/OthersPage/myaccopunt.dart';
import 'package:customer_ui/OthersPage/requestProduct.dart';
import 'package:customer_ui/OthersPage/tarck_order.dart';
import 'package:customer_ui/OthersPage/wallet.dart';
import 'package:customer_ui/components/size_config.dart';
import 'package:customer_ui/components/styles.dart';
import 'package:customer_ui/components/utils.dart';
import 'package:customer_ui/dataModel/category_data_model.dart';
import 'package:customer_ui/dataModel/chocolate_sweet_data_model.dart';
import 'package:customer_ui/dataModel/one_ninetynine_data_model.dart';
import 'package:customer_ui/widgets/category_container.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dropdown/flutter_dropdown.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import '../HomePage/offer_widget.dart';
import 'HomePage/grocer_offer/grocery_details.dart';
import 'dataModel/cart_details_model.dart';
import 'dataModel/city_model.dart';

class CategoryHomeScreenRuf extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<CategoryHomeScreenRuf> {

  ///

  ///

  var value;
  var Cart;


  Future<dynamic> buildShowDialog(BuildContext context, String areaName) {
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    return showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            backgroundColor: Color(0xFFF4EFF5),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Container(
              height: 215,
              padding: EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Container(
                          width: MediaQuery.of(context).size.width / 6,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Text(
                              "City",
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Color(0xFF515151)),
                            ),
                          )),
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width / 1.8,
                          //width: 100,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Color(0xFFFFFFFF)),
                          child: Padding(
                            padding: const EdgeInsets.only(right: 10.0),
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: DropDown(
                                items: [
                                  selectDhaka,
                                ],
                                hint: Text(
                                  "",
                                ),
                                icon: Padding(
                                  padding: const EdgeInsets.only(left: 100.0),
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Icon(
                                      Icons.expand_more,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                //onChanged: print,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Container(
                          width: MediaQuery.of(context).size.width / 6,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Text(
                              "Area",
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Color(0xFF515151)),
                            ),
                          )),
                      Container(
                        width: MediaQuery.of(context).size.width / 1.8,
                        height: 50,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Color(0xFFFFFFFF)),
                        child: Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: DropDown(
                              items: cityData,
                              hint: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                    color: Colors.teal,
                                    child: Text(
                                      cityData[0],
                                    )),
                              ),
                              icon: Padding(
                                padding: const EdgeInsets.only(left: 70.0),
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Icon(
                                    Icons.expand_more,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              onChanged: print,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Container(
                          width: MediaQuery.of(context).size.width / 6,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Text(""),
                          )),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width / 1.8,
                          height: 50,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Color(0xFF9900FF)),
                          child: Center(
                              child: Text(
                            "Submit",
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          )),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }


  @override
  void initState() {
    // TODO: implement initState
    getCartName();
    getCityName();
    getCategory();
    getOneTo99Data();
  }


  var demo=[];
  Future<void> getCartName() async {
    var res = await http.post(Uri.parse("https://test.protidin.com.bd/api/v2/carts/61"),
        headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8', 'Authorization': 'Bearer $authToken'});
    // log("Response ${res.body}");
    log("Response code ${res.statusCode}");

    var dataMap=jsonDecode(res.body);
    log(dataMap[0].toString());
    var cartModel=CartDetailsModel.fromJson(dataMap[0]);
    demo=cartModel.cartItems;
    log("cart added ${cartModel.cartItems.length} product");
    //demo=dataMap;
    setState(() {

    });
    //log("demo length "+demo.length.toString());
  }


  List<String> cityData = [];
  var selectDhaka = " ";
  Future<void> getCityName() async {
    String productURl = "https://test.protidin.com.bd/api/v2/cities";

    final response = await get(Uri.parse(productURl), headers: {"Accept": "application/json"});

    var dataMap = jsonDecode(response.body);

    if (dataMap["success"] == true) {
      log("data valid");
      //
      var cityModel = CityModel.fromJson(dataMap);

      //cityData=cityModel.data;
      for (var element in cityModel.data) {
        cityData.add(element.area);
      }
      selectDhaka = cityModel.data[0].name;
      //cityData.removeAt(0);

      setState(() {});

      //log("city data length ${cityData.length}");
      log("AREA NAME $selectDhaka");
      buildShowDialog(context, selectDhaka);
    } else {
      log("data invalid");
    }
  }


  var relatedProductsLink = " ";
  Future<void> addToCart(id, userId, quantity) async {
    var res = await http.post(Uri.parse("https://test.protidin.com.bd/api/v2/carts/add"),
        headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8', 'Authorization': 'Bearer $authToken'},
        body: jsonEncode(<String, dynamic>{"id": id, "variant": "", "user_id": userId, "quantity": quantity}));
    log("Response ${res.body}");
    log("Response code jhjk ${res.statusCode}");

  }


  var categoryData = [];
  var categoryDataItem = " ";
  Future<void> getCategory() async {
    log("comes");
    String productURl = "https://test.protidin.com.bd/api/v2/categories/home";

    final response = await get(Uri.parse(productURl), headers: {"Accept": "application/json"});

    var dataMap = jsonDecode(response.body);

    if (dataMap["success"] == true) {
      log("data valid");

      //
      var categoryDataModel = CategoryDataModel.fromJson(dataMap);
      categoryData = categoryDataModel.data;
      categoryDataItem = categoryDataModel.data[0].name;
      await getProductsAfterTap(categoryDataModel.data[0].links.products);
      setState(() {});
      log("data length ${categoryData.length}");
    } else {
      log("data invalid");
    }

    // log("after decode $dataMap");
  }


  List<BuiscitData> categoryProducts = [];
  Future<void> getProductsAfterTap(link) async {
    log("calling 2");
    //String biscuitSweetsURl = "https://test.protidin.com.bd/api/v2/products/category/46";

    final response6 = await get(Uri.parse(link), headers: {"Accept": "application/json"});

    var biscuitSweetsDataMap = jsonDecode(response6.body);

    if (biscuitSweetsDataMap["success"] == true) {
      //log("category data after tap $biscuitSweetsDataMap");

      setState(() {
        var biscuitSweetsDataModel = BiacuitSweets.fromJson(biscuitSweetsDataMap);
        categoryProducts = biscuitSweetsDataModel.data;
      });
      log("categoryProducts data length ${categoryProducts.length}");
    } else {
      log("data invalid");
    }

    // log("after decode $dataMap");
  }


  var groceryProducts = [];
  Future<void> getGroceryProductsAfterTap(link2) async {
    log("calling after tap");
    //String biscuitSweetsURl = "https://test.protidin.com.bd/api/v2/products/category/46";

    final response7 = await get(Uri.parse(link2), headers: {"Accept": "application/json"});

    var groceryItemDataMap = jsonDecode(response7.body);

    if (groceryItemDataMap["success"] == true) {
      //log("category data after tap $biscuitSweetsDataMap");

      var groceryData = BiacuitSweets.fromJson(groceryItemDataMap);
      groceryProducts = groceryData.data;
      //relatedProductsLink=groceryProducts[0].links.products;

      setState(() {});

      log("after tap grocery data length ${groceryProducts.length}");
    } else {
      log("data invalid");
    }

    // log("after decode $dataMap");
  }


  List<OneToNinentyNineDataModel> oneTwoNinentyNineData = [];
  Future<void> getOneTo99Data() async {
    log("1 to 99 data");

    final response12 =
        await get(Uri.parse("https://test.protidin.com.bd/api/v2/products/category/4"), headers: {"Accept": "application/json"});

    var oneTwoNinentyNineItemDataMap = jsonDecode(response12.body);

    if (oneTwoNinentyNineItemDataMap["success"] == true) {
      //log("category data after tap $biscuitSweetsDataMap");

      setState(() {
        var onToNinetyNine = BiacuitSweets.fromJson(oneTwoNinentyNineItemDataMap);

        //oneTwoNinentyNineData=onToNinetyNine.data;

        for (var i = 0; i < onToNinetyNine.data.length; i++) {
          if (int.parse(onToNinetyNine.data[i].basePrice.substring(1)) <= 99) {
            log("price between 1-99: ${onToNinetyNine.data[i].basePrice}");

            oneTwoNinentyNineData.add(OneToNinentyNineDataModel(
              name: onToNinetyNine.data[i].name,
              basePrice: onToNinetyNine.data[i].basePrice,
              disCountPrice: onToNinetyNine.data[i].baseDiscountedPrice,
              image: onToNinetyNine.data[i].thumbnailImage,
              id: onToNinetyNine.data[i].id,
              discount: onToNinetyNine.data[i].discount,
              unit: onToNinetyNine.data[i].unit,
            ));
          } else {
            // log("price not between 1-99: ${onToNinetyNine.data[i].basePrice}");
          }
        }
      });
      //log("1-99 data length ${oneTwoNinentyNineData.length}");

    } else {
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
      key: scaffoldKey,
      child: Scaffold(


          drawer: Drawer(
            child: ListView(
              // Important: Remove any padding from the ListView.
              padding: EdgeInsets.zero,
              children: <Widget>[
                DrawerHeader(
                  child: Container(
                    height: 200,
                    width: MediaQuery.of(context).size.width / 1.2,
                    child: Column(children: [
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        //mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            //color: Colors.white,
                            height: 60,
                            width: 60,
                            child: Image.asset(
                              "assets/img_135.png",
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                          ),
                          Container(
                            width: 120,
                            child: Column(
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Welcome ",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Md. Abcdef ghijkl",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ]),
                  ),
                  decoration: BoxDecoration(
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
                        child: Image.asset(
                          "assets/img_149.png",
                          color: Colors.black,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                      ),
                      Text(
                        'Track Order',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
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
                        child: Image.asset(
                          "assets/img_150.png",
                          color: Colors.black,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                      ),
                      Text(
                        'My Orders',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
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
                        child: Image.asset(
                          "assets/img_151.png",
                          color: Colors.black,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                      ),
                      Text(
                        'Categories',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => GroceryOfferPage()));
                  },
                ),
                ListTile(
                  title: Row(
                    children: [
                      Container(
                        //color: Colors.white,
                        height: 20,
                        width: 20,
                        child: Image.asset(
                          "assets/img_152.png",
                          color: Colors.black,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                      ),
                      Text(
                        'Wallet',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
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
                        child: Image.asset(
                          "assets/img_153.png",
                          color: Colors.black,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                      ),
                      Text(
                        'Request a product',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
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
                        child: Image.asset(
                          "assets/img_149.png",
                          color: Colors.black,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                      ),
                      Text(
                        'Call to order',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
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
                        child: Image.asset(
                          "assets/img_154.png",
                          color: Colors.black,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                      ),
                      Text(
                        'My Account',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => MyAccountPage()));
                  },
                ),
              ],
            ),
          ),


          backgroundColor: Color(0xFFE5E5E5),
          //backgroundColor: Colors.indigo[50],
          body: SingleChildScrollView(
              child: Padding(
            //padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
            padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 15.0),
            child: Column(children: [
              //_buildList(),
              Center(
                child: Container(
                  width: MediaQuery.of(context).size.width / 1.1,
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

                      ///
                      /*
                      SizedBox(
                          height: 20,
                          //width: 80,
                          width: MediaQuery.of(context).size.width / 7,

                          child: IconButton(
                            icon: _searchIcon,
                            onPressed: _searchPressed,
                          ),
                      ),
                       */
                      ///

                      SizedBox(
                        height: 20,
                        //width: 80,
                        width: MediaQuery.of(context).size.width / 7,

                        child: Image.asset("assets/img_27.png")//
                      ),

                      SizedBox(
                        height: 20,
                        //width: 230,
                        width: MediaQuery.of(context).size.width * 4 / 6.5,
                        child: Image.asset("assets/img_29.png"),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 7,
                        height: 20,
                        //width: 100,
                        child: InkWell(
                          onTap: () {
                            //Navigator.push(context, MaterialPageRoute(builder: (context) => GroceryOfferPage()));
                            if (!scaffoldKey.currentState!.isDrawerOpen) {
                              //check if drawer is closed
                              scaffoldKey.currentState!.openDrawer(); //open drawer
                            }
                          },
                          child: Container(child: Image.asset("assets/img_184.png")),
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
                          style: TextStyle(
                            color: Color(0xFF515151),
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            fontFamily: "CeraProBold",
                          ),
                        ),
                        Container(
                            height: 10,
                            child: Image.asset(
                              "assets/img_50.png",
                              height: 5,
                            )),
                      ],
                    ),
                  ),
                ),
              ),

              SizedBox(
                height: 5,
              ),

              // top banner
              Container(
                //width: 320.0,
                width: MediaQuery.of(context).size.width / 1,
                height: 185.0,
                decoration: const BoxDecoration(image: DecorationImage(image: AssetImage("assets/img_32.png"), fit: BoxFit.cover)),

                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                    ),
                    Container(width: MediaQuery.of(context).size.width / 2.5, child: Image.asset("assets/img_33.png")),
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                    ),
                    Center(
                      child: Container(
                        width: MediaQuery.of(context).size.width / 2,
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

              SizedBox(
                height: 20,
              ),

              // Offer For you
              SizedBox(
                width: MediaQuery.of(context).size.width / 1.1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Text(
                        "Offer for you",
                        style: TextStyle(color: Color(0xFF515151), fontSize: 22, fontWeight: FontWeight.w700, fontFamily: "CeraProBold"),
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
              SizedBox(
                height: 15,
              ),
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
                height: 30,
              ),
              // shop by category
              Container(
                ///height: height,
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
                            style:
                                TextStyle(color: Color(0xFF515151), fontSize: 22, fontWeight: FontWeight.w700, fontFamily: "CeraProBold"),
                          ),
                        ),

                        SizedBox(
                          height: 12,
                        ),

                        Container(
                          height: height * 0.24,
                          width: width,
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: categoryData.length,
                            itemBuilder: (_, index) {
                              if (value.toString() != index.toString()) {
                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      value = index.toString();
                                      categoryDataItem = categoryData[index].name;
                                      log(categoryData[index].links.products);
                                      getProductsAfterTap(categoryData[index].links.products);
                                    });
                                  },
                                  child: Container(
                                    width: width * 0.35,
                                    margin: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                                    decoration: BoxDecoration(
                                      color: Colors.grey.withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        //sized10,
                                        SizedBox(
                                          height: 15,
                                        ),

                                        Expanded(
                                            child: categoryData[index].mobileBanner.isEmpty
                                                ?
                                                //Text("OK"):
                                                Image.asset("assets/app_logo.png")
                                                : Image.network(imagePath + categoryData[index].mobileBanner)),

                                        ///Expanded(child: Image.network(imagePath+categoryData[index].largeBanner)),

                                        sized10,
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                            2,
                                            2,
                                            0,
                                            5,
                                          ),
                                          child: Container(
                                            //height: MediaQuery.of(context).size.height/20,
                                            height: MediaQuery.of(context).size.height / 14,
                                            child: Text(
                                              categoryData[index].name,
                                              style: TextStyle(color: Color(0xFF515151), fontWeight: FontWeight.w700, fontSize: 16),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              } else {
                                return Container(
                                  width: width * 0.35,
                                  margin: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      //sized10,
                                      SizedBox(
                                        height: 15,
                                      ),

                                      Expanded(
                                          child: categoryData[index].mobileBanner.isEmpty
                                              ?
                                              //Text("OK"):
                                              Image.asset("assets/app_logo.png")
                                              : Image.network(imagePath + categoryData[index].mobileBanner)),
                                      sized10,
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                          2,
                                          2,
                                          0,
                                          5,
                                        ),
                                        child: Container(
                                          //height: MediaQuery.of(context).size.height/20,
                                          height: MediaQuery.of(context).size.height / 14,
                                          child: Text(
                                            categoryData[index].name,
                                            style: TextStyle(color: Color(0xFF515151), fontWeight: FontWeight.w700, fontSize: 16),
                                            textAlign: TextAlign.center,
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

                        SizedBox(
                          height: 10,
                        ),

                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "$categoryDataItem",
                            style:
                                TextStyle(color: Color(0xFF515151), fontSize: 22, fontWeight: FontWeight.w700, fontFamily: "CeraProBold"),
                          ),
                        ),

                        SizedBox(
                          height: 20,
                        ),

                        ////////////////////////////////////////////////////////
                        Container(
                          height: MediaQuery.of(context).size.height / 3,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemCount: categoryProducts.length,
                            itemBuilder: (_, index) {
                              return GestureDetector(
                                onTap: () {
                                  //log(categoryProducts[index].links.details);
                                  /*setState(() {
                                        value=index.toString();

                                        getProductsAfterTap(categoryData[index].links.products);
                                      });*/
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: Container(
                                    decoration: BoxDecoration(color: Color(0xFFF1EDF2), borderRadius: BorderRadius.circular(15.0)),
                                    //height: MediaQuery.of(context).size.height/3.2,
                                    width: MediaQuery.of(context).size.width / 2.34,
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
                                        InkWell(
                                          onTap: () {
                                            Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) => GroceryDetails(
                                                          detailsLink: groceryProducts[index].links.details,
                                                          relatedProductLink: relatedProductsLink,
                                                        )));
                                          },
                                          child: Container(
                                            child: Image.network(imagePath + categoryProducts[index].thumbnailImage),
                                            height: MediaQuery.of(context).size.height / 8,
                                            width: MediaQuery.of(context).size.width / 2.34,
                                          ),
                                        ),
                                        FittedBox(
                                          child: Container(
                                            ///height: height! * 0.08,
                                            width: MediaQuery.of(context).size.width / 2.36,
                                            height: MediaQuery.of(context).size.height / 16,
                                            child: Padding(
                                              padding: const EdgeInsets.fromLTRB(5, 5, 5, 0),
                                              child: Text(
                                                categoryProducts[index].name,
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
                                              "5 lit",
                                              style: TextStyle(color: Colors.grey.withOpacity(0.9)),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                          child: Center(
                                            child: Container(
                                              //height: MediaQuery.of(context).size.height/32,
                                              height: MediaQuery.of(context).size.height / 31.5,
                                              width: MediaQuery.of(context).size.width / 2.34,
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                children: [
                                                  Container(
                                                    child: Image.asset("assets/p.png"),
                                                    height: 20,
                                                    width: 22,
                                                  ),
                                                  Text(categoryProducts[index].basePrice.toString(),
                                                      style:
                                                          TextStyle(color: Color(0xFF515151), fontSize: 16, fontWeight: FontWeight.w700)),
                                                  Text(categoryProducts[index].baseDiscountedPrice.toString(),
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
                                                      Navigator.push(context, MaterialPageRoute(builder: (context) => CartDetails()));
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
                                          //height: MediaQuery.of(context).size.height/26,
                                          height: MediaQuery.of(context).size.height / 21,
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
                                ),
                              );
                            },
                          ),
                        ),
                        /////////////////////////////////////////////////////////

                        SizedBox(
                          height: 35,
                        ),
                      ]),
                    ),
                  ],
                ),
              ),

              SizedBox(
                height: 30,
              ),
              //1-99 store
              Container(
                width: MediaQuery.of(context).size.width / 1,
                //margin: EdgeInsets.symmetric(horizontal: 5.0),
                decoration: BoxDecoration(color: kPrimaryColor, borderRadius: BorderRadius.circular(10.0)),
                child: Padding(
                  //padding: const EdgeInsets.all(10),
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "1-99 Store",
                            style: TextStyle(fontFamily: "CeraProBold", fontSize: 22, color: Colors.white, fontWeight: FontWeight.w700),
                          ),
                          Text(
                            "VIEW ALL",
                            style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                      sized10,
                      Container(
                        //width: MediaQuery.of(context).size.width/1,
                        child: Center(
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
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700, fontFamily: "CeraProBold"),
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
                      ),
                      sized10,
                      Padding(
                        padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                        child: Container(
                          //height: height*0.31,
                          height: height * 0.33,
                          width: width,
                          child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: oneTwoNinentyNineData.length,
                              itemBuilder: (_, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: Container(
                                    decoration: BoxDecoration(color: Color(0xFFF1EDF2), borderRadius: BorderRadius.circular(15.0)),
                                    //height: MediaQuery.of(context).size.height/3.2,
                                    width: MediaQuery.of(context).size.width / 2.34,
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
                                        InkWell(
                                          onTap: () {},
                                          child: InkWell(
                                            /*onTap: (){
                                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => GroceryDetails(
                                                detailsLink:  oneTwoNinentyNineData[index].links.details ,
                                              )));
                                            },*/
                                            child: Container(
                                              child: Image.network(imagePath + oneTwoNinentyNineData[index].image.toString()),
                                              height: MediaQuery.of(context).size.height / 8,
                                              width: MediaQuery.of(context).size.width / 2.34,
                                            ),
                                          ),
                                        ),
                                        FittedBox(
                                          child: Container(
                                            ///height: height! * 0.08,
                                            width: MediaQuery.of(context).size.width / 2.36,
                                            height: MediaQuery.of(context).size.height / 17,
                                            child: Padding(
                                              padding: const EdgeInsets.fromLTRB(5, 5, 5, 0),
                                              child: Text(
                                                oneTwoNinentyNineData[index].name.toString(),
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
                                              "5 lit",
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
                                                  Text(oneTwoNinentyNineData[index].disCountPrice.toString(),
                                                      style:
                                                          TextStyle(color: Color(0xFF515151), fontSize: 16, fontWeight: FontWeight.w700)),
                                                  Text(oneTwoNinentyNineData[index].basePrice.toString(),
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
                                                      Navigator.push(context, MaterialPageRoute(builder: (context) => CartDetails()));
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
                                          height: MediaQuery.of(context).size.height / 21,
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
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(
                height: 30,
              ),
              CategoryContainer(categoryName: "Grocery", nameNo: '4'),

              SizedBox(
                height: 30,
              ),
              CategoryContainer(categoryName: "Dairy & Beverage", nameNo: '7'),

              //big sale banner
              SizedBox(
                height: 30,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => OfferPage()));
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

              SizedBox(
                height: 30,
              ),
              CategoryContainer(categoryName: "Mother & Baby", nameNo: '8'),

              SizedBox(
                height: 30,
              ),
              CategoryContainer(categoryName: "Fruits & Vegetables", nameNo: '9'),

              SizedBox(
                height: 30,
              ),
              //combo offer banner
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage("assets/img_69.png"), fit: BoxFit.cover), //69
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

              SizedBox(
                height: 30,
              ),
              CategoryContainer(categoryName: "Personal Care", nameNo: '10'),

              SizedBox(
                height: 30,
              ),
              CategoryContainer(categoryName: "Bread Biscuit & Snacks", nameNo: '11'),

              SizedBox(
                height: 30,
              ),
              //mega deal banner
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
                height: 30,
              ),
              CategoryContainer(categoryName: "Household", nameNo: '13'),

              SizedBox(
                height: 30,
              ),
              CategoryContainer(categoryName: "Chocolate & Sweets", nameNo: '46'),

              SizedBox(
                height: 30,
              ),
              //big sale offer
              InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => OfferPage()));
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

              SizedBox(
                height: 30,
              ),
              CategoryContainer(categoryName: "Toys & Gift", nameNo: '14'),

              SizedBox(
                height: 30,
              ),
              CategoryContainer(categoryName: "Stationery", nameNo: '199'),

              SizedBox(
                height: 35,
              ),

              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  image: DecorationImage(image: AssetImage("assets/img_72.png"), fit: BoxFit.cover),
                  color: Colors.white,
                ),
                height: 130,
                width: MediaQuery.of(context).size.width / 1.1,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                  child: Image.asset("assets/img_73.png"),
                ),
              ),

              sized20,

              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Didn't find\nwhat you\nwere looking for?",
                    style: TextStyle(color: Color(0xFFB99DCB), fontSize: 28, fontWeight: FontWeight.bold, fontFamily: "CeraProBold"),
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
                height: height * 0.14,
                //width: width,
                width: MediaQuery.of(context).size.width / 1.1,
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
          )),


          floatingActionButton:

                 FloatingActionButton(


                      elevation: 0.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          //Icon(Icons.add_shopping_cart),

                          Image.asset("assets/pi.png",),


                          Text(demo.length.toString(),

                          ),
                        ],
                      ),
                      backgroundColor: kPrimaryColor,
                      onPressed: () {

                        Navigator.push(context, MaterialPageRoute(builder: (context) => CartDetails()));
                      }
                      ),
               )


    );
  }
}


*/

/*
import 'dart:convert';
import 'dart:developer';

import 'package:customer_ui/HomePage/grocer_offer/grocery_offer_page.dart';
import 'package:customer_ui/HomePage/offer/offer_page.dart';
import 'package:customer_ui/OthersPage/all_offerpage.dart';
import 'package:customer_ui/OthersPage/cart_details1st_page.dart';
import 'package:customer_ui/OthersPage/myOrders.dart';
import 'package:customer_ui/OthersPage/myaccopunt.dart';
import 'package:customer_ui/OthersPage/requestProduct.dart';
import 'package:customer_ui/OthersPage/tarck_order.dart';
import 'package:customer_ui/OthersPage/wallet.dart';
import 'package:customer_ui/components/size_config.dart';
import 'package:customer_ui/components/styles.dart';
import 'package:customer_ui/components/utils.dart';
import 'package:customer_ui/dataModel/category_data_model.dart';
import 'package:customer_ui/dataModel/chocolate_sweet_data_model.dart';
import 'package:customer_ui/dataModel/one_ninetynine_data_model.dart';
import 'package:flutter/cupertino.dart';

//import 'package:customer_ui/dataModel/category_data_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dropdown/flutter_dropdown.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

import '../HomePage/offer_widget.dart';
import 'HomePage/grocer_offer/grocery_details.dart';
import 'dataModel/city_model.dart';

class CategoryHomeScreenRuf extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<CategoryHomeScreenRuf> {

  var value;
  var valueOne;
  var valueTwo;
  var valueThree;
  var valueFour;

///
  List<String> cityData=[];
  var selectDhaka=" ";

  Future<void> getCityName()async{
    String productURl = "https://test.protidin.com.bd/api/v2/cities";

    final response = await get(Uri.parse(productURl), headers: {"Accept": "application/json"});

    var dataMap = jsonDecode(response.body);

    if (dataMap["success"] == true) {
      log("data valid");
      //
      var cityModel = CityModel.fromJson(dataMap);

      //cityData=cityModel.data;
      for(var element in cityModel.data){
        cityData.add(element.area);
      }
      selectDhaka=cityModel.data[0].name;
      //cityData.removeAt(0);

      setState(() {});

      //log("city data length ${cityData.length}");
      log("AREA NAME $selectDhaka");
      buildShowDialog(context, selectDhaka);
    } else {
      log("data invalid");
    }

  }



  Future<dynamic> buildShowDialog(BuildContext context,String areaName) {
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );


    return showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            backgroundColor: Color(0xFFF4EFF5),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Container(
              height: 215,
              padding: EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(

                    children: [
                      Container(
                          width: MediaQuery.of(context).size.width/6,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Text("City",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: Color(0xFF515151)),),
                          )),
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width/1.8,
                          //width: 100,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Color(0xFFFFFFFF)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(right:10.0),
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: DropDown(
                                items: [selectDhaka,],
                                hint: Text("",),
                                icon: Padding(
                                  padding: const EdgeInsets.only(left: 100.0),
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Icon(
                                      Icons.expand_more,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                //onChanged: print,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 20,),

                  Row(
                    children: [
                      Container(
                          width: MediaQuery.of(context).size.width/6,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Text("Area",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: Color(0xFF515151)),),
                          )
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width/1.8,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                            color: Color(0xFFFFFFFF)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(right:10.0),
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: DropDown(
                              items: cityData,

                              hint:Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                    color: Colors.teal,
                                    child: Text(cityData[0],)),
                              ),
                              icon: Padding(
                                padding: const EdgeInsets.only(left: 70.0),
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Icon(
                                    Icons.expand_more,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              onChanged: print,

                            ),

                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 20,),

                  Row(

                    children: [
                      Container(
                          width: MediaQuery.of(context).size.width/6,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Text(""),
                          )
                      ),
                      InkWell(
                        onTap: (){
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width/1.8,
                          height: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Color(0xFF9900FF)
                          ),
                          child: Center(child: Text("Submit",style: TextStyle(fontSize: 16,color: Colors.white),)),
                        ),
                      )
                    ],
                  ),


                ],
              ),
            ),
          );
        }

        );

  }
///



  @override
  void initState() {
    // TODO: implement initState
    //getCityName();
    getCityName();
    getfruitsVegitable();
    getbabyMother();
    getFrouitsBeverage();
    getBreadBiscuit();
    getchocolateSweets();
    getGrocery(name: "17");
    getHouseholdData();
    getStationaryData();
    gettoyGiftData();
    getpersonalCarteData();
    getCategory();
    getOneTo99Data();
  }

  ///
  var categoryData = [];
  var categoryDataItem = " ";

  //List<City> cityData=[];
  //var selectDhaka=" ";

  //related products variable

  var relatedProductsLink=" ";

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
  }


  /*
  Future<void> getCityName()async{
    String productURl = "https://test.protidin.com.bd/api/v2/cities";

    final response = await get(Uri.parse(productURl), headers: {"Accept": "application/json"});

    var dataMap = jsonDecode(response.body);

    if (dataMap["success"] == true) {
      log("data valid");
      //
      var cityModel = CityModel.fromJson(dataMap);

      cityData=cityModel.data;
      selectDhaka=cityModel.data[0].name;
      cityData.removeAt(0);

      setState(() {});

      log("city data length ${cityData.length}");
      log("AREA NAME ${selectDhaka}");


    } else {
      log("data invalid");
    }

  }
  */


  Future<void> getCategory() async {
    log("comes");
    String productURl = "https://test.protidin.com.bd/api/v2/categories/home";

    final response = await get(Uri.parse(productURl), headers: {"Accept": "application/json"});

    var dataMap = jsonDecode(response.body);

    if (dataMap["success"] == true) {
      log("data valid");

      //
      var categoryDataModel = CategoryDataModel.fromJson(dataMap);
      categoryData = categoryDataModel.data;
      categoryDataItem = categoryDataModel.data[0].name;
      await getProductsAfterTap(categoryDataModel.data[0].links.products);
      setState(() {});
      log("data length ${categoryData.length}");
    } else {
      log("data invalid");
    }

    // log("after decode $dataMap");
  }

  List<BuiscitData> categoryProducts = [];

  Future<void> getProductsAfterTap(link) async {
    log("calling 2");
    //String biscuitSweetsURl = "https://test.protidin.com.bd/api/v2/products/category/46";

    final response6 = await get(Uri.parse(link), headers: {"Accept": "application/json"});

    var biscuitSweetsDataMap = jsonDecode(response6.body);

    if (biscuitSweetsDataMap["success"] == true) {
      //log("category data after tap $biscuitSweetsDataMap");

      setState(() {
        var biscuitSweetsDataModel = BiacuitSweets.fromJson(biscuitSweetsDataMap);
        categoryProducts = biscuitSweetsDataModel.data;
      });
      log("categoryProducts data length ${categoryProducts.length}");
    } else {
      log("data invalid");
    }

    // log("after decode $dataMap");
  }

  var breadBiscuitData = [];
  var breadBiscuitItemTitle = "";

  Future<void> getBreadBiscuit() async {
    log("grocery data calling");
    String breadBiscuitURl = "https://test.protidin.com.bd/api/v2/sub-categories/11";

    final responseb = await get(Uri.parse(breadBiscuitURl), headers: {"Accept": "application/json"});

    var breadBiscuitDataMap = jsonDecode(responseb.body);

    if (breadBiscuitDataMap["success"] == true) {
      log("data valid");

      var breadBiscuitDataModel = CategoryDataModel.fromJson(breadBiscuitDataMap);
      breadBiscuitData = breadBiscuitDataModel.data;
      breadBiscuitItemTitle = breadBiscuitDataModel.data[0].name.toString();
      await getBreadBiscuitProductsAfterTap(breadBiscuitDataModel.data[0].links.products);
      setState(() {});
      log("grocery data length ${breadBiscuitData.length}");
    } else {
      log("data invalid");
    }

    // log("after decode $dataMap");
  }

  var breadBiscuitProducts = [];

  Future<void> getBreadBiscuitProductsAfterTap(link2) async {
    log("calling after tap");
    //String biscuitSweetsURl = "https://test.protidin.com.bd/api/v2/products/category/46";

    final responsebp = await get(Uri.parse(link2), headers: {"Accept": "application/json"});

    var breadBiscuitItemDataMap = jsonDecode(responsebp.body);

    if (breadBiscuitItemDataMap["success"] == true) {
      //log("category data after tap $biscuitSweetsDataMap");

      setState(() {
        var breadBiscuitProductsData = BiacuitSweets.fromJson(breadBiscuitItemDataMap);
        breadBiscuitProducts = breadBiscuitProductsData.data;
      });
      log("after tap grocery data length ${breadBiscuitProducts.length}");
    } else {
      log("data invalid");
    }

    // log("after decode $dataMap");
  }

  var chocolateSweetsData = [];
  var chocolateItemTitle = " ";

  Future<void> getchocolateSweets() async {
    log("grocery data calling");
    String chocolateSweetsURl = "https://test.protidin.com.bd/api/v2/sub-categories/46";

    final responscs = await get(Uri.parse(chocolateSweetsURl), headers: {"Accept": "application/json"});

    var chocolateSweetsDataMap = jsonDecode(responscs.body);

    if (chocolateSweetsDataMap["success"] == true) {
      log("data valid");

      var chocolateSweetsDataModel = CategoryDataModel.fromJson(chocolateSweetsDataMap);
      chocolateSweetsData = chocolateSweetsDataModel.data;
      chocolateItemTitle = chocolateSweetsDataModel.data[0].name;
      await getChocolateSweetsProductsAfterTap(chocolateSweetsDataModel.data[0].links.products);
      setState(() {});
      log("grocery data length ${chocolateSweetsData.length}");
    } else {
      log("data invalid");
    }

    // log("after decode $dataMap");
  }

  var chocolateSweetsProducts = [];

  Future<void> getChocolateSweetsProductsAfterTap(link2) async {
    log("calling after tap");
    //String biscuitSweetsURl = "https://test.protidin.com.bd/api/v2/products/category/46";

    final responsecsa = await get(Uri.parse(link2), headers: {"Accept": "application/json"});

    var chocolateSweetsItemDataMap = jsonDecode(responsecsa.body);

    if (chocolateSweetsItemDataMap["success"] == true) {
      //log("category data after tap $biscuitSweetsDataMap");

      setState(() {
        var chocolateSweetsProductsData = BiacuitSweets.fromJson(chocolateSweetsItemDataMap);
        chocolateSweetsProducts = chocolateSweetsProductsData.data;
        // chocolateItemTitle=chocolateSweetsProductsData.data[0].name;
      });
      log("after tap grocery data length ${chocolateSweetsProducts.length}");
    } else {
      log("data invalid");
    }

    // log("after decode $dataMap");
  }

  var householdData = [];
  var householdDataItem = " ";

  Future<void> getHouseholdData() async {
    log("grocery data calling");
    String chocolateSweetsURl = "https://test.protidin.com.bd/api/v2/sub-categories/13";

    final responsh = await get(Uri.parse(chocolateSweetsURl), headers: {"Accept": "application/json"});

    var householdDataMap = jsonDecode(responsh.body);

    if (householdDataMap["success"] == true) {
      log("data valid");

      var householdDataModel = CategoryDataModel.fromJson(householdDataMap);
      householdData = householdDataModel.data;
      householdDataItem = householdDataModel.data[0].name;
      await gethouseholProductsAfterTap(householdDataModel.data[0].links.products);
      setState(() {});
      log("grocery data length ${householdData.length}");
    } else {
      log("data invalid");
    }

    // log("after decode $dataMap");
  }

  var householdProducts = [];

  Future<void> gethouseholProductsAfterTap(link2) async {
    log("calling after tap");
    //String biscuitSweetsURl = "https://test.protidin.com.bd/api/v2/products/category/46";

    final responsecsa = await get(Uri.parse(link2), headers: {"Accept": "application/json"});

    var householdProductsItemDataMap = jsonDecode(responsecsa.body);

    if (householdProductsItemDataMap["success"] == true) {
      //log("category data after tap $biscuitSweetsDataMap");

      setState(() {
        var householdProductsData = BiacuitSweets.fromJson(householdProductsItemDataMap);
        householdProducts = householdProductsData.data;
      });
      log("after tap grocery data length ${householdProducts.length}");
    } else {
      log("data invalid");
    }

    // log("after decode $dataMap");
  }

  var personalCarteData = [];
  var personalCarteDataItem = " ";

  Future<void> getpersonalCarteData() async {
    log("grocery data calling");
    String personalCarteURl = "https://test.protidin.com.bd/api/v2/sub-categories/10";

    final responsp = await get(Uri.parse(personalCarteURl), headers: {"Accept": "application/json"});

    var personalCarteDataMap = jsonDecode(responsp.body);

    if (personalCarteDataMap["success"] == true) {
      log("data valid");

      var personalCarteDataModel = CategoryDataModel.fromJson(personalCarteDataMap);
      personalCarteData = personalCarteDataModel.data;
      personalCarteDataItem = personalCarteDataModel.data[0].name;
      await getpersonalCarteAfterTap(personalCarteDataModel.data[0].links.products);
      setState(() {});
      log("grocery data length ${personalCarteData.length}");
    } else {
      log("data invalid");
    }

    // log("after decode $dataMap");
  }

  var personalCarteProducts = [];

  Future<void> getpersonalCarteAfterTap(link2) async {
    log("calling after tap");
    //String biscuitSweetsURl = "https://test.protidin.com.bd/api/v2/products/category/46";

    final responsecsap = await get(Uri.parse(link2), headers: {"Accept": "application/json"});

    var personalCarteProductsItemDataMap = jsonDecode(responsecsap.body);

    if (personalCarteProductsItemDataMap["success"] == true) {
      //log("category data after tap $biscuitSweetsDataMap");

      setState(() {
        var personalCarteProductsData = BiacuitSweets.fromJson(personalCarteProductsItemDataMap);
        personalCarteProducts = personalCarteProductsData.data;
      });
      log("after tap grocery data length ${personalCarteProducts.length}");
    } else {
      log("data invalid");
    }

    // log("after decode $dataMap");
  }

  var stationaryData = [];
  var stationaryDataItem = " ";

  Future<void> getStationaryData() async {
    log("grocery data calling");
    String stationaryURl = "https://test.protidin.com.bd/api/v2/sub-categories/199";

    final responst = await get(Uri.parse(stationaryURl), headers: {"Accept": "application/json"});

    var stationaryDataMap = jsonDecode(responst.body);

    if (stationaryDataMap["success"] == true) {
      log("data valid");

      var stationaryDataModel = CategoryDataModel.fromJson(stationaryDataMap);
      stationaryData = stationaryDataModel.data;
      stationaryDataItem = stationaryDataModel.data[0].name;
      await getpstationaryAfterTap(stationaryDataModel.data[0].links.products);
      setState(() {});
      log("grocery data length ${stationaryData.length}");
    } else {
      log("data invalid");
    }

    // log("after decode $dataMap");
  }

  var stationaryProducts = [];

  Future<void> getpstationaryAfterTap(link2) async {
    log("calling after tap");
    //String biscuitSweetsURl = "https://test.protidin.com.bd/api/v2/products/category/46";

    final responsestp = await get(Uri.parse(link2), headers: {"Accept": "application/json"});

    var stationaryProductsItemDataMap = jsonDecode(responsestp.body);

    if (stationaryProductsItemDataMap["success"] == true) {
      //log("category data after tap $biscuitSweetsDataMap");

      setState(() {
        var personalCarteProductsData = BiacuitSweets.fromJson(stationaryProductsItemDataMap);
        stationaryProducts = personalCarteProductsData.data;
      });
      log("after tap grocery data length ${stationaryProducts.length}");
    } else {
      log("data invalid");
    }

    // log("after decode $dataMap");
  }

  var toyGiftData = [];
  var toyGiftDataItem = " ";

  Future<void> gettoyGiftData() async {
    log("grocery data calling");
    String toyGiftURl = "https://test.protidin.com.bd/api/v2/sub-categories/14";

    final responstg = await get(Uri.parse(toyGiftURl), headers: {"Accept": "application/json"});

    var toyGiftDataMap = jsonDecode(responstg.body);

    if (toyGiftDataMap["success"] == true) {
      log("data valid");

      var toyGiftDataModel = CategoryDataModel.fromJson(toyGiftDataMap);
      toyGiftData = toyGiftDataModel.data;
      toyGiftDataItem = toyGiftDataModel.data[0].name;
      await gettoyGiftAfterTap(toyGiftDataModel.data[0].links.products);
      setState(() {});
      log("grocery data length ${toyGiftData.length}");
    } else {
      log("data invalid");
    }

    // log("after decode $dataMap");
  }

  var toyGiftProducts = [];

  Future<void> gettoyGiftAfterTap(link2) async {
    log("calling after tap");
    //String biscuitSweetsURl = "https://test.protidin.com.bd/api/v2/products/category/46";

    final responsestgp = await get(Uri.parse(link2), headers: {"Accept": "application/json"});

    var gettoyGiftAfterTapProductsItemDataMap = jsonDecode(responsestgp.body);

    if (gettoyGiftAfterTapProductsItemDataMap["success"] == true) {
      //log("category data after tap $biscuitSweetsDataMap");

      setState(() {
        var gettoyGiftProductsData = BiacuitSweets.fromJson(gettoyGiftAfterTapProductsItemDataMap);
        toyGiftProducts = gettoyGiftProductsData.data;
      });
      log("after tap grocery data length ${toyGiftProducts.length}");
    } else {
      log("data invalid");
    }

    // log("after decode $dataMap");
  }

  var groceryData = [];
  var groceryItemData = " ";

  Future<void> getGrocery({required String name}) async {
    log("grocery data calling");
    String groceryURl = "https://test.protidin.com.bd/api/v2/sub-categories/$name";

    final response3 = await get(Uri.parse(groceryURl), headers: {"Accept": "application/json"});

    var groceryDataMap = jsonDecode(response3.body);

    if (groceryDataMap["success"] == true) {
      log("data valid");

      var categoryDataModel = CategoryDataModel.fromJson(groceryDataMap);
      groceryData = categoryDataModel.data;
      groceryItemData = categoryDataModel.data[0].name;
      relatedProductsLink=groceryData[0].links.products;

      await getGroceryProductsAfterTap(categoryDataModel.data[0].links.products);
      setState(() {});
      log("grocery data length ${groceryData.length}");
    } else {
      log("data invalid");
    }

    // log("after decode $dataMap");
  }

  var groceryProducts = [];

  Future<void> getGroceryProductsAfterTap(link2) async {
    log("calling after tap");
    //String biscuitSweetsURl = "https://test.protidin.com.bd/api/v2/products/category/46";

    final response7 = await get(Uri.parse(link2), headers: {"Accept": "application/json"});

    var groceryItemDataMap = jsonDecode(response7.body);

    if (groceryItemDataMap["success"] == true) {
      //log("category data after tap $biscuitSweetsDataMap");


        var groceryData = BiacuitSweets.fromJson(groceryItemDataMap);
        groceryProducts = groceryData.data;
        //relatedProductsLink=groceryProducts[0].links.products;

        setState(() {

        });

      log("after tap grocery data length ${groceryProducts.length}");
    } else {
      log("data invalid");
    }

    // log("after decode $dataMap");
  }

  var fruitBeverageData = [];
  var dairyBeverageItemData = " ";

  Future<void> getFrouitsBeverage() async {
    log(" froitsBeverage calling ");
    String froitsBeverageURl = "https://test.protidin.com.bd/api/v2/sub-categories/7";

    final response8 = await get(Uri.parse(froitsBeverageURl), headers: {"Accept": "application/json"});

    var froitsBeverageItemDataMap = jsonDecode(response8.body);

    if (froitsBeverageItemDataMap["success"] == true) {
      //log("category data after tap $biscuitSweetsDataMap");
      var froitsBeverageData = CategoryDataModel.fromJson(froitsBeverageItemDataMap);
      dairyBeverageItemData = froitsBeverageData.data[0].name.toString();
      await getfruitsBeverageDataAfterTap(froitsBeverageData.data[0].links.products);

      fruitBeverageData = froitsBeverageData.data;
      setState(() {});
      log("after tap fruit data length ${fruitBeverageData.length}");
    } else {
      log("data invalid");
    }

    // log("after decode $dataMap");
  }

  var fruitBeverageDataAfterTap = [];

  Future<void> getfruitsBeverageDataAfterTap(link2) async {
    log("frouits and beverage after calling");
    //String biscuitSweetsURl = "https://test.protidin.com.bd/api/v2/products/category/46";

    final response8 = await get(Uri.parse(link2), headers: {"Accept": "application/json"});

    var frouitsBeverageItemDataMap = jsonDecode(response8.body);

    if (frouitsBeverageItemDataMap["success"] == true) {
      //log("category data after tap $biscuitSweetsDataMap");

      setState(() {
        var froitBeverageData = BiacuitSweets.fromJson(frouitsBeverageItemDataMap);
        fruitBeverageDataAfterTap = froitBeverageData.data;
      });
      log("after tap grocery data length ${fruitBeverageDataAfterTap.length}");
    } else {
      log("data invalid");
    }

    // log("after decode $dataMap");
  }

  var babyMotherData = [];
  var babyMotherDataItem = " ";

  Future<void> getbabyMother() async {
    log(" babyMother calling ");
    String babyMotherURl = "https://test.protidin.com.bd/api/v2/sub-categories/8";

    final response8 = await get(Uri.parse(babyMotherURl), headers: {"Accept": "application/json"});

    var babyMotherItemDataMap = jsonDecode(response8.body);

    if (babyMotherItemDataMap["success"] == true) {
      //log("category data after tap $biscuitSweetsDataMap");
      var babyMotherDataModel = CategoryDataModel.fromJson(babyMotherItemDataMap);
      babyMotherData = babyMotherDataModel.data;
      babyMotherDataItem = babyMotherDataModel.data[0].name;
      await getbabyMotherDataAfterTap(babyMotherDataModel.data[0].links.products);
      setState(() {});
      log("after tap babyMother length ${babyMotherData.length}");
    } else {
      log("data invalid");
    }

    // log("after decode $dataMap");
  }

  var babyMotherDataAfterTap = [];

  Future<void> getbabyMotherDataAfterTap(link2) async {
    log("baby and mother after calling");
    //String biscuitSweetsURl = "https://test.protidin.com.bd/api/v2/products/category/46";

    final response9 = await get(Uri.parse(link2), headers: {"Accept": "application/json"});

    var babyMotherDataMap = jsonDecode(response9.body);

    if (babyMotherDataMap["success"] == true) {
      //log("category data after tap $biscuitSweetsDataMap");

      setState(() {
        var motherBabyData = BiacuitSweets.fromJson(babyMotherDataMap);
        babyMotherDataAfterTap = motherBabyData.data;
      });
      log("after tap grocery data length ${babyMotherDataAfterTap.length}");
    } else {
      log("data invalid");
    }

    // log("after decode $dataMap");
  }

  var fruitsVegitableData = [];
  var fruitsVegitableItemData = " ";

  Future<void> getfruitsVegitable() async {
    log(" fruit and vegetable calling ");
    String fruitsVegitableURl = "https://test.protidin.com.bd/api/v2/sub-categories/9";

    final response9 = await get(Uri.parse(fruitsVegitableURl), headers: {"Accept": "application/json"});

    var fruitsVegitableDataMap = jsonDecode(response9.body);

    if (fruitsVegitableDataMap["success"] == true) {
      //log("category data after tap $biscuitSweetsDataMap");
      var froitsBeverageData = CategoryDataModel.fromJson(fruitsVegitableDataMap);
      fruitsVegitableData = froitsBeverageData.data;
      fruitsVegitableItemData = froitsBeverageData.data[0].name;
      await getfrouitsVegitableDataAfterTap(froitsBeverageData.data[0].links.products);
      setState(() {});
      log("after tap fruit and vegetable length ${fruitsVegitableData.length}");
    } else {
      log("data invalid");
    }

    // log("after decode $dataMap");
  }

  var fruitsVegAfterTap = [];

  Future<void> getfrouitsVegitableDataAfterTap(link2) async {
    log("baby and mother after calling");
    //String biscuitSweetsURl = "https://test.protidin.com.bd/api/v2/products/category/46";

    final response10 = await get(Uri.parse(link2), headers: {"Accept": "application/json"});

    var fruitVegitableItemDataMap = jsonDecode(response10.body);

    if (fruitVegitableItemDataMap["success"] == true) {
      //log("category data after tap $biscuitSweetsDataMap");

      setState(() {
        var fruitVegitable = BiacuitSweets.fromJson(fruitVegitableItemDataMap);
        fruitsVegAfterTap = fruitVegitable.data;
      });
      log("after tap grocery data length ${fruitsVegAfterTap.length}");
    } else {
      log("data invalid");
    }

    // log("after decode $dataMap");
  }

  List<OneToNinentyNineDataModel> oneTwoNinentyNineData = [];

  Future<void> getOneTo99Data() async {
    log("1 to 99 data");

    final response12 =
        await get(Uri.parse("https://test.protidin.com.bd/api/v2/products/category/4"), headers: {"Accept": "application/json"});

    var oneTwoNinentyNineItemDataMap = jsonDecode(response12.body);

    if (oneTwoNinentyNineItemDataMap["success"] == true) {
      //log("category data after tap $biscuitSweetsDataMap");

      setState(() {
        var onToNinetyNine = BiacuitSweets.fromJson(oneTwoNinentyNineItemDataMap);

        //oneTwoNinentyNineData=onToNinetyNine.data;

        for (var i = 0; i < onToNinetyNine.data.length; i++) {
          if (int.parse(onToNinetyNine.data[i].basePrice.substring(1)) <= 99) {
            log("price between 1-99: ${onToNinetyNine.data[i].basePrice}");

            oneTwoNinentyNineData.add(OneToNinentyNineDataModel(
              name: onToNinetyNine.data[i].name,
              basePrice: onToNinetyNine.data[i].basePrice,
              disCountPrice: onToNinetyNine.data[i].baseDiscountedPrice,
              image: onToNinetyNine.data[i].thumbnailImage,
              id: onToNinetyNine.data[i].id,
              discount: onToNinetyNine.data[i].discount,
              unit: onToNinetyNine.data[i].unit,
            ));
          } else {
            // log("price not between 1-99: ${onToNinetyNine.data[i].basePrice}");
          }
        }
      });
      //log("1-99 data length ${oneTwoNinentyNineData.length}");

    } else {
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
      key: scaffoldKey,
      child: Scaffold(
        ///
        drawer: Drawer(
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                child: Container(
                  height: 200,
                  width: MediaQuery.of(context).size.width / 1.2,
                  child: Column(children: [
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      //mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          //color: Colors.white,
                          height: 60,
                          width: 60,
                          child: Image.asset(
                            "assets/img_135.png",
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                        ),
                        Container(
                          width: 120,
                          child: Column(
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Welcome ",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Md. Abcdef ghijkl",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ]),
                ),
                decoration: BoxDecoration(
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
                      child: Image.asset(
                        "assets/img_149.png",
                        color: Colors.black,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                    ),
                    Text(
                      'Track Order',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
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
                      child: Image.asset(
                        "assets/img_150.png",
                        color: Colors.black,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                    ),
                    Text(
                      'My Orders',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
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
                      child: Image.asset(
                        "assets/img_151.png",
                        color: Colors.black,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                    ),
                    Text(
                      'Categories',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => GroceryOfferPage()));
                },
              ),
              ListTile(
                title: Row(
                  children: [
                    Container(
                      //color: Colors.white,
                      height: 20,
                      width: 20,
                      child: Image.asset(
                        "assets/img_152.png",
                        color: Colors.black,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                    ),
                    Text(
                      'Wallet',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
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
                      child: Image.asset(
                        "assets/img_153.png",
                        color: Colors.black,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                    ),
                    Text(
                      'Request a product',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
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
                      child: Image.asset(
                        "assets/img_149.png",
                        color: Colors.black,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                    ),
                    Text(
                      'Call to order',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
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
                      child: Image.asset(
                        "assets/img_154.png",
                        color: Colors.black,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                    ),
                    Text(
                      'My Account',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
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
                width: MediaQuery.of(context).size.width / 1.1,
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
                      width: MediaQuery.of(context).size.width / 7,
                      child: Image.asset("assets/img_27.png"),
                    ),
                    SizedBox(
                      height: 20,
                      //width: 230,
                      width: MediaQuery.of(context).size.width * 4 / 6.5,
                      child: Image.asset("assets/img_29.png"),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 7,
                      height: 20,
                      //width: 100,
                      child: InkWell(
                        onTap: () {
                          //Navigator.push(context, MaterialPageRoute(builder: (context) => GroceryOfferPage()));
                          if (!scaffoldKey.currentState!.isDrawerOpen) {
                            //check if drawer is closed
                            scaffoldKey.currentState!.openDrawer(); //open drawer
                          }
                        },
                        child: Container(child: Image.asset("assets/img_184.png")),
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
                        style: TextStyle(
                          color: Color(0xFF515151),
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          fontFamily: "CeraProBold",
                        ),
                      ),
                      Container(
                          height: 10,
                          child: Image.asset(
                            "assets/img_50.png",
                            height: 5,
                          )),
                    ],
                  ),
                ),
              ),
            ),

            SizedBox(
              height: 5,
            ),

            // top banner
            Container(
              //width: 320.0,
              width: MediaQuery.of(context).size.width / 1,
              height: 185.0,
              decoration: const BoxDecoration(image: DecorationImage(image: AssetImage("assets/img_32.png"), fit: BoxFit.cover)),

              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                  ),
                  Container(width: MediaQuery.of(context).size.width / 2.5, child: Image.asset("assets/img_33.png")),
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                  ),
                  Center(
                    child: Container(
                      width: MediaQuery.of(context).size.width / 2,
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

            SizedBox(
              height: 20,
            ),

            // Offer For you
            SizedBox(
              width: MediaQuery.of(context).size.width / 1.1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Text(
                      "Offer for you",
                      style: TextStyle(color: Color(0xFF515151), fontSize: 22, fontWeight: FontWeight.w700, fontFamily: "CeraProBold"),
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
            SizedBox(
              height: 15,
            ),
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
              height: 30,
            ),
            // shop by category
            Container(
              ///height: height,
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
                          style: TextStyle(color: Color(0xFF515151), fontSize: 22, fontWeight: FontWeight.w700, fontFamily: "CeraProBold"),
                        ),
                      ),

                      SizedBox(
                        height: 12,
                      ),

                      Container(
                        height: height * 0.24,
                        width: width,
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: categoryData.length,
                          itemBuilder: (_, index) {
                            if (value.toString() != index.toString()) {
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    value = index.toString();
                                    categoryDataItem = categoryData[index].name;
                                    log(categoryData[index].links.products);
                                    getProductsAfterTap(categoryData[index].links.products);
                                  });
                                },
                                child: Container(
                                  width: width * 0.35,
                                  margin: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                                  decoration: BoxDecoration(
                                    color: Colors.grey.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      //sized10,
                                      SizedBox(
                                        height: 15,
                                      ),

                                      Expanded(
                                          child: categoryData[index].mobileBanner.isEmpty
                                              ?
                                              //Text("OK"):
                                              Image.asset("assets/app_logo.png")
                                              : Image.network(imagePath + categoryData[index].mobileBanner)),

                                      ///Expanded(child: Image.network(imagePath+categoryData[index].largeBanner)),

                                      sized10,
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                          2,
                                          2,
                                          0,
                                          5,
                                        ),
                                        child: Container(
                                          //height: MediaQuery.of(context).size.height/20,
                                          height: MediaQuery.of(context).size.height / 14,
                                          child: Text(
                                            categoryData[index].name,
                                            style: TextStyle(color: Color(0xFF515151), fontWeight: FontWeight.w700, fontSize: 16),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            } else {
                              return Container(
                                width: width * 0.35,
                                margin: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    //sized10,
                                    SizedBox(
                                      height: 15,
                                    ),

                                    Expanded(
                                        child: categoryData[index].mobileBanner.isEmpty
                                            ?
                                            //Text("OK"):
                                            Image.asset("assets/app_logo.png")
                                            : Image.network(imagePath + categoryData[index].mobileBanner)),
                                    sized10,
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                        2,
                                        2,
                                        0,
                                        5,
                                      ),
                                      child: Container(
                                        //height: MediaQuery.of(context).size.height/20,
                                        height: MediaQuery.of(context).size.height / 14,
                                        child: Text(
                                          categoryData[index].name,
                                          style: TextStyle(color: Color(0xFF515151), fontWeight: FontWeight.w700, fontSize: 16),
                                          textAlign: TextAlign.center,
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

                      SizedBox(
                        height: 10,
                      ),

                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "$categoryDataItem",
                          style: TextStyle(color: Color(0xFF515151), fontSize: 22, fontWeight: FontWeight.w700, fontFamily: "CeraProBold"),
                        ),
                      ),

                      SizedBox(
                        height: 20,
                      ),

                      ////////////////////////////////////////////////////////
                      Container(
                        height: MediaQuery.of(context).size.height / 3,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: categoryProducts.length,
                          itemBuilder: (_, index) {
                            return GestureDetector(
                              onTap: () {
                                //log(categoryProducts[index].links.details);
                                /*setState(() {
                                        value=index.toString();

                                        getProductsAfterTap(categoryData[index].links.products);
                                      });*/
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: Container(
                                  decoration: BoxDecoration(color: Color(0xFFF1EDF2), borderRadius: BorderRadius.circular(15.0)),
                                  //height: MediaQuery.of(context).size.height/3.2,
                                  width: MediaQuery.of(context).size.width / 2.34,
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
                                      InkWell(
                                        onTap: () {
                                          Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => GroceryDetails(
                                                        detailsLink: groceryProducts[index].links.details,
                                                    relatedProductLink: relatedProductsLink,
                                                      )));
                                        },
                                        child: Container(
                                          child: Image.network(imagePath + categoryProducts[index].thumbnailImage),
                                          height: MediaQuery.of(context).size.height / 8,
                                          width: MediaQuery.of(context).size.width / 2.34,
                                        ),
                                      ),
                                      FittedBox(
                                        child: Container(
                                          ///height: height! * 0.08,
                                          width: MediaQuery.of(context).size.width / 2.36,
                                          height: MediaQuery.of(context).size.height / 16,
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(5, 5, 5, 0),
                                            child: Text(
                                              categoryProducts[index].name,
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
                                            "5 lit",
                                            style: TextStyle(color: Colors.grey.withOpacity(0.9)),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                        child: Center(
                                          child: Container(
                                            //height: MediaQuery.of(context).size.height/32,
                                            height: MediaQuery.of(context).size.height / 31.5,
                                            width: MediaQuery.of(context).size.width / 2.34,
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Container(
                                                  child: Image.asset("assets/p.png"),
                                                  height: 20,
                                                  width: 22,
                                                ),
                                                Text(categoryProducts[index].basePrice.toString(),
                                                    style: TextStyle(color: Color(0xFF515151), fontSize: 16, fontWeight: FontWeight.w700)),
                                                Text(categoryProducts[index].baseDiscountedPrice.toString(),
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
                                                    Navigator.push(context, MaterialPageRoute(builder: (context) => CartDetails()));
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
                                        //height: MediaQuery.of(context).size.height/26,
                                        height: MediaQuery.of(context).size.height / 21,
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
                              ),
                            );
                          },
                        ),
                      ),
                      /////////////////////////////////////////////////////////

                      SizedBox(
                        height: 35,
                      ),
                    ]),
                  ),
                ],
              ),
            ),

            SizedBox(
              height: 30,
            ),
            //1-99 store
            Container(
              width: MediaQuery.of(context).size.width / 1,
              //margin: EdgeInsets.symmetric(horizontal: 5.0),
              decoration: BoxDecoration(color: kPrimaryColor, borderRadius: BorderRadius.circular(10.0)),
              child: Padding(
                //padding: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "1-99 Store",
                          style: TextStyle(fontFamily: "CeraProBold", fontSize: 22, color: Colors.white, fontWeight: FontWeight.w700),
                        ),
                        Text(
                          "VIEW ALL",
                          style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                    sized10,
                    Container(
                      //width: MediaQuery.of(context).size.width/1,
                      child: Center(
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
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700, fontFamily: "CeraProBold"),
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
                    ),
                    sized10,
                    Padding(
                      padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                      child: Container(
                        //height: height*0.31,
                        height: height * 0.33,
                        width: width,
                        child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: oneTwoNinentyNineData.length,
                            itemBuilder: (_, index) {
                              return Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: Container(
                                  decoration: BoxDecoration(color: Color(0xFFF1EDF2), borderRadius: BorderRadius.circular(15.0)),
                                  //height: MediaQuery.of(context).size.height/3.2,
                                  width: MediaQuery.of(context).size.width / 2.34,
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
                                      InkWell(
                                        onTap: () {},
                                        child: InkWell(
                                          /*onTap: (){
                                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => GroceryDetails(
                                                detailsLink:  oneTwoNinentyNineData[index].links.details ,
                                              )));
                                            },*/
                                          child: Container(
                                            child: Image.network(imagePath + oneTwoNinentyNineData[index].image.toString()),
                                            height: MediaQuery.of(context).size.height / 8,
                                            width: MediaQuery.of(context).size.width / 2.34,
                                          ),
                                        ),
                                      ),
                                      FittedBox(
                                        child: Container(
                                          ///height: height! * 0.08,
                                          width: MediaQuery.of(context).size.width / 2.36,
                                          height: MediaQuery.of(context).size.height / 17,
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(5, 5, 5, 0),
                                            child: Text(
                                              oneTwoNinentyNineData[index].name.toString(),
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
                                            "5 lit",
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
                                                Text(oneTwoNinentyNineData[index].disCountPrice.toString(),
                                                    style: TextStyle(color: Color(0xFF515151), fontSize: 16, fontWeight: FontWeight.w700)),
                                                Text(oneTwoNinentyNineData[index].basePrice.toString(),
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
                                                    Navigator.push(context, MaterialPageRoute(builder: (context) => CartDetails()));
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
                                        height: MediaQuery.of(context).size.height / 21,
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
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(
              height: 30,
            ),
            //grocery
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

                  Container(
                    width: MediaQuery.of(context).size.width / 1.1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Grocery",
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
                      itemCount: groceryData.length,
                      itemBuilder: (_, index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              valueOne = index.toString();
                              groceryItemData = groceryData[index].name;
                              relatedProductsLink=groceryData[index].links.products;
                              getGroceryProductsAfterTap(groceryData[index].links.products);
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
                                              child: groceryData[index].mobileBanner.isEmpty
                                                  ?

                                                  //Text("OK"):
                                                  Image.asset("assets/app_logo.png")
                                                  : Image.network(
                                                      imagePath + groceryData[index].mobileBanner,
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
                                                child: groceryData[index].mobileBanner.isEmpty
                                                    ?

                                                    //Text("OK"):
                                                    Image.asset("assets/app_logo.png")
                                                    : Image.network(
                                                        imagePath + groceryData[index].mobileBanner,
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
                        "$groceryItemData",
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
                          itemCount: groceryProducts.length,
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
                                                      detailsLink: groceryProducts[index].links.details,
                                                      relatedProductLink: relatedProductsLink,
                                                    )
                                            )
                                        );
                                      },
                                      child: Container(
                                        child: Image.network(imagePath + groceryProducts[index].thumbnailImage),
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
                                            groceryProducts[index].name,
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
                                          groceryProducts[index].unit,
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
                                              Text(groceryProducts[index].baseDiscountedPrice.toString(),
                                                  style: TextStyle(color: Color(0xFF515151), fontSize: 16, fontWeight: FontWeight.w700)),
                                              Text(groceryProducts[index].basePrice.toString(),
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
                                                  //addToCart(groceryProducts[index].id, 61, 1);
                                                   Navigator.push(context, MaterialPageRoute(builder: (context) => CartDetails()));
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
            ),

            SizedBox(
              height: 30,
            ),
            //dairy & beverage
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
                  Container(
                    width: MediaQuery.of(context).size.width / 1.1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Dairy & Beverages",
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
                    ],
                  ),
                  sized20,
                  Container(
                    //height: height*0.2,
                    height: height * 0.21,
                    width: width,
                    //width: width*0.4,
                    //height: height * 0.2,
                    //width: width*0.35,
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: fruitBeverageData.length,
                      itemBuilder: (_, index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              valueTwo = index.toString();
                              dairyBeverageItemData = fruitBeverageData[index].name;
                              getfruitsBeverageDataAfterTap(fruitBeverageData[index].links.products);
                            });
                          },
                          child: valueTwo.toString() != index.toString()
                              ? Padding(
                                  padding: const EdgeInsets.only(left: 5.0),
                                  child: Container(
                                      //height: height * 0.2,
                                      height: height * 0.2,
                                      width: width * 0.35,
                                      //margin: EdgeInsets.symmetric(vertical: 5.0),
                                      margin: EdgeInsets.symmetric(vertical: 0.0),
                                      decoration: BoxDecoration(
                                        //color: Colors.white,
                                        borderRadius: BorderRadius.circular(10.0),
                                      ),
                                      child: Column(
                                        children: [
                                          Container(
                                            //height: height*0.15,
                                            //width: width*0.30,

                                            height: height * 0.15,
                                            width: width * 0.30,

                                            decoration: BoxDecoration(color: Color(0xFFF0E6F2), borderRadius: BorderRadius.circular(15.0)),
                                            child: Center(
                                              child: Padding(
                                                padding: const EdgeInsets.all(0),
                                                child: fruitBeverageData[index].mobileBanner.isEmpty
                                                    ?

                                                    //Text("OK"):
                                                    Image.asset("assets/app_logo.png")
                                                    : Image.network(
                                                        imagePath + fruitBeverageData[index].mobileBanner,
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
                                      )),
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
                                                //color: Color(0xFFF0E6F2),
                                                borderRadius: BorderRadius.circular(15.0)),
                                            child: Padding(
                                              padding: const EdgeInsets.all(0),
                                              child: Center(
                                                child: fruitBeverageData[index].mobileBanner.isEmpty
                                                    ?

                                                    //Text("OK"):
                                                    Image.asset("assets/app_logo.png")
                                                    : Image.network(
                                                        imagePath + fruitBeverageData[index].mobileBanner,
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
                                      )),
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
                        "$dairyBeverageItemData",
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
                          itemCount: fruitBeverageDataAfterTap.length,
                          itemBuilder: (_, index) {
                            return Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Container(
                                decoration: BoxDecoration(color: Color(0xFFF1EDF2), borderRadius: BorderRadius.circular(15.0)),
                                //height: MediaQuery.of(context).size.height/3.2,
                                width: MediaQuery.of(context).size.width / 2.34,
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
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => GroceryDetails(
                                                      detailsLink: fruitBeverageDataAfterTap[index].links.details,
                                                  relatedProductLink: relatedProductsLink,
                                                    )
                                            )
                                        );
                                      },
                                      child: Container(
                                        child: Image.network(imagePath + fruitBeverageDataAfterTap[index].thumbnailImage),
                                        height: MediaQuery.of(context).size.height / 8,
                                        width: MediaQuery.of(context).size.width / 2.34,
                                      ),
                                    ),
                                    FittedBox(
                                      child: Container(
                                        ///height: height! * 0.08,
                                        width: MediaQuery.of(context).size.width / 2.36,
                                        height: MediaQuery.of(context).size.height / 17,
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(5, 5, 5, 0),
                                          child: Text(
                                            fruitBeverageDataAfterTap[index].name,
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
                                          fruitBeverageDataAfterTap[index].unit,
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
                                              Text(fruitBeverageDataAfterTap[index].baseDiscountedPrice.toString(),
                                                  style: TextStyle(color: Color(0xFF515151), fontSize: 16, fontWeight: FontWeight.w700)),
                                              Text(fruitBeverageDataAfterTap[index].basePrice.toString(),
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
                                                  Navigator.push(context, MaterialPageRoute(builder: (context) => CartDetails()));
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
                          }
                          ),
                    ),
                  ),
                  SizedBox(
                    height: 35,
                  ),
                ],
              ),
            ),

            //big sale banner
            SizedBox(
              height: 30,
            ),
            InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => OfferPage()));
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

            SizedBox(
              height: 30,
            ),
            //mother & baby
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
                  Container(
                    width: MediaQuery.of(context).size.width / 1.1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Mothers & Baby ",
                          style: TextStyle(color: Color(0xFF515151), fontSize: 22, fontWeight: FontWeight.w700, fontFamily: "CeraProBold"),
                        ),
                        Text(
                          "VIEW ALL",
                          style: TextStyle(color: Color(0xFF515151), fontSize: 13, fontWeight: FontWeight.w400),
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
                              style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700, fontFamily: "CeraProBold"),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 15),
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
                  sized20,
                  Container(
                    height: height * 0.22,
                    width: width,
                    //width: width*0.4,
                    //height: height * 0.2,
                    //width: width*0.35,
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: babyMotherData.length,
                      itemBuilder: (_, index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              valueThree = index.toString();
                              babyMotherDataItem = babyMotherData[index].name;
                              getbabyMotherDataAfterTap(babyMotherData[index].links.products);
                            });
                          },
                          child: valueThree.toString() != index.toString()
                              ? Padding(
                                  padding: const EdgeInsets.only(left: 5.0),
                                  child: Container(
                                      //height: height * 0.2,
                                      height: height * 0.2,
                                      width: width * 0.35,
                                      margin: EdgeInsets.symmetric(vertical: 5.0),
                                      decoration: BoxDecoration(
                                        //color: Colors.white,
                                        borderRadius: BorderRadius.circular(10.0),
                                      ),
                                      child: Column(
                                        children: [
                                          Container(
                                            height: height * 0.15,
                                            width: width * 0.30,
                                            decoration: BoxDecoration(color: Color(0xFFF0E6F2), borderRadius: BorderRadius.circular(15.0)),
                                            child: Center(
                                              child: Padding(
                                                padding: const EdgeInsets.all(0),
                                                child: babyMotherData[index].mobileBanner.isEmpty
                                                    ?

                                                    //Text("OK"):
                                                    Image.asset("assets/app_logo.png")
                                                    : Image.network(
                                                        imagePath + babyMotherData[index].mobileBanner,
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
                                      )),
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
                                                //color: Color(0xFFF0E6F2),
                                                borderRadius: BorderRadius.circular(15.0)),
                                            child: Padding(
                                              padding: const EdgeInsets.all(0),
                                              child: Center(
                                                child: babyMotherData[index].mobileBanner.isEmpty
                                                    ?

                                                    //Text("OK"):
                                                    Image.asset("assets/app_logo.png")
                                                    : Image.network(
                                                        imagePath + babyMotherData[index].mobileBanner,
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
                                      )),
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
                        "$babyMotherDataItem",
                        style: TextStyle(color: Color(0xFF515151), fontSize: 22, fontWeight: FontWeight.w700, fontFamily: "CeraProBold"),
                      ),
                    ),
                  ),
                  sized20,
                  //SizedBox(height: 5,),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 0, 8, 0),
                    child: Container(
                      height: height * 0.32,
                      width: width,
                      child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: babyMotherDataAfterTap.length,
                          itemBuilder: (_, index) {
                            return Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Container(
                                decoration: BoxDecoration(color: Color(0xFFF1EDF2), borderRadius: BorderRadius.circular(15.0)),
                                //height: MediaQuery.of(context).size.height/3.2,
                                width: MediaQuery.of(context).size.width / 2.34,
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
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => GroceryDetails(
                                                      detailsLink: babyMotherDataAfterTap[index].links.details,
                                                  relatedProductLink: relatedProductsLink,
                                                    ))
                                        );
                                      },
                                      child: Container(
                                        child: Image.network(imagePath + babyMotherDataAfterTap[index].thumbnailImage),
                                        height: MediaQuery.of(context).size.height / 8,
                                        width: MediaQuery.of(context).size.width / 2.34,
                                      ),
                                    ),
                                    FittedBox(
                                      child: Container(
                                        ///height: height! * 0.08,
                                        width: MediaQuery.of(context).size.width / 2.36,
                                        height: MediaQuery.of(context).size.height / 17,
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(5, 5, 5, 0),
                                          child: Text(
                                            babyMotherDataAfterTap[index].name,
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
                                          babyMotherDataAfterTap[index].unit,
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
                                              Text(babyMotherDataAfterTap[index].baseDiscountedPrice.toString(),
                                                  style: TextStyle(color: Color(0xFF515151), fontSize: 16, fontWeight: FontWeight.w700)),
                                              Text(babyMotherDataAfterTap[index].basePrice.toString(),
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
                                                  Navigator.push(context, MaterialPageRoute(builder: (context) => CartDetails(

                                                  )));
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
            ),

            SizedBox(
              height: 30,
            ),
            //fruits & vegetable
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
                  Container(
                    width: MediaQuery.of(context).size.width / 1.1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Fruits & Vegetables",
                          style: TextStyle(color: kBlackColor, fontSize: 22, fontWeight: FontWeight.w700, fontFamily: "CeraProBold"),
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
                    ],
                  ),
                  sized20,
                  Container(
                    height: height * 0.21,
                    width: width,
                    //width: width*0.4,
                    //height: height * 0.2,
                    //width: width*0.35,
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: fruitsVegitableData.length,
                      itemBuilder: (_, index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              valueFour = index.toString();
                              fruitsVegitableItemData = fruitsVegitableData[index].name;
                              getfrouitsVegitableDataAfterTap(fruitsVegitableData[index].links.products);
                            });
                          },
                          child: valueFour.toString() != index.toString()
                              ? Padding(
                                  padding: const EdgeInsets.only(left: 5.0),
                                  child: Container(
                                      //height: height * 0.2,
                                      height: height * 0.2,
                                      width: width * 0.35,
                                      margin: EdgeInsets.symmetric(vertical: 5.0),
                                      decoration: BoxDecoration(
                                        //color: Colors.white,
                                        borderRadius: BorderRadius.circular(10.0),
                                      ),
                                      child: Column(
                                        children: [
                                          Container(
                                            height: height * 0.15,
                                            width: width * 0.30,
                                            decoration: BoxDecoration(color: Color(0xFFF0E6F2), borderRadius: BorderRadius.circular(15.0)),
                                            child: Center(
                                              child: Padding(
                                                padding: const EdgeInsets.all(10),
                                                child: fruitsVegitableData[index].mobileBanner.isEmpty
                                                    ?

                                                    //Text("OK"):
                                                    Image.asset("assets/app_logo.png")
                                                    : Image.network(
                                                        imagePath + fruitsVegitableData[index].mobileBanner,
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
                                      )),
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
                                                //color: Color(0xFFF0E6F2),
                                                borderRadius: BorderRadius.circular(15.0)),
                                            child: Padding(
                                              padding: const EdgeInsets.all(10),
                                              child: Center(
                                                child: fruitsVegitableData[index].mobileBanner.isEmpty
                                                    ?

                                                    //Text("OK"):
                                                    Image.asset("assets/app_logo.png")
                                                    : Image.network(
                                                        imagePath + fruitsVegitableData[index].mobileBanner,
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
                                      )),
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
                        "$fruitsVegitableItemData",
                        style: TextStyle(color: Color(0xFF515151), fontSize: 22, fontWeight: FontWeight.w700, fontFamily: "CeraProBold"),
                      ),
                    ),
                  ),
                  //sized20,
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 0, 8, 0),
                    child: Container(
                      height: height * 0.32,
                      width: width,
                      child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: fruitsVegAfterTap.length,
                          itemBuilder: (_, index) {
                            return Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Container(
                                decoration: BoxDecoration(color: Color(0xFFF1EDF2), borderRadius: BorderRadius.circular(15.0)),
                                //height: MediaQuery.of(context).size.height/3.2,
                                width: MediaQuery.of(context).size.width / 2.34,
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
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => GroceryDetails(
                                                      detailsLink: fruitsVegAfterTap[index].links.details,
                                                  relatedProductLink: relatedProductsLink,
                                                    )));
                                      },
                                      child: Container(
                                        child: Image.network(imagePath + fruitsVegAfterTap[index].thumbnailImage),
                                        height: MediaQuery.of(context).size.height / 8,
                                        width: MediaQuery.of(context).size.width / 2.34,
                                      ),
                                    ),
                                    FittedBox(
                                      child: Container(
                                        ///height: height! * 0.08,
                                        width: MediaQuery.of(context).size.width / 2.36,
                                        height: MediaQuery.of(context).size.height / 17,
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(3, 5, 3, 0),
                                          child: Text(
                                            fruitsVegAfterTap[index].name,
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
                                          fruitsVegAfterTap[index].unit,
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
                                              Text(fruitsVegAfterTap[index].baseDiscountedPrice.toString(),
                                                  style: TextStyle(color: Color(0xFF515151), fontSize: 16, fontWeight: FontWeight.w700)),
                                              Text(fruitsVegAfterTap[index].basePrice.toString(),
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
                                                  Navigator.push(context, MaterialPageRoute(builder: (context) => CartDetails()));
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
            ),

            SizedBox(
              height: 30,
            ),
            //combo offer banner
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage("assets/img_69.png"), fit: BoxFit.cover), //69
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

            SizedBox(
              height: 30,
            ),
            //personal care
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

                  Container(
                    width: MediaQuery.of(context).size.width / 1.1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Personal Care",
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
                      itemCount: personalCarteData.length,
                      itemBuilder: (_, index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              valueOne = index.toString();
                              personalCarteDataItem = personalCarteData[index].name;
                              getpersonalCarteAfterTap(personalCarteData[index].links.products);
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
                                              padding: const EdgeInsets.all(10),
                                              child: personalCarteData[index].mobileBanner.isEmpty
                                                  ?

                                                  //Text("OK"):
                                                  Image.asset("assets/app_logo.png")
                                                  : Image.network(
                                                      imagePath + personalCarteData[index].mobileBanner,
                                                    ),
                                            ),
                                          ),
                                        ),
                                        sized5,
                                        Text(
                                          personalCarteData[index].name,
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
                                              padding: const EdgeInsets.all(10),
                                              child: Center(
                                                child: personalCarteData[index].mobileBanner.isEmpty
                                                    ?

                                                    //Text("OK"):
                                                    Image.asset("assets/app_logo.png")
                                                    : Image.network(
                                                        imagePath + personalCarteData[index].mobileBanner,
                                                      ),
                                              ),
                                            ),
                                          ),
                                          sized5,
                                          Text(
                                            personalCarteData[index].name,
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
                        "$personalCarteDataItem",
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
                          itemCount: personalCarteProducts.length,
                          itemBuilder: (_, index) {
                            return Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Container(
                                decoration: BoxDecoration(color: Color(0xFFF1EDF2), borderRadius: BorderRadius.circular(15.0)),
                                //height: MediaQuery.of(context).size.height/3.2,
                                width: MediaQuery.of(context).size.width / 2.34,
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
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => GroceryDetails(
                                                      detailsLink: personalCarteProducts[index].links.details,
                                                  relatedProductLink: relatedProductsLink,
                                                    )));
                                      },
                                      child: Container(
                                        child: Image.network(imagePath + personalCarteProducts[index].thumbnailImage),
                                        height: MediaQuery.of(context).size.height / 8,
                                        width: MediaQuery.of(context).size.width / 2.34,
                                      ),
                                    ),
                                    FittedBox(
                                      child: Container(
                                        ///height: height! * 0.08,
                                        width: MediaQuery.of(context).size.width / 2.36,
                                        height: MediaQuery.of(context).size.height / 17,
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(5, 5, 5, 0),
                                          child: Text(
                                            personalCarteProducts[index].name,
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
                                          personalCarteProducts[index].unit,
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
                                              Text(personalCarteProducts[index].baseDiscountedPrice.toString(),
                                                  style: TextStyle(color: Color(0xFF515151), fontSize: 16, fontWeight: FontWeight.w700)),
                                              Text(personalCarteProducts[index].basePrice.toString(),
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
                                                  Navigator.push(context, MaterialPageRoute(builder: (context) => CartDetails()));
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
            ),

            SizedBox(
              height: 30,
            ),
            //bread biscuit & snacks
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

                  Container(
                    width: MediaQuery.of(context).size.width / 1.05,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Bread Biscuits & Snacks",
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
                    //height: height*0.22,
                    height: height * 0.24,
                    width: width,
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: breadBiscuitData.length,
                      itemBuilder: (_, index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              valueOne = index.toString();
                              breadBiscuitItemTitle = breadBiscuitData[index].name;
                              getBreadBiscuitProductsAfterTap(breadBiscuitData[index].links.products);
                            });
                          },
                          child: valueOne.toString() != index.toString()
                              ? Container(
                                  child: Container(
                                    //height: height * 0.2,
                                    height: height * 0.22,
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
                                              padding: const EdgeInsets.all(10),
                                              child: breadBiscuitData[index].mobileBanner.isEmpty
                                                  ?

                                                  //Text("OK"):
                                                  Image.asset("assets/app_logo.png")
                                                  : Image.network(
                                                      imagePath + breadBiscuitData[index].mobileBanner,
                                                    ),
                                            ),
                                          ),
                                        ),
                                        sized5,
                                        Text(
                                          breadBiscuitData[index].name,
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
                                      height: height * 0.22,
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
                                              padding: const EdgeInsets.all(10),
                                              child: Center(
                                                child: breadBiscuitData[index].mobileBanner.isEmpty
                                                    ?

                                                    //Text("OK"):
                                                    Image.asset("assets/app_logo.png")
                                                    : Image.network(
                                                        imagePath + breadBiscuitData[index].mobileBanner,
                                                      ),
                                              ),
                                            ),
                                          ),
                                          sized5,
                                          Text(
                                            breadBiscuitData[index].name,
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
                        "$breadBiscuitItemTitle",
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
                          itemCount: breadBiscuitProducts.length,
                          itemBuilder: (_, index) {
                            return Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Container(
                                decoration: BoxDecoration(color: Color(0xFFF1EDF2), borderRadius: BorderRadius.circular(15.0)),
                                //height: MediaQuery.of(context).size.height/3.2,
                                width: MediaQuery.of(context).size.width / 2.34,
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
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => GroceryDetails(
                                                      detailsLink: breadBiscuitProducts[index].links.details,
                                                  relatedProductLink: relatedProductsLink,
                                                    )));
                                      },
                                      child: Container(
                                        child: Image.network(imagePath + breadBiscuitProducts[index].thumbnailImage),
                                        height: MediaQuery.of(context).size.height / 8,
                                        width: MediaQuery.of(context).size.width / 2.34,
                                      ),
                                    ),
                                    FittedBox(
                                      child: Container(
                                        ///height: height! * 0.08,
                                        width: MediaQuery.of(context).size.width / 2.36,
                                        height: MediaQuery.of(context).size.height / 17,
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(5, 5, 5, 0),
                                          child: Text(
                                            breadBiscuitProducts[index].name,
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
                                          breadBiscuitProducts[index].unit,
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
                                              Text(breadBiscuitProducts[index].baseDiscountedPrice.toString(),
                                                  style: TextStyle(color: Color(0xFF515151), fontSize: 16, fontWeight: FontWeight.w700)),
                                              Text(breadBiscuitProducts[index].basePrice.toString(),
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
                                                  Navigator.push(context, MaterialPageRoute(builder: (context) => CartDetails()));
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
            ),

            SizedBox(
              height: 30,
            ),
            //mega deal banner
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
              height: 30,
            ),
            //household
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

                  Container(
                    width: MediaQuery.of(context).size.width / 1.1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Household",
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
                      itemCount: householdData.length,
                      itemBuilder: (_, index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              valueOne = index.toString();
                              householdDataItem = householdData[index].name;
                              gethouseholProductsAfterTap(householdData[index].links.products);
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
                                              padding: const EdgeInsets.all(10),
                                              child: householdData[index].mobileBanner.isEmpty
                                                  ?
                                                  //Text("OK"):
                                                  Image.asset("assets/app_logo.png")
                                                  : Image.network(
                                                      imagePath + householdData[index].mobileBanner,
                                                    ),
                                            ),
                                          ),
                                        ),
                                        sized5,
                                        Text(
                                          householdData[index].name,
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
                                              padding: const EdgeInsets.all(10),
                                              child: Center(
                                                child: householdData[index].mobileBanner.isEmpty
                                                    ?

                                                    //Text("OK"):
                                                    Image.asset("assets/app_logo.png")
                                                    : Image.network(
                                                        imagePath + householdData[index].mobileBanner,
                                                      ),
                                              ),
                                            ),
                                          ),
                                          sized5,
                                          Text(
                                            householdData[index].name,
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
                        "$householdDataItem",
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
                          itemCount: householdProducts.length,
                          itemBuilder: (_, index) {
                            return Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Container(
                                decoration: BoxDecoration(color: Color(0xFFF1EDF2), borderRadius: BorderRadius.circular(15.0)),
                                //height: MediaQuery.of(context).size.height/3.2,
                                width: MediaQuery.of(context).size.width / 2.34,
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
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => GroceryDetails(
                                                      detailsLink: householdProducts[index].links.details,
                                                  relatedProductLink: relatedProductsLink,
                                                    )));
                                      },
                                      child: Container(
                                        child: Image.network(imagePath + householdProducts[index].thumbnailImage),
                                        height: MediaQuery.of(context).size.height / 8,
                                        width: MediaQuery.of(context).size.width / 2.34,
                                      ),
                                    ),
                                    FittedBox(
                                      child: Container(
                                        ///height: height! * 0.08,
                                        width: MediaQuery.of(context).size.width / 2.36,
                                        height: MediaQuery.of(context).size.height / 17,
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(5, 5, 5, 0),
                                          child: Text(
                                            householdProducts[index].name,
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
                                          householdProducts[index].unit,
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
                                              Text(householdProducts[index].basePrice.toString(),
                                                  style: TextStyle(color: Color(0xFF515151), fontSize: 16, fontWeight: FontWeight.w700)),
                                              Text(householdProducts[index].baseDiscountedPrice.toString(),
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
                                                  Navigator.push(context, MaterialPageRoute(builder: (context) => CartDetails()));
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
            ),

            SizedBox(
              height: 30,
            ),
            //chocolate & sweets
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

                  Container(
                    width: MediaQuery.of(context).size.width / 1.1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Chocolate & Sweets",
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
                      itemCount: chocolateSweetsData.length,
                      itemBuilder: (_, index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              valueOne = index.toString();
                              chocolateItemTitle = chocolateSweetsData[index].name;
                              getChocolateSweetsProductsAfterTap(chocolateSweetsData[index].links.products);
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
                                              padding: const EdgeInsets.all(10),
                                              child: chocolateSweetsData[index].mobileBanner.isEmpty
                                                  ?

                                                  //Text("OK"):
                                                  Image.asset("assets/app_logo.png")
                                                  : Image.network(
                                                      imagePath + chocolateSweetsData[index].mobileBanner,
                                                    ),
                                            ),
                                          ),
                                        ),
                                        sized5,
                                        Text(
                                          chocolateSweetsData[index].name,
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
                                              padding: const EdgeInsets.all(10.0),
                                              child: Center(
                                                child: chocolateSweetsData[index].mobileBanner.isEmpty
                                                    ?

                                                    //Text("OK"):
                                                    Image.asset("assets/app_logo.png")
                                                    : Image.network(
                                                        imagePath + chocolateSweetsData[index].mobileBanner,
                                                      ),
                                              ),
                                            ),
                                          ),
                                          sized5,
                                          Text(
                                            chocolateSweetsData[index].name,
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
                        "$chocolateItemTitle",
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
                          itemCount: chocolateSweetsProducts.length,
                          itemBuilder: (_, index) {
                            return Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Container(
                                decoration: BoxDecoration(color: Color(0xFFF1EDF2), borderRadius: BorderRadius.circular(15.0)),
                                //height: MediaQuery.of(context).size.height/3.2,
                                width: MediaQuery.of(context).size.width / 2.34,
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
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => GroceryDetails(
                                                      detailsLink: chocolateSweetsProducts[index].links.details,
                                                  relatedProductLink: relatedProductsLink,
                                                    )));
                                      },
                                      child: Container(
                                        child: Image.network(imagePath + chocolateSweetsProducts[index].thumbnailImage),
                                        height: MediaQuery.of(context).size.height / 8,
                                        width: MediaQuery.of(context).size.width / 2.34,
                                      ),
                                    ),
                                    FittedBox(
                                      child: Container(
                                        ///height: height! * 0.08,
                                        width: MediaQuery.of(context).size.width / 2.36,
                                        height: MediaQuery.of(context).size.height / 17,
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(5, 5, 5, 0),
                                          child: Text(
                                            chocolateSweetsProducts[index].name,
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
                                          chocolateSweetsProducts[index].unit,
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
                                              Text(chocolateSweetsProducts[index].basePrice.toString(),
                                                  style: TextStyle(color: Color(0xFF515151), fontSize: 16, fontWeight: FontWeight.w700)),
                                              Text(chocolateSweetsProducts[index].baseDiscountedPrice.toString(),
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
                                                  Navigator.push(context, MaterialPageRoute(builder: (context) => CartDetails()));
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
            ),

            SizedBox(
              height: 30,
            ),
            //big sale offer
            InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => OfferPage()));
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

            SizedBox(
              height: 30,
            ),
            //toys & gift
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

                  Container(
                    width: MediaQuery.of(context).size.width / 1.1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Toys & Gift",
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
                      itemCount: toyGiftData.length,
                      itemBuilder: (_, index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              valueOne = index.toString();
                              toyGiftDataItem = toyGiftData[index].name;
                              gettoyGiftAfterTap(toyGiftData[index].links.products);
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
                                              padding: const EdgeInsets.all(10),
                                              child: toyGiftData[index].mobileBanner.isEmpty
                                                  ?

                                                  //Text("OK"):
                                                  Image.asset("assets/app_logo.png")
                                                  : Image.network(
                                                      imagePath + toyGiftData[index].mobileBanner,
                                                    ),
                                            ),
                                          ),
                                        ),
                                        sized5,
                                        Text(
                                          toyGiftData[index].name,
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
                                              padding: const EdgeInsets.all(10),
                                              child: Center(
                                                child: toyGiftData[index].mobileBanner.isEmpty
                                                    ?

                                                    //Text("OK"):
                                                    Image.asset("assets/app_logo.png")
                                                    : Image.network(
                                                        imagePath + toyGiftData[index].mobileBanner,
                                                      ),
                                              ),
                                            ),
                                          ),
                                          sized5,
                                          Text(
                                            toyGiftData[index].name,
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
                        "$toyGiftDataItem",
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
                          itemCount: toyGiftProducts.length,
                          itemBuilder: (_, index) {
                            return Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Container(
                                decoration: BoxDecoration(color: Color(0xFFF1EDF2), borderRadius: BorderRadius.circular(15.0)),
                                //height: MediaQuery.of(context).size.height/3.2,
                                width: MediaQuery.of(context).size.width / 2.34,
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
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => GroceryDetails(
                                                      detailsLink: toyGiftProducts[index].links.details,
                                                  relatedProductLink: relatedProductsLink,
                                                    )));
                                      },
                                      child: Container(
                                        child: Image.network((imagePath) + toyGiftProducts[index].thumbnailImage),
                                        height: MediaQuery.of(context).size.height / 8,
                                        width: MediaQuery.of(context).size.width / 2.34,
                                      ),
                                    ),
                                    FittedBox(
                                      child: Container(
                                        ///height: height! * 0.08,
                                        width: MediaQuery.of(context).size.width / 2.36,
                                        height: MediaQuery.of(context).size.height / 17,
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(5, 5, 5, 0),
                                          child: Text(
                                            toyGiftProducts[index].name,
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
                                          toyGiftProducts[index].unit,
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
                                              Text(toyGiftProducts[index].basePrice.toString(),
                                                  style: TextStyle(color: Color(0xFF515151), fontSize: 16, fontWeight: FontWeight.w700)),
                                              Text(toyGiftProducts[index].baseDiscountedPrice.toString(),
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
                                                  Navigator.push(context, MaterialPageRoute(builder: (context) => CartDetails()));
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
            ),

            SizedBox(
              height: 30,
            ),
            //stationary
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

                  Container(
                    width: MediaQuery.of(context).size.width / 1.1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Stationary",
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
                      itemCount: stationaryData.length,
                      itemBuilder: (_, index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              valueOne = index.toString();
                              stationaryDataItem = stationaryData[index].name;
                              getpstationaryAfterTap(stationaryData[index].links.products);
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
                                              padding: const EdgeInsets.all(10),
                                              child: stationaryData[index].mobileBanner.isEmpty
                                                  ?

                                                  //Text("OK"):
                                                  Image.asset("assets/app_logo.png")
                                                  : Image.network(
                                                      imagePath + stationaryData[index].mobileBanner,
                                                    ),
                                            ),
                                          ),
                                        ),
                                        sized5,
                                        Text(
                                          stationaryData[index].name,
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
                                              padding: const EdgeInsets.all(10),
                                              child: Center(
                                                child: stationaryData[index].mobileBanner.isEmpty
                                                    ?

                                                    //Text("OK"):
                                                    Image.asset("assets/app_logo.png")
                                                    : Image.network(
                                                        imagePath + stationaryData[index].mobileBanner,
                                                      ),
                                              ),
                                            ),
                                          ),
                                          sized5,
                                          Text(
                                            stationaryData[index].name,
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
                        "$stationaryDataItem",
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
                          itemCount: stationaryProducts.length,
                          itemBuilder: (_, index) {
                            return Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Container(
                                decoration: BoxDecoration(color: Color(0xFFF1EDF2), borderRadius: BorderRadius.circular(15.0)),
                                //height: MediaQuery.of(context).size.height/3.2,
                                width: MediaQuery.of(context).size.width / 2.34,
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
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => GroceryDetails(
                                                      detailsLink: stationaryProducts[index].links.details,
                                                  relatedProductLink: relatedProductsLink,
                                                    )));
                                      },
                                      child: Container(
                                        child: Image.network(imagePath + stationaryProducts[index].thumbnailImage),
                                        height: MediaQuery.of(context).size.height / 8,
                                        width: MediaQuery.of(context).size.width / 2.34,
                                      ),
                                    ),
                                    FittedBox(
                                      child: Container(
                                        ///height: height! * 0.08,
                                        width: MediaQuery.of(context).size.width / 2.36,
                                        height: MediaQuery.of(context).size.height / 17,
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(5, 5, 5, 0),
                                          child: Text(
                                            stationaryProducts[index].name,
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
                                          stationaryProducts[index].unit,
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
                                              Text(stationaryProducts[index].basePrice.toString(),
                                                  style: TextStyle(color: Color(0xFF515151), fontSize: 16, fontWeight: FontWeight.w700)),
                                              Text(stationaryProducts[index].baseDiscountedPrice.toString(),
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
                                                  Navigator.push(context, MaterialPageRoute(builder: (context) => CartDetails()));
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
            ),

            SizedBox(
              height: 35,
            ),

            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                image: DecorationImage(image: AssetImage("assets/img_72.png"), fit: BoxFit.cover),
                color: Colors.white,
              ),
              height: 130,
              width: MediaQuery.of(context).size.width / 1.1,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                child: Image.asset("assets/img_73.png"),
              ),
            ),

            sized20,

            Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Didn't find\nwhat you\nwere looking for?",
                  style: TextStyle(color: Color(0xFFB99DCB), fontSize: 28, fontWeight: FontWeight.bold, fontFamily: "CeraProBold"),
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
              height: height * 0.14,
              //width: width,
              width: MediaQuery.of(context).size.width / 1.1,
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
        )),
      ),
    );
  }
}

 */
