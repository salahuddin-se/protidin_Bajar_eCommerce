import 'dart:convert';
import 'dart:developer';

import 'package:customer_ui/rufmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class ApiClass extends StatefulWidget {
  const ApiClass({Key? key}) : super(key: key);

  @override
  _ApiClassState createState() => _ApiClassState();
}

class _ApiClassState extends State<ApiClass> {
  @override
  void initState() {
    getAiResonse();
    // TODO: implement initState
  }

  var purchaseData = [];
  Future<dynamic> getAiResonse() async {
    ///final response6 = await get(Uri.parse(purchaseHistoryAPI + "/" + box.read(userID)), headers: {"Accept": "application/json"});
    final response6 = await get(Uri.parse("https://api.publicapis.org/entries"), headers: {"Accept": "application/json"});

    log("Histoty Resposne ${response6.body}");

    if (response6.statusCode == 200) {
      var dataMap = jsonDecode(response6.body);

      var data = TestApi.fromJson(dataMap);

      purchaseData = data.entries;

      log("test api calling : $purchaseData");

      // transactionID = purchaseData.data[0].shippingAddress.;
      setState(() {});
    } else {
      log("data invalid");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Container(
      child: ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          scrollDirection: Axis.vertical,
          itemCount: purchaseData.length,
          itemBuilder: (_, index) {
            return Container(
              child: Column(
                children: [Text(purchaseData[index].Description)],
              ),
            );
          }),
    )));
  }
}
