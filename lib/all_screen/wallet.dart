import 'package:flutter/material.dart';

//import 'Language.dart';

class MyWallet extends StatefulWidget {
  const MyWallet({Key? key}) : super(key: key);
  @override
  _MyWalletState createState() => _MyWalletState();
}

class _MyWalletState extends State<MyWallet> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Color(0xFF9900FF),
        body: SingleChildScrollView(

            child: Column(
                children: [

                  SizedBox(height: 35,),

                  Center(
                    child: Container(
                      height: 30,
                      //width: 230,
                      child: Text("Wallet",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: Colors.white),),
                    ),
                  ),

                  SizedBox(height: 20,),

                  Container(
                    width: MediaQuery.of(context).size.width/1.1,

                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          //height: 22,
                          width: MediaQuery.of(context).size.width/4,
                          child: Column(
                            children: [
                              Align(
                                  alignment:Alignment.centerLeft,
                                  child: Text("৳207",style: TextStyle(fontSize: 24,fontWeight: FontWeight.w800,color: Colors.white,),)),
                              Align(
                                  alignment:Alignment.centerLeft,
                                  child: Text("Balance",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500,color: Colors.white,),)),
                            ],
                          ),
                        ),
                        Container(
                          //color: Colors.white,
                          height: 25,
                          width: 25,
                          child: Image.asset(
                              "assets/img_155.png"),
                        ),
                      ],
                    ),
                  ),


                  Center(
                    child: Container(
                      width: MediaQuery.of(context).size.width/1.1,
                      child: FittedBox(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              //height: 22,
                              width: MediaQuery.of(context).size.width/3,
                              child: Column(
                                children: [
                                  Align(
                                      alignment:Alignment.centerLeft,
                                      child: Text("৳120",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w800,color: Colors.white,),)
                                  ),
                                  Align(
                                      alignment:Alignment.centerLeft,
                                      child: Text("Cashback",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: Colors.white,),)
                                  ),
                                  Align(
                                      alignment:Alignment.centerLeft,
                                      child: Text("Amount",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: Colors.white,),)
                                  ),
                                ],
                              ),
                            ),

                            Container(
                              //height: 22,
                              width: MediaQuery.of(context).size.width/3,
                              child: Column(
                                children: [
                                  Align(
                                      alignment:Alignment.centerLeft,
                                      child: Text("৳2300",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w800,color: Colors.white,),)
                                  ),
                                  Align(
                                      alignment:Alignment.centerLeft,
                                      child: Text("Reg. Bonus",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: Colors.white,),)
                                  ),
                                  Align(
                                      alignment:Alignment.centerLeft,
                                      child: Text("Amount",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: Colors.white,),)
                                  ),
                                ],
                              ),
                            ),

                            Container(
                              //height: 22,
                              width: MediaQuery.of(context).size.width/3,
                              child: Column(
                                children: [
                                  Align(
                                      alignment:Alignment.centerLeft,
                                      child: Text("৳230",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w800,color: Colors.white,),)
                                  ),
                                  Align(
                                      alignment:Alignment.centerLeft,
                                      child: Text("Referel Bonus",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: Colors.white,),)
                                  ),
                                  Align(
                                      alignment:Alignment.centerLeft,
                                      child: Text("Balance",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: Colors.white,),)
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),


                  ///



                  SizedBox(height: 20,),


                  Container(
                    width: MediaQuery.of(context).size.width/1,
                    height: MediaQuery.of(context).size.height*3/3.88,
                    //height: 290,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),

                    ),

                    child: Column(
                      children: [

                        SizedBox(height: 20,),

                        Container(
                          width:MediaQuery.of(context).size.width/1.1,
                          child: FittedBox(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [

                                Container(
                                  width:MediaQuery.of(context).size.width/3.7,
                                  child: Column(
                                    children: [
                                      Align(
                                        alignment:Alignment.centerLeft,
                                        child: Text(
                                          "Order no",style: TextStyle(color: Colors.grey,fontSize: 14,fontWeight: FontWeight.w400,),
                                        ),
                                      ),
                                      SizedBox(height: 5,),
                                      /*Align(
                                        alignment:Alignment.centerLeft,
                                        child:Text(
                                          "00000000",style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.w900,),
                                        ),
                                      )*/
                                    ],
                                  ),
                                ),

                                Container(
                                  width:MediaQuery.of(context).size.width/3.7,
                                  child: Column(
                                    children: [
                                      Align(
                                        alignment:Alignment.centerLeft,
                                        child: Text(
                                          "Adjustment",style: TextStyle(color: Colors.grey,fontSize: 14,fontWeight: FontWeight.w400,),
                                        ),
                                      ),
                                      SizedBox(height: 5,),
                                      /*Align(
                                        alignment:Alignment.centerLeft,
                                        child:Text(
                                          "৳1050",style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.w900,),
                                        ),
                                      )*/
                                    ],
                                  ),
                                ),


                                Container(
                                  width:MediaQuery.of(context).size.width/4,
                                  child: Column(
                                    children: [
                                      Align(
                                        alignment:Alignment.centerLeft,
                                        child: Text(
                                          "Bonus",style: TextStyle(color: Colors.grey,fontSize: 14,fontWeight: FontWeight.w400,),
                                        ),
                                      ),
                                      SizedBox(height: 5,),
                                      /*Align(
                                        alignment:Alignment.centerLeft,
                                        child:Text(
                                          "৳1050",style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.w900,),
                                        ),
                                      )*/
                                    ],
                                  ),
                                ),

                                Container(
                                  width:MediaQuery.of(context).size.width/4,
                                  child: Column(
                                    children: [
                                      Align(
                                        alignment:Alignment.centerLeft,
                                        child: Text(
                                          "Balance",style: TextStyle(color: Colors.grey,fontSize: 14,fontWeight: FontWeight.w400,),
                                        ),
                                      ),
                                      SizedBox(height: 5,),
                                      /*Align(
                                        alignment:Alignment.centerLeft,
                                        child:Text(
                                          "৳1050",style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.w900,),
                                        ),
                                      )*/
                                    ],
                                  ),
                                ),

                              ],
                            ),
                          ),
                        ),

                        SizedBox(height: 15,),

                        Container(
                          //height:MediaQuery.of(context).size.height*3/4,
                          width:MediaQuery.of(context).size.width/1.1,
                          child: FittedBox(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [

                                Container(
                                  width:MediaQuery.of(context).size.width/4,
                                  child: Column(
                                    children: [
                                      Align(
                                        alignment:Alignment.centerLeft,
                                        child: Text(
                                          "#POP1h000",style: TextStyle(color: Colors.grey,fontSize: 14,fontWeight: FontWeight.w400,),
                                        ),
                                      ),
                                      SizedBox(height: 5,),
                                      Align(
                                        alignment:Alignment.centerLeft,
                                        child:Text(
                                          "19sep,2021",style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.w900,),
                                        ),
                                      )
                                    ],
                                  ),
                                ),

                                Container(
                                  width:MediaQuery.of(context).size.width/4,
                                  child: Column(
                                    children: [

                                      SizedBox(height: 5,),
                                      Align(
                                        alignment:Alignment.centerLeft,
                                        child:Text(
                                          "-৳1050",style: TextStyle(color: Colors.red,fontSize: 14,fontWeight: FontWeight.w900,),
                                        ),
                                      )
                                    ],
                                  ),
                                ),


                                Container(
                                  width:MediaQuery.of(context).size.width/4,
                                  child: Column(
                                    children: [

                                      SizedBox(height: 5,),
                                      Align(
                                        alignment:Alignment.centerLeft,
                                        child:Text(
                                          "+৳5",style: TextStyle(color: Colors.green,fontSize: 14,fontWeight: FontWeight.w900,),
                                        ),
                                      )
                                    ],
                                  ),
                                ),

                                Container(
                                  width:MediaQuery.of(context).size.width/4,
                                  child: Column(
                                    children: [

                                      SizedBox(height: 5,),
                                      Align(
                                        alignment:Alignment.centerLeft,
                                        child:Text(
                                          "৳4000",style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.w900,),
                                        ),
                                      )
                                    ],
                                  ),
                                ),

                              ],
                            ),
                          ),
                        ),


                        SizedBox(height: 15,),

                        Container(
                          width:MediaQuery.of(context).size.width/1.1,
                          child: FittedBox(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [

                                Container(
                                  width:MediaQuery.of(context).size.width/4,
                                  child: Column(
                                    children: [
                                      Align(
                                        alignment:Alignment.centerLeft,
                                        child: Text(
                                          "#POP1h000",style: TextStyle(color: Colors.grey,fontSize: 14,fontWeight: FontWeight.w400,),
                                        ),
                                      ),
                                      SizedBox(height: 5,),
                                      Align(
                                        alignment:Alignment.centerLeft,
                                        child:Text(
                                          "19sep,2021",style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.w900,),
                                        ),
                                      )
                                    ],
                                  ),
                                ),

                                Container(
                                  width:MediaQuery.of(context).size.width/4,
                                  child: Column(
                                    children: [

                                      SizedBox(height: 5,),
                                      Align(
                                        alignment:Alignment.centerLeft,
                                        child:Text(
                                          "-৳1050",style: TextStyle(color: Colors.red,fontSize: 14,fontWeight: FontWeight.w900,),
                                        ),
                                      )
                                    ],
                                  ),
                                ),


                                Container(
                                  width:MediaQuery.of(context).size.width/4,
                                  child: Column(
                                    children: [

                                      SizedBox(height: 5,),
                                      Align(
                                        alignment:Alignment.centerLeft,
                                        /*child:Text(
                                          "+৳5",style: TextStyle(color: Colors.green,fontSize: 14,fontWeight: FontWeight.w900,),
                                        ),*/
                                      )
                                    ],
                                  ),
                                ),

                                Container(
                                  width:MediaQuery.of(context).size.width/4,
                                  child: Column(
                                    children: [

                                      SizedBox(height: 5,),
                                      Align(
                                        alignment:Alignment.centerLeft,
                                        child:Text(
                                          "৳4000",style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.w900,),
                                        ),
                                      )
                                    ],
                                  ),
                                ),

                              ],
                            ),
                          ),
                        ),

                        SizedBox(height: 15,),

                        Container(
                          width:MediaQuery.of(context).size.width/1.1,
                          child: FittedBox(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [

                                Container(
                                  width:MediaQuery.of(context).size.width/4,
                                  child: Column(
                                    children: [
                                      Align(
                                        alignment:Alignment.centerLeft,
                                        child: Text(
                                          "#POP1h000",style: TextStyle(color: Colors.grey,fontSize: 14,fontWeight: FontWeight.w400,),
                                        ),
                                      ),
                                      SizedBox(height: 5,),
                                      Align(
                                        alignment:Alignment.centerLeft,
                                        child:Text(
                                          "19sep,2021",style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.w900,),
                                        ),
                                      )
                                    ],
                                  ),
                                ),

                                Container(
                                  width:MediaQuery.of(context).size.width/4,
                                  child: Column(
                                    children: [

                                      SizedBox(height: 5,),
                                      Align(
                                        alignment:Alignment.centerLeft,
                                        child:Text(
                                          "-৳1050",style: TextStyle(color: Colors.red,fontSize: 14,fontWeight: FontWeight.w900,),
                                        ),
                                      )
                                    ],
                                  ),
                                ),


                                Container(
                                  width:MediaQuery.of(context).size.width/4,
                                  child: Column(
                                    children: [

                                      SizedBox(height: 5,),
                                      Align(
                                        alignment:Alignment.centerLeft,
                                        child:Text(
                                          "+৳5",style: TextStyle(color: Colors.green,fontSize: 14,fontWeight: FontWeight.w900,),
                                        ),
                                      )
                                    ],
                                  ),
                                ),

                                Container(
                                  width:MediaQuery.of(context).size.width/4,
                                  child: Column(
                                    children: [

                                      SizedBox(height: 5,),
                                      Align(
                                        alignment:Alignment.centerLeft,
                                        child:Text(
                                          "৳4000",style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.w900,),
                                        ),
                                      )
                                    ],
                                  ),
                                ),

                              ],
                            ),
                          ),
                        ),


                        SizedBox(height: 15,),

                        Container(
                          width:MediaQuery.of(context).size.width/1.1,
                          child: FittedBox(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [

                                Container(
                                  width:MediaQuery.of(context).size.width/4,
                                  child: Column(
                                    children: [
                                      Align(
                                        alignment:Alignment.centerLeft,
                                        child: Text(
                                          "Registration Bonus",style: TextStyle(color: Colors.grey,fontSize: 14,fontWeight: FontWeight.w400,),
                                        ),
                                      ),
                                      SizedBox(height: 5,),
                                      Align(
                                        alignment:Alignment.centerLeft,
                                        child:Text(
                                          "19sep,2021",style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.w900,),
                                        ),
                                      )
                                    ],
                                  ),
                                ),

                                Container(
                                  width:MediaQuery.of(context).size.width/4,
                                  child: Column(
                                    children: [

                                      SizedBox(height: 5,),
                                      Align(
                                        alignment:Alignment.centerLeft,
                                        child:Text(
                                          "",style: TextStyle(color: Colors.red,fontSize: 14,fontWeight: FontWeight.w900,),
                                        ),
                                      )
                                    ],
                                  ),
                                ),


                                Container(
                                  width:MediaQuery.of(context).size.width/4,
                                  child: Column(
                                    children: [

                                      SizedBox(height: 5,),
                                      Align(
                                        alignment:Alignment.centerLeft,
                                        child:Text(
                                          "+৳500",style: TextStyle(color: Colors.green,fontSize: 14,fontWeight: FontWeight.w900,),
                                        ),
                                      )
                                    ],
                                  ),
                                ),

                                Container(
                                  width:MediaQuery.of(context).size.width/4,
                                  child: Column(
                                    children: [

                                      SizedBox(height: 5,),
                                      Align(
                                        alignment:Alignment.centerLeft,
                                        child:Text(
                                          "৳4000",style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.w900,),
                                        ),
                                      )
                                    ],
                                  ),
                                ),

                              ],
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




