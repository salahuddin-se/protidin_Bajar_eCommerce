import 'package:customer_ui/HomePage/offer/grocery.dart';
import 'package:customer_ui/OthersPage/cartDetails1stPage.dart';
import 'package:customer_ui/components/size_config.dart';
import 'package:customer_ui/components/styles.dart';
import 'package:flutter/material.dart';

import 'all_gorcery.dart';

class GroceryOfferPage extends StatefulWidget {
  const GroceryOfferPage({Key? key}) : super(key: key);

  @override
  _GroceryOfferPageState createState() => _GroceryOfferPageState();
}

class _GroceryOfferPageState extends State<GroceryOfferPage> with SingleTickerProviderStateMixin{
  late TabController controller;

  @override
  void initState() {
    // TODO: implement initState
    controller = TabController(length: 4, vsync: this);
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
          "Grocery",
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
              Image.asset("assets/groceryposter.png"),

              SizedBox(
                height: 50,
                child: TabBar(
                  isScrollable: true,
                  indicatorColor: kPrimaryColor,
                  controller: controller,
                  tabs: [
                    tabBarItems(block,"All Grocery  ","184"),
                    tabBarItems(block,"Edible Oil  ","99"),
                    tabBarItems(block,"Spices  ","56"),
                    tabBarItems(block,"Bakery  ",""),

                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  controller: controller,
                  children: const [
                    AllGrocery(),
                    AllGrocery(),
                    AllGrocery(),
                    AllGrocery(),
                  ],
                ),
              ),

              SizedBox(height: 10,),

              Center(
                child: InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => CartDetails()));
                  },
                  child: Container(
                    height: 60,
                    width: MediaQuery.of(context).size.width/4.5,
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

  Row tabBarItems(double block,String title,String amount) {
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
