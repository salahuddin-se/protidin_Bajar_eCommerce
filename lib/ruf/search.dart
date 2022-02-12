import 'dart:convert';

import 'package:customer_ui/all_screen/category_wise_separate.dart';
import 'package:customer_ui/all_screen/product_details.dart';
import 'package:customer_ui/components/styles.dart';
import 'package:customer_ui/dataModel/breat_biscuit.dart';
import 'package:customer_ui/dataModel/category_data_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
//Step 3
  late ScrollController _scrollController;

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
  List<Data> filteredCategories = []; // names filtered by search text
  String large_banner = "";
  int _pageSize = 10;
  List<ProductsData> filteredNames = [];
  final PagingController<int, ProductsData> _pagingController = PagingController(firstPageKey: 1);

  //step 2.1
  Future<List<ProductsData>> _getNames({int page = 1}) async {
    final response12 =
        await get(Uri.parse("http://test.protidin.com.bd:88/api/v2/products/search?page=$page"), headers: {"Accept": "application/json"});

    final catResponse = await get(Uri.parse("http://test.protidin.com.bd:88/api/v2/categories"), headers: {"Accept": "application/json"});

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

        filteredCategories = cateList;
        //_filter.clear();
      });
    }
    return tempList;
  }

  //Step 4
  Widget _buildList() {
    return PagedListView<int, ProductsData>(
      pagingController: _pagingController,
      builderDelegate: PagedChildBuilderDelegate<ProductsData>(
        firstPageErrorIndicatorBuilder: (ctx) => Container(),
        newPageErrorIndicatorBuilder: (ctx) => Container(),
        noItemsFoundIndicatorBuilder: (ctx) => Center(
          child: Text('No item'),
        ),
        noMoreItemsIndicatorBuilder: (ctx) => Center(
          child: Text('No more item'),
        ),
        itemBuilder: (context, item, index) {
          if (item.name!.toLowerCase().contains(_searchText.toLowerCase())) {
            return ListTile(
              title: Text(item.name.toString()),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProductDetails(
                      detailsLink: item.links!.details!,
                      relatedProductLink: "",
                    ),
                  ),
                );
              },
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }

  Widget getCatList() {
    if (!(_searchText.isEmpty)) {
      List<Data> tempList = [];
      for (int i = 0; i < filteredCategories.length; i++) {
        if (filteredCategories[i].name.toLowerCase().contains(_searchText.toLowerCase())) {
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
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => GroceryOfferPage(
                  //categoryLink: categoryItemData,
                  receiveCategoryName: filteredCategories[index].name.toString(),
                  receiveLargeBanner: filteredCategories[index].largeBanner,
                  categoryData: filteredCategories,
                ),
              ),
            );
          },
        );
      },
    );
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final newItems = await _getNames(page: pageKey);

      final nextPageKey = pageKey + newItems.length;
      _pagingController.appendPage(newItems, nextPageKey);
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  void initState() {
    _getNames();
    super.initState();
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[100],
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
                // Text(
                //   "Categories",
                //   style: TextStyle(fontSize: 18.0, color: kBlackColor, fontWeight: FontWeight.w500),
                // )
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
                  //height: filteredNames.length >= 5 ? 400 : 300,
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
