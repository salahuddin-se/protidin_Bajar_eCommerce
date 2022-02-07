import 'package:customer_ui/dataModel/category_data_model.dart';
import 'package:flutter/material.dart';

class CategoryProducts extends StatefulWidget {
  const CategoryProducts({Key? key, required this.data}) : super(key: key);
  final Data data;

  @override
  _CategoryProductsState createState() => _CategoryProductsState();
}

class _CategoryProductsState extends State<CategoryProducts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.data.name,
        ),
      ),
      body: Column(
        children: [Text(widget.data.name)],
      ),
    );
  }
}
