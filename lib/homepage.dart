/*
import 'package:customer_ui/components/size_config.dart';
import 'package:customer_ui/components/styles.dart';
import 'package:flutter/material.dart';

import 'HomePage/drawer_class.dart';
import 'HomePage/grocer_offer/grocery_offer_page.dart';
import 'all_screen/category_home_screen.dart';
import 'all_screen/profile_screen.dart';
import 'OthersPage/cart_detailspage.dart';
import 'OthersPage/catgoryView1stPage.dart';
import 'OthersPage/ongoing_orders.dart';
import 'OthersPage/myaccopunt.dart';
import 'OthersPage/request_product.dart';
import 'OthersPage/tarck_order.dart';
import 'OthersPage/wallet.dart';

class Homepage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Homepage> {
  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  int selectIndex=0;
  PageController pageController=PageController();

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
        /*drawer: Drawer(
          //backgroundColor: Colors.,
          // Add a ListView to the drawer. This ensures the user can scroll
          // through the options in the drawer if there isn't enough vertical
          // space to fit everything.
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
        ),*/
        ///
        
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          // isExtended: true,
          child: Icon(Icons.home),
          backgroundColor: kPrimaryColor,
          onPressed: () {
            setState(() {
              Navigator.push(context, MaterialPageRoute(builder: (context) => CategoryHomeScreen()));

            });
          },
        ),

          body: PageView(
            controller: pageController,
            children: [
              CategoryHomeScreen(),
              //ProfileScreen(),
              Drawer(),
              CartDetails(),

            ],
          ),
        /*bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: kPrimaryColor,
          unselectedItemColor: Colors.grey,
          currentIndex: selectIndex,
          onTap: onTap,
          items: [
            BottomNavigationBarItem(icon: InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => CartDetails()));
                },
                child: Icon(Icons.shopping_cart_rounded)),label: "cart"),
            BottomNavigationBarItem(icon:InkWell(
                onTap: () {
                  if(!scaffoldKey.currentState!.isDrawerOpen){ //check if drawer is closed
                    scaffoldKey.currentState!.openDrawer(); //open drawer
                  }
                },
                //child: Icon(Icons.person)), label: "Profile"),
                child: Icon(Icons.person)), label: "Profile"),
          ],
        ),*/
      ),
    );
  }

  void onTap(index){
    setState(() {
      selectIndex=index;
    });
    pageController.jumpToPage(index);
  }
}
*/

/*
import 'package:customer_ui/components/size_config.dart';
import 'package:customer_ui/components/styles.dart';
import 'package:flutter/material.dart';

import 'HomePage/drawer_class.dart';
import 'all_screen/category_home_screen.dart';
import 'all_screen/profile_screen.dart';
import 'OthersPage/cart_detailspage.dart';

class Homepage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Homepage> {
  final GlobalKey<ScaffoldState> _scaffoldKey =  GlobalKey<ScaffoldState>();
  int selectIndex=0;
  PageController pageController=PageController();

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
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          // isExtended: true,
          child: Icon(Icons.home),
          backgroundColor: kPrimaryColor,
          onPressed: () {
            setState(() {
              Navigator.push(context, MaterialPageRoute(builder: (context) => CategoryHomeScreen()));

            });
          },
        ),

          body: PageView(
            controller: pageController,
            children: [
              CategoryHomeScreen(),
              ProfileScreen(),
              CartDetails(),

            ],
          ),
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: kPrimaryColor,
          unselectedItemColor: Colors.grey,
          currentIndex: selectIndex,
          onTap: onTap,
          items: [
            BottomNavigationBarItem(icon: InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => CartDetails()));
                },
                child: Icon(Icons.shopping_cart_rounded)),label: "cart"),
            BottomNavigationBarItem(icon:InkWell(
                onTap: () {
                  Scaffold.of(context).openDrawer();
                },
                child: Icon(Icons.person)), label: "Profile"),
          ],
        ),
      ),
    );
  }

  void onTap(index){
    setState(() {
      selectIndex=index;
    });
    pageController.jumpToPage(index);
  }
}

*/
