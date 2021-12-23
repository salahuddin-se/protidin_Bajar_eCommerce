import 'package:customer_ui/components/styles.dart';
import 'package:flutter/material.dart';


class ProductItemsWidget extends StatelessWidget {
  final double? height;
  final double? width;
  final double? block;
  final String? image;
  final String? productName;
  final String? productWeight;
  final String? productOfferPrice;
  final String? productActualPrice;

  const ProductItemsWidget(
      {this.height, this.width, this.block, this.image, this.productName, this.productWeight, this.productOfferPrice, this.productActualPrice});

  @override
  Widget build(BuildContext context) {

    return Container(
      height: height! * 0.375,
      margin: EdgeInsets.only(left: 0, top: 5, bottom: 5),
      width: width! * 0.44,
      decoration: BoxDecoration(
          color: Color(0xFFF1EDF2),
          borderRadius: BorderRadius.circular(15.0)
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,

        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Container(

              //
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(4.0),
                    bottomRight: Radius.circular(4.0)
                ),
              ),
              //

              height: height! * 0.028,
              margin: EdgeInsets.only(top: 10),
              width: width! * 0.21,
              child: Center(
                child: Text(
                  "15% OFF",
                  style: TextStyle(color: Colors.white,
                      fontSize: 12.5,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
          ),

          Expanded(child: Image.asset(image!,height: height!*0.25,width: width!*0.25,)),
          //Expanded(child: Image.asset(image!,height: height!*0.5,width: width!*0.4,)),
          //sized5,
          Text(
            productName!,
            style: TextStyle(color: Color(0xFF515151), fontSize: block!*4, fontWeight: FontWeight.w500,fontFamily: "CeraProBold",),
            textAlign: TextAlign.center,softWrap: false,

          ),
          sized5,
          Center(
            child: Text(
              productWeight!,
              style: TextStyle(color: Colors.grey.withOpacity(0.9)),
            ),
          ),
          sized5,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [

              Image.asset("assets/p.png",height:block!*5,width: block!*5,),
              Text(productOfferPrice!, style: TextStyle(
                  color: Color(0xFF515151),
                  fontSize: block!*4.5,
                  fontWeight: FontWeight.w700)),
              Text(productActualPrice!,
                  style: TextStyle(
                      color: Color(0xFFA299A8),
                      fontSize: block!*3.5,
                      fontWeight: FontWeight.w400,
                      decoration: TextDecoration.lineThrough)
              ),
              Container(
                height: block!*6,
                width: block!*6,
                decoration: BoxDecoration(
                    color: kPrimaryColor, shape: BoxShape.circle),
                child: Center(
                  child: Icon(
                    Icons.shopping_cart_rounded,
                    color: Colors.white,
                    size: block! * 4,
                  ),
                ),
              )

            ],
          ),
          sized5,
          Container(
            //height: height! * 0.03,
            height: height! * 0.05,
            width: width!,
            decoration: BoxDecoration(
                color: Colors.lightGreen[100],
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10.0),
                    bottomRight: Radius.circular(10.0))
            ),
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
                      " Wallet Bonus +৳18",
                      style: TextStyle(fontSize: block!*3.5,
                          color: Colors.green,
                          fontWeight: FontWeight.w400),

                    ),
                  ),

                ],
              ),
            ),
          )
        ],
      ),

    );
  }
}



/*import 'package:customer_ui/components/styles.dart';
import 'package:flutter/material.dart';

class ProductItemsWidget extends StatelessWidget {
  final double? height;
  final double? width;
  final double? block;
  final String? image;
  final String? productName;
  final String? productWeight;
  final String? productOfferPrice;
  final String? productActualPrice;

  ProductItemsWidget({this.height, this.width, this.block,this.image,this.productName,this.productWeight,this.productOfferPrice,this.productActualPrice});

  @override
  Widget build(BuildContext context) {
    return Container(
      //height: height! * 0.27,
      //height: height! * 0.37,
      height: 290,
      margin: EdgeInsets.only(left: 0,top: 5, bottom: 5),
      //width: width! * 0.45,
      //width: width! * 0.5,
      //width: width! * 0.47,
      width: width! * 0.44,
      decoration: BoxDecoration(
          color: Color(0xFFF1EDF2),
          borderRadius: BorderRadius.circular(15.0)),
      child: Column(
        //mainAxisAlignment: MainAxisAlignment.end,

        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Container(

              //
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(4.0),
                    bottomRight: Radius.circular(4.0)
                ),

              ),
              //

              height: MediaQuery.of(context).size.height/30,
              margin: EdgeInsets.only(top: 10),
              width: width!*0.21,
              child: Center(
                child: Text(
                  "15% OFF",
                  style: TextStyle(color: Colors.white, fontSize: 12.5, fontWeight: FontWeight.w500),
                ),
              ),
            ),
          ),

          Container(
              height: MediaQuery.of(context).size.height/10,
              child: Image.asset(image!)
          ),

          Container(
            height: MediaQuery.of(context).size.height/10,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2),
              child: Text(
                productName!,
                style: TextStyle(color: Color(0xFF515151), fontSize: 15, fontWeight: FontWeight.w500,fontFamily: "CeraProBold"),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          SizedBox(height: 2,),
          Container(
            height: MediaQuery.of(context).size.height/15,
            child: Center(
              child: Text(
                productWeight!,
                style: TextStyle(color: Colors.grey.withOpacity(0.9)),
              ),
            ),
          ),
          //sized5,
          Container(
            height: MediaQuery.of(context).size.height/10,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(5,0,5,0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                      child: Image.asset("assets/p.png"),
                    height: 18,
                    width: 22,
                  ),
                  Text(productOfferPrice!, style: TextStyle(color: Color(0xFF515151), fontSize: 19, fontWeight: FontWeight.w700)),
                  Text(productActualPrice!,
                      style: TextStyle(
                          color: Color(0xFFA299A8),
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          decoration: TextDecoration.lineThrough)
                  ),
                  Container(
                    height: 25,
                    width: 25,
                    decoration: BoxDecoration(color: kPrimaryColor, shape: BoxShape.circle),
                    child: Center(
                      child: Icon(
                        Icons.shopping_cart_rounded,
                        color: Colors.white,
                        size: block! * 4,
                      ),
                    ),
                  )

                ],
              ),
            ),
          ),
          //sized5,
          Container(
            height: MediaQuery.of(context).size.height/10,
            //height: height! * 0.03,
            //height: height! * 0.06,
            width: width!,
            decoration: BoxDecoration(
              color: Colors.lightGreen[100],
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10.0),bottomRight: Radius.circular(10.0))
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(2,3,2,3),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  SizedBox(
                    width: 2,
                  ),

                  Container(
                    child: Image.asset("assets/img_42.png"),
                    height: 20,
                    width: 15,
                  ),

                  /*SizedBox(
                    //color: Colors.white,
                    height: 10,
                    width: 15,
                    child: Image.asset("assets/img_186.png",color: Colors.black,),
                  ),*/

                  /*Icon(
                    Icons.wallet_giftcard,
                    color: Colors.green,                    size: block! * 5,
                  ),*/

                  Padding(
                    padding: const EdgeInsets.only(top: 2),
                    child: Text(
                      " Wallet Bonus +৳18",
                      style: TextStyle(fontSize:13,color: Colors.green),

                    ),
                  ),

                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
