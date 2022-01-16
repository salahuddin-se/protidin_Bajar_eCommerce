import 'package:customer_ui/all_screen/cart_detailspage.dart';
import 'package:customer_ui/all_screen/grocery.dart';
import 'package:customer_ui/components/size_config.dart';
import 'package:customer_ui/components/styles.dart';
import 'package:flutter/material.dart';

class OfferPage extends StatefulWidget {
  const OfferPage({Key? key}) : super(key: key);

  @override
  _OfferPageState createState() => _OfferPageState();
}

class _OfferPageState extends State<OfferPage> with SingleTickerProviderStateMixin {
  late TabController controller;

  @override
  void initState() {
    // TODO: implement initState
    controller = TabController(length: 5, vsync: this);
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
          "Offer",
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
      body: SingleChildScrollView(
        child: SizedBox(
          height: height,
          width: width,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 0.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //SizedBox(height: 10,),

                Container(
                  decoration: BoxDecoration(
                    image: const DecorationImage(image: AssetImage("assets/img_79.png"), fit: BoxFit.cover),
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
                  height: 180,
                  width: MediaQuery.of(context).size.width / 1.1,
                  child: Image.asset(
                    "assets/img_80.png",
                  ),
                ),

                SizedBox(
                  height: 20,
                ),

                Text(
                  "Enjoy upto 80% off on the following items",
                  style: TextStyle(color: kBlackColor, fontSize: block * 4),
                ),
                SizedBox(
                  //height: 50,
                  height: 50,
                  child: TabBar(
                    isScrollable: true,
                    indicatorColor: kPrimaryColor,
                    controller: controller,
                    tabs: [
                      tabBarItems(block, "Grocery  ", "184"),
                      tabBarItems(block, "99 Shop  ", "99"),
                      tabBarItems(block, "Kid Care  ", "56"),
                      tabBarItems(block, "Home Cleaning  ", ""),
                      tabBarItems(block, "Foods  ", ""),
                    ],
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    controller: controller,
                    children: [
                      Grocery(),
                      Grocery(),
                      Grocery(),
                      Grocery(),
                      Grocery(),
                    ],
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
                      width: MediaQuery.of(context).size.width / 4,
                      child: Image.asset("assets/img_160.png"),
                    ),
                  ),
                ),
              ],
            ),
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
        Container(
          decoration: BoxDecoration(shape: BoxShape.circle, color: kBlackColor.withOpacity(0.1)),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(3.0),
              child: Text(
                amount,
                style: TextStyle(color: kBlackColor.withOpacity(0.3), fontSize: block * 2.5),
              ),
            ),
          ),
        )
      ],
    );
  }
}
