import 'package:customer_ui/components/styles.dart';
import 'package:flutter/material.dart';

import 'order_delivered.dart';

//import 'Language.dart';

class TrackOrder extends StatefulWidget {
  const TrackOrder({Key? key}) : super(key: key);
  @override
  _TrackOrderState createState() => _TrackOrderState();
}

class _TrackOrderState extends State<TrackOrder> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: kWhiteColor,
          centerTitle: true,
          title: Text(
            "Track order",
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
            child: Column(
                children: [

                  SizedBox(height: 20,),




                  Center(
                    child: Container(
                      height: 30,
                      //width: 230,
                      child: Text("ID : PO35J901",style: TextStyle(fontSize: 22,fontWeight: FontWeight.w700,color: Colors.black),),
                    ),
                  ),


                  SizedBox(height: 20,),

                  Container(

                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(20),

                    ),

                    height: 200,
                    width: MediaQuery.of(context).size.width/1.2,
                    child: Column(
                      children: [

                        SizedBox(height: 20,),

                        FittedBox(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                //color: Colors.white,
                                height: 70,
                                width: MediaQuery.of(context).size.width/3,
                                child: Image.asset("assets/img_135.png",),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width/1.7,
                                child: Column(
                                  children: [
                                    Align(
                                      alignment:Alignment.centerLeft,
                                      child: Text(
                                        "Your order will be delivered by ",style: TextStyle(color: Colors.grey,fontSize: 14,fontWeight: FontWeight.w400,),
                                      ),
                                    ),
                                    SizedBox(height: 5,),
                                    Align(
                                      alignment:Alignment.centerLeft,
                                      child:Text(
                                        "Md. Abcdef ghijkl",style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.w900,),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: 20,),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [

                            Align(
                              alignment: Alignment.center,
                              child: InkWell(

                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => TrackOrder()));
                                },

                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(30),

                                    boxShadow: [

                                      BoxShadow(
                                        color: Colors.white,
                                      ),

                                    ],

                                  ),
                                  //color: Colors.green,
                                  height: 45,
                                  width: MediaQuery.of(context).size.width/3,
                                  child: Padding(
                                    padding: const EdgeInsets.all(0),
                                    child: Center(
                                      child: Text("Call",style: TextStyle(
                                          color: Colors.white,fontSize: 16,fontWeight: FontWeight.w900
                                      ),),
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            Align(
                              alignment: Alignment.center,
                              child: InkWell(

                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => TrackOrder()));
                                },

                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.purpleAccent[700],
                                    borderRadius: BorderRadius.circular(30),

                                    boxShadow: [

                                      BoxShadow(
                                        color: Colors.white,
                                      ),

                                    ],

                                  ),
                                  //color: Colors.green,
                                  height: 45,
                                  width: MediaQuery.of(context).size.width/3,
                                  child: Padding(
                                    padding: const EdgeInsets.all(0),
                                    child: Center(
                                      child: Text("Message",style: TextStyle(
                                          color: Colors.white,fontSize: 16,fontWeight: FontWeight.w900
                                      ),),
                                    ),
                                  ),
                                ),
                              ),
                            ),


                          ],
                        ),

                      ],
                    ),
                  ),





                  Container(
                    width: MediaQuery.of(context).size.width/1,
                    height: 565,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.15),
                          spreadRadius: 5, //spread radius
                          blurRadius: 5, // blur radius
                          offset: Offset(
                              0, 3),
                        ),
                      ],
                    ),

                    child: Column(
                      children: [

                        SizedBox(height: 20,),

                        Center(
                          child: Container(
                            width:MediaQuery.of(context).size.width/1.4,
                            child: Row(
                              children: [

                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  height: 55,
                                  width: 60,
                                ),

                                Padding(padding: const EdgeInsets.fromLTRB(20,0,20,0),),

                                Container(
                                  width: 120,
                                  child: Column(
                                    children: [
                                      Align(
                                        alignment:Alignment.centerLeft,
                                        child: Text(
                                          "Order confirmed",style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.w700,),
                                        ),
                                      ),
                                      SizedBox(height: 5,),
                                      Align(
                                        alignment:Alignment.centerLeft,
                                        child:Text(
                                          "1:45 P.M",style: TextStyle(color: Colors.grey,fontSize: 14,fontWeight: FontWeight.w900,),
                                        ),
                                      )
                                    ],
                                  ),
                                ),

                              ],
                            ),
                          ),
                        ),

                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 80),
                            child: Container(
                              //color: Colors.white,
                              height: 40,
                              width: 20,
                              child: Image.asset("assets/img_136.png",),
                            ),
                          ),
                        ),

                        Center(
                          child: Container(
                            width:MediaQuery.of(context).size.width/1.4,
                            child: Row(
                              children: [

                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  height: 55,
                                  width: 60,
                                ),

                                Padding(padding: const EdgeInsets.fromLTRB(20,0,20,0),),

                                Container(
                                  width: 120,
                                  child: Column(
                                    children: [
                                      Align(
                                        alignment:Alignment.centerLeft,
                                        child: Text(
                                          "Dispathed",style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.w700,),
                                        ),
                                      ),
                                      SizedBox(height: 5,),
                                      Align(
                                        alignment:Alignment.centerLeft,
                                        child:Text(
                                          "1:49 P.M",style: TextStyle(color: Colors.grey,fontSize: 14,fontWeight: FontWeight.w900,),
                                        ),
                                      )
                                    ],
                                  ),
                                ),

                              ],
                            ),
                          ),
                        ),


                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 80),
                            child: Container(
                              //color: Colors.white,
                              height: 40,
                              width: 20,
                              child: Image.asset("assets/img_136.png",),
                            ),
                          ),
                        ),

                        Center(
                          child: Container(
                            width:MediaQuery.of(context).size.width/1.4,
                            child: Row(
                              children: [

                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  height: 55,
                                  width: 60,
                                ),

                                Padding(padding: const EdgeInsets.fromLTRB(20,0,20,0),),

                                Container(
                                  width: 120,
                                  child: Column(
                                    children: [
                                      Align(
                                        alignment:Alignment.centerLeft,
                                        child: Text(
                                          "Delivery boy nearby",style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.w700,),
                                        ),
                                      ),
                                      SizedBox(height: 5,),
                                      Align(
                                        alignment:Alignment.centerLeft,
                                        child:Text(
                                          "2:15 P.M",style: TextStyle(color: Colors.grey,fontSize: 14,fontWeight: FontWeight.w900,),
                                        ),
                                      )
                                    ],
                                  ),
                                ),



                              ],
                            ),
                          ),
                        ),





                        Center(
                          child: Container(
                            width:MediaQuery.of(context).size.width/1.4,
                            child: Row(
                              children: [

                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 20),
                                    child: Container(
                                      //color: Colors.white,
                                      height: 200,
                                      width: 20,
                                      child: Image.asset("assets/img_136.png",),
                                    ),
                                  ),
                                ),

                                Padding(padding: const EdgeInsets.fromLTRB(20,0,0,0),),

                                Column(
                                  children: [
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Container(
                                        width:MediaQuery.of(context).size.width/1.9,
                                        child: Padding(
                                          padding: const EdgeInsets.only(left: 00),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              image:DecorationImage(
                                                  image: AssetImage("assets/img_137.png"),
                                                  fit: BoxFit.cover
                                              ),
                                            ),
                                            //color: Colors.white,
                                            height: 120,
                                            //width: 197,
                                            child: Center(child: Image.asset("assets/img_138.png",)),
                                          ),
                                        ),
                                      ),
                                    ),

                                    SizedBox(height: 15,),

                                    Align(
                                      alignment: Alignment.center,
                                      child: InkWell(

                                        onTap: () {
                                          Navigator.push(context, MaterialPageRoute(builder: (context) => OrderDelivered()));
                                        },

                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Color(0xFFFFB200),
                                            borderRadius: BorderRadius.circular(10),

                                            boxShadow: [

                                              BoxShadow(
                                                color: Colors.white,
                                              ),

                                            ],

                                          ),
                                          //color: Colors.green,
                                          height: 45,
                                          width: MediaQuery.of(context).size.width/2.375,
                                          child: Padding(
                                            padding: const EdgeInsets.all(0),
                                            child: Center(
                                              child: Text("Delivery Boy Nearby",style: TextStyle(
                                                  color: Colors.white,fontSize: 14,fontWeight: FontWeight.w900
                                              ),),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),


                                  ],
                                ),


                              ],
                            ),
                          ),
                        ),




                        ///
                        Center(
                          child: InkWell(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => OrderDelivered()));
                            },
                            child: Container(
                              width:MediaQuery.of(context).size.width/1.4,
                              child: Row(
                                children: [

                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.grey[200],
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    height: 55,
                                    width: 60,
                                  ),

                                  Padding(padding: const EdgeInsets.fromLTRB(20,0,20,0),),

                                  Container(
                                    width: 120,
                                    child: Column(
                                      children: [
                                        Align(
                                          alignment:Alignment.centerLeft,
                                          child: Text(
                                            "Done",style: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.w900,),
                                          ),
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




                      ],
                    ),
                  )



                ]
            )
        )
    );
  }

}




