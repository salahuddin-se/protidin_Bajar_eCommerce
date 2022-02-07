/// home screen
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
import 'package:customer_ui/ruf/search.dart';
import 'package:customer_ui/welcomeScreen/sigininform.dart';
import 'package:customer_ui/widgets/category_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
                              onChanged: (String? value) {
                                newArea = value!;
                              },
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
                          setState(() {
                            selectAreaName = newArea;
                            isLocationChanged = true;
                            log("Area name is $selectAreaName");
                          });
                          Navigator.of(context).pop();
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

  CategoryContainer userService = CategoryContainer(
    categoryName: '',
    large_Banner: '',
    add_banner: '',
    nameNo: '',
  );

  @override
  void initState() {
    // TODO: implement initState
    log("------USER TOKEN IS------ :${box.read(userToken)}");
    Clipboard.setData(ClipboardData(text: box.read(userToken)));
    controller.getCartName();
    getCityName();
    getCategory();
    getSliderSearch();
    getOneTo99Data();

    //fetchProducts(areaName);
    // getLogoutResponse();
  }

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

    ///log("add user address response ${res.body}");

    if (res.statusCode == 200 || res.statusCode == 201) {
      var dataMap = jsonDecode(res.body);
    } else {
      showToast("Something went wrong", context: context);
    }
    setState(() {});
  }

  ///
  Future<void> getLogoutResponse() async {
    log("Log out response calling");
    final response = await http.get(
      Uri.parse("https://test.protidin.com.bd/api/v2/auth/logout"),
      headers: {"Authorization": "Bearer ${box.read(userToken)}"},
    );

    //
    if (response.statusCode == 200 || response.statusCode == 201) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => SignInPage()));

      ///print(box.read('userName'));
      ///log(userDataModel.user.name);

      setState(() {});
    }
    //

    log("Response from log out ${response.body}");

    ///return logoutResponseFromJson(response.body);
  }

  ///

  var productData = [];

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

  ///

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

  Future<void> getCityName() async {
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
    buildShowDialog(context, areaName, cityName);
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
                    getCityName();
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
                            getCityName();
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
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.fitWidth,
                              image: AssetImage("assets/p1.png"),
                            ),
                          ),
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

                Center(
                    child: Image.asset(
                  "assets/pi.png",
                  height: 45,
                  width: 30,
                )),

                Obx(() => Text(
                      controller.cartLength.value.toString(),
                )
                ),
              ],
            ),
            backgroundColor: kPrimaryColor,
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => CartDetails()));
            }),
      ),
    );
  }
}

*/

