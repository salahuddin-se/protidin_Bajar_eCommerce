import 'dart:convert';
import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:customer_ui/all_screen/all_offerpage.dart';
import 'package:customer_ui/all_screen/cart_detailspage.dart';
import 'package:customer_ui/components/drawer_class.dart';
import 'package:customer_ui/components/size_config.dart';
import 'package:customer_ui/components/styles.dart';
import 'package:customer_ui/components/utils.dart';
import 'package:customer_ui/controller/cartItemsController.dart';
import 'package:customer_ui/dataModel/category_data_model.dart';
import 'package:customer_ui/dataModel/one_ninetynine_data_model.dart';
import 'package:customer_ui/dataModel/search_data_model.dart';
import 'package:customer_ui/dataModel/slider_model.dart';
import 'package:customer_ui/preferences/user_preferance.dart';
import 'package:customer_ui/ruf/search.dart';
import 'package:customer_ui/welcomeScreen/sigininform.dart';
import 'package:customer_ui/widgets/category_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dropdown/flutter_dropdown.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

import '../dataModel/breat_biscuit.dart';
import '../dataModel/city_model.dart';
import '../dataModel/seller_response.dart';
import '../dataModel/shop_response.dart';
import 'offer_page.dart';
import 'product_details.dart';

class CategoryHomeScreen extends StatefulWidget {
  const CategoryHomeScreen({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<CategoryHomeScreen> {
  var value;
  var Cart;
  bool isLocationChanged = false;
  bool isCategoryLoaded = false;
  String newArea = "";
  //final keyIsFirstLoaded = 'is_first_loaded';

  Future<dynamic> buildShowDialog(BuildContext context, List<String> areaName, List<String> cityName) {
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
                                ///items: [cityName[0]],
                                items: [cityName[0]],

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
                              //
                              items: areaName..removeAt(0),

                              //: areaName..removeAt(0)..add("Sylhet"); means:
                              //areaName =  areaName..removeAt(0);
                              //areaName = areaName..add("Sylhet");
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
                              onChanged: (String? value) {
                                newArea = value!;
                              },
                            ),
                          ),
                        ),
                      ),
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
                          setState(() {
                            selectAreaName = newArea;
                            isLocationChanged = true;
                            log("Area name is $selectAreaName");
                          });
                          Navigator.of(context).pop();
                          if (!UserPreference.containsKey(UserPreference.showAreaDialogue)) {
                            UserPreference.setBool(UserPreference.showAreaDialogue, true);
                            UserPreference.setString(UserPreference.selectedArea, selectAreaName);
                          } else {
                            UserPreference.setString(UserPreference.selectedArea, selectAreaName);
                          }
                          fetchShop(selectAreaName).then((value) {
                            getCategory();
                          });
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
    log("------USER TOKEN IS------ :${box.read(userToken)}");
    //Clipboard.setData(ClipboardData(text: box.read(userToken)));
    controller.getCartName();

    UserPreference.setPreference().then((value) {
      if (!UserPreference.containsKey(UserPreference.showAreaDialogue)) {
        getCityName(true);
      } else {
        setState(() {
          selectAreaName = UserPreference.getString(UserPreference.selectedArea) ?? "";
        });
        getCityName(false);
      }
    });

