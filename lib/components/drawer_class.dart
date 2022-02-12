import 'package:customer_ui/all_screen/my_order_tab.dart';
import 'package:customer_ui/all_screen/myaccopunt.dart';
import 'package:customer_ui/all_screen/request_product.dart';
import 'package:customer_ui/all_screen/tarck_order.dart';
import 'package:customer_ui/all_screen/wallet.dart';
import 'package:customer_ui/components/utils.dart';
import 'package:flutter/material.dart';

Drawer buildDrawerClass(BuildContext context, double block, {VoidCallback? callback}) {
  return Drawer(
    child: ListView(
      // Important: Remove any padding from the ListView.
      padding: EdgeInsets.zero,
      children: <Widget>[
        Container(
          height: 130,
          child: DrawerHeader(
            child: Container(
              //height: 50,
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
                      //height: 60,
                      width: 60,
                      child: Image.asset(
                        "assets/img_142.png",
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                    ),
                    Container(
                      width: 100,
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Welcome ",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 13,
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
                                fontWeight: FontWeight.w700,
                                fontFamily: "CeraProBold",
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 40.0),
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          //color: Colors.white,
                          //height: 40,
                          width: 40,
                          child: Image.asset(
                            "assets/img_186.png",
                            color: Colors.white,
                          ),
                        ),
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
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 0, 5),
          child: ListTile(
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
                  padding: const EdgeInsets.fromLTRB(40, 0, 0, 0),
                ),
                Text(
                  'Track Order',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    fontFamily: "CeraProBold",
                    color: Color(0xFF515151),
                  ),
                ),
              ],
            ),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => TrackOrder()));
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 0, 5),
          child: ListTile(
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
                  padding: const EdgeInsets.fromLTRB(40, 0, 0, 0),
                ),
                Text(
                  'My Orders',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    fontFamily: "CeraProBold",
                    color: Color(0xFF515151),
                  ),
                ),
              ],
            ),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => MyOrderTabBar()));
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 0, 5),
          child: ListTile(
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
                  padding: const EdgeInsets.fromLTRB(40, 0, 0, 0),
                ),
                Text(
                  'Categories',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    fontFamily: "CeraProBold",
                    color: Color(0xFF515151),
                  ),
                ),
              ],
            ),
            onTap: () {
              //Navigator.push(context, MaterialPageRoute(builder: (context) => GroceryOfferPage()));
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 0, 5),
          child: ListTile(
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
                  padding: const EdgeInsets.fromLTRB(40, 0, 0, 0),
                ),
                Text(
                  'Wallet',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    fontFamily: "CeraProBold",
                    color: Color(0xFF515151),
                  ),
                ),
              ],
            ),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => MyWallet()));
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 0, 5),
          child: ListTile(
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
                  padding: const EdgeInsets.fromLTRB(40, 0, 0, 0),
                ),
                Text(
                  'Request a product',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    fontFamily: "CeraProBold",
                    color: Color(0xFF515151),
                  ),
                ),
              ],
            ),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => ReqquestPage()));
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 0, 5),
          child: ListTile(
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
                  padding: const EdgeInsets.fromLTRB(40, 0, 0, 0),
                ),
                Text(
                  'Call to order',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    fontFamily: "CeraProBold",
                    color: Color(0xFF515151),
                  ),
                ),
              ],
            ),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => TrackOrder()));
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 0, 5),
          child: ListTile(
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
                  padding: const EdgeInsets.fromLTRB(40, 0, 0, 0),
                ),
                Text(
                  'My Account',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    fontFamily: "CeraProBold",
                    color: Color(0xFF515151),
                  ),
                ),
              ],
            ),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => MyAccountPage()));
            },
          ),
        ),
        // Padding(
        //   padding: const EdgeInsets.only(left: 15.0),
        //   child: ListTile(
        //     title: Row(
        //       children: [
        //         Container(
        //           //color: Colors.white,
        //           height: 20,
        //           width: 20,
        //           child: Image.asset(
        //             "assets/e.jpg",
        //             color: Colors.black,
        //           ),
        //         ),
        //         Padding(
        //           padding: const EdgeInsets.fromLTRB(40, 0, 0, 0),
        //         ),
        //         Text(
        //           'Exit',
        //           style: TextStyle(
        //             color: Colors.black,
        //             fontSize: 15,
        //             fontWeight: FontWeight.w700,
        //           ),
        //         ),
        //       ],
        //     ),
        //     onTap: () {
        //       Navigator.pop(context);
        //     },
        //   ),
        // ),
        SizedBox(
          height: 90,
        ),

        Padding(
          padding: const EdgeInsets.fromLTRB(30, 0, 30, 10),
          child: Divider(
            color: Colors.black,
          ),
        ),

        Padding(
          padding: const EdgeInsets.fromLTRB(30, 0, 0, 5),
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
                  padding: const EdgeInsets.only(left: 25),
                  child: Text(
                    "Log Out",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      fontFamily: "CeraProBold",
                      color: Color(0xFF515151),
                    ),
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
