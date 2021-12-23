import 'package:flutter/material.dart';

class ColumnTest extends StatefulWidget {
  const ColumnTest({Key? key}) : super(key: key);

  @override
  _ColumnTestState createState() => _ColumnTestState();
}

class _ColumnTestState extends State<ColumnTest> {
  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: size.height,
          color: Colors.grey,
          width: size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text("This is title"),
              Expanded(child: Container(
                child: ListView(
                  children: [
                    Text("TEST"),
                    Text("TEST"),
                    Text("TEST"),
                    Text("TEST"),
                    Text("TEST"),
                    Text("TEST"),
                    Text("TEST"),
                    Text("TEST"),
                    Text("TEST"),
                    Text("TEST"),
                    Text("TEST"),
                    Text("TEST"),
                    Text("TEST"),
                    Text("TEST"),
                    Text("TEST"),
                    Text("TEST"),
                  ],
                ),
              )),
              Text("Hello"),

            ],
          ),
        ),
      ),
    );
  }
}
