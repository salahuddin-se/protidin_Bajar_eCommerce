
/*
import 'package:flutter/material.dart';

import 'cart_details1st_page.dart';

//import 'Language.dart';


class ProductSinglePage1 extends StatefulWidget {
  const ProductSinglePage1({Key? key}) : super(key: key);

  @override
  _ProductSinglePage1State createState() => _ProductSinglePage1State();
}

class _ProductSinglePage1State extends State<ProductSinglePage1> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        //backgroundColor: Colors.indigo[50],
        body: SingleChildScrollView(
            child: Column(
                children: [

                  SizedBox(height: 30,),

                  Center(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                      child: Container(

                        //width: 330,
                        width: MediaQuery.of(context).size.width/1.1,
                        height: 45,

                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [

                            //Padding(padding: const EdgeInsets.fromLTRB(15,0,0,0),),

                            Container(
                              //color: Colors.white,
                              height: 15,
                              width: 25,
                              child: Image.asset("assets/img_134.png",color: Colors.black,),
                            ),

                            //Padding(padding: const EdgeInsets.fromLTRB(70,0,0,0),),

                            Center(
                              child: Container(
                                height: 28,
                                //width: 200,
                                child: Center(child: Text("Grocery",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500,color: Colors.black),)),
                              ),
                            ),

                            Container(
                              //color: Colors.white,
                              height: 10,
                              width: 25,
                              child: Image.asset("assets/img_77.png",color: Colors.black,),
                            ),

                          ],


                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 30,),

                  Container(
                    decoration: BoxDecoration(

                      image: const DecorationImage(
                          image: AssetImage("assets/img_40.png"),
                          fit: BoxFit.cover
                      ),

                      borderRadius: BorderRadius.circular(5),

                    ),
                    height: 200,
                    width: MediaQuery.of(context).size.width/1.4,
                    child: Image.asset("assets/img_96.png",),
                  ),


                  Container(
                    height: 60,
                    width: MediaQuery.of(context).size.width/1.2,
                    child: Text("ACI pure 100% healthy soyabin oil.\n- 5 Litre",style: TextStyle(
                        color: Colors.grey,fontSize: 18,fontWeight: FontWeight.w800
                    ),),
                  ),

                  SizedBox(height: 10,),

                  Container(
                    height: 55,
                    width: MediaQuery.of(context).size.width/1.2,
                    child: Text("Soybean oil is a type of vegetable oil that is derived from the seeds of the soybean plant. "
                      ,style: TextStyle(
                          color: Colors.grey,fontSize: 14,fontWeight: FontWeight.w800
                      ),),
                  ),



                  ///
                  Container(
                    width: MediaQuery.of(context).size.width/1,
                    height: 40,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                            width: MediaQuery.of(context).size.width/6,
                            child: Image.asset("assets/img_97.png",)
                        ),
                        //Padding(padding: const EdgeInsets.fromLTRB(0,0,20,0),),
                        Container(
                          width: MediaQuery.of(context).size.width/6,
                          child: Text("৳700Tk ",style: TextStyle(
                              color: Colors.black,fontSize: 16,fontWeight: FontWeight.w900
                          ),),
                        ),

                        Container(
                          width: MediaQuery.of(context).size.width/6,
                          child: Text("৳790Tk ",style: TextStyle(
                              color: Colors.black,fontSize: 14,fontWeight: FontWeight.w900,
                              decoration: TextDecoration.lineThrough
                          ),),
                        ),

                        //Padding(padding: const EdgeInsets.fromLTRB(7,0,10,0),),

                        Container(
                          width: MediaQuery.of(context).size.width/6,
                          decoration: BoxDecoration(
                            //color: Colors.indigo[100],
                            borderRadius: BorderRadius.circular(5),

                            boxShadow: [
                              BoxShadow(
                                color: Colors.green,

                              ),
                            ],

                          ),
                          //color: Colors.green,
                          height: 27,
                          child: Padding(
                            padding: const EdgeInsets.all(0),
                            child: Center(
                              child: Text("20% Off",style: TextStyle(
                                  color: Colors.white,fontSize: 16,fontWeight: FontWeight.w900
                              ),),
                            ),
                          ),
                        ),


                        Container(
                            width: MediaQuery.of(context).size.width/6,
                            child: Image.asset("assets/img_98.png",)
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width/6,
                          child: Text("৳ 35Tk ",style: TextStyle(
                              color: Colors.black,fontSize: 14,fontWeight: FontWeight.w500
                          ),),
                        ),

                      ],
                    ),
                  ),
                  ///


                  SizedBox(height: 20,),

                  Container(
                    width: MediaQuery.of(context).size.width/1.1,
                    decoration: BoxDecoration(

                      image: const DecorationImage(
                          image: AssetImage("assets/img_99.png"),
                          fit: BoxFit.cover
                      ),

                      borderRadius: BorderRadius.circular(5),
                      boxShadow: [

                      ],
                    ),
                    height: 40,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                            width: MediaQuery.of(context).size.width/7,
                            child: Image.asset("assets/img_100.png",)
                        ),
                        //Padding(padding: const EdgeInsets.fromLTRB(0,0,20,0),),
                        Container(
                          width: MediaQuery.of(context).size.width/2.5,
                          child: Text("Member Price :৳680 ",style: TextStyle(
                              color: Colors.black,fontSize: 16,fontWeight: FontWeight.w500
                          ),),
                        ),

                        //Padding(padding: const EdgeInsets.fromLTRB(10,0,10,0),),
                        Container(
                          width: MediaQuery.of(context).size.width/5.5,
                          child: Text("Save :৳20 ",style: TextStyle(
                              color: Colors.green,fontSize: 16,fontWeight: FontWeight.w500
                          ),),
                        ),

                        //Padding(padding: const EdgeInsets.fromLTRB(15,0,15,0),),

                        Container(
                            width: MediaQuery.of(context).size.width/6,
                            child: Image.asset("assets/img_101.png",)
                        ),

                      ],
                    ),
                  ),

                  SizedBox(height: 20,),



                  ///
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Container(
                        width: MediaQuery.of(context).size.width/1.3,
                        height: 40,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [

                            Padding(padding: const EdgeInsets.only(left: 8),),

                            Text("Unit :",style: TextStyle(
                                color: Colors.black,fontSize: 18,fontWeight: FontWeight.w500
                            ),),
                            Padding(padding: const EdgeInsets.fromLTRB(0,0,20,0),),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  //color: Colors.indigo[100],
                                  borderRadius: BorderRadius.circular(0),
                                  border: Border.all(
                                      width: 1,
                                      color: Colors.grey
                                  ),
                                  boxShadow: [
                                    BoxShadow(

                                      color: Colors.grey.withOpacity(0.10),
                                      spreadRadius: 5, //spread radius
                                      blurRadius: 5, // blur radius
                                      offset: Offset(
                                          0, 3),
                                    ),
                                  ],

                                ),
                                //color: Colors.green,
                                height: 30,
                                width: MediaQuery.of(context).size.width/6,
                                child: Padding(
                                  padding: const EdgeInsets.all(0),
                                  child: Center(
                                    child: Text("1 kg",style: TextStyle(
                                        color: Colors.black,fontSize: 15,fontWeight: FontWeight.w900
                                    ),),
                                  ),
                                ),
                              ),
                            ),

                            Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  //color: Colors.indigo[100],
                                  borderRadius: BorderRadius.circular(0),
                                  border: Border.all(
                                      width: 1,
                                      color: Colors.grey
                                  ),
                                  boxShadow: [
                                    BoxShadow(

                                      color: Colors.grey.withOpacity(0.10),
                                      spreadRadius: 5, //spread radius
                                      blurRadius: 5, // blur radius
                                      offset: Offset(
                                          0, 3),
                                    ),
                                  ],

                                ),
                                //color: Colors.green,
                                height: 30,
                                width: MediaQuery.of(context).size.width/6,
                                child: Padding(
                                  padding: const EdgeInsets.all(0),
                                  child: Center(
                                    child: Text("2 kg",style: TextStyle(
                                        color: Colors.black,fontSize: 15,fontWeight: FontWeight.w900
                                    ),),
                                  ),
                                ),
                              ),
                            ),

                            Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  //color: Colors.indigo[100],
                                  borderRadius: BorderRadius.circular(0),
                                  border: Border.all(
                                      width: 1,
                                      color: Colors.grey
                                  ),
                                  boxShadow: [
                                    BoxShadow(

                                      color: Colors.grey.withOpacity(0.10),
                                      spreadRadius: 5, //spread radius
                                      blurRadius: 5, // blur radius
                                      offset: Offset(
                                          0, 3),
                                    ),
                                  ],

                                ),
                                //color: Colors.green,
                                height: 30,
                                width: MediaQuery.of(context).size.width/6,
                                child: Padding(
                                  padding: const EdgeInsets.all(0),
                                  child: Center(
                                    child: Text("5 kg",style: TextStyle(
                                        color: Colors.black,fontSize: 15,fontWeight: FontWeight.w900
                                    ),),
                                  ),
                                ),
                              ),
                            ),



                          ],
                        ),
                      ),
                    ),
                  ),
                  ///



                  SizedBox(height: 25,),

                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xFF9900FF),
                        //color: Colors.indigo[100],
                        borderRadius: BorderRadius.circular(45),
                        border: Border.all(
                            width: 1,
                            color: Colors.grey
                        ),
                        boxShadow: [
                          BoxShadow(

                            color: Colors.grey.withOpacity(0.10),
                            spreadRadius: 5, //spread radius
                            blurRadius: 5, // blur radius
                            offset: Offset(
                                0, 3),
                          ),
                        ],

                      ),

                      height: 50,
                      width: MediaQuery.of(context).size.width/2.5,
                      child: Center(
                        child: Text("Add  +",style: TextStyle(
                            color: Colors.white,fontSize: 16,fontWeight: FontWeight.w900
                        ),),
                      ),
                    ),
                  ),


                  const SizedBox(height: 30,),



                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      //color: Colors.indigo[100],
                      borderRadius: BorderRadius.circular(40),
                      /*border: Border.all(
                    width: 1,
                    color: Colors.grey
                ),*/
                      boxShadow: [
                        BoxShadow(

                          color: Colors.grey.withOpacity(0.10),
                          spreadRadius: 5, //spread radius
                          blurRadius: 5, // blur radius
                          offset: Offset(
                              0, 3),
                        ),
                      ],

                    ),

                    child: Column(
                      children: [
                        const SizedBox(height: 10,),
                        Container(
                          width: MediaQuery.of(context).size.width/1.2,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 0),
                                child: Container(
                                    width: MediaQuery.of(context).size.width/2,
                                    child: const Text("Related",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w800,color: Colors.black),)),
                              ),
                              //Padding(padding: const EdgeInsets.fromLTRB(40,0,40,0),),
                              Padding(
                                padding: const EdgeInsets.only(left: 0),
                                child: Container(
                                    width: MediaQuery.of(context).size.width/3,
                                    child: const Text("SHOW MORE",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500,color: Colors.black),)),
                              ),
                            ],
                          ),
                        ),



                        const SizedBox(height: 25,),


                        Container(
                          decoration: BoxDecoration(

                            image: DecorationImage(
                                image: AssetImage("assets/img_40.png"),
                                fit: BoxFit.cover
                            ),

                            color: Colors.indigo[100],
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.10),
                                spreadRadius: 5, //spread radius
                                blurRadius: 5, // blur radius
                                offset: Offset(
                                    0, 3),
                              ),
                            ],
                          ),
                          height: 140,
                          width: MediaQuery.of(context).size.width/1.1,
                          //color: Colors.cyan,
                          child: FittedBox(
                            child: Row(
                              children: [

                                Padding(padding: const EdgeInsets.only(left: 10.0),),

                                Container(
                                  height: 120,
                                  width: MediaQuery.of(context).size.width/3,
                                  child: Image.asset("assets/img_158.png"),
                                ),

                                Container(
                                  width: MediaQuery.of(context).size.width/2.2,
                                  child: Column(
                                    children: [
                                      SizedBox(height: 5,),

                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Container(
                                          height: 70,
                                          //width: 200,
                                          child: Text("Cadberi silk bar\-10 gm",style: TextStyle(
                                              color: Colors.grey,fontSize: 16,fontWeight: FontWeight.w800
                                          ),),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              //color: Colors.indigo[100],
                                              borderRadius: BorderRadius.circular(5),

                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.green,

                                                ),
                                              ],

                                            ),
                                            //color: Colors.green,
                                            height: 25,
                                            width: 90,
                                            child: Padding(
                                              padding: const EdgeInsets.all(0),
                                              child: Center(
                                                child: Text("20% Offer",style: TextStyle(
                                                    color: Colors.white,fontSize: 12,fontWeight: FontWeight.w900
                                                ),),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),

                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [

                                            Container(
                                              height: 25,
                                              //width: 50,
                                              child: Padding(
                                                padding: const EdgeInsets.only(top: 3),
                                                child: Text("৳20Tk ",style: TextStyle(
                                                    color: Colors.black,fontSize: 18,fontWeight: FontWeight.w900
                                                ),),
                                              ),
                                            ),
                                            Container(
                                              height: 25,
                                              //width: 50,
                                              child: Padding(
                                                padding: const EdgeInsets.only(top: 7.5),
                                                child: Text("৳25Tk ",style: TextStyle(
                                                    color: Colors.black,fontSize: 14,fontWeight: FontWeight.w900,
                                                    decoration: TextDecoration.lineThrough
                                                ),),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),

                                      //Padding(padding: const EdgeInsets.only(left: 50.0),),

                                    ],
                                  ),
                                ),



                                SizedBox(height: 20,),


                                Padding(
                                  padding: const EdgeInsets.fromLTRB(0,50,10,0),
                                  child: Align(
                                    alignment: Alignment.bottomRight,
                                    child: Container(
                                      width: MediaQuery.of(context).size.width/5,
                                      height: 35,
                                      decoration: BoxDecoration(
                                        color: Color(0xFF9900FF),
                                        borderRadius: BorderRadius.circular(20),

                                      ),

                                      child:InkWell(
                                        /*onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => OnBoardingPage3()));
                            },*/
                                        child: Container(
                                          width: 40,
                                          child: Center(
                                            child: Text(
                                              "Add +",style: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.w800),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),

                              ],
                            ),
                          ),

                        ),

                        const SizedBox(height: 10,),

                        Container(
                          decoration: BoxDecoration(

                            image: DecorationImage(
                                image: AssetImage("assets/img_40.png"),
                                fit: BoxFit.cover
                            ),

                            color: Colors.indigo[100],
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.10),
                                spreadRadius: 5, //spread radius
                                blurRadius: 5, // blur radius
                                offset: Offset(
                                    0, 3),
                              ),
                            ],
                          ),
                          height: 140,
                          width: MediaQuery.of(context).size.width/1.1,
                          //color: Colors.cyan,
                          child: FittedBox(
                            child: Row(
                              children: [

                                Padding(padding: const EdgeInsets.only(left: 10.0),),

                                Container(
                                  height: 120,
                                  width: MediaQuery.of(context).size.width/3,
                                  child: Image.asset("assets/img_159.png"),
                                ),

                                Container(
                                  width: MediaQuery.of(context).size.width/2.2,
                                  child: Column(
                                    children: [
                                      SizedBox(height: 5,),

                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Container(
                                          height: 70,
                                          //width: 200,
                                          child: Text("ACI pure 100% healthy\nsoyabin oil 5 Litre",style: TextStyle(
                                              color: Colors.grey,fontSize: 16,fontWeight: FontWeight.w800
                                          ),),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              //color: Colors.indigo[100],
                                              borderRadius: BorderRadius.circular(5),

                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.green,

                                                ),
                                              ],

                                            ),
                                            //color: Colors.green,
                                            height: 25,
                                            width: 90,
                                            child: Padding(
                                              padding: const EdgeInsets.all(0),
                                              child: Center(
                                                child: Text("20% Offer",style: TextStyle(
                                                    color: Colors.white,fontSize: 12,fontWeight: FontWeight.w900
                                                ),),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),

                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [

                                            Container(
                                              height: 25,
                                              //width: 50,
                                              child: Padding(
                                                padding: const EdgeInsets.only(top: 3),
                                                child: Text("৳700Tk ",style: TextStyle(
                                                    color: Colors.black,fontSize: 18,fontWeight: FontWeight.w900
                                                ),),
                                              ),
                                            ),
                                            Container(
                                              height: 25,
                                              //width: 50,
                                              child: Padding(
                                                padding: const EdgeInsets.only(top: 7.5),
                                                child: Text("৳790Tk ",style: TextStyle(
                                                    color: Colors.black,fontSize: 14,fontWeight: FontWeight.w900,
                                                    decoration: TextDecoration.lineThrough
                                                ),),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),

                                      //Padding(padding: const EdgeInsets.only(left: 50.0),),

                                    ],
                                  ),
                                ),



                                SizedBox(height: 20,),


                                Padding(
                                  padding: const EdgeInsets.fromLTRB(0,50,10,0),
                                  child: Align(
                                    alignment: Alignment.bottomRight,
                                    child: Container(
                                      width: MediaQuery.of(context).size.width/5,
                                      height: 35,
                                      decoration: BoxDecoration(
                                        color: Color(0xFF9900FF),
                                        borderRadius: BorderRadius.circular(20),

                                      ),

                                      child:InkWell(
                                        /*onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => OnBoardingPage3()));
                            },*/
                                        child: Container(
                                          width: 40,
                                          child: Center(
                                            child: Text(
                                              "Add +",style: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.w800),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),

                              ],
                            ),
                          ),

                        ),


                        const SizedBox(height: 10,),

                        Container(
                          decoration: BoxDecoration(

                            image: DecorationImage(
                                image: AssetImage("assets/img_40.png"),
                                fit: BoxFit.cover
                            ),

                            color: Colors.indigo[100],
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.10),
                                spreadRadius: 5, //spread radius
                                blurRadius: 5, // blur radius
                                offset: Offset(
                                    0, 3),
                              ),
                            ],
                          ),
                          height: 140,
                          width: MediaQuery.of(context).size.width/1.1,
                          //color: Colors.cyan,
                          child: FittedBox(
                            child: Row(
                              children: [

                                Padding(padding: const EdgeInsets.only(left: 10.0),),

                                Container(
                                  height: 120,
                                  width: MediaQuery.of(context).size.width/3,
                                  child: Image.asset("assets/img_89.png"),
                                ),

                                Container(
                                  width: MediaQuery.of(context).size.width/2.2,
                                  child: Column(
                                    children: [
                                      SizedBox(height: 5,),

                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Container(
                                          height: 70,
                                          //width: 200,
                                          child: Text("ACI pure 100% healthy\nsoyabin oil 5 Litre",style: TextStyle(
                                              color: Colors.grey,fontSize: 16,fontWeight: FontWeight.w800
                                          ),),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              //color: Colors.indigo[100],
                                              borderRadius: BorderRadius.circular(5),

                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.green,

                                                ),
                                              ],

                                            ),
                                            //color: Colors.green,
                                            height: 25,
                                            width: 90,
                                            child: Padding(
                                              padding: const EdgeInsets.all(0),
                                              child: Center(
                                                child: Text("20% Offer",style: TextStyle(
                                                    color: Colors.white,fontSize: 12,fontWeight: FontWeight.w900
                                                ),),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),

                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [

                                            Container(
                                              height: 25,
                                              //width: 50,
                                              child: Padding(
                                                padding: const EdgeInsets.only(top: 3),
                                                child: Text("৳700Tk ",style: TextStyle(
                                                    color: Colors.black,fontSize: 18,fontWeight: FontWeight.w900
                                                ),),
                                              ),
                                            ),
                                            Container(
                                              height: 25,
                                              //width: 50,
                                              child: Padding(
                                                padding: const EdgeInsets.only(top: 7.5),
                                                child: Text("৳790Tk ",style: TextStyle(
                                                    color: Colors.black,fontSize: 14,fontWeight: FontWeight.w900,
                                                    decoration: TextDecoration.lineThrough
                                                ),),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),

                                      //Padding(padding: const EdgeInsets.only(left: 50.0),),

                                    ],
                                  ),
                                ),



                                SizedBox(height: 20,),


                                Padding(
                                  padding: const EdgeInsets.fromLTRB(0,50,10,0),
                                  child: Align(
                                    alignment: Alignment.bottomRight,
                                    child: Container(
                                      width: MediaQuery.of(context).size.width/5,
                                      height: 35,
                                      decoration: BoxDecoration(
                                        color: Color(0xFF9900FF),
                                        borderRadius: BorderRadius.circular(20),

                                      ),

                                      child:InkWell(
                                        /*onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => OnBoardingPage3()));
                            },*/
                                        child: Container(
                                          width: 40,
                                          child: Center(
                                            child: Text(
                                              "Add +",style: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.w800),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),

                              ],
                            ),
                          ),

                        ),


                        const SizedBox(height: 10,),

                        Container(
                          decoration: BoxDecoration(

                            image: DecorationImage(
                                image: AssetImage("assets/img_40.png"),
                                fit: BoxFit.cover
                            ),

                            color: Colors.indigo[100],
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.10),
                                spreadRadius: 5, //spread radius
                                blurRadius: 5, // blur radius
                                offset: Offset(
                                    0, 3),
                              ),
                            ],
                          ),
                          height: 140,
                          width: MediaQuery.of(context).size.width/1.1,
                          //color: Colors.cyan,
                          child: FittedBox(
                            child: Row(
                              children: [

                                Padding(padding: const EdgeInsets.only(left: 10.0),),

                                Container(
                                  height: 120,
                                  width: MediaQuery.of(context).size.width/3,
                                  child: Image.asset("assets/img_89.png"),
                                ),

                                Container(
                                  width: MediaQuery.of(context).size.width/2.2,
                                  child: Column(
                                    children: [
                                      SizedBox(height: 5,),

                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Container(
                                          height: 70,
                                          //width: 200,
                                          child: Text("ACI pure 100% healthy\nsoyabin oil 5 Litre",style: TextStyle(
                                              color: Colors.grey,fontSize: 16,fontWeight: FontWeight.w800
                                          ),),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              //color: Colors.indigo[100],
                                              borderRadius: BorderRadius.circular(5),

                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.green,

                                                ),
                                              ],

                                            ),
                                            //color: Colors.green,
                                            height: 25,
                                            width: 90,
                                            child: Padding(
                                              padding: const EdgeInsets.all(0),
                                              child: Center(
                                                child: Text("20% Offer",style: TextStyle(
                                                    color: Colors.white,fontSize: 12,fontWeight: FontWeight.w900
                                                ),),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),

                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [

                                            Container(
                                              height: 25,
                                              //width: 50,
                                              child: Padding(
                                                padding: const EdgeInsets.only(top: 3),
                                                child: Text("৳700Tk ",style: TextStyle(
                                                    color: Colors.black,fontSize: 18,fontWeight: FontWeight.w900
                                                ),),
                                              ),
                                            ),
                                            Container(
                                              height: 25,
                                              //width: 50,
                                              child: Padding(
                                                padding: const EdgeInsets.only(top: 7.5),
                                                child: Text("৳790Tk ",style: TextStyle(
                                                    color: Colors.black,fontSize: 14,fontWeight: FontWeight.w900,
                                                    decoration: TextDecoration.lineThrough
                                                ),),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),

                                      //Padding(padding: const EdgeInsets.only(left: 50.0),),

                                    ],
                                  ),
                                ),



                                SizedBox(height: 20,),


                                Padding(
                                  padding: const EdgeInsets.fromLTRB(0,50,10,0),
                                  child: Align(
                                    alignment: Alignment.bottomRight,
                                    child: Container(
                                      width: MediaQuery.of(context).size.width/5,
                                      height: 35,
                                      decoration: BoxDecoration(
                                        color: Color(0xFF9900FF),
                                        borderRadius: BorderRadius.circular(20),

                                      ),

                                      child:InkWell(
                                        /*onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => OnBoardingPage3()));
                            },*/
                                        child: Container(
                                          width: 40,
                                          child: Center(
                                            child: Text(
                                              "Add +",style: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.w800),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),

                              ],
                            ),
                          ),

                        ),

                        const SizedBox(height: 10,),

                        Container(
                          decoration: BoxDecoration(

                            image: DecorationImage(
                                image: AssetImage("assets/img_40.png"),
                                fit: BoxFit.cover
                            ),

                            color: Colors.indigo[100],
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.10),
                                spreadRadius: 5, //spread radius
                                blurRadius: 5, // blur radius
                                offset: Offset(
                                    0, 3),
                              ),
                            ],
                          ),
                          height: 140,
                          width: MediaQuery.of(context).size.width/1.1,
                          //color: Colors.cyan,
                          child: FittedBox(
                            child: Row(
                              children: [

                                Padding(padding: const EdgeInsets.only(left: 10.0),),

                                Container(
                                  height: 120,
                                  width: MediaQuery.of(context).size.width/3,
                                  child: Image.asset("assets/img_89.png"),
                                ),

                                Container(
                                  width: MediaQuery.of(context).size.width/2.2,
                                  child: Column(
                                    children: [
                                      SizedBox(height: 5,),

                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Container(
                                          height: 70,
                                          //width: 200,
                                          child: Text("ACI pure 100% healthy\nsoyabin oil 5 Litre",style: TextStyle(
                                              color: Colors.grey,fontSize: 16,fontWeight: FontWeight.w800
                                          ),),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              //color: Colors.indigo[100],
                                              borderRadius: BorderRadius.circular(5),

                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.green,

                                                ),
                                              ],

                                            ),
                                            //color: Colors.green,
                                            height: 25,
                                            width: 90,
                                            child: Padding(
                                              padding: const EdgeInsets.all(0),
                                              child: Center(
                                                child: Text("20% Offer",style: TextStyle(
                                                    color: Colors.white,fontSize: 12,fontWeight: FontWeight.w900
                                                ),),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),

                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [

                                            Container(
                                              height: 25,
                                              //width: 50,
                                              child: Padding(
                                                padding: const EdgeInsets.only(top: 3),
                                                child: Text("৳700Tk ",style: TextStyle(
                                                    color: Colors.black,fontSize: 18,fontWeight: FontWeight.w900
                                                ),),
                                              ),
                                            ),

                                            Container(
                                              height: 25,
                                              //width: 50,
                                              child: Padding(
                                                padding: const EdgeInsets.only(top: 7.5),
                                                child: Text("৳790Tk ",style: TextStyle(
                                                    color: Colors.black,fontSize: 14,fontWeight: FontWeight.w900,
                                                    decoration: TextDecoration.lineThrough
                                                ),),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),

                                      //Padding(padding: const EdgeInsets.only(left: 50.0),),

                                    ],
                                  ),
                                ),



                                SizedBox(height: 20,),


                                Padding(
                                  padding: const EdgeInsets.fromLTRB(0,50,10,0),
                                  child: Align(
                                    alignment: Alignment.bottomRight,
                                    child: Container(
                                      width: MediaQuery.of(context).size.width/5,
                                      height: 35,
                                      decoration: BoxDecoration(
                                        color: Color(0xFF9900FF),
                                        borderRadius: BorderRadius.circular(20),

                                      ),

                                      child:InkWell(
                                        /*onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => OnBoardingPage3()));
                            },*/
                                        child: Container(
                                          width: 40,
                                          child: Center(
                                            child: Text(
                                              "Add +",style: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.w800),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),

                              ],
                            ),
                          ),

                        ),

                        SizedBox(height: 10,),

                        InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => CartDetails()));
                          },
                          child: Container(
                            height: 80,
                            width: MediaQuery.of(context).size.width/4,
                            child: Image.asset("assets/img_160.png"),
                          ),
                        ),


                        SizedBox(height: 80,),

                      ],
                    ),
                  ),
                ]
            )
        )
    );
  }

}

*/


