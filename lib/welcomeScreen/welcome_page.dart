import 'dart:async';

import 'package:flutter/material.dart';

import 'onboarding_1.dart';
//import 'Language.dart';

class WelcomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<WelcomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFECEEF6),
      //backgroundColor: Colors.indigo[50],
      body: SingleChildScrollView(
        child: Column(
          children: [

            SizedBox(height: 50,),


            Center(
              child: Container(
                height: 120,
                width:MediaQuery.of(context).size.width/2,
                child: Image.asset("assets/img.png"),
              ),
            ),

            Center(
              child: Container(
                height: 70,
                width:MediaQuery.of(context).size.width/2,
                child: Image.asset("assets/img_1.png"),
              ),
            ),



            Center(
              child: Container(
                height: 120,
                width:MediaQuery.of(context).size.width/2,
                child: Image.asset("assets/img_2.png"),
              ),
            ),


            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Container(
                  height: 270,
                  width:MediaQuery.of(context).size.width/1.4,
                  child: Image.asset("assets/img_3.png"),
                ),
              ),
            ),

            SizedBox(height: 25,),

            Container(
              width:MediaQuery.of(context).size.width/1.2,
              height: 50,
              decoration: BoxDecoration(
                border: Border.all(
                  width: 0.150,
                  color:  Colors.cyan,
                ),

                color: Color(0xFF9900FF),
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey
                        .withOpacity(0.1),
                    spreadRadius: 5, //spread radius
                    blurRadius: 5, // blur radius
                    offset: Offset(
                        0, 2),
                  ),
                ],
              ),

              child:InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => OnBoardingPage()));
                },
                child: Container(
                  child: Center(
                    child: Text(
                      "Get Started",style: TextStyle(color: Colors.white),
                    ),
                  ),
                  width: 160,
                ),
              ),
            ),

          ],
        ),
      ),

    );
  }



}




