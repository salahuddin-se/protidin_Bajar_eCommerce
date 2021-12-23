
import 'package:customer_ui/OthersPage/requestProduct.dart';
import 'package:flutter/material.dart';

//import 'Language.dart';

class OrderDelivered extends StatefulWidget {
  const OrderDelivered({Key? key}) : super(key: key);
  @override
  _OrderDeliveredState createState() => _OrderDeliveredState();
}

class _OrderDeliveredState extends State<OrderDelivered> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.white,
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            child: Column(
                children: [

                  SizedBox(height: 60,),


                  Center(
                    child: Container(
                      height: 25,
                      //width: 230,
                      child: Text("Ordered Delivered",style: TextStyle(fontSize: 22,fontWeight: FontWeight.w600,color: Colors.black),),
                    ),
                  ),


                  SizedBox(height: 25,),


                  Center(
                    child: Container(
                      height: 40,
                      //width: 230,
                      child: Text("Your order is completed, please leave your\n"
                          "feedback for better service.",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w300,color: Colors.grey),textAlign: TextAlign.center,),
                    ),
                  ),

                  SizedBox(height: 30),

                  CircleAvatar(
                      radius: 90,
                      child: Image.asset("assets/img_139.png",)
                  ),

                  SizedBox(height: 30,),

                  Center(
                    child: Container(
                      height: 25,
                      //width: 230,
                      child: Text("Md. Redyan",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w700,color: Colors.black),),
                    ),
                  ),

                  SizedBox(height: 8,),

                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      width: MediaQuery.of(context).size.width/2,
                      child: Row(
                        children: [
                          Container(
                            height: 15,
                            width: 20,
                            child: Image.asset("assets/img_140.png"),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20),
                          ),
                          Container(
                            height: 15,
                            width: 20,
                            child: Image.asset("assets/img_140.png"),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20),
                          ),
                          Container(
                            height: 15,
                            width: 20,
                            child: Image.asset("assets/img_140.png"),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20),
                          ),
                          Container(
                            height: 15,
                            width: 20,
                            child: Image.asset("assets/img_140.png"),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20),
                          ),
                          Container(
                            height: 15,
                            width: 20,
                            child: Image.asset("assets/img_140.png"),
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 30,
                  ),

                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(10),

                      boxShadow: [

                        BoxShadow(
                          color: Colors.white,
                        ),

                      ],

                    ),
                    height: 150,
                    width: MediaQuery.of(context).size.width/1.2,

                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Text("Leave your feedback here",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w700,color: Colors.grey),),
                    ),
                  ),


                  SizedBox(height: 20,),

                  Align(
                    alignment: Alignment.center,
                    child: InkWell(
                      /*onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => ReqquestPage()));
                      },*/
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
                        height: 50,
                        width: MediaQuery.of(context).size.width/1.2,
                        child: Padding(
                          padding: const EdgeInsets.all(0),
                          child: Center(
                            child: Text("Submit",style: TextStyle(
                                color: Colors.white,fontSize: 16,fontWeight: FontWeight.w900
                            ),),
                          ),
                        ),
                      ),
                    ),
                  ),


                  SizedBox(height: 20,),

                  Align(
                    alignment: Alignment.center,
                    child: InkWell(
                      /*onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => TrackOrder()));
                      },*/
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color(0xFFA299A8),
                          borderRadius: BorderRadius.circular(25),

                          boxShadow: [
                            BoxShadow(
                              color: Colors.white,
                            ),
                          ],
                        ),
                        //color: Colors.green,
                        height: 50,
                        width: MediaQuery.of(context).size.width/1.2,
                        child: Padding(
                          padding: const EdgeInsets.all(0),
                          child: Center(
                            child: Text("Skip",style: TextStyle(
                                color: Colors.white,fontSize: 16,fontWeight: FontWeight.w900
                            ),),
                          ),
                        ),
                      ),
                    ),
                  ),


                ]
            )
        )
    );
  }

}




