import 'dart:convert';
import 'dart:developer';

import 'package:customer_ui/dataModel/category_data_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class CategoryHomePageMain extends StatefulWidget {
  const CategoryHomePageMain({Key? key}) : super(key: key);

  @override
  _CategoryHomePageMainState createState() => _CategoryHomePageMainState();
}

class _CategoryHomePageMainState extends State<CategoryHomePageMain> {


  var categoryData=[];
  var subCategoryData=[];

  Future<void> getMainCategory()async{
    log("comes");
    String productURl = "https://test.protidin.com.bd/api/v2/categories/home";

    final response = await get(Uri.parse(productURl), headers: {"Accept": "application/json"});

    var dataMap=jsonDecode(response.body);
    if(dataMap["success"]==true){
      log("data valid");

      var categoryDataModel=CategoryDataModel.fromJson(dataMap);
      categoryData=categoryDataModel.data;
      await getBreadSubCategory(categoryDataModel.data[0].links.subCategories);
      setState(() {

      });
      log("data length ${categoryData.length}");

    }else{
      log("data invalid");
    }

  }

  //Call sub category API
  Future<void> getBreadSubCategory(link)async{

    final response = await get(Uri.parse(link), headers: {"Accept": "application/json"});

    var dataMap=jsonDecode(response.body);
    if(dataMap["success"]==true){

      var categoryDataModel=CategoryDataModel.fromJson(dataMap);
      subCategoryData=categoryDataModel.data;
      /*setState(() {

      });*/
      log("sub category data length ${subCategoryData.length}");

    }else{
      log("data invalid");
    }

  }

  @override
  void initState() {
    // TODO: implement initState
    getMainCategory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        title: Text("HOME PAGE",style: TextStyle(color: Colors.black),),
      ),
      body: Column(
        children: [
          Container(
            height: 300,
            width: double.infinity,
            child: ListView.builder(
              itemCount: categoryData.length,
              itemBuilder: (_,index){
                return Column(
                  children: [
                    Text(categoryData[index].name),
                    Container(
                      height: 100,
                      width: double.infinity,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: subCategoryData.length,
                        itemBuilder: (_,index2){
                          return Text(subCategoryData[index2].name);
                        },
                      ),
                    )
                  ],
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
