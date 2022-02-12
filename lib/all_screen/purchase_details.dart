import 'dart:convert';
import 'dart:developer';

import 'package:customer_ui/components/utils.dart';
import 'package:customer_ui/dataModel/purchase_details.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class Details extends StatefulWidget {
  var link = "";

  Details({Key? key, required this.link}) : super(key: key);

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  @override
  void initState() {
    getPurchaseHistoryDetails();
    // TODO: implement initState
    log("link ${widget.link}");
  }

  /*
Future<void> getrelatedData() async {
    final response2 = await get(Uri.parse(widget.relatedProductLink), headers: {"Accept": "application/json"});

    var dataMap2 = jsonDecode(response2.body);

    if (dataMap2["success"] == true) {
      log("data $dataMap2");

      //var productsDataMap2=BreadBiscuit.fromJson(dataMap2);
      var productsDataMap2 = BreadBiscuit.fromJson(dataMap2);
      relatedData = productsDataMap2.data;
      setState(() {});
    } else {
      log("data invalid");
    }
  }
 */

  List<Data> purchaseDetails = [];
  Future<void> getPurchaseHistoryDetails() async {
    log("calling 2");

    final response6 =
        await get(Uri.parse(widget.link), headers: {"Accept": "application/json", 'Authorization': 'Bearer ${box.read(userToken)}'});

    log("Histoty Resposne ${response6.body}");

    if (response6.statusCode == 200) {
      var dataMap = jsonDecode(response6.body);
      var purchaseData = PurchaseDetails.fromJson(dataMap);
      purchaseDetails = purchaseData.data;

      ///log("last data ${purchaseData.last.code}");

      setState(() {});
    } else {
      log("data invalid");
    }
    // log("after decode $dataMap");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        ///appBar: AppBar(),
        body: SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 35,
          ),
          Container(
            height: 300,
            child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: purchaseDetails.length,
                itemBuilder: (_, index) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Container(
                      decoration: BoxDecoration(color: Color(0xFFF1EDF2), borderRadius: BorderRadius.circular(15.0)),
                      width: MediaQuery.of(context).size.width / 2.34,
                      child: Column(
                        children: [
                          Text(purchaseDetails[index].product),
                          Text(purchaseDetails[index].tax.toString()),
                        ],
                      ),
                    ),
                  );
                }),
          ),
        ],
      ),
    ));
  }
}
