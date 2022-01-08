import 'package:customer_ui/all_screen/grocery_offer_page.dart';
import 'package:customer_ui/all_screen/offer_page.dart';
import 'package:customer_ui/components/size_config.dart';
import 'package:customer_ui/components/styles.dart';
import 'package:flutter/material.dart';



class AllOfferPage extends StatefulWidget {
  @override
  _AllOfferPageState createState() => _AllOfferPageState();
}

class _AllOfferPageState extends State<AllOfferPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: kWhiteColor,
        centerTitle: true,
        title: Text(
          "All Offers",
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
      //backgroundColor: Colors.indigo[50],
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              SizedBox(height: 10,),


              InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => GroceryOfferPage()));
                },
                child: Container(
                  decoration: BoxDecoration(

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
                  height: 200,
                  width: MediaQuery.of(context).size.width/1.1,
                  child: Image.asset("assets/img_78.png",fit: BoxFit.cover,),
                ),
              ),


              SizedBox(height: 10,),

              InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) =>OfferPage()));
                },
                child: Container(
                  decoration: BoxDecoration(

                    image: DecorationImage(
                        image: AssetImage("assets/img_79.png"),
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
                  height: 200,
                  width: MediaQuery.of(context).size.width/1.1,
                  child: Image.asset("assets/img_80.png",),
                ),
              ),

              const SizedBox(height: 10,),

              InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => GroceryOfferPage()));
                },
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/img_81.png"),
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
                  height: 350,
                  width: MediaQuery.of(context).size.width/1.1,
                  child: Image.asset("assets/img_175.png",),
                ),
              ),

              const SizedBox(height: 10,),

              Container(
                decoration: BoxDecoration(

                  image: DecorationImage(
                      image: AssetImage("assets/img_82.png"),
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
                height: 200,
                width: MediaQuery.of(context).size.width/1.1,
                //child: Image.asset("assets/img_86.png",),
              ),


              const SizedBox(height: 10,),

              Container(
                decoration: BoxDecoration(

                  image: DecorationImage(
                      image: AssetImage("assets/img_176.png"),
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
                height: 200,
                width: MediaQuery.of(context).size.width/1.1,
                //child: Image.asset("assets/img_78.png",),
              ),

              const SizedBox(height: 10,),

              Container(
                decoration: BoxDecoration(

                  image: DecorationImage(
                      image: AssetImage("assets/img_178.png"),
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
                height: 200,
                width: MediaQuery.of(context).size.width/1.1,
                child: Image.asset("assets/img_177.png",),
              ),


              const SizedBox(height: 10,),

              Container(
                decoration: BoxDecoration(

                  image: DecorationImage(
                      image: AssetImage("assets/img_180.png"),
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
                height: 200,
                width: MediaQuery.of(context).size.width/1.1,
                child: Image.asset("assets/img_179.png",),
              ),

              SizedBox(height: 80,),

            ],
          ),
        ),
      ),

    );
  }

}




/*
import 'package:customer_ui/HomePage/grocer_offer/grocery_offer_page.dart';
import 'package:customer_ui/HomePage/offer/offer_page.dart';
import 'package:flutter/material.dart';
import 'catgoryView1stPage.dart';
import 'offer_single_page1.dart';

//import 'offer_single_page1.dart';

//import 'Language.dart';


class AllOfferPage extends StatefulWidget {
  @override
  _AllOfferPageState createState() => _AllOfferPageState();
}

class _AllOfferPageState extends State<AllOfferPage> {

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
                          child: Center(child: Text("All Offers",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500,color: Colors.black),)),
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

            InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => GroceryOfferPage()));
              },
              child: Container(
                decoration: BoxDecoration(

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
                height: 200,
                width: MediaQuery.of(context).size.width/1.1,
                child: Image.asset("assets/img_78.png",fit: BoxFit.cover,),
              ),
            ),


            SizedBox(height: 10,),

            InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) =>OfferPage()));
              },
              child: Container(
                decoration: BoxDecoration(

                  image: DecorationImage(
                      image: AssetImage("assets/img_79.png"),
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
                height: 200,
                width: MediaQuery.of(context).size.width/1.1,
                child: Image.asset("assets/img_80.png",),
              ),
            ),

            const SizedBox(height: 10,),

            InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => GroceryOfferPage()));
              },
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/img_81.png"),
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
                height: 350,
                width: MediaQuery.of(context).size.width/1.1,
                child: Image.asset("assets/img_175.png",),
              ),
            ),

            const SizedBox(height: 10,),

            Container(
              decoration: BoxDecoration(

                image: DecorationImage(
                    image: AssetImage("assets/img_82.png"),
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
              height: 200,
              width: MediaQuery.of(context).size.width/1.1,
              //child: Image.asset("assets/img_86.png",),
            ),


            const SizedBox(height: 10,),

            Container(
              decoration: BoxDecoration(

                image: DecorationImage(
                    image: AssetImage("assets/img_176.png"),
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
              height: 200,
              width: MediaQuery.of(context).size.width/1.1,
              //child: Image.asset("assets/img_78.png",),
            ),

            const SizedBox(height: 10,),

            Container(
              decoration: BoxDecoration(

                image: DecorationImage(
                    image: AssetImage("assets/img_178.png"),
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
              height: 200,
              width: MediaQuery.of(context).size.width/1.1,
              child: Image.asset("assets/img_177.png",),
            ),


            const SizedBox(height: 10,),

            Container(
              decoration: BoxDecoration(

                image: DecorationImage(
                    image: AssetImage("assets/img_180.png"),
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
              height: 200,
              width: MediaQuery.of(context).size.width/1.1,
              child: Image.asset("assets/img_179.png",),
            ),

            SizedBox(height: 80,),

          ],
        ),
      ),

    );
  }

}

*/

