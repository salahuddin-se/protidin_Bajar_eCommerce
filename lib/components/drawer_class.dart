import 'package:customer_ui/all_screen/grocery_offer_page.dart';
import 'package:customer_ui/all_screen/my_order_tab.dart';
import 'package:customer_ui/all_screen/myaccopunt.dart';
import 'package:customer_ui/all_screen/request_product.dart';
import 'package:customer_ui/all_screen/tarck_order.dart';
import 'package:customer_ui/all_screen/wallet.dart';
import 'package:customer_ui/components/styles.dart';
import 'package:customer_ui/components/utils.dart';
import 'package:flutter/material.dart';

Drawer buildDrawerClass(BuildContext context, double block, {VoidCallback? callback}) {
  return Drawer(
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
                      "assets/img_142.png",
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
                            box.read(userName),
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
            Navigator.push(context, MaterialPageRoute(builder: (context) => MyOrderTabBar()));
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
        ListTile(
          title: Row(
            children: [
              Container(
                //color: Colors.white,
                height: 20,
                width: 20,
                child: Image.asset(
                  "assets/e.jpg",
                  color: Colors.black,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
              ),
              Text(
                'Exit',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        SizedBox(
          height: 30,
        ),
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: Row(
            children: [
              GestureDetector(
                onTap: callback,
                child: Container(
                  height: 30,
                  width: 40,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Image.asset(
                      "assets/img_45.png",
                      fit: BoxFit.contain,
                      height: 30,
                      width: 40,
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: callback,
                child: Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: Text(
                    "Log Out",
                    style: TextStyle(color: kBlackColor, fontSize: block * 4.2, fontWeight: FontWeight.w800),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    ),
  );
}
