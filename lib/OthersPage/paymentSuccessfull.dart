//import 'package:customer_ui/paymentMethod&_address/Payment_Screen.dart';
import 'package:flutter/material.dart';

import 'Payment_Screen.dart';

//import 'Language.dart';

class Payment_Successful extends StatefulWidget {
  const Payment_Successful({Key? key}) : super(key: key);

  @override
  _Payment_SuccessfulState createState() => _Payment_SuccessfulState();
}

class _Payment_SuccessfulState extends State<Payment_Successful> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      //backgroundColor: Colors.indigo[50],
      body: SingleChildScrollView(
        child: Column(
          children: [

            SizedBox(height: 50),


            Container(
              width: MediaQuery.of(context).size.width/2,
              height: MediaQuery.of(context).size.height/2,
              child: Image.asset("assets/img_170.png"),
            ),



            Container(
              child: Center(
                child: Text(
                  "Payment Successful",style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.w800),
                ),
              ),
            ),

            SizedBox(height: 25,),

            Container(
              child: Center(
                child: Text(
                  "Your payment is Successful, your order\nwill arrive to your house soon",style: TextStyle(color: Colors.grey[400],fontSize: 14,fontWeight: FontWeight.w800,),textAlign:TextAlign.center,
                ),
              ),
            ),

            SizedBox(height: 60,),

            Container(
              width: MediaQuery.of(context).size.width/1.2,
              height: 50,
              decoration: BoxDecoration(
                border: Border.all(
                  width: 0.150,
                  //color:  Colors.cyan,
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
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Payment_Screen()));
                },
                child: Container(
                  child: Center(
                    child: Text(
                      "Next",style: TextStyle(color: Colors.white),
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




