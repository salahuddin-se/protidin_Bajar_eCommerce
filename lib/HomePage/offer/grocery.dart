import 'package:customer_ui/HomePage/grocer_offer/grocery_details.dart';
import 'package:customer_ui/components/size_config.dart';
import 'package:customer_ui/components/styles.dart';
import 'package:flutter/material.dart';

class Grocery extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var width = SizeConfig.screenWidth;
    var height = SizeConfig.screenHeight;
    var block = SizeConfig.block;
    return Scaffold(
      body: SizedBox(
        height: height,
        width: width,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("454 offer found"),
                  Row(
                    children: [Icon(Icons.filter_list_outlined), Text("Discount")],
                  ),
                  Icon(Icons.category_outlined)
                ],
              ),
              sized20,
              Expanded(
                //flex: 3,
                child: ListView(
                  children: [
                    TabProductItemWidget(
                      width: width,
                      block: block,
                      height: height,
                      image: "assets/lays.png",
                      productName: "Lays Premium Chips Orange Flavor- 65g",
                      actualPrice: "BDT 130",
                      discountPrice: "BDT 110",
                    ),
                    TabProductItemWidget(
                      width: width,
                      block: block,
                      height: height,
                      image: "assets/dove.png",
                      productName: "Dove Alovera Moyesture Lotions - 500g",
                      actualPrice: "BDT 550",
                      discountPrice: "BDT 410",
                    ),
                    TabProductItemWidget(
                      width: width,
                      block: block,
                      height: height,
                      image: "assets/oil.png",
                      productName: "Aci Pure 100% Healthy Soyabin Oil - 5 litre",
                      actualPrice: "BDT 650",
                      discountPrice: "BDT 590",
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class TabProductItemWidget extends StatelessWidget {
  const TabProductItemWidget({
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
          child: Row(
            children: [
              InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => GroceryDetails()));
                  },
                  child: Image.asset(image!)
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      productName!,
                      style: TextStyle(color: kBlackColor, fontSize: block * 4, fontWeight: FontWeight.w500),
                      maxLines: 2,
                    ),
                    sized5,
                    Container(
                      height: height * 0.03,
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
                          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 3.0),
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
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        Divider(
          color: kBlackColor,
          thickness: 0.3,
        )
      ],
    );
  }
}
