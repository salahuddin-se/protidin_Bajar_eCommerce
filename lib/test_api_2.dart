import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

import 'api_model2.dart';

class Api extends StatefulWidget {
  const Api({Key? key}) : super(key: key);

  @override
  _ApiState createState() => _ApiState();
}

class _ApiState extends State<Api> {
  @override
  void initState() {
    getApi();
    // TODO: implement initState
  }

  dynamic timeData = [];
  dynamic disclamer = [];
  dynamic bPI = [];
  Future<dynamic> getApi() async {
    final res = await get(Uri.parse("https://api.coindesk.com/v1/bpi/currentprice.json"), headers: {"Accept": "application/json"});

    ///log("get resposne ${res.body}");

    if (res.statusCode == 200) {
      var dataMap = jsonDecode(res.body);

      var data = AutoGenerate.fromJson(dataMap);

      timeData = data.time.updatedISO;
      disclamer = data.disclaimer;

      //bPI = data.bpi.USD.code;

      //log("test api calling : $timeData");
      //log("test api calling : $disclamer");
      ///log("test api calling : $bPI".toString());

      // transactionID = purchaseData.data[0].shippingAddress.;
      setState(() {});
    } else {
      log("data invalid");
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Center(
      child: Container(
          child: Column(
        children: [
          SizedBox(
            height: 50,
          ),
          Text("$timeData".toString()),
          SizedBox(
            height: 20,
          ),
          Text("$disclamer".toString()),
        ],
      )),
    )));
  }
}

/*
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

import 'api_model2.dart';

class Api extends StatefulWidget {
  const Api({Key? key}) : super(key: key);

  @override
  _ApiState createState() => _ApiState();
}

class _ApiState extends State<Api> {
  @override
  void initState() {
    getApi();
    // TODO: implement initState
  }

  dynamic timeData = [];
  Future<dynamic> getApi() async {
    final res = await get(Uri.parse("https://api.coindesk.com/v1/bpi/currentprice.json"), headers: {"Accept": "application/json"});

    log("get resposne ${res.body}");

    if (res.statusCode == 200) {
      var dataMap = jsonDecode(res.body);

      var data = AutoGenerate.fromJson(dataMap);

      timeData = data.time.updatedISO;

      log("test api calling : $timeData");

      // transactionID = purchaseData.data[0].shippingAddress.;
      setState(() {});
    } else {
      log("data invalid");
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Container(
                child: Column(
      children: [
        SizedBox(
          height: 50,
        ),
        Text("$timeData".toString()),
      ],
    ))));
  }
}

 */
