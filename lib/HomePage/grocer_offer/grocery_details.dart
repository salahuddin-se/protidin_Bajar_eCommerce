import 'package:customer_ui/HomePage/offer/grocery.dart';
import 'package:customer_ui/OthersPage/cartDetails1stPage.dart';
import 'package:customer_ui/components/size_config.dart';
import 'package:customer_ui/components/styles.dart';
import 'package:flutter/material.dart';

class GroceryDetails extends StatefulWidget {
  const GroceryDetails({Key? key}) : super(key: key);

  @override
  _GroceryDetailsState createState() => _GroceryDetailsState();
}

class _GroceryDetailsState extends State<GroceryDetails> {
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
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 13.0, vertical: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(
                      Icons.share,
                      color: kBlackColor,
                    )
                  ],
                ),
                Center(
                  child: Image.asset(
                    "assets/oil.png",
                    fit: BoxFit.cover,
                    height: height * 0.2,
                  ),
                ),
                sized30,
                Text(
                  "Aci Pure 100% Healthy Soyabin Oil - 5 litre",
                  style: TextStyle(color: kBlackColor, fontSize: block * 5, fontWeight: FontWeight.w500),
                ),
                sized15,
                Text(
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et "
                  "dolore magna aliqua.",
                  style: TextStyle(color: kBlackColor.withOpacity(0.5), fontSize: block * 3.5, fontWeight: FontWeight.w300),
                ),
                sized15,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text("BDT 700", style: TextStyle(color: kBlackColor, fontSize: block * 4.5, fontWeight: FontWeight.bold)),
                        SizedBox(
                          width: 15,
                        ),
                        Text(
                          "BDT 770",
                          style: TextStyle(
                              color: kBlackColor,
                              fontSize: block * 4,
                              fontWeight: FontWeight.w300,
                              decoration: TextDecoration.lineThrough),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Container(
                          height: height * 0.02,
                          width: width * 0.15,
                          decoration: BoxDecoration(color: Colors.green),
                          child: Center(
                            child: Text(
                              "15% Off",
                              style: TextStyle(color: Colors.white, fontSize: block * 3, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.wallet_travel_rounded,
                          color: Colors.green,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text("BDT 35", style: TextStyle(color: kBlackColor, fontSize: block * 4, fontWeight: FontWeight.w400)),
                      ],
                    )
                  ],
                ),
                sized15,
                Container(
                  height: height * 0.05,
                  width: width,
                  padding: EdgeInsets.symmetric(horizontal: 5.0),
                  decoration: BoxDecoration(color: Colors.red[50], borderRadius: BorderRadius.circular(5.0)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset("assets/emo.png"),
                      Text(
                        "Member Price: BDT 690",
                        style: TextStyle(color: kBlackColor, fontSize: block * 3.5, fontWeight: FontWeight.w400),
                      ),
                      Text(
                        "Save BDT 20",
                        style: TextStyle(color: Colors.green, fontSize: block * 3.5, fontWeight: FontWeight.w400),
                      ),
                      Icon(
                        Icons.shopping_bag_outlined,
                        color: kBlackColor.withOpacity(0.3),
                      )
                    ],
                  ),
                ),
                sized20,
                Row(
                  children: [
                    Text("Unit:", style: TextStyle(color: kBlackColor, fontSize: block * 3.5, fontWeight: FontWeight.w400)),
                    SizedBox(
                      width: 10.0,
                    ),
                    uniteWidget(height, width, block,"1 Kg",kBlackColor.withOpacity(0.4)),
                    width10,
                    uniteWidget(height, width, block,"2 Kg",kBlackColor.withOpacity(0.4)),
                    width10,
                    uniteWidget(height, width, block,"5 Kg",kPrimaryColor),
                  ],
                ),
                sized20,
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 100),
                    child: MaterialButton(
                      onPressed: (){

                      },
                      height: height*0.06,
                      minWidth: width,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0)),
                      color: kPrimaryColor,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Add",
                            style: TextStyle(color: kWhiteColor, fontSize: block * 5, fontWeight: FontWeight.w500),
                          ),
                          width10,
                          Icon(Icons.add,color: kWhiteColor,)
                        ],
                      ),
                    ),
                  ),
                ),
                sized30,
                Container(
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: Colors.red[50],
                    borderRadius: BorderRadius.circular(10.0)
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Related", style: TextStyle(color: kBlackColor, fontSize: block * 4, fontWeight: FontWeight.bold)),
                          Text("Show more", style: TextStyle(color: kBlackColor, fontSize: block * 4, fontWeight: FontWeight.w300)),
                        ],
                      ),
                      sized10,
                      RelatedMoreItems(
                        width: width,
                        block: block,
                        height: height,
                        image: "assets/oil.png",
                        productName: "Aci Pure 100% Healthy Soyabin Oil - 5 litre",
                        actualPrice: "BDT 650",
                        discountPrice: "BDT 590",
                      ),
                      sized10,
                      RelatedMoreItems(
                        width: width,
                        block: block,
                        height: height,
                        image: "assets/dove.png",
                        productName: "Dove Alovera Moyesture Lotions - 500g",
                        actualPrice: "BDT 550",
                        discountPrice: "BDT 410",
                      ),
                      sized10,
                      RelatedMoreItems(
                        width: width,
                        block: block,
                        height: height,
                        image: "assets/lays.png",
                        productName: "Lays Premium Chips Orange Flavor- 65g",
                        actualPrice: "BDT 130",
                        discountPrice: "BDT 110",
                      ),
                    ],
                  ),
                ),

                Center(
                  child: InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => CartDetails()));
                    },
                    child: Container(
                      height: 60,
                      width: MediaQuery.of(context).size.width/4,
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

  Container uniteWidget(double height, double width, double block,String unit,Color borderColor) {
    return Container(
      height: height * 0.03,
      width: width * 0.13,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), border: Border.all(color: borderColor)),
      child: Center(
        child: Text(unit, style: TextStyle(color: kBlackColor, fontSize: block * 3.5, fontWeight: FontWeight.w400)),
      ),
    );
  }
}


