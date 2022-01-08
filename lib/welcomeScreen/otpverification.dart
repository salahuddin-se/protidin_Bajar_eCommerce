
import 'package:flutter/material.dart';

import '../homepage.dart';
//import 'Language.dart';


class OTPPage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<OTPPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      //backgroundColor: Colors.indigo[50],
      body: SingleChildScrollView(
        child: Column(
          children: [

            SizedBox(height: 130,),

            Center(

              child: Container(
                child: Text("OTP verification Page"),
              ),
            ),


            SizedBox(height: 200,),

            Container(
              width: 340,
              height: 50,
              decoration: BoxDecoration(
                border: Border.all(
                  width: 0.150,
                  color:  Colors.cyan,
                ),

                color: Colors.deepPurpleAccent,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [

                  BoxShadow(
                    color: Colors.grey
                        .withOpacity(0.1),
                    spreadRadius: 5, //spread radius
                    blurRadius: 5, // blur radius
                    offset: Offset(0, 2),
                  ),



                ],
              ),

              child:InkWell(
                /*onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => CategoryHomeScreen()));
                },*/
                child: Container(
                  child: Center(
                    child: Text(
                      "Continue",style: TextStyle(color: Colors.white),
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




