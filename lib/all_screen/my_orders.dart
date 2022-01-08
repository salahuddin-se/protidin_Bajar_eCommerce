
import 'package:customer_ui/all_screen/tarck_order.dart';
import 'package:customer_ui/all_screen/wallet.dart';
import 'package:customer_ui/components/styles.dart';
import 'package:flutter/material.dart';

import 'myaccopunt.dart';
import 'request_product.dart';


//import 'Language.dart';

class MyOrder extends StatefulWidget {
  const MyOrder({Key? key}) : super(key: key);
  @override
  _MyOrderState createState() => _MyOrderState();
}

class _MyOrderState extends State<MyOrder> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: kWhiteColor,
          centerTitle: true,
          title: Text(
            "My Order",
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

        backgroundColor: Colors.white,
        body: SingleChildScrollView(

            child: Column(
                children: [

                  SizedBox(height: 35,),

                  /*Container(
                    //width: 330,
                    width: MediaQuery.of(context).size.width/1.1,
                    height: 115,

                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [

                            Padding(padding: const EdgeInsets.fromLTRB(0,0,0,0),),

                            Container(
                              //color: Colors.white,
                              height: 15,
                              width: 20,
                              child: Image.asset("assets/img_134.png",color: Colors.black,),
                            ),

                            Padding(padding: const EdgeInsets.fromLTRB(0,0,0,0),),

                            Center(
                              child: Container(
                                height: 22,
                                width: 150,
                                child: Text("My orders",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500,color: Colors.black),),
                              ),
                            ),

                            Container(
                              //color: Colors.white,
                              height: 15,
                              width: 20,
                              child: Image.asset("assets/img_77.png",color: Colors.black,),
                            ),

                          ],
                        ),


                      ],
                    ),
                  ),*/


                  Center(
                    child: Container(
                      height: 25,
                      //width: 230,
                      child: Text("My Orders",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600,color: Colors.black),),
                    ),
                  ),

                  SizedBox(height: 20,),

                  /*Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Center(
                        child: Container(
                          height: 22,
                          //width: 230,
                          child: Text("Ongoing",style: TextStyle(fontSize: 17,fontWeight: FontWeight.w500,color: Colors.black,decoration: TextDecoration.underline,decorationThickness: 5,decorationColor: Colors.purpleAccent[700]),),
                        ),
                      ),
                      Center(
                        child: Container(
                          height: 22,
                          //width: 230,
                          child: Text("History",style: TextStyle(fontSize: 17,fontWeight: FontWeight.w500,color: Colors.black,decoration: TextDecoration.underline,),),
                        ),
                      ),
                    ],
                  ),*/


                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      //height: 25,
                      //width: 230,
                      width: MediaQuery.of(context).size.width/1.2,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20,0,0,0),
                        child: Text("You have 1(one) delivery in-Progress.",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w600,color: Colors.grey),),
                      ),
                    ),
                  ),


                  SizedBox(height: 20,),


                  Container(
                    width: MediaQuery.of(context).size.width/1.2,
                    height: 290,
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(20),

                    ),

                    child: Column(
                      children: [

                        SizedBox(height: 20,),

                        Center(
                          child: Container(
                            width:MediaQuery.of(context).size.width/1.3,
                            child: FittedBox(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [

                                  Container(
                                    width: MediaQuery.of(context).size.width/3,
                                    child: Column(
                                      children: [
                                        Align(
                                          alignment:Alignment.centerLeft,
                                          child: Text(
                                            "Transaction ID",style: TextStyle(color: Colors.grey,fontSize: 14,fontWeight: FontWeight.w400,),
                                          ),
                                        ),
                                        SizedBox(height: 5,),
                                        Align(
                                          alignment:Alignment.centerLeft,
                                          child:Text(
                                            "00000000",style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.w900,),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),

                                  Container(
                                    width: MediaQuery.of(context).size.width/3,
                                    child: Column(
                                      children: [
                                        Align(
                                          alignment:Alignment.centerLeft,
                                          child: Text(
                                            "Amount",style: TextStyle(color: Colors.grey,fontSize: 14,fontWeight: FontWeight.w400,),
                                          ),
                                        ),
                                        SizedBox(height: 5,),
                                        Align(
                                          alignment:Alignment.centerLeft,
                                          child:Text(
                                            "৳1050",style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.w900,),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),


                                  Container(

                                    width: MediaQuery.of(context).size.width/3,
                                    child: Column(
                                      children: [
                                        Align(
                                          alignment:Alignment.centerLeft,
                                          child: Text(
                                            "Payment",style: TextStyle(color: Colors.grey,fontSize: 14,fontWeight: FontWeight.w400,),
                                          ),
                                        ),
                                        SizedBox(height: 5,),
                                        Align(
                                          alignment:Alignment.centerLeft,
                                          child:Text(
                                            "paid",style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.w900,),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),

                                ],
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: 15,),

                        Padding(
                          padding: const EdgeInsets.only(left: 15.0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              width: MediaQuery.of(context).size.width/2,
                              child: Column(
                                children: [
                                  Align(
                                    alignment:Alignment.centerLeft,
                                    child: Text(
                                      "Buyer",style: TextStyle(color: Colors.grey,fontSize: 14,fontWeight: FontWeight.w400,),
                                    ),
                                  ),
                                  SizedBox(height: 5,),
                                  Align(
                                    alignment:Alignment.centerLeft,
                                    child:Text(
                                      "Shafayat Hossain",style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.w900,),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),


                        SizedBox(height: 15,),

                        Padding(
                          padding: const EdgeInsets.only(left: 15.0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              width: MediaQuery.of(context).size.width/2,
                              child: Column(
                                children: [
                                  Align(
                                    alignment:Alignment.centerLeft,
                                    child: Text(
                                      "Address",style: TextStyle(color: Colors.grey,fontSize: 14,fontWeight: FontWeight.w400,),
                                    ),
                                  ),
                                  SizedBox(height: 5,),
                                  Align(
                                    alignment:Alignment.centerLeft,
                                    child:Text(
                                      "40,Topkhana Road,3rd floor,Dhaka-1000",style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.w900,),
                                    ),
                                  ),

                                ],
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: 20,),
                        Align(
                          alignment: Alignment.center,
                          child: InkWell(

                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => TrackOrder()));
                            },

                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.purpleAccent[700],
                                borderRadius: BorderRadius.circular(25),

                                boxShadow: [

                                  BoxShadow(
                                    color: Colors.white,
                                  ),

                                ],

                              ),
                              //color: Colors.green,
                              height: 50,
                              width: MediaQuery.of(context).size.width/1.7,
                              child: Padding(
                                padding: const EdgeInsets.all(0),
                                child: Center(
                                  child: Text("Track Order",style: TextStyle(
                                      color: Colors.white,fontSize: 16,fontWeight: FontWeight.w900
                                  ),),
                                ),
                              ),
                            ),
                          ),
                        ),

                      ],
                    ),
                  )



                ]
            )
        )
    );
  }

}




