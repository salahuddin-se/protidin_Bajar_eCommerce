import 'package:customer_ui/components/size_config.dart';
import 'package:customer_ui/components/styles.dart';
import 'package:customer_ui/components/utils.dart';
import 'package:customer_ui/controller/cartItemsController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'all_gorcery.dart';
import 'cart_detailspage.dart';

class GroceryOfferPage extends StatefulWidget {
  ///var categoryLink = "";
  var receiveCategoryName = "";
  var receiveLargeBanner = "";
  var categoryData = [];

  ///Details({Key? key, required this.link}) : super(key: key);

  ///

  ///

  GroceryOfferPage(
      {Key? key,

      ///required this.categoryLink,
      required this.receiveCategoryName,
      required this.receiveLargeBanner,
      required this.categoryData})
      : super(key: key);

  @override
  _GroceryOfferPageState createState() => _GroceryOfferPageState();
}

class _GroceryOfferPageState extends State<GroceryOfferPage> with SingleTickerProviderStateMixin {
  late TabController controller;

  var scaffoldKey = GlobalKey<ScaffoldState>();
  var controller2 = Get.put(CartItemsController());

  @override
  void initState() {
    // TODO: implement initState

    controller = TabController(length: widget.categoryData.length, vsync: this);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var width = SizeConfig.screenWidth;
    var height = SizeConfig.screenHeight;
    var block = SizeConfig.block;

    return Scaffold(
      backgroundColor: kWhiteColor,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: kWhiteColor,
        centerTitle: true,
        title: Text(
          widget.receiveCategoryName,
          style: TextStyle(color: kBlackColor, fontSize: block * 4),
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
      body: SafeArea(
        child: SizedBox(
          height: height,
          width: width,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width / 1.1,
                    child: Image.network(
                      imagePath + widget.receiveLargeBanner,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                ///
                SizedBox(
                  height: 50,
                  child: TabBar(
                    isScrollable: true,
                    indicatorColor: kPrimaryColor,
                    controller: controller,
                    tabs: widget.categoryData.map((string) => tabBarItems(block, string.name, '1')).toList(),
                  ),
                ),

                Expanded(
                  child: TabBarView(
                    controller: controller,
                    children: widget.categoryData
                        .map((string) => AllGrocery(
                              link: string.links.products,
                            ))
                        .toList(),
                  ),
                ),
                // SizedBox(
                //   height: 100,
                // ),
              ],
            ),
          ),
        ),
      ),
      /*
      Obx(() => Align(
                        alignment: Alignment.topRight,
                        child: CircleAvatar(
                          radius: 11.5,
                          backgroundColor: Colors.green[500],
                          child: Text(
                            controller.cartLength.value.toString(),
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800),
                          ),
                        ),
                      )),
       */
      floatingActionButton: Container(
        // height: 85,
        // width: 85,
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
                          controller2.cartLength.value.toString(),
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
    );
  }

  Row tabBarItems(double block, String title, String amount) {
    return Row(
      children: [
        Text(
          title,
          style: TextStyle(color: kBlackColor),
        ),
      ],
    );
  }
}

/*
import 'package:customer_ui/all_screen/cart_detailspage.dart';
import 'package:customer_ui/components/size_config.dart';
import 'package:customer_ui/components/styles.dart';
import 'package:customer_ui/components/utils.dart';
import 'package:flutter/material.dart';
import 'all_gorcery.dart';

class GroceryOfferPage extends StatefulWidget {
  var categoryLink = "";
  var receiveCategoryName = "";
  var receiveLargeBanner = "";
  var categoryData = [];

  ///Details({Key? key, required this.link}) : super(key: key);

  GroceryOfferPage(
      {Key? key,
      required this.categoryLink,
      required this.receiveCategoryName,
      required this.receiveLargeBanner,
      required this.categoryData})
      : super(key: key);

  @override
  _GroceryOfferPageState createState() => _GroceryOfferPageState();
}

class _GroceryOfferPageState extends State<GroceryOfferPage> with SingleTickerProviderStateMixin {
  late TabController controller;

  @override
  void initState() {
    // TODO: implement initState
    controller = TabController(length: widget.categoryData.length, vsync: this);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var width = SizeConfig.screenWidth;
    var height = SizeConfig.screenHeight;
    var block = SizeConfig.block;

    return Scaffold(
      backgroundColor: kWhiteColor,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: kWhiteColor,
        centerTitle: true,
        title: Text(
          widget.receiveCategoryName,
          style: TextStyle(color: kBlackColor, fontSize: block * 4),
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
      body: SizedBox(
        height: height,
        width: width,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ///Image.asset("assets/groceryposter.png"),
              Center(
                child: Container(
                  width: MediaQuery.of(context).size.width / 1.1,
                  child: Image.network(
                    imagePath + widget.receiveLargeBanner,
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              ///
              SizedBox(
                height: 50,
                child: TabBar(
                  isScrollable: true,
                  indicatorColor: kPrimaryColor,
                  controller: controller,
                  tabs: widget.categoryData.map((string) => tabBarItems(block, string.name, '1')).toList(),
                ),
              ),
              Expanded(
                child: TabBarView(
                  controller: controller,
                  children: widget.categoryData
                      .map((string) => AllGrocery(
                            link: string.links.products,
                          ))
                      .toList(),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Center(
                child: InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => CartDetails()));
                  },
                  child: Container(
                    height: 60,
                    width: MediaQuery.of(context).size.width / 4.5,
                    child: Image.asset("assets/img_160.png"),
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }

  Row tabBarItems(double block, String title, String amount) {
    return Row(
      children: [
        Text(
          title,
          style: TextStyle(color: kBlackColor),
        ),
      ],
    );
  }
}
*/