    getSliderSearch();
    getOneTo99Data();
    fetchShop(selectAreaName).then((value) {
      getCategory();
      fetchSellers(selectAreaName);
    });
  }

  //

  //

  /// slider
  var sliderData = [];
  Future<void> getSliderSearch() async {
    String sliderURl = "http://test.protidin.com.bd:88/api/v2/sliders";

    final res3 = await get(Uri.parse(sliderURl), headers: {"Accept": "application/json"});

    var sliderDataMap = jsonDecode(res3.body);

    if (sliderDataMap["success"] == true) {
      //log("data valid");
      var sliderDataModel = SliderModel.fromJson(sliderDataMap);
      sliderData = sliderDataModel.data;

      ///categoryItemData = categoryDataModel.data[0].name;

      setState(() {});
    }
    // log("after decode $dataMap");
  }

  /// add to cart
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
      await controller.getCartName();

      //await getCartSummary();
    } else {
      showToast("Something went wrong", context: context);
    }

    /////////
    //box.write(add_carts, addToCart(, box.read(userID), 1));
    ////////
  }

  Future<void> updateAddressInCart(userId) async {
    var jsonBody = (<String, dynamic>{"user_id": userId.toString(), "address_id": userId.toString()});

    var res = await post(Uri.parse("http://test.protidin.com.bd:88/api/v2/update-address-in-cart"),
        headers: <String, String>{'Accept': 'application/json', 'Authorization': 'Bearer ${box.read(userToken)}'}, body: jsonBody);

    log("update cart ${res.body}");

    if (res.statusCode == 200 || res.statusCode == 201) {
      var dataMap = jsonDecode(res.body);
    } else {
      showToast("Something went wrong", context: context);
    }
    setState(() {});
  }

  /// logout
  Future<void> getLogoutResponse() async {
    log("Log out response calling");
    final response = await http.get(
      Uri.parse("http://test.protidin.com.bd:88/api/v2/auth/logout"),
      headers: {"Authorization": "Bearer ${box.read(userToken)}"},
    );

    //
    if (response.statusCode == 200 || response.statusCode == 201) {
      UserPreference.clearPreference();
      Navigator.push(context, MaterialPageRoute(builder: (context) => SignInPage()));

      ///print(box.read('userName'));
      ///log(userDataModel.user.name);

      setState(() {});
    }
    //

    log("Response from log out ${response.body}");

    ///return logoutResponseFromJson(response.body);
  }

  var productData = [];

  /// search product
  Future<void> getProductBySearch({required String name}) async {
    String searchProductURl = "http://test.protidin.com.bd:88/api/v2/products/search";

    final response3 = await get(Uri.parse(searchProductURl), headers: {"Accept": "application/json"});

    var productDataMap = jsonDecode(response3.body);

    if (productDataMap["success"] == true) {
      //log("data valid");
      var productDataModel = SearchProductModel.fromJson(productDataMap);
      productData = productDataModel.data;

      ///categoryItemData = categoryDataModel.data[0].name;

      setState(() {});
    }
    // log("after decode $dataMap");
  }

  var demo = [];

  ///
  ///
  var controller = Get.put(CartItemsController());

  ///
  ///
  List<String> cityData = [];
  var selectDhaka = " ";

  List<String> areaName = [];
  List<String> cityName = [];
  var _shops = [];
  var _sellers = [];
  var selectAreaName = "";
  int _webStoreId = 0;
  int _userId = 0;
  int shopId = 0;
  var shopName = "";

  Future<void> getCityName(bool isShowDialog) async {
    areaName.clear();
    cityName.clear();

    var response = await get(Uri.parse("http://test.protidin.com.bd:88/api/v2/cities"), headers: <String, String>{
      'Accept': 'application/json',
    });

    log("Get City Name: " + response.body);

    var dataMap = jsonDecode(response.body);

    var areaModel = CityModel.fromJson(dataMap);
    for (var element in areaModel.data) {
      cityName.add(element.name);
      areaName.add(element.area);
    }
    // city name comment out

    if (isShowDialog) buildShowDialog(context, areaName, cityName);

    setState(() {});
    //log("area2 name $areaName");
    //log("city2 name $cityName");
  }

  Future fetchShop(String areaName) async {
    _shops.clear();
    var response = await get(Uri.parse("http://test.protidin.com.bd:88/api/v2/shops?page=1"));
    log("shops res: " + response.body);
    var shopResponse = shopResponseFromJson(response.body);
    _shops.addAll(shopResponse.shops!);
    setState(() {});
    fetchSellers(areaName);
  }

  Future fetchSellers(String areaName) async {
    _sellers.clear();
    var response = await get(Uri.parse("http://test.protidin.com.bd:88/api/v2/sellers?page=1&name=''"));
    log("sellers res: " + response.body);
    var sellerResponse = sellerResponseFromJson(response.body);
    _sellers.addAll(sellerResponse.sellers!);
    for (Seller seller in _sellers) {
      if (seller.area != '') {
        var areaJson = jsonDecode(seller.area!);
        List<String> areaList = areaJson != null ? List.from(areaJson) : [];
        for (String area in areaList) {
          if (areaName == area) {
            _webStoreId = seller.webStoreId!;
            _userId = seller.userId!;

            log("webstore ID $_webStoreId");
            log("user ID $_userId");

            box.write(webStoreId, _webStoreId);
            box.write(user_Id, _userId);

            //await getCategoryData(name: widget.na)

            setState(() {
              isLocationChanged = false;
            });
          }
        }
      }
    }
  }

  var relatedProductsLink = " ";

  var categoryData = [];
  var categoryDatafor_add_banner = [];
  var categoryDataItem = "";
  var groceryLargeBanner = "";
  var chocolateLargeBanner = "";
  var breadLargeBanner = "";
  var dairyBeverageLargeBanner = "";
  var motherBabyLargeBanner = "";
  var fruitsVegLargeBanner = "";
  var personalCareLargeBanner = "";
  var householdLargeBanner = "";
  var toysGiftLargeBanner = "";
  var stationaryLargeBanner = "";

  ///
  var groceryAddBanner = "";
  var chocolateAddBanner = "";
  var breadAddBanner = "";
  var dairyBeverageAddBanner = "";
  var motherBabyAddBanner = "";
  var fruitsVegAddBanner = "";
  var personalCareAddBanner = "";
  var householdAddBanner = "";
  var toysGiftAddBanner = "";
  var stationaryAddBanner = "";

  ///

  Future<void> getCategory() async {
    log("comes");
    String productURl = "http://test.protidin.com.bd:88/api/v2/categories/home";

    final response = await get(Uri.parse(productURl), headers: {"Accept": "application/json"});

    var dataMap = jsonDecode(response.body);

    if (dataMap["success"] == true) {
      var categoryDataModel = CategoryDataModel.fromJson(dataMap);
      categoryData = categoryDataModel.data;
      categoryDataItem = categoryDataModel.data[0].name;
      for (var ele in categoryDataModel.data) {
        if (ele.name == "Grocery") {
          groceryLargeBanner = ele.largeBanner;
          //log("Banner Image $groceryLargeBanner");
        } else if (ele.name == "Chocolate & Sweets") {
          chocolateLargeBanner = ele.largeBanner;
        } else if (ele.name == "Bread Biscuit & Snacks") {
          breadLargeBanner = ele.largeBanner;
        } else if (ele.name == "Dairy & Beverages") {
          dairyBeverageLargeBanner = ele.largeBanner;
        } else if (ele.name == "Mother & Baby") {
          motherBabyLargeBanner = ele.largeBanner;
        } else if (ele.name == "Fruits & Vegetables") {
          fruitsVegLargeBanner = ele.largeBanner;
        } else if (ele.name == "Personal Care") {
          personalCareLargeBanner = ele.largeBanner;
        } else if (ele.name == "Household") {
          householdLargeBanner = ele.largeBanner;
        } else if (ele.name == "Toys & Gift") {
          toysGiftLargeBanner = ele.largeBanner;
        } else if (ele.name == "Stationery") {
          stationaryLargeBanner = ele.largeBanner;
        }

        ///
        if (ele.name == "Grocery") {
          groceryAddBanner = ele.addBanner;
          //log("Banner Image $groceryLargeBanner");
        } else if (ele.name == "Chocolate & Sweets") {
          chocolateAddBanner = ele.addBanner;
        } else if (ele.name == "Bread Biscuit & Snacks") {
          breadAddBanner = ele.addBanner;
        } else if (ele.name == "Dairy & Beverages") {
          dairyBeverageAddBanner = ele.addBanner;
        } else if (ele.name == "Mother & Baby") {
          motherBabyAddBanner = ele.addBanner;
        } else if (ele.name == "Fruits & Vegetables") {
          fruitsVegAddBanner = ele.addBanner;
        } else if (ele.name == "Personal Care") {
          personalCareAddBanner = ele.addBanner;
        } else if (ele.name == "Household") {
          householdAddBanner = ele.addBanner;
        } else if (ele.name == "Toys & Gift") {
          toysGiftAddBanner = ele.addBanner;
        } else if (ele.name == "Stationery") {
          stationaryAddBanner = ele.addBanner;
        }

        ///

      }
      setState(() {
        isCategoryLoaded = true;
      });
      getProductsAfterTap(categoryDataModel.data[0].links.products).then((value) {
        setState(() {
          isCategoryLoaded = false;
        });
      });

      //log("data length ${categoryData.length}");
    } else {}

    // log("after decode $dataMap");
  }

  var categoryProducts = [];
  List<ProductsData> productsData = [];

  Future<void> getProductsAfterTap(link) async {
    categoryProducts.clear();
    setState(() {
      isCategoryLoaded = true;
    });
    log("new user id ${box.read(user_Id)}");
    log("new web store id ${box.read(webStoreId)}");
    // log("calling 2");
    log("shop by cat link $link"); //String biscuitSweetsURl = "https://test.protidin.com.bd/api/v2/products/category/46";
    relatedProductsLink = link;
    final response6 = await get(Uri.parse(link), headers: {"Accept": "application/json"});

    var biscuitSweetsDataMap = jsonDecode(response6.body);

    if (biscuitSweetsDataMap["success"] == true) {
      //log("category data after tap $biscuitSweetsDataMap");

      var biscuitSweetsDataModel = BreadBiscuit.fromJson(biscuitSweetsDataMap);
      List<ProductsData> prodData = biscuitSweetsDataModel.data;

      productsData = prodData.where((element) => element.userId == box.read(user_Id) || element.userId == box.read(webStoreId)).toList();
      // for (var ele in biscuitSweetsDataModel.data) {
      //   productsData.clear();
      //
      //   log("element user_id: ${ele.userId == box.read(user_Id) || ele.userId == box.read(webStoreId)}");
      //   // log("seller user_id: ${ele.userId == box.read(webStoreId)}");
      //   if (ele.userId == box.read(user_Id) || ele.userId == box.read(webStoreId)) {
      //     productsData.add(ProductsData(
      //
      //         ///name: ele.name,
      //         name: ele.name,
      //         thumbnailImage: ele.thumbnailImage,
      //         baseDiscountedPrice: ele.baseDiscountedPrice,
      //         shopName: ele.shopName,
      //         basePrice: ele.basePrice,
      //         unit: ele.unit,
      //         id: ele.id,
      //         links: ele.links!,
      //         discount: ele.discount!,
      //         hasDiscount: ele.hasDiscount,
      //         userId: ele.userId));
      //   }
      // }
      // Future.delayed(Duration(seconds: 3), () {
      setState(() {
        categoryProducts = productsData;
        isCategoryLoaded = false;
      });
      // });

      //relatedProductsLink=ca
      //log("categoryProducts data length ${categoryProducts.length}");
    } else {
      //log("data invalid");
    }
    // log("after decode $dataMap");
  }

  var groceryProducts = [];

  /// 1 to 99 data
  List<OneToNinentyNineDataModel> oneTwoNinentyNineData = [];

  Future<void> getOneTo99Data() async {
    final response12 =
        await get(Uri.parse("http://test.protidin.com.bd:88/api/v2/products/category/4"), headers: {"Accept": "application/json"});

    var oneTwoNinentyNineItemDataMap = jsonDecode(response12.body);

    if (oneTwoNinentyNineItemDataMap["success"] == true) {
      //log("category data after tap $biscuitSweetsDataMap");

      setState(() {
        var onToNinetyNine = BreadBiscuit.fromJson(oneTwoNinentyNineItemDataMap);

        //oneTwoNinentyNineData=onToNinetyNine.data;

        for (var i = 0; i < onToNinetyNine.data.length; i++) {
          if (int.parse(onToNinetyNine.data[i].basePrice!.substring(1)) <= 99) {
            //log("price between 1-99: ${onToNinetyNine.data[i].basePrice}");

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
    } else {
      //log("data invalid");
    }
    // log("after decode $dataMap");
  }

  Future<void> getCategoryData({required String name}) async {
    //log("grocery data calling");
    String groceryURl = "http://test.protidin.com.bd:88/api/v2/sub-categories/$name";

    final response3 = await get(Uri.parse(groceryURl), headers: {"Accept": "application/json"});

    var groceryDataMap = jsonDecode(response3.body);

    if (groceryDataMap["success"] == true) {
      //log("data valid");
      var categoryDataModel = CategoryDataModel.fromJson(groceryDataMap);
      categoryDatafor_add_banner = categoryDataModel.data;
      //categoryItemData = categoryDataModel.data[0].large_Banner;
      setState(() {});
      //log("grocery data length ${categoryData.length}");
    } else {
      //log("data invalid");
    }
    // log("after decode $dataMap");
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  ///var scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    SizeConfig().init(context);
    var width = SizeConfig.screenWidth;
    var height = SizeConfig.screenHeight;
    var block = SizeConfig.block;

    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: Color(0xFFF4EFF5),
        endDrawer: buildDrawerClass(context, block, callback: getLogoutResponse),
        body: SingleChildScrollView(
            child: Padding(
          //padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 15.0),
          padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 15.0),
          child: Column(children: [
            SizedBox(
              height: 10,
            ),

            /// search bar
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
                height: 45,
                child: Row(
                  children: [
                    ///

                    GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => SearchScreen()));

                        ///Navigator.push(context, MaterialPageRoute(builder: (context) => TrackOrder()));
                      },
                      child: SizedBox(
                          height: 20,
                          //width: 80,
                          width: MediaQuery.of(context).size.width / 7,
                          child: Image.asset("assets/img_27.png") //
                          ),
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
                          if (!_scaffoldKey.currentState!.isEndDrawerOpen) {
                            //check if drawer is closed
                            _scaffoldKey.currentState!.openEndDrawer(); //open drawer
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
                child: GestureDetector(
                  onTap: () {
                    getCityName(true);
                  },
                  child: SizedBox(
                    height: 40,
                    //width: 200,
                    width: MediaQuery.of(context).size.width / 1.2,
                    child: Row(
                      children: [
                        SizedBox(height: 17, child: Image.asset("assets/img_49.png")),
                        Padding(
                          padding: const EdgeInsets.only(top: 2.5),
                          child: Text(
                            "   $selectAreaName  ",

                            ///"  Protidin PG Store, Shahbag ",
                            style: TextStyle(
                              color: Colors.grey[700],
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              fontFamily: "CeraProBold",
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            getCityName(true);
                          },
                          child: Container(
                              height: 8,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 0.0),
                                child: Image.asset(
                                  "assets/img_50.png",
                                  height: 5,
                                  color: Colors.black,
                                ),
                              )),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(
              height: 0,
            ),

            /// top banner

            CarouselSlider.builder(
                itemCount: sliderData.length,
                itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) => Container(
                      ///height: 250,
                      child: Image.network(imagePath + sliderData[itemIndex].photo),
                    ),
                options: CarouselOptions(
                  height: 120,

                  ///aspectRatio: 16 / 9,
                  aspectRatio: 16 / 12,
                  viewportFraction: 1,
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  reverse: false,
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 3),
                  autoPlayAnimationDuration: Duration(milliseconds: 800),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enlargeCenterPage: true,

                  ///onPageChanged: callbackFunction,
                  scrollDirection: Axis.horizontal,
                )),

            SizedBox(
              height: 10,
            ),

            /// Offer For you
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
                child: Container(
                  //height: 170,
                  height: 170,
                  child: Row(
                    children: <Widget>[
                      InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => OfferPage()));
                        },
                        child: Container(
                          //decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
                          child: Image.asset("assets/p1.png"),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 15),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => OfferPage()));
                        },
                        child: Container(
                          child: Image.asset("assets/p2.png"),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 15),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => OfferPage()));
                        },
                        child: Container(
                          child: Image.asset("assets/p3.png"),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 15),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => OfferPage()));
                        },
                        child: Container(
                          child: Image.asset("assets/p4.png"),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 15),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => OfferPage()));
                        },
                        child: Container(
                          child: Image.asset("assets/p5.png"),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 15),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => OfferPage()));
                        },
                        child: Container(
                          child: Image.asset("assets/p6.png"),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 15),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => OfferPage()));
                        },
                        child: Container(
                          child: Image.asset("assets/p7.png"),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 15),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            SizedBox(
              height: 30,
            ),

            /// shop by category
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
                                    relatedProductsLink = categoryData[index].links.products;
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
                                            style: TextStyle(
                                                color: Color(0xFF515151),
                                                fontWeight: FontWeight.w700,
                                                fontSize: 16,
                                                fontStyle: FontStyle.normal,
                                                fontFamily: "CeraProBold"),
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
                                          style: TextStyle(
                                              color: Color(0xFF515151),
                                              fontWeight: FontWeight.w700,
                                              fontSize: 16,
                                              fontStyle: FontStyle.normal,
                                              fontFamily: "CeraProBold"),
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

                      ///
                      isCategoryLoaded || isLocationChanged
                          ? Container(
                              height: MediaQuery.of(context).size.height / 3,
                            )
                          : Container(
                              height: MediaQuery.of(context).size.height / 3,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                itemCount: categoryProducts.length,
                                itemBuilder: (_, index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: Container(
                                      decoration: BoxDecoration(color: Color(0xFFF4F1F5), borderRadius: BorderRadius.circular(15.0)),
                                      width: MediaQuery.of(context).size.width / 2.34,
                                      child: Column(
                                        children: [
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: Container(
                                              width: MediaQuery.of(context).size.width / 5,
                                              height: MediaQuery.of(context).size.height / 41,
                                              margin: EdgeInsets.only(top: 10),
                                              decoration: BoxDecoration(
                                                color: categoryProducts[index].hasDiscount == true ? Colors.green : Color(0xFFF1EDF2),
                                                borderRadius:
                                                    BorderRadius.only(topRight: Radius.circular(4.0), bottomRight: Radius.circular(4.0)),
                                              ),
                                              //
                                              child: Align(
                                                alignment: Alignment.centerLeft,
                                                child: categoryProducts[index].hasDiscount == true
                                                    ? Padding(
                                                        padding: const EdgeInsets.only(left: 3.0),
                                                        child: Text(
                                                          "${categoryProducts[index].discount.toString()}TK OFF",
                                                          style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w700),
                                                        ),
                                                      )
                                                    : Text(
                                                        //"15% OFF",
                                                        "",
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
                                                  builder: (context) => ProductDetails(
                                                    detailsLink: categoryProducts[index].links.details,
                                                    relatedProductLink: relatedProductsLink,
                                                  ),
                                                ),
                                              );
                                            },
                                            child: Container(
                                              child: Image.network(imagePath + categoryProducts[index].thumbnailImage),
                                              height: MediaQuery.of(context).size.height / 8,
                                              width: MediaQuery.of(context).size.width / 2.34,
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) => ProductDetails(
                                                            detailsLink: categoryProducts[index].links.details,
                                                            relatedProductLink: relatedProductsLink,
                                                          )));
                                            },
                                            child: FittedBox(
                                              child: Container(
                                                ///height: height! * 0.08,
                                                width: MediaQuery.of(context).size.width / 2.36,
                                                height: MediaQuery.of(context).size.height / 16.5,
                                                child: Padding(
                                                  padding: const EdgeInsets.fromLTRB(5, 5, 5, 0),
                                                  child: Text(
                                                    categoryProducts[index].name,
                                                    //'ACI Healthy 100% pure Soybean Oil',
                                                    style: TextStyle(
                                                      color: Color(0xFF515151),
                                                      fontSize: 15.3111,
                                                      //fontWeight: FontWeight.w300,
                                                      fontFamily: "CeraProMedium",
                                                      fontWeight: FontWeight.w500,
                                                      fontStyle: FontStyle.normal,
                                                    ),
                                                    maxLines: 2,
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Center(
                                            child: Container(
                                              height: MediaQuery.of(context).size.height / 40,
                                              child: Text(
                                                categoryProducts[index].unit,
                                                style: TextStyle(color: Colors.grey.withOpacity(0.9), fontSize: 15),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                            child: Center(
                                              child: Container(
                                                //height: MediaQuery.of(context).size.height/32,
                                                height: MediaQuery.of(context).size.height / 22,
                                                width: MediaQuery.of(context).size.width / 2.34,
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                  children: [
                                                    Container(
                                                      child: Image.asset(
                                                        "assets/p.png",
                                                        height: 24,
                                                        width: 24,
                                                      ),
                                                      height: 24,
                                                      width: 24,
                                                    ),
                                                    Text(categoryProducts[index].baseDiscountedPrice.toString(),
                                                        style: TextStyle(
                                                          color: Color(0xFF515151),
                                                          fontSize: 19,
                                                          fontFamily: 'CeraProMedium',
                                                          fontWeight: FontWeight.bold,
                                                        )),
                                                    categoryProducts[index].baseDiscountedPrice == categoryProducts[index].basePrice
                                                        ? Text("")
                                                        : Text(categoryProducts[index].basePrice.toString(),
                                                            style: TextStyle(
                                                                color: Color(0xFFA299A8),
                                                                fontSize: 13,
                                                                fontWeight: FontWeight.w500,
                                                                decoration: TextDecoration.lineThrough)),
                                                    Padding(
                                                      padding: const EdgeInsets.only(left: 10),
                                                    ),
                                                    GestureDetector(
                                                      onTap: () {
                                                        addToCart(categoryProducts[index].id, box.read(userID), 1);
                                                        //Navigator.push(context, MaterialPageRoute(builder: (context) => CartDetails()));
                                                      },
                                                      child: Container(
                                                        height: 40,
                                                        width: 40,
                                                        decoration: BoxDecoration(color: kPrimaryColor, shape: BoxShape.circle),
                                                        child: Center(
                                                          child: Image.asset(
                                                            "assets/pi.png",
                                                            height: 40,
                                                            width: 40,
                                                          ),
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
                                            height: MediaQuery.of(context).size.height / 26,
                                            width: MediaQuery.of(context).size.width / 2.34,
                                            decoration: BoxDecoration(
                                                color: Color(0xFFDDEAE1),
                                                borderRadius: BorderRadius.only(
                                                    bottomLeft: Radius.circular(10.0), bottomRight: Radius.circular(10.0))),
                                            child: Padding(
                                              padding: const EdgeInsets.fromLTRB(1, 3, 1, 3),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    child: Image.asset("assets/img_42.png"),
                                                    height: 12,
                                                    width: 10,
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.fromLTRB(4, 3, 0, 0),
                                                    child: Text(
                                                      "Earning  +৳18",
                                                      style: TextStyle(fontSize: 13, color: Colors.green, fontWeight: FontWeight.w600),
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
                                },
                              ),
                            ),

                      ///

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

            ///1-99 store
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
                      children: const [
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

                                          height: MediaQuery.of(context).size.height / 41,
                                          margin: EdgeInsets.only(top: 10),
                                          decoration: BoxDecoration(
                                            color: oneTwoNinentyNineData[index].discount == 0 ? Color(0xFFF4F1F5) : Color(0xFF10AA2A),
                                            borderRadius:
                                                BorderRadius.only(topRight: Radius.circular(4.0), bottomRight: Radius.circular(4.0)),
                                          ),
                                          //

                                          child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: oneTwoNinentyNineData[index].discount == 0
                                                  ? Text(
                                                      //"15% OFF",
                                                      "",
                                                      style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w500),
                                                    )
                                                  : Padding(
                                                      padding: const EdgeInsets.only(left: 3.0),
                                                      child: Text(
                                                        //"15% OFF",
                                                        "${oneTwoNinentyNineData[index].discount.toString()}TK OFF",
                                                        style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w700),
                                                      ),
                                                    )),
                                        ),
                                      ),
                                      Container(
                                        height: MediaQuery.of(context).size.height / 8,
                                        child: InkWell(
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
                                            oneTwoNinentyNineData[index].unit.toString(),
                                            style: TextStyle(color: Colors.grey.withOpacity(0.9)),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                        child: Center(
                                          child: Container(
                                            height: MediaQuery.of(context).size.height / 22.8,
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
                                                oneTwoNinentyNineData[index].basePrice == oneTwoNinentyNineData[index].disCountPrice
                                                    ? Text("")
                                                    : Text(oneTwoNinentyNineData[index].basePrice.toString(),
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
                                                    //box.write("sub_category", subCategoryProducts);
                                                    //addToCart();

                                                    addToCart(oneTwoNinentyNineData[index].id, box.read(userID), 1);
                                                    //Navigator.push(context, MaterialPageRoute(builder: (context) => CartDetails()));
                                                    //addToCart(box.read(areaName.toString()), box.read(userID), 1);
                                                  },
                                                  /*onTap: () {
                                                    Navigator.push(context, MaterialPageRoute(builder: (context) => CartDetails()));
                                                  },*/
                                                  child: Container(
                                                    height: 40,
                                                    width: 40,
                                                    decoration: BoxDecoration(color: kPrimaryColor, shape: BoxShape.circle),
                                                    child: Center(
                                                      child: Image.asset(
                                                        "assets/pi.png",
                                                        height: 40,
                                                        width: 40,
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        height: MediaQuery.of(context).size.height / 28,
                                        width: MediaQuery.of(context).size.width / 2.34,
                                        decoration: BoxDecoration(
                                            color: Color(0xFFDDEAE1),
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
                                                padding: const EdgeInsets.fromLTRB(4, 3, 0, 0),
                                                child: Text(
                                                  "  Earning  +৳18",
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

            isLocationChanged
                ? Container()
                : CategoryContainer(
                    categoryName: "Grocery",
                    nameNo: 4,
                    large_Banner: groceryLargeBanner,
                    add_banner: groceryAddBanner,
                  ),

            SizedBox(
              height: 30,
            ),
            isLocationChanged
                ? Container()
                : CategoryContainer(
                    categoryName: "Dairy & Beverage",
                    nameNo: 7,
                    large_Banner: dairyBeverageLargeBanner,
                    add_banner: dairyBeverageAddBanner),

            SizedBox(
              height: 30,
            ),
            isLocationChanged
                ? Container()
                : CategoryContainer(
                    categoryName: "Mother & Baby", nameNo: 8, large_Banner: motherBabyLargeBanner, add_banner: motherBabyAddBanner),

            SizedBox(
              height: 30,
            ),
            isLocationChanged
                ? Container()
                : CategoryContainer(
                    categoryName: "Fruits & Vegetables", nameNo: 9, large_Banner: fruitsVegLargeBanner, add_banner: fruitsVegAddBanner),

            SizedBox(
              height: 30,
            ),
            isLocationChanged
                ? Container()
                : CategoryContainer(
                    categoryName: "Personal Care", nameNo: 10, large_Banner: personalCareLargeBanner, add_banner: personalCareAddBanner),

            SizedBox(
              height: 30,
            ),
            isLocationChanged
                ? Container()
                : CategoryContainer(
                    categoryName: "Bread Biscuit & Snacks", nameNo: 11, large_Banner: breadLargeBanner, add_banner: breadAddBanner),

            SizedBox(
              height: 30,
            ),
            isLocationChanged
                ? Container()
                : CategoryContainer(
                    categoryName: "Household", nameNo: 13, large_Banner: householdLargeBanner, add_banner: householdAddBanner),

            SizedBox(
              height: 30,
            ),
            isLocationChanged
                ? Container()
                : CategoryContainer(
                    categoryName: "Chocolate & Sweets", nameNo: 46, large_Banner: chocolateLargeBanner, add_banner: chocolateAddBanner),

            SizedBox(
              height: 30,
            ),
            isLocationChanged
                ? Container()
                : CategoryContainer(
                    categoryName: "Toys & Gift", nameNo: 14, large_Banner: toysGiftLargeBanner, add_banner: toysGiftAddBanner),

            SizedBox(
              height: 30,
            ),
            isLocationChanged
                ? Container()
                : CategoryContainer(
                    categoryName: "Stationery", nameNo: 199, large_Banner: stationaryLargeBanner, add_banner: stationaryAddBanner),

            SizedBox(
              height: 30,
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

            Padding(
              padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
              child: Container(
                color: Colors.white,
                child: TextFormField(
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      contentPadding: EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                      hintText: 'Search Here',
                      prefixIcon: Padding(
                        padding: const EdgeInsets.only(left: 30),
                        child: Icon(Icons.search),
                      )),
                ),
              ),
            ),

            SizedBox(
              height: 20,
            ),

            Padding(
              padding: const EdgeInsets.only(left: 17.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text("or",
                        style: TextStyle(color: Color(0xFF515151), fontSize: 12.5, fontWeight: FontWeight.w100, fontFamily: "CeraProBold")),
                    Text("Request the item.",
                        style: TextStyle(color: Color(0xFFB99DCB), fontSize: 14.4, fontWeight: FontWeight.w100, fontFamily: "CeraProBold")),
                    Text(
                      "We will get it as soon as possible and\n notify you",
                      style: TextStyle(color: Color(0xFF515151), fontSize: 14.4, fontFamily: "CeraProBold"),
                    )
                  ],
                ),
              ),
            ),

            SizedBox(
              height: 30,
            ),

            /// call
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
                    size: block * 8,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Call for query:",
                        style: TextStyle(color: Colors.grey, fontSize: block * 5, fontFamily: "CeraProBold", fontWeight: FontWeight.normal),
                      ),
                      Text(
                        "01812-3456789",
                        style: TextStyle(color: kBlackColor, fontSize: block * 6, fontWeight: FontWeight.bold, fontFamily: "CeraProBold"),
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
        floatingActionButton: Container(
          // height: 75,
          // width: 75,
          height: 70,
          width: 70,

          child: FloatingActionButton(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //Icon(Icons.add_shopping_cart),

                  Center(
                      child: Padding(
                    //padding: const EdgeInsets.fromLTRB(25, 0, 0, 0),
                    padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                    child: Image.asset(
                      "assets/cat.png",
                      height: 29,
                    ),
                  )),

                  Obx(() => Align(
                        alignment: Alignment.topRight,
                        child: CircleAvatar(
                          radius: 10.5,
                          backgroundColor: Colors.green[500],
                          child: Text(
                            controller.cartLength.value.toString(),
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800),
                          ),
                        ),
                      )),
                ],
              ),
              backgroundColor: Color(0xFF9900FF),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => CartDetails()));
              }),
        ),
      ),
    );
  }
}

/*
import 'dart:convert';
import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:customer_ui/all_screen/all_offerpage.dart';
import 'package:customer_ui/all_screen/cart_detailspage.dart';
import 'package:customer_ui/components/drawer_class.dart';
import 'package:customer_ui/components/size_config.dart';
import 'package:customer_ui/components/styles.dart';
import 'package:customer_ui/components/utils.dart';
import 'package:customer_ui/controller/cartItemsController.dart';
import 'package:customer_ui/dataModel/category_data_model.dart';
import 'package:customer_ui/dataModel/one_ninetynine_data_model.dart';
import 'package:customer_ui/dataModel/search_data_model.dart';
import 'package:customer_ui/dataModel/slider_model.dart';
import 'package:customer_ui/preferences/user_preferance.dart';
import 'package:customer_ui/ruf/search.dart';
import 'package:customer_ui/welcomeScreen/sigininform.dart';
import 'package:customer_ui/widgets/category_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dropdown/flutter_dropdown.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

import '../dataModel/breat_biscuit.dart';
import '../dataModel/city_model.dart';
import '../dataModel/seller_response.dart';
import '../dataModel/shop_response.dart';
import 'offer_page.dart';
import 'product_details.dart';

class CategoryHomeScreen extends StatefulWidget {
  const CategoryHomeScreen({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<CategoryHomeScreen> {
  var value;
  var Cart;
  bool isLocationChanged = false;
  bool isCategoryLoaded = false;
  String newArea = "";
  //final keyIsFirstLoaded = 'is_first_loaded';

  Future<dynamic> buildShowDialog(BuildContext context, List<String> areaName, List<String> cityName) {
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
                          )
                      ),
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
                                ///items: [cityName[0]],
                                items: [cityName[0]],

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
                              //
                              items: areaName..removeAt(0),

                              //: areaName..removeAt(0)..add("Sylhet"); means:
                              //areaName =  areaName..removeAt(0);
                              //areaName = areaName..add("Sylhet");
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
                              onChanged: (String? value) {
                                newArea = value!;
                              },
                            ),
                          ),
                        ),
                      ),
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
                          setState(() {
                            selectAreaName = newArea;
                            isLocationChanged = true;
                            log("Area name is $selectAreaName");
                          });
                          Navigator.of(context).pop();
                          if (!UserPreference.containsKey(UserPreference.showAreaDialogue)) {
                            UserPreference.setBool(UserPreference.showAreaDialogue, true);
                            UserPreference.setString(UserPreference.selectedArea, selectAreaName);
                          } else {
                            UserPreference.setString(UserPreference.selectedArea, selectAreaName);
                          }
                          fetchShop(selectAreaName).then((value) {
                            getCategory();
                          });
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
    log("------USER TOKEN IS------ :${box.read(userToken)}");
    //Clipboard.setData(ClipboardData(text: box.read(userToken)));
    controller.getCartName();

    UserPreference.setPreference().then((value) {
      if (!UserPreference.containsKey(UserPreference.showAreaDialogue)) {
        getCityName(true);
      } else {
        getCityName(false).then((value) {
          setState(() {
            selectAreaName = UserPreference.getString(UserPreference.selectedArea) ?? "";
          });
        });
      }
    });

    getCategory();
    getSliderSearch();
    getOneTo99Data();
  }

  //

  //

  /// slider
  var sliderData = [];
  Future<void> getSliderSearch() async {
    String sliderURl = "https://test.protidin.com.bd/api/v2/sliders";

    final res3 = await get(Uri.parse(sliderURl), headers: {"Accept": "application/json"});

    var sliderDataMap = jsonDecode(res3.body);

    if (sliderDataMap["success"] == true) {
      //log("data valid");
      var sliderDataModel = SliderModel.fromJson(sliderDataMap);
      sliderData = sliderDataModel.data;

      ///categoryItemData = categoryDataModel.data[0].name;

      setState(() {});
    }
    // log("after decode $dataMap");
  }

  /// add to cart
  Future<void> addToCart(
    id,
    userId,
    quantity,
  ) async {
    log("user id $userId");
    var res = await http.post(Uri.parse("https://test.protidin.com.bd/api/v2/carts/add"),
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
      await controller.getCartName();

      //await getCartSummary();
    } else {
      showToast("Something went wrong", context: context);
    }

    /////////
    //box.write(add_carts, addToCart(, box.read(userID), 1));
    ////////
  }

  Future<void> updateAddressInCart(userId) async {
    var jsonBody = (<String, dynamic>{"user_id": userId.toString(), "address_id": userId.toString()});

    var res = await post(Uri.parse("https://test.protidin.com.bd/api/v2/update-address-in-cart"),
        headers: <String, String>{'Accept': 'application/json', 'Authorization': 'Bearer ${box.read(userToken)}'}, body: jsonBody);

    log("update cart ${res.body}");

    if (res.statusCode == 200 || res.statusCode == 201) {
      var dataMap = jsonDecode(res.body);
    } else {
      showToast("Something went wrong", context: context);
    }
    setState(() {});
  }

  /// logout
  Future<void> getLogoutResponse() async {
    log("Log out response calling");
    final response = await http.get(
      Uri.parse("https://test.protidin.com.bd/api/v2/auth/logout"),
      headers: {"Authorization": "Bearer ${box.read(userToken)}"},
    );

    //
    if (response.statusCode == 200 || response.statusCode == 201) {
      UserPreference.clearPreference();
      Navigator.push(context, MaterialPageRoute(builder: (context) => SignInPage()));

      ///print(box.read('userName'));
      ///log(userDataModel.user.name);

      setState(() {});
    }
    //

    log("Response from log out ${response.body}");

    ///return logoutResponseFromJson(response.body);
  }

  var productData = [];

  /// search product
  Future<void> getProductBySearch({required String name}) async {
    String searchProductURl = "https://test.protidin.com.bd/api/v2/products/search";

    final response3 = await get(Uri.parse(searchProductURl), headers: {"Accept": "application/json"});

    var productDataMap = jsonDecode(response3.body);

    if (productDataMap["success"] == true) {
      //log("data valid");
      var productDataModel = SearchProductModel.fromJson(productDataMap);
      productData = productDataModel.data;

      ///categoryItemData = categoryDataModel.data[0].name;

      setState(() {});
    }
    // log("after decode $dataMap");
  }

  var demo = [];
  var controller = Get.put(CartItemsController());

  List<String> cityData = [];
  var selectDhaka = " ";

  List<String> areaName = [];
  List<String> cityName = [];
  var _shops = [];
  var _sellers = [];
  var selectAreaName = "";
  int _webStoreId = 0;
  int _userId = 0;
  int shopId = 0;
  var shopName = "";

  Future<void> getCityName(bool isShowDialog) async {
    areaName.clear();
    cityName.clear();

    var response = await get(Uri.parse("https://test.protidin.com.bd/api/v2/cities"), headers: <String, String>{
      'Accept': 'application/json',
    });

    log("Get City Name: " + response.body);

    var dataMap = jsonDecode(response.body);

    var areaModel = CityModel.fromJson(dataMap);
    for (var element in areaModel.data) {
      cityName.add(element.name);
      areaName.add(element.area);
    }
    // city name comment out

    if (isShowDialog) buildShowDialog(context, areaName, cityName);

    setState(() {});
    //log("area2 name $areaName");
    //log("city2 name $cityName");
  }

  Future fetchShop(String areaName) async {
    _shops.clear();
    var response = await get(Uri.parse("https://test.protidin.com.bd/api/v2/shops?page=1"));
    log("shops res: " + response.body);
    var shopResponse = shopResponseFromJson(response.body);
    _shops.addAll(shopResponse.shops!);
    setState(() {});
    fetchSellers(areaName);
  }

  Future fetchSellers(String areaName) async {
    _sellers.clear();
    var response = await get(Uri.parse("https://test.protidin.com.bd/api/v2/sellers?page=1&name=''"));
    log("sellers res: " + response.body);
    var sellerResponse = sellerResponseFromJson(response.body);
    _sellers.addAll(sellerResponse.sellers!);
    for (Seller seller in _sellers) {
      if (seller.area != '') {
        var areaJson = jsonDecode(seller.area!);
        List<String>? areaList = areaJson != null ? List.from(areaJson) : null;
        for (String area in areaList!) {
          if (areaName == area) {
            _webStoreId = seller.webStoreId!;
            _userId = seller.userId!;

            box.write(webStoreId, _webStoreId);
            box.write(user_Id, _userId);

            log("webstore ID $_webStoreId");
            log("user ID $_userId");

            //await getCategoryData(name: widget.na)

            setState(() {
              isLocationChanged = false;
            });
          }
        }
      }
    }
  }

  ///

  ///

  var relatedProductsLink = " ";

  var categoryData = [];
  var categoryDatafor_add_banner = [];
  var categoryDataItem = "";
  var groceryLargeBanner = "";
  var chocolateLargeBanner = "";
  var breadLargeBanner = "";
  var dairyBeverageLargeBanner = "";
  var motherBabyLargeBanner = "";
  var fruitsVegLargeBanner = "";
  var personalCareLargeBanner = "";
  var householdLargeBanner = "";
  var toysGiftLargeBanner = "";
  var stationaryLargeBanner = "";

  ///
  var groceryAddBanner = "";
  var chocolateAddBanner = "";
  var breadAddBanner = "";
  var dairyBeverageAddBanner = "";
  var motherBabyAddBanner = "";
  var fruitsVegAddBanner = "";
  var personalCareAddBanner = "";
  var householdAddBanner = "";
  var toysGiftAddBanner = "";
  var stationaryAddBanner = "";

  ///

  Future<void> getCategory() async {
    log("comes");
    String productURl = "https://test.protidin.com.bd/api/v2/categories/home";

    final response = await get(Uri.parse(productURl), headers: {"Accept": "application/json"});

    var dataMap = jsonDecode(response.body);

    if (dataMap["success"] == true) {
      var categoryDataModel = CategoryDataModel.fromJson(dataMap);
      categoryData = categoryDataModel.data;
      categoryDataItem = categoryDataModel.data[0].name;
      for (var ele in categoryDataModel.data) {
        if (ele.name == "Grocery") {
          groceryLargeBanner = ele.largeBanner;
          //log("Banner Image $groceryLargeBanner");
        } else if (ele.name == "Chocolate & Sweets") {
          chocolateLargeBanner = ele.largeBanner;
        } else if (ele.name == "Bread Biscuit & Snacks") {
          breadLargeBanner = ele.largeBanner;
        } else if (ele.name == "Dairy & Beverages") {
          dairyBeverageLargeBanner = ele.largeBanner;
        } else if (ele.name == "Mother & Baby") {
          motherBabyLargeBanner = ele.largeBanner;
        } else if (ele.name == "Fruits & Vegetables") {
          fruitsVegLargeBanner = ele.largeBanner;
        } else if (ele.name == "Personal Care") {
          personalCareLargeBanner = ele.largeBanner;
        } else if (ele.name == "Household") {
          householdLargeBanner = ele.largeBanner;
        } else if (ele.name == "Toys & Gift") {
          toysGiftLargeBanner = ele.largeBanner;
        } else if (ele.name == "Stationery") {
          stationaryLargeBanner = ele.largeBanner;
        }

        ///
        if (ele.name == "Grocery") {
          groceryAddBanner = ele.addBanner;
          //log("Banner Image $groceryLargeBanner");
        } else if (ele.name == "Chocolate & Sweets") {
          chocolateAddBanner = ele.addBanner;
        } else if (ele.name == "Bread Biscuit & Snacks") {
          breadAddBanner = ele.addBanner;
        } else if (ele.name == "Dairy & Beverages") {
          dairyBeverageAddBanner = ele.addBanner;
        } else if (ele.name == "Mother & Baby") {
          motherBabyAddBanner = ele.addBanner;
        } else if (ele.name == "Fruits & Vegetables") {
          fruitsVegAddBanner = ele.addBanner;
        } else if (ele.name == "Personal Care") {
          personalCareAddBanner = ele.addBanner;
        } else if (ele.name == "Household") {
          householdAddBanner = ele.addBanner;
        } else if (ele.name == "Toys & Gift") {
          toysGiftAddBanner = ele.addBanner;
        } else if (ele.name == "Stationery") {
          stationaryAddBanner = ele.addBanner;
        }

        ///

      }
      setState(() {
        isCategoryLoaded = true;
      });
      getProductsAfterTap(categoryDataModel.data[0].links.products).then((value) {
        setState(() {
          isCategoryLoaded = false;
        });
      });

      //log("data length ${categoryData.length}");
    } else {}

    // log("after decode $dataMap");
  }

  var categoryProducts = [];
  List<ProductsData> productsData = [];

  Future<void> getProductsAfterTap(link) async {
    categoryProducts.clear();
    setState(() {
      isCategoryLoaded = true;
    });
    log("new user id ${box.read(user_Id)}");
    log("new web store id ${box.read(webStoreId)}");
    // log("calling 2");
    log("shop by cat link $link"); //String biscuitSweetsURl = "https://test.protidin.com.bd/api/v2/products/category/46";
    relatedProductsLink = link;
    final response6 = await get(Uri.parse(link), headers: {"Accept": "application/json"});

    var biscuitSweetsDataMap = jsonDecode(response6.body);

    if (biscuitSweetsDataMap["success"] == true) {
      //log("category data after tap $biscuitSweetsDataMap");

      var biscuitSweetsDataModel = BreadBiscuit.fromJson(biscuitSweetsDataMap);
      List<ProductsData> prodData = biscuitSweetsDataModel.data;

      productsData = prodData.where((element) => element.userId == box.read(user_Id) || element.userId == box.read(webStoreId)).toList();
      // for (var ele in biscuitSweetsDataModel.data) {
      //   productsData.clear();
      //
      //   log("element user_id: ${ele.userId == box.read(user_Id) || ele.userId == box.read(webStoreId)}");
      //   // log("seller user_id: ${ele.userId == box.read(webStoreId)}");
      //   if (ele.userId == box.read(user_Id) || ele.userId == box.read(webStoreId)) {
      //     productsData.add(ProductsData(
      //
      //         ///name: ele.name,
      //         name: ele.name,
      //         thumbnailImage: ele.thumbnailImage,
      //         baseDiscountedPrice: ele.baseDiscountedPrice,
      //         shopName: ele.shopName,
      //         basePrice: ele.basePrice,
      //         unit: ele.unit,
      //         id: ele.id,
      //         links: ele.links!,
      //         discount: ele.discount!,
      //         hasDiscount: ele.hasDiscount,
      //         userId: ele.userId));
      //   }
      // }
      // Future.delayed(Duration(seconds: 3), () {
      setState(() {
        categoryProducts = productsData;
        isCategoryLoaded = false;
      });
      // });

      //relatedProductsLink=ca
      //log("categoryProducts data length ${categoryProducts.length}");
    } else {
      //log("data invalid");
    }
    // log("after decode $dataMap");
  }

  var groceryProducts = [];

  /// 1 to 99 data
  List<OneToNinentyNineDataModel> oneTwoNinentyNineData = [];

  Future<void> getOneTo99Data() async {
    final response12 =
        await get(Uri.parse("https://test.protidin.com.bd/api/v2/products/category/4"), headers: {"Accept": "application/json"});

    var oneTwoNinentyNineItemDataMap = jsonDecode(response12.body);

    if (oneTwoNinentyNineItemDataMap["success"] == true) {
      //log("category data after tap $biscuitSweetsDataMap");

      setState(() {
        var onToNinetyNine = BreadBiscuit.fromJson(oneTwoNinentyNineItemDataMap);

        //oneTwoNinentyNineData=onToNinetyNine.data;

        for (var i = 0; i < onToNinetyNine.data.length; i++) {
          if (int.parse(onToNinetyNine.data[i].basePrice!.substring(1)) <= 99) {
            //log("price between 1-99: ${onToNinetyNine.data[i].basePrice}");

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
      categoryDatafor_add_banner = categoryDataModel.data;
      //categoryItemData = categoryDataModel.data[0].large_Banner;
      setState(() {});
      //log("grocery data length ${categoryData.length}");
    } else {
      //log("data invalid");
    }
    // log("after decode $dataMap");
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  ///var scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    SizeConfig().init(context);
    var width = SizeConfig.screenWidth;
    var height = SizeConfig.screenHeight;
    var block = SizeConfig.block;

    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: Color(0xFFE5E5E5),
        endDrawer: buildDrawerClass(context, block, callback: getLogoutResponse),
        body: SingleChildScrollView(
            child: Padding(
          //padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 15.0),
          padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 15.0),
          child: Column(children: [
            SizedBox(
              height: 10,
            ),

            /// search bar
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
                height: 45,
                child: Row(
                  children: [
                    ///

                    GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => SearchScreen()));

                        ///Navigator.push(context, MaterialPageRoute(builder: (context) => TrackOrder()));
                      },
                      child: SizedBox(
                          height: 20,
                          //width: 80,
                          width: MediaQuery.of(context).size.width / 7,
                          child: Image.asset("assets/img_27.png") //
                          ),
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
                          if (!_scaffoldKey.currentState!.isEndDrawerOpen) {
                            //check if drawer is closed
                            _scaffoldKey.currentState!.openEndDrawer(); //open drawer
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
                child: GestureDetector(
                  onTap: () {
                    getCityName(true);
                  },
                  child: SizedBox(
                    height: 40,
                    //width: 200,
                    width: MediaQuery.of(context).size.width / 1.2,
                    child: Row(
                      children: [
                        SizedBox(height: 17, child: Image.asset("assets/img_49.png")),
                        Padding(
                          padding: const EdgeInsets.only(top: 2.5),
                          child: Text(
                            "   $selectAreaName  ",

                            ///"  Protidin PG Store, Shahbag ",
                            style: TextStyle(
                              color: Colors.grey[700],
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              fontFamily: "CeraProBold",
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            getCityName(true);
                          },
                          child: Container(
                              height: 8,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 0.0),
                                child: Image.asset(
                                  "assets/img_50.png",
                                  height: 5,
                                  color: Colors.black,
                                ),
                              )),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(
              height: 0,
            ),

            /// top banner

            CarouselSlider.builder(
                itemCount: sliderData.length,
                itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) => Container(
                      ///height: 250,
                      child: Image.network(imagePath + sliderData[itemIndex].photo),
                    ),
                options: CarouselOptions(
                  height: 120,

                  ///aspectRatio: 16 / 9,
                  aspectRatio: 16 / 12,
                  viewportFraction: 1,
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  reverse: false,
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 3),
                  autoPlayAnimationDuration: Duration(milliseconds: 800),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enlargeCenterPage: true,

                  ///onPageChanged: callbackFunction,
                  scrollDirection: Axis.horizontal,
                )),

            SizedBox(
              height: 10,
            ),

            /// Offer For you
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
                child: Container(
                  //height: 170,
                  height: 170,
                  child: Row(
                    children: <Widget>[
                      // InkWell(
                      //   onTap: () {
                      //     Navigator.push(context, MaterialPageRoute(builder: (context) => OfferPage()));
                      //   },
                      //   child: Container(
                      //     decoration: BoxDecoration(
                      //       image: DecorationImage(
                      //         fit: BoxFit.fitWidth,
                      //         image: AssetImage("assets/p1.png"),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      // Padding(
                      //   padding: const EdgeInsets.only(right: 15),
                      // ),
                      InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => OfferPage()));
                        },
                        child: Container(
                          child: Image.asset("assets/p2.png"),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 15),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => OfferPage()));
                        },
                        child: Container(
                          child: Image.asset("assets/p3.png"),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 15),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => OfferPage()));
                        },
                        child: Container(
                          child: Image.asset("assets/p4.png"),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 15),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => OfferPage()));
                        },
                        child: Container(
                          child: Image.asset("assets/p5.png"),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 15),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => OfferPage()));
                        },
                        child: Container(
                          child: Image.asset("assets/p6.png"),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 15),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => OfferPage()));
                        },
                        child: Container(
                          child: Image.asset("assets/p7.png"),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 15),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            SizedBox(
              height: 30,
            ),

            /// shop by category
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
                                    relatedProductsLink = categoryData[index].links.products;
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

                      ///
                      isCategoryLoaded || isLocationChanged
                          ? Container(
                              height: MediaQuery.of(context).size.height / 3,
                            )
                          : Container(
                              height: MediaQuery.of(context).size.height / 3,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                itemCount: categoryProducts.length,
                                itemBuilder: (_, index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: Container(
                                      decoration: BoxDecoration(color: Color(0xFFF1EDF2), borderRadius: BorderRadius.circular(15.0)),
                                      width: MediaQuery.of(context).size.width / 2.34,
                                      child: Column(
                                        children: [
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: Container(
                                              width: MediaQuery.of(context).size.width / 5,
                                              height: MediaQuery.of(context).size.height / 41,
                                              margin: EdgeInsets.only(top: 10),
                                              decoration: BoxDecoration(
                                                color: categoryProducts[index].hasDiscount == true ? Colors.green : Color(0xFFF1EDF2),
                                                borderRadius:
                                                    BorderRadius.only(topRight: Radius.circular(4.0), bottomRight: Radius.circular(4.0)),
                                              ),
                                              //
                                              child: Center(
                                                child: categoryProducts[index].hasDiscount == true
                                                    ? Text(
                                                        "-৳ ${categoryProducts[index].discount.toString()}",
                                                        style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w700),
                                                      )
                                                    : Text(
                                                        //"15% OFF",
                                                        "",
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
                                                            detailsLink: categoryProducts[index].links.details,
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
                                              child: Row(
                                                children: [
                                                  Text(
                                                    categoryProducts[index].unit,
                                                    style: TextStyle(color: Colors.grey.withOpacity(0.9)),
                                                  ),
                                                  Text(
                                                    categoryProducts[index].userId.toString(),
                                                    style: TextStyle(color: Colors.grey.withOpacity(0.9)),
                                                  ),
                                                ],
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
                                                    Text(categoryProducts[index].baseDiscountedPrice.toString(),
                                                        style:
                                                            TextStyle(color: Color(0xFF515151), fontSize: 16, fontWeight: FontWeight.w700)),
                                                    Text(categoryProducts[index].basePrice.toString(),
                                                        style: TextStyle(
                                                            color: Color(0xFFA299A8),
                                                            fontSize: 12,
                                                            fontWeight: FontWeight.w400,
                                                            decoration: TextDecoration.lineThrough)),
                                                    Padding(
                                                      padding: const EdgeInsets.only(left: 10),
                                                    ),
                                                    GestureDetector(
                                                      onTap: () {
                                                        addToCart(categoryProducts[index].id, box.read(userID), 1);
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
                                            //height: MediaQuery.of(context).size.height/26,
                                            height: MediaQuery.of(context).size.height / 21,
                                            width: MediaQuery.of(context).size.width / 2.34,
                                            decoration: BoxDecoration(
                                                color: Colors.lightGreen[100],
                                                borderRadius: BorderRadius.only(
                                                    bottomLeft: Radius.circular(10.0), bottomRight: Radius.circular(10.0))),
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
                                },
                              ),
                            ),

                      ///

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

            ///1-99 store
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
                      children: const [
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
                                          height: MediaQuery.of(context).size.height / 41,
                                          margin: EdgeInsets.only(top: 10),
                                          decoration: BoxDecoration(
                                            color: Colors.green,
                                            borderRadius:
                                                BorderRadius.only(topRight: Radius.circular(4.0), bottomRight: Radius.circular(4.0)),
                                          ),
                                          //

                                          child: Center(
                                            child: Text(
                                              "-৳ ${oneTwoNinentyNineData[index].discount.toString()}",
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
                                            oneTwoNinentyNineData[index].unit.toString(),
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
                                                    //box.write("sub_category", subCategoryProducts);
                                                    //addToCart();

                                                    addToCart(oneTwoNinentyNineData[index].id, box.read(userID), 1);
                                                    //Navigator.push(context, MaterialPageRoute(builder: (context) => CartDetails()));
                                                    //addToCart(box.read(areaName.toString()), box.read(userID), 1);
                                                  },
                                                  /*onTap: () {
                                                    Navigator.push(context, MaterialPageRoute(builder: (context) => CartDetails()));
                                                  },*/
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

            isLocationChanged
                ? Container()
                : CategoryContainer(
                    categoryName: "Grocery",
                    nameNo: '4',
                    large_Banner: groceryLargeBanner,
                    add_banner: groceryAddBanner,
                  ),

            SizedBox(
              height: 30,
            ),
            isLocationChanged
                ? Container()
                : CategoryContainer(
                    categoryName: "Dairy & Beverage",
                    nameNo: '7',
                    large_Banner: dairyBeverageLargeBanner,
                    add_banner: dairyBeverageAddBanner),

            SizedBox(
              height: 30,
            ),
            isLocationChanged
                ? Container()
                : CategoryContainer(
                    categoryName: "Mother & Baby", nameNo: '8', large_Banner: motherBabyLargeBanner, add_banner: motherBabyAddBanner),

            SizedBox(
              height: 30,
            ),
            isLocationChanged
                ? Container()
                : CategoryContainer(
                    categoryName: "Fruits & Vegetables", nameNo: '9', large_Banner: fruitsVegLargeBanner, add_banner: fruitsVegAddBanner),

            SizedBox(
              height: 30,
            ),
            isLocationChanged
                ? Container()
                : CategoryContainer(
                    categoryName: "Personal Care", nameNo: '10', large_Banner: personalCareLargeBanner, add_banner: personalCareAddBanner),

            SizedBox(
              height: 30,
            ),
            isLocationChanged
                ? Container()
                : CategoryContainer(
                    categoryName: "Bread Biscuit & Snacks", nameNo: '11', large_Banner: breadLargeBanner, add_banner: breadAddBanner),

            SizedBox(
              height: 30,
            ),
            isLocationChanged
                ? Container()
                : CategoryContainer(
                    categoryName: "Household", nameNo: '13', large_Banner: householdLargeBanner, add_banner: householdAddBanner),

            SizedBox(
              height: 30,
            ),
            isLocationChanged
                ? Container()
                : CategoryContainer(
                    categoryName: "Chocolate & Sweets", nameNo: '46', large_Banner: chocolateLargeBanner, add_banner: chocolateAddBanner),

            SizedBox(
              height: 30,
            ),
            isLocationChanged
                ? Container()
                : CategoryContainer(
                    categoryName: "Toys & Gift", nameNo: '14', large_Banner: toysGiftLargeBanner, add_banner: toysGiftAddBanner),

            SizedBox(
              height: 30,
            ),
            isLocationChanged
                ? Container()
                : CategoryContainer(
                    categoryName: "Stationery", nameNo: '199', large_Banner: stationaryLargeBanner, add_banner: stationaryAddBanner),

            SizedBox(
              height: 30,
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

            /// call
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
        floatingActionButton: Container(
          height: 78,
          width: 78,
          child: FloatingActionButton(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //Icon(Icons.add_shopping_cart),

                  Center(
                      child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                    child: Image.asset(
                      "assets/pi.png",
                    ),
                  )),

                  /*
                  RefreshIndicator(
                  onRefresh: () {},
                  child: Container()
                  )
                  */
                  Obx(() => Align(
                        alignment: Alignment.topRight,
                        child: CircleAvatar(
                          radius: 13,
                          backgroundColor: Colors.green[600],
                          child: Text(
                            controller.cartLength.value.toString(),
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800),
                          ),
                        ),
                      )),
                ],
              ),
              backgroundColor: kPrimaryColor,
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => CartDetails()));
              }),
        ),
      ),
    );
  }
}

*/
