import 'package:customer_ui/components/styles.dart';
import 'package:flutter/material.dart';

//import 'Language.dart';

class ReqquestPage extends StatefulWidget {
  const ReqquestPage({Key? key}) : super(key: key);
  @override
  _ReqquestPageState createState() => _ReqquestPageState();
}

class _ReqquestPageState extends State<ReqquestPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: kWhiteColor,
          centerTitle: true,
          title: Text(
            "Request a product",
            style: TextStyle(color: kBlackColor, fontSize: 14),
          ),
          iconTheme: IconThemeData(color: kBlackColor),
          actions: const [
            Center(
              child: Icon(
                Icons.menu,
                color: kBlackColor,
              ),
            ),
            SizedBox(
              width: 10,
            )
          ],
        ),
        //backgroundColor: Colors.white,
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            child: Column(children: [
          SizedBox(
            height: 25,
          ),
          Center(
            child: Container(
              //color: Colors.white,
              height: 120,
              width: 120,
              child: Image.asset(
                "assets/img_141.png",
                color: Colors.black,
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Center(
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  width: 0.5,
                  color: Colors.black,
                ),

                //color: Color(0xFFE5E5E5),
                borderRadius: BorderRadius.circular(30),
              ),
              //color: Colors.white,
              height: 37,
              width: 150,
              child: Center(
                  child: Text(
                "Upload",
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 15),
              )),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Center(
            child: Container(
              height: 47,
              //width: 230,
              child: Text(
                "Upload one or more photos of\n"
                "your design product",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400, color: Colors.black),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                height: 35,
                //width: 230,
                child: Text(
                  "Name Of the Product",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400, color: Colors.black),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: TextFormField(
              autofocus: false,
              decoration: InputDecoration(
                fillColor: Colors.grey[100],
                filled: true,
                contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide(color: Colors.white)),
                focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide(color: Colors.white)),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide(color: Colors.white)),
                //hintText: "User name or email"
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                height: 35,
                //width: 230,
                child: Text(
                  "Brand",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400, color: Colors.black),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: TextFormField(
              autofocus: false,
              decoration: InputDecoration(
                fillColor: Colors.grey[100],
                filled: true,
                contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide(color: Colors.white)),
                focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide(color: Colors.white)),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide(color: Colors.white)),
                //hintText: "User name or email"
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                height: 47,
                //width: 230,
                child: Text("Others Information(e.g unit,weight,origin of country, measuement etc)",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400, color: Colors.black)),
              ),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: TextFormField(
              autofocus: false,
              decoration: InputDecoration(
                fillColor: Colors.grey[100],
                filled: true,
                contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide(color: Colors.white)),
                focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide(color: Colors.white)),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide(color: Colors.white)),
                //hintText: "User name or email"
              ),
            ),
          ),
          SizedBox(
            height: 25,
          ),
          Align(
            alignment: Alignment.center,
            child: InkWell(
              // onTap: () {
              //   Navigator.push(context, MaterialPageRoute(builder: (context) => MyAccountPage()));
              // },
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFF9900FF),
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white,
                    ),
                  ],
                ),
                //color: Colors.green,
                height: 35,
                width: 140,
                child: Padding(
                  padding: const EdgeInsets.all(0),
                  child: Center(
                    child: Text(
                      "Submit",
                      style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w900),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ])));
  }
}
