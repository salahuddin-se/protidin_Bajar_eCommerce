import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appTitle = 'Flutter Basic Alert Demo';
    return MaterialApp(
      title: appTitle,
      home: Scaffold(
        appBar: AppBar(
          title: Text(appTitle),
        ),
        body: MyAlert(),
      ),
    );
  }
}

class MyAlert extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: RaisedButton(
        child: Text('Show alert'),
        onPressed: () {
          showAlertDialog(context);
        },
      ),
    );
  }
}

showAlertDialog(BuildContext context) {
  // Create button
  Widget okButton = FlatButton(
    child: Text("OK"),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );

  // Create AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Simple Alert"),
    content: Container(
      height: 150,
      child: Column(
        children: [
          Row(
            children: [
              Text("city"),
              Container(
                height: 20,
                width: 100,
                color: Colors.grey,
                child: Container(
                    height:25,
                    child: Image.asset("assets/d2.png")),
              )
            ],
          ),
          SizedBox(height: 20,),
          Row(
            children: [
              Text("area"),
              Container(
                height: 20,
                width: 100,
                color: Colors.grey,
                child: Container(
                    height:25,
                    child: Image.asset("assets/d2.png")),
              )
            ],
          ),
        ],
      ),
    ),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}