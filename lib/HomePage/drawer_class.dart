import 'package:customer_ui/components/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DrawerClass extends StatelessWidget {
  const DrawerClass({
    Key? key,
    required this.height,
    required this.width,
    required this.block,
  }) : super(key: key);

  final double height;
  final double width;
  final double block;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          Container(
            height: height*0.2,
            width: width,
            padding: EdgeInsets.all(15.9),
            alignment: Alignment.center,
            color: kPrimaryColor,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                Container(
                  height: 50,width: 50,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,color: kWhiteColor

                  ),
                  child: Center(
                    child: Icon(Icons.person),
                  ),
                ),
                width20,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Welcome",
                      style: TextStyle(color: kWhiteColor, fontSize: block * 5),
                    ),
                    Text(
                      "Shafayet Hossain",
                      style: TextStyle(color: kWhiteColor, fontSize: block * 5,fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
          ),
          sized30,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Row(
              children: [
                Icon(Icons.my_location,color: kBlackColor.withOpacity(0.7),),
                width20,
                Text(
                  "Track Order",
                  style: TextStyle(color: kBlackColor, fontSize: block * 6,fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
          sized30,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Row(
              children: [
                Icon(Icons.bookmark_border,color: kBlackColor.withOpacity(0.7),),
                width20,
                Text(
                  "My Order",
                  style: TextStyle(color: kBlackColor, fontSize: block * 6,fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
          sized30,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Row(
              children: [
                Icon(Icons.menu_sharp,color: kBlackColor.withOpacity(0.7),),
                width20,
                Text(
                  "Category",
                  style: TextStyle(color: kBlackColor, fontSize: block * 6,fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
          sized30,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Row(
              children: [
                Icon(Icons.wallet_travel,color: kBlackColor.withOpacity(0.7),),
                width20,
                Text(
                  "Wallet",
                  style: TextStyle(color: kBlackColor, fontSize: block * 6,fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
          sized30,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Row(
              children: [
                Icon(Icons.call,color: kBlackColor.withOpacity(0.7),),
                width20,
                Text(
                  "Call to Order",
                  style: TextStyle(color: kBlackColor, fontSize: block * 6,fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
          sized30,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Row(
              children: [
                Icon(Icons.person,color: kBlackColor.withOpacity(0.7),),
                width20,
                Text(
                  "My Account",
                  style: TextStyle(color: kBlackColor, fontSize: block * 6,fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),

        ],
      ),
    );
  }
}