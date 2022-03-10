// import 'package:customer_ui/components/size_config.dart';
// import 'package:customer_ui/components/styles.dart';
// import 'package:customer_ui/components/utils.dart';
// import 'package:customer_ui/controller/cartItemsController.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import 'all_gorcery.dart';
// import 'cart_detailspage.dart';
//
// class GroceryOfferPage extends StatefulWidget {
//   ///var categoryLink = "";
//   var receiveCategoryName = "";
//   var receiveLargeBanner = "";
//   var categoryData = [];
//
//   ///Details({Key? key, required this.link}) : super(key: key);
//
//   ///
//
//   ///
//
//   GroceryOfferPage(
//       {Key? key,
//
//       ///required this.categoryLink,
//       required this.receiveCategoryName,
//       required this.receiveLargeBanner,
//       required this.categoryData})
//       : super(key: key);
//
//   @override
//   _GroceryOfferPageState createState() => _GroceryOfferPageState();
// }
//
// class _GroceryOfferPageState extends State<GroceryOfferPage> with SingleTickerProviderStateMixin {
//   late TabController controller;
//
//   var scaffoldKey = GlobalKey<ScaffoldState>();
//   var controller2 = Get.put(CartItemsController());
//
//   @override
//   void initState() {
//     // TODO: implement initState
//
//     controller = TabController(length: widget.categoryData.length, vsync: this);
//   }
//
//   @override
//   void dispose() {
//     // TODO: implement dispose
//     controller.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     SizeConfig().init(context);
//     var width = SizeConfig.screenWidth;
//     var height = SizeConfig.screenHeight;
//     var block = SizeConfig.block;
//
//     return Scaffold(
//       backgroundColor: kWhiteColor,
//       appBar: AppBar(
//         elevation: 0.0,
//         backgroundColor: kWhiteColor,
//         centerTitle: true,
//         title: Text(widget.receiveCategoryName,
//             style: TextStyle(
//               color: Color(0xFF515151),
//               fontSize: 13,
//               fontFamily: 'CeraProMedium',
//               fontWeight: FontWeight.w500,
//             )),
//         iconTheme: IconThemeData(color: kBlackColor),
//         actions: const [
//           Center(
//             child: Icon(
//               Icons.menu,
//               color: kBlackColor,
//             ),
//           ),
//           SizedBox(
//             width: 10,
//           )
//         ],
//       ),
//       body: SafeArea(
//         child: SizedBox(
//           height: height,
//           width: width,
//           child: Padding(
//             padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
//             child: SingleChildScrollView(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Container(
//                     height: 100,
//                     child: Center(
//                       child: Image.network(
//                         imagePath + widget.receiveLargeBanner,
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                   ),
//
//                   SizedBox(
//                     height: 10,
//                   ),
//
//                   ///
//                   Container(
//                     height: 50,
//                     decoration: BoxDecoration(
//                       border: Border(
//                         //top: BorderSide(width: 4.0, color: Colors.lightBlue.shade600),
//                         bottom: BorderSide(
//                           width: 2.0,
//                           color: Colors.grey,
//                         ),
//                       ),
//                       // borderRadius: BorderRadius.circular(5.0),
//                       //color: Colors.white,
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.white,
//                           offset: Offset(
//                             0.0,
//                             01.0,
//                           ), //(x,y)
//                           blurRadius: 6.0,
//                         ),
//                       ],
//                     ),
//                     child: SizedBox(
//                       height: 50,
//                       child: TabBar(
//                         isScrollable: true,
//                         indicatorColor: Colors.green,
//                         controller: controller,
//                         tabs: widget.categoryData
//                             .map(
//                               (string) => tabBarItems(
//                                 block,
//                                 string.name,
//                                 '1',
//                               ),
//                             )
//                             .toList(),
//                       ),
//                     ),
//                   ),
//
//                   // Divider(
//                   //   color: kBlackColor,
//                   //   thickness: 0.5,
//                   // ),
//                   SizedBox(
//                     height: 12,
//                   ),
//                   // Padding(
//                   //   padding: const EdgeInsets.fromLTRB(10, 0, 7, 0),
//                   //   child: Container(
//                   //     width: MediaQuery.of(context).size.width / 1,
//                   //     child: Row(
//                   //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   //       children: [
//                   //         Text(
//                   //           "1454 item found",
//                   //           style: TextStyle(
//                   //             color: kBlackColor,
//                   //             fontSize: 15,
//                   //             fontWeight: FontWeight.w400,
//                   //             fontFamily: 'CeraProMedium',
//                   //           ),
//                   //         ),
//                   //         Container(
//                   //           child: Image.asset(
//                   //             "assets/img_187.png",
//                   //             height: 22,
//                   //             width: 22,
//                   //           ),
//                   //           height: 22,
//                   //           width: 22,
//                   //         ),
//                   //         Text(
//                   //           "Top Deal",
//                   //           style: TextStyle(
//                   //             color: kBlackColor,
//                   //             fontSize: 13,
//                   //             fontWeight: FontWeight.w500,
//                   //             fontFamily: 'CeraProMedium',
//                   //           ),
//                   //         ),
//                   //         Container(
//                   //           child: Image.asset(
//                   //             "assets/img_188.png",
//                   //             height: 15,
//                   //             width: 15,
//                   //           ),
//                   //           height: 15,
//                   //           width: 15,
//                   //         ),
//                   //         Container(
//                   //           child: Image.asset(
//                   //             "assets/img_189.png",
//                   //             height: 22,
//                   //             width: 22,
//                   //           ),
//                   //           height: 22,
//                   //           width: 22,
//                   //         ),
//                   //       ],
//                   //     ),
//                   //   ),
//                   // ),
//                   SizedBox(
//                     height: 10,
//                   ),
//                   Container(
//                     height: 1000,
//                     child: TabBarView(
//                       controller: controller,
//                       children: widget.categoryData
//                           .map((category) => AllGrocery(
//                                 link: category.links.products,
//                                 related: category.links.products,
//                               ))
//                           .toList(),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//       floatingActionButton: Container(
//         // height: 85,
//         // width: 85,
//         height: 70,
//         width: 70,
//         child: FloatingActionButton(
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 //Icon(Icons.add_shopping_cart),
//
//                 Center(
//                     child: Padding(
//                   //padding: const EdgeInsets.fromLTRB(25, 0, 0, 0),
//                   padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
//                   child: Image.asset(
//                     "assets/cat.png",
//                     height: 29,
//                   ),
//                 )),
//
//                 Obx(() => Align(
//                       alignment: Alignment.topRight,
//                       child: CircleAvatar(
//                         radius: 10.5,
//                         backgroundColor: Colors.green[500],
//                         child: Text(
//                           controller2.cartLength.value.toString(),
//                           style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800),
//                         ),
//                       ),
//                     )),
//               ],
//             ),
//             backgroundColor: Color(0xFF9900FF),
//             onPressed: () {
//               Navigator.push(context, MaterialPageRoute(builder: (context) => CartDetailsPage()));
//             }),
//       ),
//     );
//   }
//
//   Row tabBarItems(double block, String title, String amount) {
//     return Row(
//       children: [
//         Text(
//           title,
//           style: TextStyle(
//             color: kBlackColor,
//             fontSize: 16,
//             fontFamily: 'CeraProMedium',
//           ),
//         ),
//       ],
//     );
//   }
// }
//
// /*
// import 'package:customer_ui/all_screen/cart_detailspage.dart';
// import 'package:customer_ui/components/size_config.dart';
// import 'package:customer_ui/components/styles.dart';
// import 'package:customer_ui/components/utils.dart';
// import 'package:flutter/material.dart';
// import 'all_gorcery.dart';
//
// class GroceryOfferPage extends StatefulWidget {
//   var categoryLink = "";
//   var receiveCategoryName = "";
//   var receiveLargeBanner = "";
//   var categoryData = [];
//
//   ///Details({Key? key, required this.link}) : super(key: key);
//
//   GroceryOfferPage(
//       {Key? key,
//       required this.categoryLink,
//       required this.receiveCategoryName,
//       required this.receiveLargeBanner,
//       required this.categoryData})
//       : super(key: key);
//
//   @override
//   _GroceryOfferPageState createState() => _GroceryOfferPageState();
// }
//
// class _GroceryOfferPageState extends State<GroceryOfferPage> with SingleTickerProviderStateMixin {
//   late TabController controller;
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     controller = TabController(length: widget.categoryData.length, vsync: this);
//   }
//
//   @override
//   void dispose() {
//     // TODO: implement dispose
//     controller.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     SizeConfig().init(context);
//     var width = SizeConfig.screenWidth;
//     var height = SizeConfig.screenHeight;
//     var block = SizeConfig.block;
//
//     return Scaffold(
//       backgroundColor: kWhiteColor,
//       appBar: AppBar(
//         elevation: 0.0,
//         backgroundColor: kWhiteColor,
//         centerTitle: true,
//         title: Text(
//           widget.receiveCategoryName,
//           style: TextStyle(color: kBlackColor, fontSize: block * 4),
//         ),
//         iconTheme: IconThemeData(color: kBlackColor),
//         actions: const [
//           Center(
//             child: Icon(
//               Icons.menu,
//               color: kBlackColor,
//             ),
//           ),
//           SizedBox(
//             width: 10,
//           )
//         ],
//       ),
//       body: SizedBox(
//         height: height,
//         width: width,
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               ///Image.asset("assets/groceryposter.png"),
//               Center(
//                 child: Container(
//                   width: MediaQuery.of(context).size.width / 1.1,
//                   child: Image.network(
//                     imagePath + widget.receiveLargeBanner,
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//               ),
//
//               ///
//               SizedBox(
//                 height: 50,
//                 child: TabBar(
//                   isScrollable: true,
//                   indicatorColor: kPrimaryColor,
//                   controller: controller,
//                   tabs: widget.categoryData.map((string) => tabBarItems(block, string.name, '1')).toList(),
//                 ),
//               ),
//               Expanded(
//                 child: TabBarView(
//                   controller: controller,
//                   children: widget.categoryData
//                       .map((string) => AllGrocery(
//                             link: string.links.products,
//                           ))
//                       .toList(),
//                 ),
//               ),
//               SizedBox(
//                 height: 10,
//               ),
//               Center(
//                 child: InkWell(
//                   onTap: () {
//                     Navigator.push(context, MaterialPageRoute(builder: (context) => CartDetails()));
//                   },
//                   child: Container(
//                     height: 60,
//                     width: MediaQuery.of(context).size.width / 4.5,
//                     child: Image.asset("assets/img_160.png"),
//                   ),
//                 ),
//               ),
//
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Row tabBarItems(double block, String title, String amount) {
//     return Row(
//       children: [
//         Text(
//           title,
//           style: TextStyle(color: kBlackColor),
//         ),
//       ],
//     );
//   }
// }
// */
//
// /*
// import 'dart:developer';
//
// import 'package:customer_ui/components/size_config.dart';
// import 'package:customer_ui/components/styles.dart';
// import 'package:customer_ui/components/utils.dart';
// import 'package:customer_ui/controller/cartItemsController.dart';
// import 'package:customer_ui/dataModel/product_response.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart';
//
// import 'cart_detailspage.dart';
// import 'grocery.dart';
//
// class GroceryOfferPage extends StatefulWidget {
//   ///var categoryLink = "";
//   var receiveCategoryName = "";
//   var receiveLargeBanner = "";
//   var categoryData = [];
//
//   ///Details({Key? key, required this.link}) : super(key: key);
//
//   ///
//
//   ///
//
//   GroceryOfferPage(
//       {Key? key,
//
//       ///required this.categoryLink,
//       required this.receiveCategoryName,
//       required this.receiveLargeBanner,
//       required this.categoryData})
//       : super(key: key);
//
//   @override
//   _GroceryOfferPageState createState() => _GroceryOfferPageState();
// }
//
// class _GroceryOfferPageState extends State<GroceryOfferPage> with SingleTickerProviderStateMixin {
//   late TabController controller;
//
//   var scaffoldKey = GlobalKey<ScaffoldState>();
//   var controller2 = Get.put(CartItemsController());
//
//   @override
//   void initState() {
//     // TODO: implement initState
//
//     controller = TabController(length: widget.categoryData.length, vsync: this);
//   }
//
//   @override
//   void dispose() {
//     // TODO: implement dispose
//     controller.dispose();
//   }
//
//   List<Product> listOfProducts = [];
//
//   Future fetchProducts(link2) async {
//     listOfProducts.clear();
//     log("tap link $link2");
//     log("user id ${box.read(user_Id)}");
//     log("web store id ${box.read(webStoreId)}");
//
//     var response = await get(Uri.parse(link2));
//     var productResponse = productMiniResponseFromJson(response.body);
//
//     for (var ele in productResponse.products!) {
//       if (ele.user_id == box.read(user_Id) || ele.user_id == box.read(webStoreId)) {
//         log(" name  ${ele.name}");
//         listOfProducts.add(Product(
//             name: ele.name,
//             thumbnail_image: ele.thumbnail_image,
//             base_discounted_price: ele.base_discounted_price,
//             shop_name: ele.shop_name,
//             base_price: ele.base_price,
//             unit: ele.unit,
//             id: ele.id,
//             links: ele.links!,
//             discount: ele.discount!,
//             has_discount: ele.has_discount,
//             user_id: ele.user_id));
//         log("product length ${listOfProducts.length}");
//         setState(() {});
//       }
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     SizeConfig().init(context);
//     var width = SizeConfig.screenWidth;
//     var height = SizeConfig.screenHeight;
//     var block = SizeConfig.block;
//
//     return Scaffold(
//       backgroundColor: kWhiteColor,
//       appBar: AppBar(
//         elevation: 0.0,
//         backgroundColor: kWhiteColor,
//         centerTitle: true,
//         title: Text(widget.receiveCategoryName,
//             style: TextStyle(
//               color: Color(0xFF515151),
//               fontSize: 13,
//               fontFamily: 'CeraProMedium',
//               fontWeight: FontWeight.w500,
//             )),
//         iconTheme: IconThemeData(color: kBlackColor),
//         actions: const [
//           Center(
//             child: Icon(
//               Icons.menu,
//               color: kBlackColor,
//             ),
//           ),
//           SizedBox(
//             width: 10,
//           )
//         ],
//       ),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Container(
//                 height: 100,
//                 child: Center(
//                   child: Image.network(
//                     imagePath + widget.receiveLargeBanner,
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//               ),
//
//               SizedBox(
//                 height: 10,
//               ),
//
//
//               ///
//               Container(
//                 height: 50,
//                 decoration: BoxDecoration(
//                   border: Border(
//                     //top: BorderSide(width: 4.0, color: Colors.lightBlue.shade600),
//                     bottom: BorderSide(
//                       width: 2.0,
//                       color: Colors.grey,
//                     ),
//                   ),
//                   // borderRadius: BorderRadius.circular(5.0),
//                   //color: Colors.white,
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.white,
//                       offset: Offset(
//                         0.0,
//                         01.0,
//                       ), //(x,y)
//                       blurRadius: 6.0,
//                     ),
//                   ],
//                 ),
//                 child: SizedBox(
//                   height: 50,
//                   child: TabBar(
//                     onTap: (6),
//                     isScrollable: true,
//                     indicatorColor: Colors.green,
//                     controller: controller,
//                     tabs: widget.categoryData
//                         .map(
//                           (category) => tabBarItems(block, category.name, '1', category.links.products),
//                         )
//                         .toList(),
//                   ),
//                 ),
//               ),
//
//               // Divider(
//               //   color: kBlackColor,
//               //   thickness: 0.5,
//               // ),
//               SizedBox(
//                 height: 12,
//               ),
//               // Padding(
//               //   padding: const EdgeInsets.fromLTRB(10, 0, 7, 0),
//               //   child: Container(
//               //     width: MediaQuery.of(context).size.width / 1,
//               //     child: Row(
//               //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               //       children: [
//               //         Text(
//               //           "1454 item found",
//               //           style: TextStyle(
//               //             color: kBlackColor,
//               //             fontSize: 15,
//               //             fontWeight: FontWeight.w400,
//               //             fontFamily: 'CeraProMedium',
//               //           ),
//               //         ),
//               //         Container(
//               //           child: Image.asset(
//               //             "assets/img_187.png",
//               //             height: 22,
//               //             width: 22,
//               //           ),
//               //           height: 22,
//               //           width: 22,
//               //         ),
//               //         Text(
//               //           "Top Deal",
//               //           style: TextStyle(
//               //             color: kBlackColor,
//               //             fontSize: 13,
//               //             fontWeight: FontWeight.w500,
//               //             fontFamily: 'CeraProMedium',
//               //           ),
//               //         ),
//               //         Container(
//               //           child: Image.asset(
//               //             "assets/img_188.png",
//               //             height: 15,
//               //             width: 15,
//               //           ),
//               //           height: 15,
//               //           width: 15,
//               //         ),
//               //         Container(
//               //           child: Image.asset(
//               //             "assets/img_189.png",
//               //             height: 22,
//               //             width: 22,
//               //           ),
//               //           height: 22,
//               //           width: 22,
//               //         ),
//               //       ],
//               //     ),
//               //   ),
//               // ),
//               SizedBox(
//                 height: 10,
//               ),
//
//               for (int index = 0; index < listOfProducts.length; index++)
//                 TabProductItemWidget(
//                   width: width,
//                   block: block,
//                   height: height,
//                   //Image.network(imagePath + listOfProducts[index].thumbnail_image.toString()),
//                   image: imagePath + listOfProducts[index].thumbnail_image.toString(),
//                   productName: listOfProducts[index].name.toString(),
//                   discountPrice: listOfProducts[index].base_price,
//                   actualPrice: listOfProducts[index].base_discounted_price,
//                   id: listOfProducts[index].id,
//                   unit: listOfProducts[index].unit,
//                   off: listOfProducts[index].discount.toString(),
//                   product: listOfProducts[index],
//                   related: "",
//                 ),
//
//               SizedBox(
//                 height: 50,
//               )
//
//               // Expanded(
//               //   child: TabBarView(
//               //     controller: controller,
//               //     children: widget.categoryData
//               //         .map((category) => AllGrocery(
//               //       link: category.links.products,
//               //       related: category.links.products,
//               //     ))
//               //         .toList(),
//               //   ),
//               // ),
//             ],
//           ),
//         ),
//       ),
//       floatingActionButton: Container(
//         // height: 85,
//         // width: 85,
//         height: 70,
//         width: 70,
//         child: FloatingActionButton(
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 //Icon(Icons.add_shopping_cart),
//
//                 Center(
//                     child: Padding(
//                   //padding: const EdgeInsets.fromLTRB(25, 0, 0, 0),
//                   padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
//                   child: Image.asset(
//                     "assets/cat.png",
//                     height: 29,
//                   ),
//                 )),
//
//                 Obx(() => Align(
//                       alignment: Alignment.topRight,
//                       child: CircleAvatar(
//                         radius: 10.5,
//                         backgroundColor: Colors.green[500],
//                         child: Text(
//                           controller2.cartLength.value.toString(),
//                           style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800),
//                         ),
//                       ),
//                     )),
//               ],
//             ),
//             backgroundColor: Color(0xFF9900FF),
//             onPressed: () {
//               Navigator.push(context, MaterialPageRoute(builder: (context) => CartDetailsPage()));
//             }),
//       ),
//     );
//   }
//
//   Row tabBarItems(double block, String title, String amount, String link) {
//     return Row(
//       children: [
//         InkWell(
//           onTap: () {
//             controller.addListener(() {})
//             fetchProducts(link);
//           },
//           child: Text(
//             title,
//             style: TextStyle(
//               color: kBlackColor,
//               fontSize: 16,
//               fontFamily: 'CeraProMedium',
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
//
// /*
// import 'package:customer_ui/all_screen/cart_detailspage.dart';
// import 'package:customer_ui/components/size_config.dart';
// import 'package:customer_ui/components/styles.dart';
// import 'package:customer_ui/components/utils.dart';
// import 'package:flutter/material.dart';
// import 'all_gorcery.dart';
//
// class GroceryOfferPage extends StatefulWidget {
//   var categoryLink = "";
//   var receiveCategoryName = "";
//   var receiveLargeBanner = "";
//   var categoryData = [];
//
//   ///Details({Key? key, required this.link}) : super(key: key);
//
//   GroceryOfferPage(
//       {Key? key,
//       required this.categoryLink,
//       required this.receiveCategoryName,
//       required this.receiveLargeBanner,
//       required this.categoryData})
//       : super(key: key);
//
//   @override
//   _GroceryOfferPageState createState() => _GroceryOfferPageState();
// }
//
// class _GroceryOfferPageState extends State<GroceryOfferPage> with SingleTickerProviderStateMixin {
//   late TabController controller;
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     controller = TabController(length: widget.categoryData.length, vsync: this);
//   }
//
//   @override
//   void dispose() {
//     // TODO: implement dispose
//     controller.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     SizeConfig().init(context);
//     var width = SizeConfig.screenWidth;
//     var height = SizeConfig.screenHeight;
//     var block = SizeConfig.block;
//
//     return Scaffold(
//       backgroundColor: kWhiteColor,
//       appBar: AppBar(
//         elevation: 0.0,
//         backgroundColor: kWhiteColor,
//         centerTitle: true,
//         title: Text(
//           widget.receiveCategoryName,
//           style: TextStyle(color: kBlackColor, fontSize: block * 4),
//         ),
//         iconTheme: IconThemeData(color: kBlackColor),
//         actions: const [
//           Center(
//             child: Icon(
//               Icons.menu,
//               color: kBlackColor,
//             ),
//           ),
//           SizedBox(
//             width: 10,
//           )
//         ],
//       ),
//       body: SizedBox(
//         height: height,
//         width: width,
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               ///Image.asset("assets/groceryposter.png"),
//               Center(
//                 child: Container(
//                   width: MediaQuery.of(context).size.width / 1.1,
//                   child: Image.network(
//                     imagePath + widget.receiveLargeBanner,
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//               ),
//
//               ///
//               SizedBox(
//                 height: 50,
//                 child: TabBar(
//                   isScrollable: true,
//                   indicatorColor: kPrimaryColor,
//                   controller: controller,
//                   tabs: widget.categoryData.map((string) => tabBarItems(block, string.name, '1')).toList(),
//                 ),
//               ),
//               Expanded(
//                 child: TabBarView(
//                   controller: controller,
//                   children: widget.categoryData
//                       .map((string) => AllGrocery(
//                             link: string.links.products,
//                           ))
//                       .toList(),
//                 ),
//               ),
//               SizedBox(
//                 height: 10,
//               ),
//               Center(
//                 child: InkWell(
//                   onTap: () {
//                     Navigator.push(context, MaterialPageRoute(builder: (context) => CartDetails()));
//                   },
//                   child: Container(
//                     height: 60,
//                     width: MediaQuery.of(context).size.width / 4.5,
//                     child: Image.asset("assets/img_160.png"),
//                   ),
//                 ),
//               ),
//
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Row tabBarItems(double block, String title, String amount) {
//     return Row(
//       children: [
//         Text(
//           title,
//           style: TextStyle(color: kBlackColor),
//         ),
//       ],
//     );
//   }
// }
// */
//
// */