class RelatedMoreItems extends StatelessWidget {
  const RelatedMoreItems({
    Key? key,
    required this.width,
    required this.block,
    required this.height,
    this.image,
    this.productName,
    this.off,
    this.actualPrice,
    this.discountPrice,
  }) : super(key: key);

  final double width;
  final double block;
  final double height;
  final String? image;
  final String? productName;
  final String? off;
  final String? actualPrice;
  final String? discountPrice;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          //height: height * 0.15,
          width: width,
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: kWhiteColor
          ),
          child: Row(
            children: [
              Image.asset(image!),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    sized10,
                    Text(
                      productName!,
                      style: TextStyle(color: kBlackColor, fontSize: block * 4, fontWeight: FontWeight.w500),
                      maxLines: 2,
                    ),
                    sized5,
                    Container(
                      height: height * 0.02,
                      margin: EdgeInsets.only(top: 10),
                      width: width * 0.15,
                      decoration: BoxDecoration(color: Colors.green),
                      child: Center(
                        child: Text(
                          "$off Off",
                          style: TextStyle(color: Colors.white, fontSize: block * 3, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    sized5,
                    Row(
                      children: [
                        Row(
                          children: [
                            Text(discountPrice!,
                                style: TextStyle(color: kBlackColor, fontSize: block * 4.5, fontWeight: FontWeight.bold)),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              actualPrice!,
                              style: TextStyle(
                                  color: kBlackColor,
                                  fontSize: block * 4,
                                  fontWeight: FontWeight.w300,
                                  decoration: TextDecoration.lineThrough),
                            )
                          ],
                        ),
                        Expanded(child: Container()),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 7.0, vertical: 3.0),
                          decoration: BoxDecoration(
                            color: kPrimaryColor,
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Row(
                            children: [
                              Text("Add", style: TextStyle(color: kWhiteColor, fontSize: block * 4, fontWeight: FontWeight.bold)),
                              Icon(
                                Icons.add,
                                color: kWhiteColor,
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                      ],
                    ),
                    sized10,
                  ],
                ),
              ),
            ],
          ),
        ),

        SizedBox(height: 10,),



      ],
    );
  }
}
