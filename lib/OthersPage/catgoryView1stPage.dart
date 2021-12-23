
/*import 'package:customer_ui/HomePage/grocer_offer/grocery_details.dart';
import 'package:flutter/material.dart';

import 'cartDetails1stPage.dart';
import 'productSinglePage1.dart';

//import 'Language.dart';


class CategoryView1stPage extends StatefulWidget {
  const CategoryView1stPage({Key? key}) : super(key: key);

  @override
  _CategoryView1stPageState createState() => _CategoryView1stPageState();
}

class _CategoryView1stPageState extends State<CategoryView1stPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      //backgroundColor: Colors.indigo[50],
      body: SingleChildScrollView(
        child: Column(
          children: [

            //SizedBox(height: 20,),

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


            SizedBox(height: 5,),

            Container(

              decoration: BoxDecoration(

                image: const DecorationImage(
                    image: AssetImage("assets/img_95.png"),
                    fit: BoxFit.cover
                ),

                borderRadius: BorderRadius.circular(5),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey
                        .withOpacity(0.15),
                    spreadRadius: 5, //spread radius
                    blurRadius: 5, // blur radius
                    offset: Offset(
                        0, 3),
                  ),
                ],
              ),
              //height: 105,
              height: 110,
              width: MediaQuery.of(context).size.width/1.1,
              //child: Image.asset("assets/img_80.png",),
            ),

            const SizedBox(height: 30,),

            Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 22.0),
                  child: const Text("1454 items found",style: TextStyle(fontSize: 17,fontWeight: FontWeight.w500,color: Colors.grey),),
                )),

            const SizedBox(height: 30,),

            Container(
              decoration: BoxDecoration(

                image: DecorationImage(
                    image: AssetImage("assets/img_40.png"),
                    fit: BoxFit.cover
                ),

                color: Colors.indigo[100],
                borderRadius: BorderRadius.circular(5),
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

                    InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => GroceryDetails()));
                      },
                      child: Container(
                        height: 120,
                        width: MediaQuery.of(context).size.width/3,
                        child: Image.asset("assets/img_89.png"),
                      ),
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

            SizedBox(height: 5,),

            Container(
              decoration: BoxDecoration(

                image: DecorationImage(
                    image: AssetImage("assets/img_40.png"),
                    fit: BoxFit.cover
                ),

                color: Colors.indigo[100],
                borderRadius: BorderRadius.circular(5),
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
                      child: Image.asset("assets/img_156.png"),
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
                              child: Text("Cadberi Candi Bar silk\-10gm",style: TextStyle(
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

            SizedBox(height: 5,),

            Container(
              decoration: BoxDecoration(

                image: DecorationImage(
                    image: AssetImage("assets/img_40.png"),
                    fit: BoxFit.cover
                ),

                color: Colors.indigo[100],
                borderRadius: BorderRadius.circular(5),
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
                      child: Image.asset("assets/img_157.png"),
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

            SizedBox(height: 5,),


            Container(
              decoration: BoxDecoration(

                image: DecorationImage(
                    image: AssetImage("assets/img_40.png"),
                    fit: BoxFit.cover
                ),

                color: Colors.indigo[100],
                borderRadius: BorderRadius.circular(5),
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

            SizedBox(height: 5,),

            Container(
              decoration: BoxDecoration(

                image: DecorationImage(
                    image: AssetImage("assets/img_40.png"),
                    fit: BoxFit.cover
                ),

                color: Colors.indigo[100],
                borderRadius: BorderRadius.circular(5),
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
                height: 70,
                width: MediaQuery.of(context).size.width/4.5,
                child: Image.asset("assets/img_160.png"),
              ),
            ),

            SizedBox(height: 80,),

          ],
        ),
      ),

    );
  }

}





/*Container(

              decoration: BoxDecoration(

                image: const DecorationImage(
                    image: AssetImage("assets/img_95.png"),
                    fit: BoxFit.cover
                ),

                borderRadius: BorderRadius.circular(5),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey
                        .withOpacity(0.15),
                    spreadRadius: 5, //spread radius
                    blurRadius: 5, // blur radius
                    offset: Offset(
                        0, 3),
                  ),
                ],
              ),
              height: 105,
              width: MediaQuery.of(context).size.width/1.1,
              //child: Image.asset("assets/img_80.png",),
            ),*/



 */
