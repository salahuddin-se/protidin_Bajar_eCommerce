import 'dart:convert';
import 'dart:developer';

import 'package:customer_ui/dataModel/city_model.dart';
import 'package:customer_ui/dataModel/product_response.dart';
import 'package:customer_ui/dataModel/seller_response.dart';
import 'package:customer_ui/dataModel/shop_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dropdown/flutter_dropdown.dart';
import 'package:http/http.dart';

class FinalHomeScreen extends StatefulWidget {
  const FinalHomeScreen({Key? key}) : super(key: key);

  @override
  _FinalHomeScreenState createState() => _FinalHomeScreenState();
}

class _FinalHomeScreenState extends State<FinalHomeScreen> {


  List<String> areaName=[];
  List<String> cityName=[];
  var _shops=[];
  var _sellers=[];
  var selectAreaName="";
  int _webStoreId = 0;
  int _userId = 0;
  int shopId = 0;
  var shopName="";

  //Show area/city dialog
  Future<void> getCityName()async{
    areaName.clear();
    cityName.clear();

    var response = await get(Uri.parse("https://test.protidin.com.bd/api/v2/cities"),
        headers: <String, String>{
          'Accept': 'application/json',

        });

    log(response.body);

    var dataMap=jsonDecode(response.body);

    var areaModel=CityModel.fromJson(dataMap);
    for(var element in areaModel.data){
      areaName.add(element.area);
      cityName.add(element.name);
    }
    // city name comment out
    buildShowDialog(context, areaName,cityName);
    setState(() {

    });
    log("area2 name $areaName");
    log("city2 name $cityName");


  }

  Future fetchShop(String areaName)async{
    var response = await get(Uri.parse("https://test.protidin.com.bd/api/v2/shops?page=1"));
    log("shops res: " + response.body);
    var shopResponse = shopResponseFromJson(response.body);
    _shops.addAll(shopResponse.shops!);

    fetchSellers(areaName);
  }

  Future fetchSellers(String areaName) async {
    //_areaName = areaName;
    _sellers.clear();
    var response = await get(Uri.parse("https://test.protidin.com.bd/api/v2/sellers?page=1&name=''"));
    log("sellers res: " + response.body);
    var sellerResponse = sellerResponseFromJson(response.body);
    _sellers.addAll(sellerResponse.sellers!);
    for (Seller seller in _sellers) {
      if (seller.area != '') {
        var areaJson = jsonDecode(seller.area!);
        List<String>? areaList = areaJson != null ? List.from(areaJson) : null;
        for (String area in areaList!) {
          if (areaName == area) {
            _webStoreId = seller.webStoreId!;
            _userId = seller.userId!;

            log("webstore ID $_webStoreId");
            log("user ID $_userId");
          }
        }
      }
    }

    fetchProducts();
  }

  Future fetchProducts() async {
    for (Shop shop in _shops) {
      if (shop.user_id == _userId) shopId = shop.id!;
    }
    log("shop ID $shopId");
    var response = await get(Uri.parse("https://test.protidin.com.bd/api/v2/shops/products/all/${shopId.toString()}"));
    log("products response ${response.body}");
    var productResponse = productMiniResponseFromJson(response.body);
    shopName=productResponse.products![0].shop_name!;

  }

  @override
  void initState() {
    // TODO: implement initState
    getCityName();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

    );
  }


  //Dialog Build
  Future<dynamic> buildShowDialog(BuildContext context, List<String> areaName,List<String> cityName) {
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    return showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            backgroundColor: Color(0xFFF4EFF5),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Container(
              height: 215,
              padding: EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Container(
                          width: MediaQuery.of(context).size.width / 6,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Text(
                              "City",
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Color(0xFF515151)),
                            ),
                          )),
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width / 1.8,
                          //width: 100,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Color(0xFFFFFFFF)),
                          child: Padding(
                            padding: const EdgeInsets.only(right: 10.0),
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: DropDown(
                                items:cityName,
                                hint: Text(
                                  "",
                                ),
                                icon: Padding(
                                  padding: const EdgeInsets.only(left: 100.0),
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Icon(
                                      Icons.expand_more,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                //onChanged: print,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Container(
                          width: MediaQuery.of(context).size.width / 6,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Text(
                              "Area",
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Color(0xFF515151)),
                            ),
                          )),
                      Container(
                        width: MediaQuery.of(context).size.width / 1.8,
                        height: 50,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Color(0xFFFFFFFF)),
                        child: Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: DropDown(
                              items: areaName,
                              hint: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                    color: Colors.teal,
                                    child: Text(
                                      " ",
                                    )),
                              ),
                              icon: Padding(
                                padding: const EdgeInsets.only(left: 70.0),
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Icon(
                                    Icons.expand_more,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              onChanged:(String? value){
                                setState(() {
                                  selectAreaName=value!;
                                });
                              },
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Container(
                          width: MediaQuery.of(context).size.width / 6,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Text(""),
                          )),
                      InkWell(
                        onTap: () {
                          fetchShop(selectAreaName);
                          log(selectAreaName);
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width / 1.8,
                          height: 50,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Color(0xFF9900FF)),
                          child: Center(
                              child: Text(
                                "Submit",
                                style: TextStyle(fontSize: 16, color: Colors.white),
                              )),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          );
        }
    );
  }

}
