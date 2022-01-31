/*import 'dart:convert';

import 'package:customer_ui/dataModel/breat_biscuit.dart';
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
          filteredNames = names;
        });
      } else {
        setState(() {
          _searchText = _filter.text;
        });
      }
    });
  }

//Step 1
  final TextEditingController _filter = new TextEditingController();
  final dio = new Dio(); // for http requests
  String _searchText = "";
  List names = []; // names we get from API
  List filteredNames = []; // names filtered by search text
  Icon _searchIcon = Icon(Icons.search);
  Widget _appBarTitle = Text('Search Example');

  //step 2.1
  void _getNames() async {
    final response12 =
    await get(Uri.parse("https://test.protidin.com.bd/api/v2/products/category/4"), headers: {"Accept": "application/json"});
    //print("res :: ${response}");
    var searchDataMap = jsonDecode(response12.body);
    if (searchDataMap["success"] == true) {}
    List tempList = [];

    setState(() {
      var searchProduct = BreadBiscuit.fromJson(searchDataMap);
      names = tempList;
      filteredNames = names;
      for (int i = 0; i < searchProduct.data.length; i++) {
        tempList.add(searchProduct.data[i]);
      }
    });
  }

//Step 2.2
  void _searchPressed() {
    setState(() {
      if (this._searchIcon.icon == Icons.search) {
        this._searchIcon = Icon(Icons.close);
        this._appBarTitle = TextField(
          controller: _filter,
          decoration: InputDecoration(prefixIcon: Icon(Icons.search), hintText: 'Search...'),
        );
        _filter.clear();
      } else {
        this._searchIcon = Icon(Icons.search);
        this._appBarTitle = Text('Search Example');
        filteredNames = names;
        _filter.clear();
      }
    });
    return _getNames();
  }

  //Step 4
  Widget _buildList() {
    if (!(_searchText.isEmpty)) {
      List tempList = [];
      for (int i = 0; i < filteredNames.length; i++) {
        if (filteredNames[i].name.toLowerCase().contains(_searchText.toLowerCase())) {
          tempList.add(filteredNames[i]);
        }
      }
      filteredNames = tempList;
    }

    ///oneTwoNinentyNineData[index].discount.toString()
    return ListView.builder(
      itemCount: names == null ? 0 : filteredNames.length,
      itemBuilder: (_, int index) {
        return ListTile(
          title: Text(filteredNames[index].name.toString()),
          onTap: () => print(filteredNames[index].name),
        );
      },
    );
  }

  //STep6
  Widget _buildBar(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: _appBarTitle,
      leading: IconButton(
        icon: _searchIcon,
        onPressed: _searchPressed,
      ),
    );
  }

  @override
  void initState() {
    ///_getNames();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: _appBarTitle,
        leading: IconButton(
          icon: _searchIcon,
          onPressed: _searchPressed,
        ),
      ),
      body: Container(
        child: _buildList(),
      ),
      //resizeToAvoidBottomPadding: false,
//      floatingActionButton: FloatingActionButton(
//        onPressed: _postName,
//        child: Icon(Icons.add),
//      ),
    );
  }
}


 */
