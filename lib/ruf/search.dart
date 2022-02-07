import 'dart:convert';

import 'package:customer_ui/all_screen/product_details.dart';
import 'package:customer_ui/components/styles.dart';
import 'package:customer_ui/dataModel/breat_biscuit.dart';
import 'package:customer_ui/dataModel/category_data_model.dart';
import 'package:customer_ui/ruf/details.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
//Step 3
  _SearchScreenState() {
    _filter.addListener(() {
      if (_filter.text.isEmpty) {
        setState(() {
          _searchText = "";
          filteredNames = [];
        });
      } else {
        setState(() {
          _searchText = _filter.text;
        });
      }
    });
  }

//Step 1
  final TextEditingController _filter = TextEditingController();
  final dio = Dio(); // for http requests
  String _searchText = "";
  // List<ProductsData> names = []; // names we get from API
  List<ProductsData> filteredNames = [];
  List<Data> filteredCategories = []; // names filtered by search text
  Icon _searchIcon = Icon(Icons.search);
  Widget _appBarTitle = Text('Search Example');

  //step 2.1
  void _getNames() async {
    final response12 =
        await get(Uri.parse("https://test.protidin.com.bd/api/v2/products/category/4"), headers: {"Accept": "application/json"});

    final catResponse = await get(Uri.parse("https://test.protidin.com.bd/api/v2/categories"), headers: {"Accept": "application/json"});

    List<ProductsData> tempList = [];
    List<Data> cateList = [];

    var searchDataMap = jsonDecode(response12.body);
    if (searchDataMap["success"] == true) {
      setState(() {
        var searchProduct = BreadBiscuit.fromJson(searchDataMap);
        // names = tempList;
        for (int i = 0; i < searchProduct.data.length; i++) {
          tempList.add(searchProduct.data[i]);
        }
        filteredNames = tempList;
        //_filter.clear();
      });
    }

    var searchCategoryMap = jsonDecode(catResponse.body);
    if (searchCategoryMap["success"] == true) {
      setState(() {
        var searchCategory = CategoryDataModel.fromJson(searchCategoryMap);
        cateList.addAll(searchCategory.data);
        // for (int i = 0; i < searchCategory.data.length; i++) {
        //   cateList.add(searchCategory.data);
        // }
        filteredCategories = cateList;
        //_filter.clear();
      });
    }
  }

  //Step 4
  Widget _buildList() {
    if (!(_searchText.isEmpty)) {
      List<ProductsData> tempList = [];
      for (int i = 0; i < filteredNames.length; i++) {
        if (filteredNames[i].name!.toLowerCase().contains(_searchText.toLowerCase())) {
          tempList.add(filteredNames[i]);
        }
      }
      filteredNames = tempList;
    }
    return ListView.builder(
      itemCount: filteredNames.length,
      itemBuilder: (_, int index) {
        return ListTile(
          title: Text(filteredNames[index].name.toString()),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => GroceryDetails(
                  detailsLink: filteredNames[index].links!.details!,
                  relatedProductLink: "",
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget getCatList() {
    if (!(_searchText.isEmpty)) {
      List<Data> tempList = [];
      for (int i = 0; i < filteredCategories.length; i++) {
        if (filteredCategories[i].name!.toLowerCase().contains(_searchText.toLowerCase())) {
          tempList.add(filteredCategories[i]);
        }
      }
      filteredCategories = tempList;
    }
    return ListView.builder(
      itemCount: filteredCategories.length,
      itemBuilder: (_, int index) {
        return ListTile(
          title: Text(filteredCategories[index].name.toString()),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => CategoryProducts(data: filteredCategories[index])));
          },
        );
      },
    );
  }

  @override
  void initState() {
    ///_getNames();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        // appBar: AppBar(
        //   backgroundColor: kWhiteColor,
        //   centerTitle: true,
        //   title: _appBarTitle,
        //   leading: IconButton(
        //     icon: _searchIcon,
        //     onPressed: _searchPressed,
        //   ),
        // ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  color: Colors.white,
                  child: TextField(
                    controller: _filter,
                    decoration: InputDecoration(
                        hintText: '',
                        contentPadding: const EdgeInsets.all(15),
                        prefixIcon: Icon(
                          Icons.search,
                          color: kBlackColor,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        )),
                    onChanged: (value) {
                      // do something
                      _getNames();
                      //_searchPressed();
                    },
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  "Categories",
                  style: TextStyle(fontSize: 18.0, color: kBlackColor, fontWeight: FontWeight.w500),
                ),
                Container(height: filteredCategories.length >= 5 ? 400 : 100, child: getCatList()),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Products for you",
                  style: TextStyle(fontSize: 18.0, color: kBlackColor, fontWeight: FontWeight.w500),
                ),
                Container(
                  height: filteredNames.length >= 5 ? 400 : 100,
                  child: _buildList(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
