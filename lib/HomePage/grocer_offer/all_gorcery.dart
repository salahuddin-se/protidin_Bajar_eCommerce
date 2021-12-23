import 'package:customer_ui/HomePage/offer/grocery.dart';
import 'package:customer_ui/components/size_config.dart';
import 'package:customer_ui/components/styles.dart';
import 'package:flutter/material.dart';

class AllGrocery extends StatefulWidget {
  const AllGrocery({Key? key}) : super(key: key);

  @override
  _AllGroceryState createState() => _AllGroceryState();
}

class _AllGroceryState extends State<AllGrocery> {
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
                  Text("1454 offer found"),
                  Row(
                    children: const [
                      Icon(Icons.filter_list_outlined),
                      SizedBox(width: 5,),
                      Text("Top Deal"),
                      SizedBox(width: 5,),
                      Icon(Icons.keyboard_arrow_down)
                    ],
                  ),
                  Icon(Icons.category_outlined)
                ],
              ),
              sized20,
              Expanded(
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