/// cart details page
/*
import 'dart:convert';
import 'dart:developer';

import 'package:customer_ui/all_screen/payment_method_address.dart';
import 'package:customer_ui/components/apis.dart';
import 'package:customer_ui/components/drawer_class.dart';
import 'package:customer_ui/components/size_config.dart';
import 'package:customer_ui/components/styles.dart';
import 'package:customer_ui/components/utils.dart';
import 'package:customer_ui/controller/cartItemsController.dart';
import 'package:customer_ui/dataModel/breat_biscuit.dart';
import 'package:customer_ui/dataModel/cart_summary_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class CartDetails extends StatelessWidget {
  const CartDetails({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CartDetailsPage(),
    );
  }
}

class CartDetailsPage extends StatefulWidget {
  const CartDetailsPage({Key? key}) : super(key: key);

  @override
  _CartDetailsPageState createState() => _CartDetailsPageState();
}

class _CartDetailsPageState extends State<CartDetailsPage> {
  final TextEditingController _controller = TextEditingController();

  //
  var scaffoldKey = GlobalKey<ScaffoldState>();
  //

  var demo = [];
  int totalProducts = 0;
  var subTotal = "";
  var tax = "";
  var shipCost = "";
  var discount = "";
  var grand_Total = "";
  var ownerId = 0;
  var _quantity = "";
  var controller = Get.put(CartItemsController());

  ///
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

      await getCartSummary();
    } else {
      showToast("Something went wrong", context: context);
    }
    /////////
    //box.write(add_carts, addToCart(, box.read(userID), 1));
    ////////
  }

  ///

  var bestProducts = [];
  Future<void> getBestSellersProduct() async {
    var res = await http.get(Uri.parse("https://test.protidin.com.bd/api/v2/products/best-seller"),
        headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8', 'Authorization': 'Bearer ${box.read(userToken)}'});

    log("cart Summary response= " + res.body);

    if (res.statusCode == 200) {
      var dataMap3 = jsonDecode(res.body);
      var productModel = BreadBiscuit.fromJson(dataMap3);
      bestProducts = productModel.data;
      setState(() {});
    }
  }

  ///

  Future<void> changeQuantity(id, userId, quantity) async {
    var res2 = await http.post(Uri.parse("https://test.protidin.com.bd/api/v2/carts/change-quantity"),
        headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8', 'Authorization': 'Bearer ${box.read(userToken)}'},
        body: jsonEncode(<String, dynamic>{"id": id, "variant": "", "user_id": userId, "quantity": quantity}));

    log("Response ${res2.body}");
    log("Response code  ${res2.statusCode}");

    if (res2.statusCode == 200 || res2.statusCode == 201) {
      await getCartSummary();
      showToast("Cart Updated Successfully", context: context);
      //getCartSummary();
    } else {
      showToast("Something went wrong", context: context);
    }
  }

  Future<void> getCartSummary() async {
    var res = await http.get(Uri.parse("$cartSummary/${box.read(userID)}"),
        headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8', 'Authorization': 'Bearer ${box.read(userToken)}'});

    log("cart Summary response= " + res.body);

    if (res.statusCode == 200) {
      var dataMap = jsonDecode(res.body);
      var cartSummaryModel = CartSummaryModel.fromJson(dataMap);
      subTotal = cartSummaryModel.subTotal;
      tax = cartSummaryModel.tax;
      shipCost = cartSummaryModel.shippingCost;
      discount = cartSummaryModel.discount;
      grand_Total = cartSummaryModel.grandTotal;

      //await addToCart("", "", "");
      setState(() {});
    }
  }

  Future cartDeleteAPI(cartID) async {
    var res = await http.delete(Uri.parse("$cartDelete/$cartID"),
        headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8', 'Authorization': 'Bearer ${box.read(userToken)}'});

    if (res.statusCode == 200 || res.statusCode == 201) {
      showToast("Item delete Successfully", context: context);
      await getCartSummary();
      await controller.getCartName();
      // await Get.find<CartItemsController>().getCartName();

      setState(() {});
    }
  }

  @override
  void initState() {
    getBestSellersProduct();
    super.initState();
    controller.getCartName();
    getCartSummary();
    _controller.text = "1"; // Setting the initial value for the field.
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var width = SizeConfig.screenWidth;
    var height = SizeConfig.screenHeight;
    var block = SizeConfig.block;
    return Scaffold(
      key: scaffoldKey,
      endDrawer: buildDrawerClass(context, block),
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: kWhiteColor,
        centerTitle: true,
        title: Text(
          "Cart",
          style: TextStyle(color: kBlackColor, fontSize: 14),
        ),
        iconTheme: IconThemeData(color: kBlackColor),
        actions: [
          GestureDetector(
            onTap: () {
              if (!scaffoldKey.currentState!.isEndDrawerOpen) {
                //check if drawer is closed
                scaffoldKey.currentState!.openEndDrawer(); //open drawer
              }
            },
            child: Center(
              child: Icon(
                Icons.menu,
                color: kBlackColor,
              ),
            ),
          ),
          SizedBox(
            width: 10,
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            ///listview builder
            Obx(
              () => Container(
                // height: MediaQuery.of(context).size.height / 1,
                child: ListView.builder(
                  itemCount: controller.cartItemsList.length,
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (_, index) {
                    //var data=demo[index].product_name;
                    //return Text(demo[index].productName);
                    return Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(image: AssetImage("assets/img_40.png"), fit: BoxFit.cover),
                        color: Colors.indigo[100],
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.10),
                            spreadRadius: 5, //spread radius
                            blurRadius: 5, // blur radius
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      height: 140,
                      width: MediaQuery.of(context).size.width / 1.1,
                      //color: Colors.cyan,
                      child: FittedBox(
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                            ),
                            InkWell(
                              //ProductSinglePage1
                              onTap: () {
                                //Navigator.push(context, MaterialPageRoute(builder: (context) => GroceryDetails()));
                              },
                              child: Container(
                                height: 120,
                                width: MediaQuery.of(context).size.width / 3,
                                child: Image.network(
                                  imagePath + controller.cartItemsList[index].productThumbnailImage,
                                ),
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width / 2.2,
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 5,
                                  ),

                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Container(
                                      height: 70,
                                      //width: 200,
                                      child: Text(
                                        controller.cartItemsList[index].productName,
                                        style: TextStyle(color: Colors.grey, fontSize: 16, fontWeight: FontWeight.w800),
                                      ),
                                    ),
                                  ),

                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          //color: Colors.indigo[100],
                                          borderRadius: BorderRadius.circular(5),

                                          boxShadow: const [
                                            BoxShadow(
                                              color: Colors.green,
                                            ),
                                          ],
                                        ),
                                        //color: Colors.green,
                                        height: 25,
                                        width: 90,
                                        child: Padding(
                                          padding: const EdgeInsets.all(0),
                                          child: Center(
                                            child: Text(
                                              "20% Offer",
                                              style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w900),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),

                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        //'${_totalPrice}'
                                        Container(
                                          height: 25,
                                          //width: 50,
                                          child: Padding(
                                            padding: const EdgeInsets.only(top: 3),
                                            child: Text(
                                              //"${demo[index].price}",
                                              "${controller.cartItemsList[index].currencySymbol} ${controller.cartItemsList[index].price}",
                                              style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w900),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  //Padding(padding: const EdgeInsets.only(left: 50.0),),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Column(
                              children: [
                                SizedBox(
                                  height: 35,
                                ),
                                GestureDetector(
                                  onTap: () => cartDeleteAPI(controller.cartItemsList[index].id),
                                  child: Container(
                                    child: Image.asset(
                                      "assets/img_106.png",
                                    ),
                                    height: 40,
                                    width: 40,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(0, 30, 10, 0),
                                  child: Align(
                                    alignment: Alignment.bottomRight,
                                    child: Container(
                                      width: MediaQuery.of(context).size.width / 4,
                                      height: 35,
                                      decoration: BoxDecoration(
                                        color: Color(0xFF9900FF),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Center(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          children: <Widget>[
                                            FittedBox(
                                              child: Container(
                                                child: MaterialButton(
                                                    child: Icon(
                                                      Icons.remove,
                                                      color: Colors.white,
                                                    ),
                                                    onPressed: () {
                                                      log("add click");
                                                      controller.cartItemsList[index].quantity--;
                                                      changeQuantity(controller.cartItemsList[index].id, "${box.read(userID)}",
                                                          controller.cartItemsList[index].quantity);
                                                      setState(() {});
                                                    }),
                                                width: MediaQuery.of(context).size.width / 10,
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(left: 5.0),
                                              child: FittedBox(
                                                child: Container(
                                                    width: 25,
                                                    child: Center(
                                                        child: Text(
                                                      "${controller.cartItemsList[index].quantity}",
                                                      style: TextStyle(fontSize: 18, color: kWhiteColor),
                                                    ))),
                                              ),
                                            ),
                                            FittedBox(
                                              child: Container(
                                                child: MaterialButton(
                                                    child: Icon(
                                                      Icons.add,
                                                      color: Colors.white,
                                                    ),
                                                    onPressed: () {
                                                      log("add click");
                                                      controller.cartItemsList[index].quantity++;
                                                      changeQuantity(controller.cartItemsList[index].id, "${box.read(userID)}",
                                                          controller.cartItemsList[index].quantity);
                                                      setState(() {});
                                                    }),
                                                width: MediaQuery.of(context).size.width / 10,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),

            ///congrates
            Container(
              color: Colors.grey[100],
              width: MediaQuery.of(context).size.width / 1.1,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        height: 40,
                        width: MediaQuery.of(context).size.width / 4.5,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 3),
                          child: Image.asset(
                            "assets/img_102.png",
                          ),
                        ),
                      ),
                      Container(
                        height: 68,
                        width: MediaQuery.of(context).size.width / 1.7,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 7),
                          child: Text(
                            "Congratulations! your order is adjusted with ৳96 from your Protidin wallet. Spend more to adjust wallet !",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      height: 28,
                      width: MediaQuery.of(context).size.width / 3,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 5, 0, 0),
                        child: Text(
                          "Adjusted: ৳96 ",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 13,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      height: 28,
                      width: MediaQuery.of(context).size.width * 3 / 4,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 5, 0, 0),
                        child: Text(
                          "Walet balace after adjustment : ৳6304",
                          style: TextStyle(
                            color: Colors.grey[400],
                            fontSize: 13,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            ///you may also like
            Container(
              width: MediaQuery.of(context).size.width / 1.1,
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      height: 35,
                      width: 280,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                        child: Text(
                          "You may also like",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 200,
                    width: double.infinity,
                    child: ListView.builder(
                        itemCount: bestProducts.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (_, index) {
                          return Container(
                              height: 195,
                              width: 120,
                              child: Column(
                                children: [
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(left: 0.0),
                                        ),
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                //color: Colors.indigo[100],
                                                borderRadius: BorderRadius.circular(5),

                                                boxShadow: const [
                                                  BoxShadow(
                                                    color: Colors.green,
                                                  ),
                                                ],
                                              ),
                                              //color: Colors.green,
                                              height: 20,
                                              width: 70,
                                              child: Padding(
                                                padding: const EdgeInsets.all(0),
                                                child: Center(
                                                  child: Text(
                                                    "20% Off",
                                                    style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w900),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        //Padding(padding: const EdgeInsets.only(left: 75.0),),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    height: 90,
                                    width: 100,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: NetworkImage(imagePath + bestProducts[index].thumbnailImage), fit: BoxFit.cover),
                                    ),
                                    child: Align(
                                      alignment: Alignment.bottomRight,
                                      child: Container(
                                        height: 20,
                                        width: 40,
                                        //padding: const EdgeInsets.only(top: 0),
                                        child: InkWell(
                                          onTap: () {
                                            addToCart(bestProducts[index].id, box.read(userID), 1);
                                          },
                                          child: Container(
                                            child: Image.asset(
                                              "assets/img_104.png",
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.center,
                                    child: Container(
                                      height: 35,
                                      width: 110,
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(5, 4, 5, 0),
                                        child: Center(
                                          child: Text(
                                            bestProducts[index].name,
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w900,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.center,
                                    child: Container(
                                      height: 20,
                                      width: 50,
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                                        child: Text(
                                          bestProducts[index].unit,
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.center,
                                    child: Container(
                                      height: 20,
                                      width: 50,
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                                        child: Text(
                                          bestProducts[index].baseDiscountedPrice,
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ));
                        }),
                  ),
                ],
              ),
            ),

            ///order summary
            SizedBox(
              height: 10,
            ),

            Container(
              height: 10,
              width: MediaQuery.of(context).size.width / 1.1,
              child: Padding(
                padding: const EdgeInsets.only(top: 0),
                child: Image.asset(
                  "assets/img_107.png",
                ),
              ),
            ),

            SizedBox(
              height: 20,
            ),

            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 5, 0, 0),
                  child: Text(
                    "Order Summary",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(
              height: 15,
            ),

            Align(
              alignment: Alignment.centerRight,
              child: Container(
                width: MediaQuery.of(context).size.width / 1.1,
                child: Row(
                  children: [
                    Container(
                      height: 20,
                      width: MediaQuery.of(context).size.width / 7,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 0),
                        child: Image.asset(
                          "assets/img_108.png",
                        ),
                      ),
                    ),
                    Container(
                      height: 20,
                      width: MediaQuery.of(context).size.width / 3,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: Text(
                          ///"MRP ($totalProducts products)",
                          "MRP (${box.read(cart_length) ?? 0} products)",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(00, 0, 0, 0),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        height: 20,
                        width: MediaQuery.of(context).size.width / 2.4,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                          child: Text(
                            subTotal,
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Align(
              alignment: Alignment.centerRight,
              child: Container(
                width: MediaQuery.of(context).size.width / 1.1,
                child: Row(
                  children: [
                    Container(
                      height: 20,
                      width: MediaQuery.of(context).size.width / 7,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 0),
                        child: Image.asset(
                          "assets/img_164.png",
                        ),
                      ),
                    ),
                    Container(
                      height: 20,
                      width: MediaQuery.of(context).size.width / 3,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: Text(
                          "Applicable VAT,tax",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(00, 0, 0, 0),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        height: 20,
                        width: MediaQuery.of(context).size.width / 2.4,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                          child: Text(
                            tax,
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(
              height: 10,
            ),

            Container(
              decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage("assets/img_110.png"), fit: BoxFit.cover),

                //color: Colors.white,
                //borderRadius: BorderRadius.circular(20),
              ),
              height: 40,
              width: MediaQuery.of(context).size.width / 1.1,
              //color: Colors.cyan,
              child: Align(
                alignment: Alignment.centerRight,
                child: Container(
                  width: MediaQuery.of(context).size.width / 2,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 40, 0),
                    child: Center(
                      child: Text(
                        subTotal,
                        style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w900),
                      ),
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(
              height: 30,
            ),

            ///
            Container(
              height: 90,
              width: MediaQuery.of(context).size.width / 1.1,
              decoration: BoxDecoration(
                  color: Colors.white,
                  // Red border with the width is equal to 5
                  border: Border.all(width: 1, color: Colors.black)),
              child: Column(
                children: [
                  SizedBox(
                    height: 14,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      width: MediaQuery.of(context).size.width / 1.1,
                      child: Row(
                        children: [
                          Container(
                            height: 20,
                            width: MediaQuery.of(context).size.width / 7,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 0),
                              child: Image.asset(
                                "assets/img_111.png",
                              ),
                            ),
                          ),
                          Container(
                            height: 20,
                            width: MediaQuery.of(context).size.width / 2.8,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                              child: Text(
                                "Protidin Discount",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            height: 20,
                            width: MediaQuery.of(context).size.width / 2.5,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                              child: Text(
                                discount,
                                style: TextStyle(
                                  color: Color(0xFF9900FF),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      width: MediaQuery.of(context).size.width / 1.1,
                      child: Row(
                        children: [
                          /*Padding(
                              padding: const EdgeInsets.fromLTRB(20,0,00,0),
                            ),*/

                          Container(
                            height: 20,
                            width: MediaQuery.of(context).size.width / 7,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 0),
                              child: Image.asset(
                                "assets/img_165.png",
                              ),
                            ),
                          ),
                          Container(
                            height: 20,
                            width: MediaQuery.of(context).size.width / 2.8,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                              child: Text(
                                "Walet adjustment",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),

                          /*Padding(
                              padding: const EdgeInsets.fromLTRB(10,0,70,0),
                            ),*/

                          Container(
                            height: 20,
                            width: MediaQuery.of(context).size.width / 2.5,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                              child: Text(
                                "0.00",
                                style: TextStyle(
                                  color: Color(0xFF9900FF),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      width: MediaQuery.of(context).size.width / 1.1,
                      child: Row(
                        children: [
                          Container(
                            height: 20,
                            width: MediaQuery.of(context).size.width / 7,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 0),
                              child: Image.asset(
                                "assets/img_166.png",
                              ),
                            ),
                          ),
                          Container(
                            height: 20,
                            width: MediaQuery.of(context).size.width / 2.8,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                              child: Text(
                                "Delivery charge",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            height: 20,
                            width: MediaQuery.of(context).size.width / 2.5,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                              child: Text(
                                "free",
                                style: TextStyle(
                                  color: Color(0xFF9900FF),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(
              height: 10,
            ),

            Container(
              decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage("assets/img_110.png"), fit: BoxFit.cover),
              ),
              height: 40,
              width: MediaQuery.of(context).size.width / 1.1,
              //color: Colors.cyan,
              child: Align(
                alignment: Alignment.centerRight,
                child: Container(
                  width: MediaQuery.of(context).size.width / 2,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 35, 0),
                    child: Center(
                      child: Text(
                        grand_Total,
                        style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w900),
                      ),
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(
              height: 20,
            ),

            Container(
              width: MediaQuery.of(context).size.width / 1.1,
              child: Row(
                children: [
                  Container(
                    height: 20,
                    width: MediaQuery.of(context).size.width / 7,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 0),
                      child: Image.asset(
                        "assets/img_167.png",
                      ),
                    ),
                  ),
                  Container(
                    height: 40,
                    width: MediaQuery.of(context).size.width / 2.8,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                      child: Text(
                        "Cash back received\n(Added to walet)",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 20,
                    width: MediaQuery.of(context).size.width / 2.5,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                      child: Text(
                        "0.00",
                        style: TextStyle(
                          color: Color(0xFF9900FF),
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(
              height: 10,
            ),

            Container(
              width: MediaQuery.of(context).size.width / 1,
              height: 55,
              decoration: BoxDecoration(
                border: Border.all(
                  width: 0.150,
                  color: Colors.deepPurpleAccent,
                ),
                color: Color(0xFF9900FF),
                borderRadius: BorderRadius.circular(0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 5, //spread radius
                    blurRadius: 5, // blur radius
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PaymentAddress1stPage(
                                grandTotal: grand_Total,
                                ownerId: ownerId,
                                user_address: userAddress,
                              )));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      child: Center(
                        child: Text(
                          "Payment method & Address",
                          style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w800),
                        ),
                      ),
                      width: 260,
                      //height: 40,
                    ),
                    Container(
                      height: 20,
                      width: 10,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 0),
                        child: Image.asset(
                          "assets/img_115.png",
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

*/

/// category container
/*
import 'dart:convert';
import 'dart:developer';

import 'package:customer_ui/all_screen/product_details.dart';
import 'package:customer_ui/components/size_config.dart';
import 'package:customer_ui/components/styles.dart';
import 'package:customer_ui/components/utils.dart';
import 'package:customer_ui/controller/cartItemsController.dart';
import 'package:customer_ui/dataModel/category_data_model.dart';
import 'package:customer_ui/dataModel/product_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

class CategoryContainer extends StatefulWidget {
  const CategoryContainer(
      {Key? key, required this.categoryName, required this.nameNo, required this.large_Banner, required this.add_banner})
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
  var adt;

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

  Future<void> getCategoryData({required String name}) async {
    log("widget name $name");

    String groceryURl = "https://test.protidin.com.bd/api/v2/sub-categories/$name";

    final response3 = await get(Uri.parse(groceryURl), headers: {"Accept": "application/json"});

    var groceryDataMap = jsonDecode(response3.body);

    if (groceryDataMap["success"] == true) {
      var categoryDataModel = CategoryDataModel.fromJson(groceryDataMap);
      categoryData = categoryDataModel.data;
      categoryItemData = categoryDataModel.data[0].name;
      relatedProductsLink = categoryData[0].links.products;

      box.write(related_product_link, relatedProductsLink);

      await fetchProducts(categoryDataModel.data[0].links.products);
      setState(() {});
    } else {}
  }

  var controller = Get.put(CartItemsController());

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
    } else {
      showToast("Something went wrong", context: context);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    log("name no ${widget.nameNo}");
    getCategoryData(name: widget.nameNo);

    ///fetchProducts("link2");
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
                      style: TextStyle(color: Color(0xFF515151), fontSize: 22, fontWeight: FontWeight.w700, fontFamily: "CeraProBold"),
                    ),
                    Text(
                      "VIEW ALL",
                      style: TextStyle(color: Color(0xFF515151), fontSize: 12, fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),

              SizedBox(
                height: 5,
              ),

              ///large_banner
              Container(
                height: 100,
                decoration: BoxDecoration(
                  //color: Colors.grey.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                //width: double.infinity,
                width: MediaQuery.of(context).size.width / 1.1,
                child: Image.network(
                  imagePath + widget.large_Banner,
                  fit: BoxFit.cover,
                ),
              ),

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
                          log("related link $relatedProductsLink");
                          fetchProducts(categoryData[index].links.products);
                          setState(() {});
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
                                    Container(
                                      height: height * 0.15,
                                      //width: width*0.30,
                                      width: width * 0.30,
                                      decoration: BoxDecoration(color: Color(0xFFF0E6F2), borderRadius: BorderRadius.circular(15.0)),
                                      child: Center(
                                        child: Padding(
                                          padding: const EdgeInsets.all(0),
                                          child: categoryData[index].mobileBanner.isEmpty
                                              ? Image.asset("assets/app_logo.png")
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
                                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(15.0)),
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
                      itemCount: listOfProducts.length,
                      itemBuilder: (_, index) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Container(
                            decoration: BoxDecoration(color: Color(0xFFF1EDF2), borderRadius: BorderRadius.circular(15.0)),
                            //height: MediaQuery.of(context).size.height/3.2,width: MediaQuery.of(context).size.width / 2.34,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Container(
                                    width: MediaQuery.of(context).size.width / 5,

                                    height: MediaQuery.of(context).size.height / 41,
                                    margin: EdgeInsets.only(top: 10),
                                    decoration: BoxDecoration(
                                      color: listOfProducts[index].has_discount == true ? Colors.green : Color(0xFFF1EDF2),
                                      borderRadius: BorderRadius.only(topRight: Radius.circular(4.0), bottomRight: Radius.circular(4.0)),
                                    ),
                                    //

                                    child: Center(
                                      child: listOfProducts[index].has_discount == true
                                          ? Text(
                                              //"15% OFF",
                                              "-৳ ${listOfProducts[index].discount.toString()}",
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

                                ///
                                GestureDetector(
                                  onTap: () {
                                    log("details ${listOfProducts[index].links!.details}");

                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => GroceryDetails(
                                                  detailsLink: listOfProducts[index].links!.details!,
                                                  relatedProductLink: relatedProductsLink,
                                                )));
                                  },
                                  child: Container(
                                    child: Image.network(imagePath + listOfProducts[index].thumbnail_image.toString()),
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
                                        listOfProducts[index].name.toString(),
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

                                Align(
                                  alignment: Alignment.center,
                                  child: Container(
                                    height: MediaQuery.of(context).size.height / 38,
                                    width: MediaQuery.of(context).size.width / 2.5,
                                    child: Center(
                                      child: Text(
                                        listOfProducts[index].unit.toString(),
                                        style: TextStyle(color: Colors.grey.withOpacity(0.9)),
                                      ),
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
                                          Text(listOfProducts[index].base_discounted_price.toString(),
                                              style: TextStyle(color: Color(0xFF515151), fontSize: 16, fontWeight: FontWeight.w700)),
                                          Text(listOfProducts[index].base_price.toString(),
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
                                              addToCart(listOfProducts[index].id, box.read(userID), 1);
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
        SizedBox(
          height: 32,
        ),
        Container(
          height: 200,
          decoration: BoxDecoration(
            //color: Colors.grey.withOpacity(0.2),
            borderRadius: BorderRadius.circular(10.0),
          ),
          //width: double.infinity,
          width: MediaQuery.of(context).size.width / 1.1,
          child: Image.network(
            imagePath + widget.add_banner,
            fit: BoxFit.cover,
          ),
        ),
      ],
    );
  }
}

*/

/// payment method & address
/*
import 'dart:convert';
import 'dart:developer';

import 'package:customer_ui/all_screen/payment_screen.dart';
import 'package:customer_ui/components/apis.dart';
import 'package:customer_ui/components/styles.dart';
import 'package:customer_ui/components/utils.dart';
import 'package:customer_ui/dataModel/payment_method.dart';
import 'package:customer_ui/dataModel/show_user_model.dart';
import 'package:customer_ui/dataModel/user_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class PaymentAddress1stPage extends StatefulWidget {
  String grandTotal = "";
  String user_address = "";
  int ownerId = 0;
  PaymentAddress1stPage({Key? key, required this.grandTotal, required this.ownerId, required this.user_address}) : super(key: key);

  @override
  _PaymentAddress1stPageState createState() => _PaymentAddress1stPageState();
}

class _PaymentAddress1stPageState extends State<PaymentAddress1stPage> {
  var userAddressController = TextEditingController();
  var userCountryController = TextEditingController();
  var userCityController = TextEditingController();
  var userPostalCodeController = TextEditingController();
  var userPhoneController = TextEditingController();

  var value = " ";
  var addressValue = " ";

  var formKey = GlobalKey<FormState>();

  var userInfoData = [];

  Future addressDeleteAPI(userID) async {
    var res = await http.get(Uri.parse("$addressDelete/$userID"),
        headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8', 'Authorization': 'Bearer ${box.read(userToken)}'});

    log("CART DELETE RESPONSE ${res.body}");

    if (res.statusCode == 200 || res.statusCode == 201) {
      showToast("Address delete Successfully", context: context);
      // await Get.find<CartItemsController>().getCartName();
      await getUserAddress(userID);

      setState(() {});
    }
  }

  Future<void> getUserInfo(userID) async {
    var res = await get(Uri.parse("$userInfoAPI$userID"),
        headers: {"Accept": "application/json", 'Authorization': 'Bearer ${box.read(userToken)}'});

    ///log("user info response ${res.body}");
    var dataMap = jsonDecode(res.body);
    if (res.statusCode == 200 || res.statusCode == 201) {
      var userInfoModel = UserInfoModel.fromJson(dataMap);

      ///userInfoModel.data[0].country

      userInfoData = userInfoModel.data;

      //print(userInfoData[0].address);
    }
  }

  Future<void> addUserAddress(userID, address, country, city, postalCode, phone, bool isUpdate, int addressId) async {
    String targetUrl = isUpdate ? "https://test.protidin.com.bd/api/v2/update-address-in-cart" : addUserAddressAPI;

    var bodyData = isUpdate
        ? jsonEncode(<String, dynamic>{
            "user_id": userID,
            "address": address,
            "address_id": addressId,
            "country": country,
            "city": city,
            "postal_code": postalCode,
            "phone": phone
          })
        : jsonEncode(<String, dynamic>{
            "user_id": userID,
            "address": address,
            "country": country,
            "city": city,
            "postal_code": postalCode,
            "phone": phone
          });

    var res = await post(
      Uri.parse(targetUrl),
      headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8', 'Authorization': 'Bearer ${box.read(userToken)}'},
      body: bodyData,
    );

    ///log("add user address response ${res.body}");

    if (res.statusCode == 200 || res.statusCode == 201) {
      showToast("Shipping information has been added successfully", context: context);
      await getUserAddress(userID);
    } else {
      showToast("Something went wrong", context: context);
    }

    setState(() {
      _userAddress = userAddressController.text;
      userCity = userCityController.text;
      userPostalCode = userPostalCodeController.text;
      userCountry = userCountryController.text;
      userPhone = userPhoneController.text;
    });
  }

  List<AddressData> userAddressData = [];
  var _userAddress = "";
  var userCity = "";
  var userCountry = "";
  var userPostalCode = "";
  var userPhone = "";
  var paymentType = "";

  var selectedAddress = "";

  Future<void> getUserAddress(userID) async {
    var res = await get(Uri.parse("$showAddressAPI/$userID"),
        headers: {"Accept": "application/json", 'Authorization': 'Bearer ${box.read(userToken)}'});

    ///log("user info response ${res.body}");
    var dataMap2 = jsonDecode(res.body);
    if (res.statusCode == 200 || res.statusCode == 201) {
      var userAddressModel = ShowUserAddressModel.fromJson(dataMap2);

      ///userInfoModel.data[0].country;
      userAddressData = userAddressModel.data;
      _userAddress = userAddressData[0].address!;

      box.write("Phone_Number", userPhone);

      //userCountry = userAddressData[0].country;
      print("Area ${userAddressData[0].address} city ${userAddressData[0].city}  Country ${userAddressData[0].country}");
      setState(() {});
    }
  }

  ///
  ///var paymentModel = [];
  var paymentData = [];

  Future<void> getPaymentTypes() async {
    var response = await get(Uri.parse("https://test.protidin.com.bd/api/v2/payment-types"), headers: <String, String>{
      'Accept': 'application/json',
    });

    ///List<String> userData = List<String>.from(usersDataFromJson);
    final dataMap = jsonDecode(response.body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      paymentData = dataMap.map((json) => PaymentTypeResponse.fromJson(json)).toList();
      //print(paymentModel[1].payment_type_key);
      setState(() {});
    }
  }

  Future<void> updateAddressInCart(userId, addressID) async {
    log("address ID $addressID");
    var jsonBody = (<String, dynamic>{"user_id": userId.toString(), "address_id": addressID.toString()});

    var res = await post(Uri.parse("https://test.protidin.com.bd/api/v2/update-address-in-cart"),
        headers: <String, String>{'Accept': 'application/json', 'Authorization': 'Bearer ${box.read(userToken)}'}, body: jsonBody);

    log("update address in cart ${res.body}");

    ///log("add user address response ${res.body}");

    if (res.statusCode == 200 || res.statusCode == 201) {
      var dataMap = jsonDecode(res.body);
    } else {
      showToast("Something went wrong", context: context);
    }
    setState(() {});
  }

  Future<void> orderCreate(userId, ownerID, paymentType, userAddress, grandTotal) async {
    log("CALLING");
    log("owner_ID $ownerID user id $userId payment type $paymentType");

    var jsonBody = (<String, dynamic>{
      "user_id": userId.toString(),
      "owner_id": ownerID.toString(),
      "payment_type_key": "cash_payment",
      "address": selectedAddress
    });

    var res = await post(Uri.parse(createOrderAPI),
        headers: <String, String>{'Accept': 'application/json', 'Authorization': 'Bearer ${box.read(userToken)}'}, body: jsonBody);

    log("after click place order ${res.body}");

    ///log("add user address response ${res.body}");

    if (res.statusCode == 200 || res.statusCode == 201) {
      showToast("Payment Successfull", context: context);

      var dataMap = jsonDecode(res.body);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Payment_Screen(
                    orderNo: dataMap["order_id"].toString(),
                    address: userAddress,
                    paymentTypes: paymentType,
                    grandTotal: grandTotal.toString(),
                  )));
    } else {
      showToast("Something went wrong", context: context);
    }
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    log("Grand Total ${widget.grandTotal} and owner Id ${widget.ownerId}");
    getUserInfo(box.read(userID));
    getUserAddress(box.read(userID));
    // updateAddressInCart(11);
    getPaymentTypes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: kWhiteColor,
        centerTitle: true,
        title: Text(
          "Payment & address",
          style: TextStyle(color: kBlackColor, fontSize: 14),
        ),
        iconTheme: IconThemeData(color: kBlackColor),
        actions: const [
          Center(
            child: Icon(
              Icons.menu,
              color: kBlackColor,
            ),
          ),
          SizedBox(
            width: 10,
          )
        ],
      ),
      backgroundColor: Colors.grey[100],
      //backgroundColor: Colors.indigo[50],
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Colors.white,
              //height: 440 ,
              height: 480,
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: const Text(
                              "Delivered to",
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black),
                            ),
                          )),
                      Padding(
                        padding: const EdgeInsets.only(left: 80.0),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            //primary: Color(0xFF9900FF),
                            primary: Colors.white,
                            //side: BorderSide(width:3, color:Colors.brown), //border width and color
                            elevation: 1.5, //elevation of button

                            padding: EdgeInsets.all(10) //content padding inside button
                            ),
                        onPressed: () {
                          _swAddressBottoSheet(false, -1);
                        },
                        child: Container(
                            height: 20,
                            width: 20,
                            //height: 190,
                            //width: 200,
                            child: Image.asset(
                              "assets/img_47.png",
                              fit: BoxFit.cover,
                            )),
                      ),
                    ],
                  ),

                  SizedBox(
                    height: 20,
                  ),

                  ///map
                  Container(
                    height: 140,
                    width: MediaQuery.of(context).size.width / 1.1,
                    decoration: BoxDecoration(
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
                    child: Container(
                        //height: 190,
                        //width: 200,
                        child: Image.asset(
                      "assets/img_116.png",
                      fit: BoxFit.cover,
                    )),
                  ),

                  SizedBox(
                    height: 30,
                  ),

                  ///address list
                  Container(
                    //height: 120,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(12, 0, 0, 10),
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        itemCount: userAddressData.length,
                        itemBuilder: (_, index) {
                          return addressValue == index.toString()
                              ? Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(left: 10.0),
                                      ),
                                      Container(
                                        height: 15,
                                        width: 15,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle, border: Border.all(color: kBlackColor), color: kPrimaryColor),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 10.0),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(6.0),
                                        child: Container(
                                          child: Text(
                                            "${userAddressData[index].address},${userAddressData[index].city},${userAddressData[index].postalCode},${userAddressData[index].country},${userAddressData[index].phone},",
                                            style: TextStyle(fontWeight: FontWeight.w500),
                                          ),
                                          width: MediaQuery.of(context).size.width / 1.8,
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          userAddressController.text = userAddressData[index].address!;
                                          userCityController.text = userAddressData[index].city!;
                                          userPostalCodeController.text = userAddressData[index].postalCode!;
                                          userCountryController.text = userAddressData[index].country!;
                                          userPhoneController.text = userAddressData[index].phone!;
                                          //updateAddressInCart(box.read(userID), userAddressData[index].id);
                                          print("ADDR_ID: ${userAddressData[index].id}");
                                          _swAddressBottoSheet(true, userAddressData[index].id);
                                        },
                                        child: Container(
                                          height: 15,
                                          width: 15,
                                          child: Padding(
                                            padding: const EdgeInsets.only(left: 0),
                                            child: Image.asset(
                                              "assets/img_60.png",
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 20.0),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          addressDeleteAPI(userAddressData[index].userId);

                                          ///updateAddressInCart(box.read(userID), userAddressData[index].id);
                                        },
                                        child: Container(
                                          height: 25,
                                          width: 25,
                                          child: Padding(
                                            padding: const EdgeInsets.only(left: 0),
                                            child: Image.asset(
                                              "assets/img_106.png",
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : GestureDetector(
                                  onTap: () {
                                    ///updateAddressInCart(box.read(userID), userAddressData[index].id);
                                    selectedAddress =
                                        ("${userAddressData[index].address},${userAddressData[index].city},${userAddressData[index].postalCode},${userAddressData[index].country},${userAddressData[index].phone}");
                                    log(selectedAddress);
                                    box.write(account_userAddress, selectedAddress);
                                    setState(() {
                                      addressValue = index.toString();
                                    });
                                  },
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(left: 10.0),
                                      ),
                                      Container(
                                        height: 15,
                                        width: 15,
                                        decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: kBlackColor)),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 10.0),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(6.0),
                                        child: Container(
                                          child: Text(
                                            "${userAddressData[index].address},${userAddressData[index].city},${userAddressData[index].postalCode},${userAddressData[index].country},${userAddressData[index].phone},",
                                            style: TextStyle(fontWeight: FontWeight.w500),
                                          ),
                                          width: MediaQuery.of(context).size.width / 1.8,
                                        ),
                                      ),
                                      Container(
                                        height: 15,
                                        width: 15,
                                        child: Padding(
                                          padding: const EdgeInsets.only(left: 0),
                                          child: Image.asset(
                                            "assets/img_60.png",
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 20.0),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          addressDeleteAPI(userAddressData[index].userId);

                                          ///updateAddressInCart(box.read(userID), userAddressData[index].id);
                                        },
                                        child: Container(
                                          height: 25,
                                          width: 25,
                                          child: Padding(
                                            padding: const EdgeInsets.only(left: 0),
                                            child: Image.asset(
                                              "assets/img_106.png",
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                        },
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 10,
                  ),

                  ///add address button
                  SizedBox(
                    height: 10,
                  ),

                  Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: Container(
                            width: MediaQuery.of(context).size.width / 1.5,
                            child: const Text(
                              "+ Add delivery instruction",
                              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800, color: Colors.green),
                            )),
                      )),
                ],
              ),
            ),

            SizedBox(
              height: 30,
            ),

            ///Preferred delivery slot
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.15),
                    spreadRadius: 5, //spread radius
                    blurRadius: 5, // blur radius
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              width: MediaQuery.of(context).size.width / 1.1,
              height: 130,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                  ),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: const Text(
                          "Preferred delivery slot",
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black),
                        ),
                      )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              width: MediaQuery.of(context).size.width / 2.5,
                              child: const Text(
                                "Delivered date :",
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black),
                              ),
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Align(
                            alignment: Alignment.centerRight,
                            child: Container(
                                width: MediaQuery.of(context).size.width / 2.5,
                                child: const Text(
                                  "Time slot :",
                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black),
                                ))),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width / 2.5,
                          height: 40,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              // Red border with the width is equal to 5
                              border: Border.all(width: 1, color: Colors.black)),
                          child: Row(
                            children: [
                              Container(
                                height: 20,
                                //width: 200,
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(4, 0, 7, 0),
                                  child: Text(
                                    "Today, 23 Sep ",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                height: 15,
                                width: 15,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 0),
                                  child: Image.asset(
                                    "assets/ca.png",
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 2.5,
                        height: 40,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            // Red border with the width is equal to 5
                            border: Border.all(width: 1, color: Colors.black)),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(5, 0, 8, 0),
                              //width: 200,
                              child: Text(
                                "Tap to choose",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Container(
                              height: 15,
                              width: 15,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 0),
                                child: Image.asset(
                                  "assets/dr.png",
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ]),
                  )
                ],
              ),
            ),

            SizedBox(
              height: 20,
            ),

            ///Payment Method
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.15),
                    spreadRadius: 5, //spread radius
                    blurRadius: 5, // blur radius
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              width: MediaQuery.of(context).size.width / 1.1,
              height: 785,
              child: Column(children: [
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                ),

                Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: const Text(
                        "Payment Method",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black),
                      ),
                    )),

                SizedBox(
                  height: 15,
                ),

                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: Container(
                    height: 300,
                    child: ListView.builder(
                        shrinkWrap: true,
                        physics: ClampingScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        itemCount: paymentData.length,
                        itemBuilder: (_, index) {
                          return value == index.toString()
                              ? Row(
                                  children: [
                                    Container(
                                      height: 15,
                                      width: 15,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle, border: Border.all(color: kBlackColor), color: Colors.black),
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width * 3 / 5,
                                      child: ListTile(
                                        title: Text(
                                          paymentData[index].payment_type_key,
                                          style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800, color: Colors.black),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 40,
                                      width: MediaQuery.of(context).size.width / 7,
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 0),
                                        child: Image.network(
                                          paymentData[index].image,
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              : GestureDetector(
                                  onTap: () {
                                    paymentType = paymentData[index].payment_type_key;
                                    setState(() {
                                      value = index.toString();
                                    });
                                  },
                                  child: Row(
                                    children: [
                                      Container(
                                        height: 15,
                                        width: 15,
                                        decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: kBlackColor)),
                                      ),
                                      Container(
                                        width: MediaQuery.of(context).size.width * 3 / 5,
                                        child: ListTile(
                                          title: Text(
                                            ///payment_type_key
                                            paymentData[index].payment_type_key,
                                            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800, color: Colors.black),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        height: 40,
                                        width: MediaQuery.of(context).size.width / 7,
                                        child: Padding(
                                          padding: const EdgeInsets.only(left: 0),
                                          child: Image.network(
                                            paymentData[index].image,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                        }),
                  ),
                ),

                SizedBox(
                  height: 20,
                ),

                ///card image
                /*
                                Center(
                  child: Container(
                    height: 190,
                    width: MediaQuery.of(context).size.width / 1.1,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 0),
                      child: Image.asset(
                        "assets/img_124.png",
                      ),
                    ),
                  ),
                ),

                 */
                SizedBox(height: 20),

                ///card number
                /*
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                    border: Border.all(width: 0.5, color: Colors.black),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: const [
                          Padding(
                            padding: EdgeInsets.only(left: 22),
                            child: Text(
                              "Card Number",
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black),
                            ),
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(5, 10, 10, 10),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(width: 0.8, color: Colors.black),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          height: 45,
                          width: MediaQuery.of(context).size.width / 1.3,
                        ),
                      ),
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 15.0),
                                  child: Container(
                                      width: MediaQuery.of(context).size.width / 2.5,
                                      child: const Text(
                                        "Exdpery date",
                                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black),
                                      )),
                                )),

                            /*Padding(
                                  padding: const EdgeInsets.fromLTRB(40,0,40,0),
                                ),*/

                            Align(
                                alignment: Alignment.centerRight,
                                child: Container(
                                    width: MediaQuery.of(context).size.width / 2.5,
                                    child: const Text(
                                      "CV code",
                                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black),
                                    ))),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Container(
                            width: MediaQuery.of(context).size.width / 6,
                            height: 40,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                // Red border with the width is equal to 5
                                border: Border.all(width: 1, color: Colors.black)),
                            child: Center(
                              child: Text(
                                "MM",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width / 6,
                          height: 40,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              // Red border with the width is equal to 5
                              border: Border.all(width: 1, color: Colors.black)),
                          child: Container(
                            height: 20,
                            //width: 200,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                              child: Center(
                                child: Text(
                                  "YY",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 25.0),
                          child: Container(
                            width: MediaQuery.of(context).size.width / 3,
                            height: 40,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                // Red border with the width is equal to 5
                                border: Border.all(width: 1, color: Colors.black)),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                              child: Center(
                                child: Text(
                                  "CV",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ])
                    ],
                  ),
                )
                 */
              ]),
            ),

            SizedBox(
              height: 25,
            ),

            Center(
              child: Container(
                height: 40,
                width: MediaQuery.of(context).size.width / 1,
                child: Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 5.0),
                      child: Column(
                        children: const [
                          Text(
                            "By tapping on 'place order',you agree to our",
                            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black),
                          ),
                          Text(
                            "Terms & Conditions",
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.green),
                          ),
                        ],
                      ),
                    )),
              ),
            ),

            SizedBox(
              height: 25,
            ),

            GestureDetector(
              onTap: () {
                orderCreate("${box.read(userID)}", widget.ownerId, paymentType, selectedAddress, widget.grandTotal);
              },
              child: Container(
                width: MediaQuery.of(context).size.width / 1,
                height: 56,
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 0.150,
                    color: Colors.deepPurpleAccent,
                  ),
                  color: Color(0xFF9900FF),
                  borderRadius: BorderRadius.circular(0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 5, //spread radius
                      blurRadius: 5, // blur radius
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Center(
                  child: Column(
                    children: [
                      Text(
                        widget.grandTotal,
                        style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w800),
                      ),
                      Text(
                        "place order",
                        style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w800),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _swAddressBottoSheet(bool isUpdate, int addrId) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return SingleChildScrollView(
          child: Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: Padding(
              padding: const EdgeInsets.only(
                left: 20,
                right: 20,
                top: 20,
                bottom: 10,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: userAddressController,
                    autofocus: true,
                    onChanged: (value) {},
                    decoration: InputDecoration(
                      hintText: 'Address',
                      fillColor: Colors.grey[100],
                      filled: true,
                      contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                      enabledBorder:
                          OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide(color: Colors.white)),
                      focusedBorder:
                          OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide(color: Colors.white)),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide(color: Colors.white)),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: userCityController,
                    autofocus: true,
                    onChanged: (value) {},
                    decoration: InputDecoration(
                      hintText: 'City',
                      fillColor: Colors.grey[100],
                      filled: true,
                      contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                      enabledBorder:
                          OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide(color: Colors.white)),
                      focusedBorder:
                          OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide(color: Colors.white)),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide(color: Colors.white)),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: userPostalCodeController,
                    autofocus: true,
                    onChanged: (value) {},
                    decoration: InputDecoration(
                      hintText: 'Postal code',
                      fillColor: Colors.grey[100],
                      filled: true,
                      contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                      enabledBorder:
                          OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide(color: Colors.white)),
                      focusedBorder:
                          OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide(color: Colors.white)),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide(color: Colors.white)),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: userCountryController,
                    autofocus: true,
                    onChanged: (value) {},
                    decoration: InputDecoration(
                      hintText: 'Country',
                      fillColor: Colors.grey[100],
                      filled: true,
                      contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                      enabledBorder:
                          OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide(color: Colors.white)),
                      focusedBorder:
                          OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide(color: Colors.white)),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide(color: Colors.white)),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: userPhoneController,
                    keyboardType: TextInputType.phone,
                    autofocus: true,
                    onChanged: (value) {},
                    decoration: InputDecoration(
                      hintText: 'Phone',
                      fillColor: Colors.grey[100],
                      filled: true,
                      contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                      enabledBorder:
                          OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide(color: Colors.white)),
                      focusedBorder:
                          OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide(color: Colors.white)),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide(color: Colors.white)),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Color(0xFF9900FF), //background color of button
                              //side: BorderSide(width:3, color:Colors.brown), //border width and color
                              elevation: 1, //elevation of button
                              shape: RoundedRectangleBorder(
                                  //to set border radius to button
                                  borderRadius: BorderRadius.circular(30)),
                              padding: EdgeInsets.all(10) //content padding inside button
                              ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text(
                            'Cancel',
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Color(0xFF9900FF), //background color of button
                              //side: BorderSide(width:3, color:Colors.brown), //border width and color
                              elevation: 1, //elevation of button
                              shape: RoundedRectangleBorder(
                                  //to set border radius to button
                                  borderRadius: BorderRadius.circular(30)),
                              padding: EdgeInsets.all(10) //content padding inside button
                              ),
                          onPressed: () {
                            Navigator.pop(context);
                            addUserAddress(
                              "${box.read(userID)}",
                              userAddressController.text,
                              userCountryController.text,
                              userCityController.text,
                              userPostalCodeController.text,
                              userPhoneController.text,
                              isUpdate,
                              addrId,
                            );
                          },
                          child: const Text(
                            'Save',
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
*/

/// my account
/*
import 'package:customer_ui/components/styles.dart';
import 'package:customer_ui/components/utils.dart';
import 'package:flutter/material.dart';

class MyAccountPage extends StatefulWidget {
  const MyAccountPage({Key? key}) : super(key: key);
  @override
  _MyAccountPageState createState() => _MyAccountPageState();
}

class _MyAccountPageState extends State<MyAccountPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: kWhiteColor,
          centerTitle: true,
          title: Text(
            "My account",
            style: TextStyle(color: kBlackColor, fontSize: 14),
          ),
          iconTheme: IconThemeData(color: kBlackColor),
          actions: const [
            Center(
              child: Icon(
                Icons.menu,
                color: kBlackColor,
              ),
            ),
            SizedBox(
              width: 10,
            )
          ],
        ),
        //backgroundColor: Colors.white,
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            child: Column(children: [
          SizedBox(
            height: 25,
          ),
          Center(
            child: Container(
              //color: Colors.white,
              height: 120,
              width: 120,

              child: Image.asset(
                "assets/img_142.png",
              ),

              /*child: Image.network(
                box.read(imagePath + 'userAvatar'),
              ),*/

              /*child: Image.asset(
                "assets/img_142.png",
              ),*/
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Center(
            child: Container(
              height: 37,
              width: 150,
              child: Center(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    ///box.write(userName, userDataModel.user.name);///datacount.read('count')
                    box.read(userName),
                    style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16, color: Colors.black),
                  ),
                  Container(
                    //color: Colors.white,
                    height: 15,
                    width: 15,
                    child: Image.asset(
                      "assets/img_143.png",
                    ),
                  ),
                ],
              )),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            width: MediaQuery.of(context).size.width / 1,
            height: MediaQuery.of(context).size.height / 1.6,
            decoration: BoxDecoration(
              color: Colors.grey[50],
              //borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Align(
                    alignment: Alignment.center,
                    child: Container(
                      //width:MediaQuery.of(context).size.width/6,
                      child: Row(
                        //mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            //color: Colors.white,
                            height: 15,
                            width: MediaQuery.of(context).size.width / 7,
                            child: Image.asset(
                              "assets/img_144.png",
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 30, 0),
                          ),

                          Container(
                            width: MediaQuery.of(context).size.width / 2,
                            child: Column(
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "My Address",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    box.read(account_userAddress) ?? "No address",
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          //Padding(padding: const EdgeInsets.fromLTRB(0,0,50,0),),

                          Container(
                            //color: Colors.white,
                            height: 15,
                            width: MediaQuery.of(context).size.width / 7,
                            child: Image.asset(
                              "assets/img_145.png",
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Align(
                    alignment: Alignment.center,
                    child: Container(
                      child: Row(
                        //mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            //color: Colors.white,
                            height: 15,
                            width: MediaQuery.of(context).size.width / 7,
                            child: Image.asset(
                              "assets/img_146.png",
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 30, 0),
                          ),

                          Container(
                            width: MediaQuery.of(context).size.width / 2,
                            child: Column(
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Email",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "${box.read(userPhone)}",
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          //Padding(padding: const EdgeInsets.fromLTRB(0,0,50,0),),

                          Container(
                            //color: Colors.white,
                            height: 15,
                            width: MediaQuery.of(context).size.width / 7,
                            child: Image.asset(
                              "assets/img_145.png",
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Align(
                    alignment: Alignment.center,
                    child: Container(
                      child: Row(
                        //mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            //color: Colors.white,
                            height: 15,
                            width: MediaQuery.of(context).size.width / 7,
                            child: Image.asset(
                              "assets/img_148.png",
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 30, 0),
                          ),

                          Container(
                            width: MediaQuery.of(context).size.width / 2,
                            child: Column(
                              children: const [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Change Password",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "......",
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          //Padding(padding: const EdgeInsets.fromLTRB(0,0,50,0),),

                          Container(
                            //color: Colors.white,
                            height: 15,
                            width: MediaQuery.of(context).size.width / 7,
                            child: Image.asset(
                              "assets/img_145.png",
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
              ],
            ),
          )
        ])));
  }
}

*/

/// cart item controller
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

 */

/// payment screen
/*
import 'dart:async';
import 'dart:developer';

import 'package:customer_ui/all_screen/home_screen.dart';
import 'package:customer_ui/components/styles.dart';
import 'package:flutter/material.dart';

import 'ongoing_orders.dart';

//import 'Language.dart';
/*
 @override
void initState() {
 Timer(Duration(seconds: 3), (){
Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>
 HomeScreen()));
});
 super.initState();
}
*/
class Payment_Screen extends StatefulWidget {
  String? orderNo = "";
  String grandTotal = "";
  String address = "";
  String paymentTypes = "";

  Payment_Screen({Key? key, required this.orderNo, required this.grandTotal, required this.address, required this.paymentTypes})
      : super(key: key);

  @override
  _Payment_ScreenState createState() => _Payment_ScreenState();
}

class _Payment_ScreenState extends State<Payment_Screen> {
  @override
  void initState() {
    Timer(Duration(seconds: 5), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => CategoryHomeScreen()));
    });
    super.initState();
    // TODO: implement initState
    log("order no ${widget.orderNo} grand total ${widget.grandTotal} address ${widget.address}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.purpleAccent[700],
        centerTitle: true,
        title: Text(
          "Payment Screen",
          style: TextStyle(color: Colors.white, fontSize: 14),
        ),
        iconTheme: IconThemeData(color: kBlackColor),
        actions: const [
          Center(
            child: Icon(
              Icons.menu,
              color: Colors.white,
            ),
          ),
          SizedBox(
            width: 10,
          )
        ],
      ),
      //backgroundColor: Colors.white,
      backgroundColor: Colors.purpleAccent[700],
      body: SingleChildScrollView(
        child: FittedBox(
          child: Column(
            children: [
              SizedBox(
                height: 25,
              ),

              //SizedBox(height: 25,),

              Center(
                child: Container(
                  //color: Colors.white,
                  height: 100,
                  width: 100,
                  child: Image.asset(
                    "assets/img_129.png",
                    color: Colors.white,
                  ),
                ),
              ),

              Container(
                child: Center(
                  child: Text(
                    "Your order has been confirmed",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),

              SizedBox(
                height: 10,
              ),

              Container(
                child: Center(
                  child: Text(
                    "Order No #${widget.orderNo}",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),

              SizedBox(
                height: 20,
              ),

              Align(
                alignment: Alignment.center,
                child: InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => OngoingOrder()));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      //color: Colors.indigo[100],
                      borderRadius: BorderRadius.circular(30),

                      boxShadow: const [
                        BoxShadow(
                          color: Colors.white,
                        ),
                      ],
                    ),
                    //color: Colors.green,
                    height: 45,
                    width: MediaQuery.of(context).size.width / 2.5,
                    child: Padding(
                      padding: const EdgeInsets.all(0),
                      child: Center(
                        child: Text(
                          "Track Order",
                          style: TextStyle(color: Colors.purpleAccent[700], fontSize: 16, fontWeight: FontWeight.w900),
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(
                height: 20,
              ),

              FittedBox(
                child: Container(
                  width: MediaQuery.of(context).size.width / 1,
                  height: MediaQuery.of(context).size.height / 1.4,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.15),
                        spreadRadius: 5, //spread radius
                        blurRadius: 5, // blur radius
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 15,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          width: MediaQuery.of(context).size.width / 1,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Container(
                                  width: MediaQuery.of(context).size.width / 5,
                                  //color: Colors.white,
                                  height: 40,
                                  child: Image.asset(
                                    "assets/img_130.png",
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                              ),
                              Container(
                                child: Column(
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width * 3 / 5,
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "${widget.grandTotal}",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w900,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width * 3 / 5,
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "Total Payable",
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          width: MediaQuery.of(context).size.width / 1,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Container(
                                  width: MediaQuery.of(context).size.width / 5,
                                  //color: Colors.white,
                                  height: 40,
                                  child: Image.asset(
                                    "assets/img_171.png",
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                              ),
                              Container(
                                child: Column(
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width * 3 / 5,
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          widget.paymentTypes,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w900,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width * 3 / 5,
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "Payment Method",
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          width: MediaQuery.of(context).size.width / 1,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Container(
                                  width: MediaQuery.of(context).size.width / 5,
                                  //color: Colors.white,
                                  height: 40,
                                  child: Image.asset(
                                    "assets/img_173.png",
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                              ),
                              Container(
                                child: Column(
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width * 3 / 5,
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          widget.address,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w900,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width * 3 / 5,
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "Delivery Address",
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          width: MediaQuery.of(context).size.width / 1,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Container(
                                  width: MediaQuery.of(context).size.width / 5,
                                  //color: Colors.white,
                                  height: 40,
                                  child: Image.asset(
                                    "assets/img_133.png",
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                              ),
                              Container(
                                child: Column(
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width * 3 / 5,
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "24 september,\n2021,8:P.M",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w900,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width * 3 / 5,
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "Delivery date & Time",
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Center(
                        child: Container(
                          height: 30,
                          //width: 230,
                          child: Text(
                            "Thank You for shopping with us ",
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: Colors.purpleAccent[700]),
                          ),
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
  }
}

*/