*/

/*
import 'package:customer_ui/components/styles.dart';
import 'package:flutter/material.dart';

class ProductItemsWidget extends StatelessWidget {
  final double? height;
  final double? width;
  final double? block;
  final String? image;
  final String? productName;
  final String? productWeight;
  final String? productOfferPrice;
  final String? productActualPrice;

  ProductItemsWidget({this.height, this.width, this.block,this.image,this.productName,this.productWeight,this.productOfferPrice,this.productActualPrice});

  @override
  Widget build(BuildContext context) {
    return Container(
      //height: height! * 0.27,
      height: height! * 0.37,
      margin: EdgeInsets.only(left: 0,top: 5, bottom: 5),
      //width: width! * 0.45,
      //width: width! * 0.5,
      //width: width! * 0.47,
      width: width! * 0.44,
      decoration: BoxDecoration(
          color: Color(0xFFF1EDF2),
          borderRadius: BorderRadius.circular(15.0)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,

        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Container(

              //
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(4.0),
                    bottomRight: Radius.circular(4.0)
                ),

              ),
              //

              height: height!*0.028,
              margin: EdgeInsets.only(top: 10),
              width: width!*0.21,
              child: Center(
                child: Text(
                  "15% OFF",
                  style: TextStyle(color: Colors.white, fontSize: 12.5, fontWeight: FontWeight.w500),
                ),
              ),
            ),
          ),
          Expanded(child: Image.asset(image!)),
          Container(
            height: height!*0.073,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2),
              child: Text(
                productName!,
                style: TextStyle(color: Color(0xFF515151), fontSize: 15, fontWeight: FontWeight.w500,fontFamily: "CeraProBold"),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          SizedBox(height: 2,),
          Center(
            child: Text(
              productWeight!,
              style: TextStyle(color: Colors.grey.withOpacity(0.9)),
            ),
          ),
          //sized5,
          Padding(
            padding: const EdgeInsets.fromLTRB(5,0,5,0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                    child: Image.asset("assets/p.png"),
                  height: 18,
                  width: 22,
                ),
                Text(productOfferPrice!, style: TextStyle(color: Color(0xFF515151), fontSize: 19, fontWeight: FontWeight.w700)),
                Text(productActualPrice!,
                    style: TextStyle(
                        color: Color(0xFFA299A8),
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        decoration: TextDecoration.lineThrough)
                ),
                Container(
                  height: 25,
                  width: 25,
                  decoration: BoxDecoration(color: kPrimaryColor, shape: BoxShape.circle),
                  child: Center(
                    child: Icon(
                      Icons.shopping_cart_rounded,
                      color: Colors.white,
                      size: block! * 4,
                    ),
                  ),
                )

              ],
            ),
          ),
          //sized5,
          Container(
            //height: height! * 0.03,
            height: height! * 0.06,
            width: width!,
            decoration: BoxDecoration(
              color: Colors.lightGreen[100],
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10.0),bottomRight: Radius.circular(10.0))
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(2,3,2,3),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  SizedBox(
                    width: 2,
                  ),

                  Container(
                    child: Image.asset("assets/img_42.png"),
                    height: 20,
                    width: 15,
                  ),

                  /*SizedBox(
                    //color: Colors.white,
                    height: 10,
                    width: 15,
                    child: Image.asset("assets/img_186.png",color: Colors.black,),
                  ),*/

                  /*Icon(
                    Icons.wallet_giftcard,
                    color: Colors.green,                    size: block! * 5,
                  ),*/

                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 2),
                      child: Text(
                        " Wallet Bonus +৳18",
                        style: TextStyle(fontSize:13,color: Colors.green),

                      ),
                    ),
                  ),

                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}*/

