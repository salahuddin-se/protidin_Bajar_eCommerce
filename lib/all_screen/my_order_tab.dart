import 'package:customer_ui/all_screen/ongoing_orders.dart';
import 'package:customer_ui/components/size_config.dart';
import 'package:customer_ui/components/styles.dart';
import 'package:flutter/material.dart';

import 'history_order.dart';

class MyOrderTabBar extends StatefulWidget {
  @override
  _MyOrderTabBarState createState() => _MyOrderTabBarState();
}

class _MyOrderTabBarState extends State<MyOrderTabBar> with SingleTickerProviderStateMixin {
  late TabController controller;

  @override
  void initState() {
    // TODO: implement initState
    controller = TabController(length: 2, vsync: this);
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
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: kWhiteColor,
        centerTitle: true,
        title: Text(
          "My Order",
          style: TextStyle(color: kBlackColor, fontSize: block * 4),
        ),
        iconTheme: IconThemeData(color: kBlackColor),
      ),
      body: SizedBox(
        height: height,
        width: width,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
          child: Column(
            children: [
              SizedBox(
                height: 50,
                child: TabBar(
                  isScrollable: true,
                  indicatorColor: kPrimaryColor,
                  controller: controller,
                  tabs: [
                    Text(
                      "Ongoing",
                      style: TextStyle(color: kBlackColor),
                    ),
                    Text("History", style: TextStyle(color: kBlackColor)),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  controller: controller,
                  children: const [
                    OngoingOrder(),
                    HistoryOrder(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
