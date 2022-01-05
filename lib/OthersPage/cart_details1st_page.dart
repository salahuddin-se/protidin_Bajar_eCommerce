import 'dart:convert';
import 'dart:developer';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:http/http.dart' as http;
import 'package:customer_ui/components/styles.dart';
import 'package:customer_ui/components/utils.dart';
import 'package:customer_ui/dataModel/cart_details_model.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';


void main() => runApp(CartDetails());

class CartDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final title = 'Increment Decrement Demo';
    return MaterialApp(
      title: title,
      home: NumberInputWithIncrementDecrement(),
    );
  }
}

class NumberInputWithIncrementDecrement extends StatefulWidget {
  @override
  _NumberInputWithIncrementDecrementState createState() =>
      _NumberInputWithIncrementDecrementState();
}

class _NumberInputWithIncrementDecrementState
    extends State<NumberInputWithIncrementDecrement> {
  TextEditingController _controller = TextEditingController();

  var demo=[];

  Future<void> getCartName() async {
    var res = await http.post(Uri.parse("https://test.protidin.com.bd/api/v2/carts/61"),
        headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8', 'Authorization': 'Bearer $authToken'});
    // log("Response ${res.body}");
    log("Response code ${res.statusCode}");

    var dataMap=jsonDecode(res.body);
    log(dataMap[0].toString());
    var cartModel=CartDetailsModel.fromJson(dataMap[0]);
    demo=cartModel.cartItems;
    log("length ${cartModel.cartItems.length}");
    //demo=dataMap;
    setState(() {

    });
    //log("demo length "+demo.length.toString());

  }


  Future<void> changeQuantity(id, userId, quantity) async {
    var res2 = await http.post(Uri.parse("https://test.protidin.com.bd/api/v2/carts/change-quantity"),
        headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8', 'Authorization': 'Bearer $authToken'},
        body: jsonEncode(<String, dynamic>{"id": id, "variant": "", "user_id": userId, "quantity": quantity}));

    log("Response ${res2.body}");
    log("Response code jhjk ${res2.statusCode}");

    if (res2.statusCode == 200 || res2.statusCode == 201) {
      showToast("Cart Added Successfully", context: context);
    } else {
      showToast("Something went wrong", context: context);
    }
  }


  @override
  void initState() {
    super.initState();
    getCartName();
    _controller.text = "1"; // Setting the initial value for the field.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: kWhiteColor,
        centerTitle: true,
        title: Text(
          "Cart",
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

            Container(
              height: MediaQuery.of(context).size.height/1,
              child: ListView.builder(
                itemCount: demo.length,
                itemBuilder: (_,index){
                  //var data=demo[index].product_name;
                  //return Text(demo[index].productName);
                  return Container(
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
                            //ProductSinglePage1
                            onTap: () {
                              //Navigator.push(context, MaterialPageRoute(builder: (context) => GroceryDetails()));
                            },
                            child: Container(
                              height: 120,
                              width: MediaQuery.of(context).size.width/3,
                              child: Image.network(
                                imagePath + demo[index].productThumbnailImage,
                              ),
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
                                    child: Text(demo[index].productName,style: TextStyle(
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
                                width: MediaQuery.of(context).size.width/4,
                                height: 35,
                                decoration: BoxDecoration(
                                  color: Color(0xFF9900FF),
                                  borderRadius: BorderRadius.circular(20),

                                ),

                                /*
                                Text(
                                        "- 1 +",style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.w800),
                                      ),
                                */
                                child:Container(
                                  //width: 50,
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: <Widget>[

                                    FittedBox(
                                      child: Container(
                                        child: MaterialButton(
                                          child: Icon(Icons.remove,color: Colors.white),
                                          onPressed: () {
                                            int currentValue = int.parse(_controller.text);
                                            setState(() {
                                              currentValue--;
                                              _controller.text =
                                                  (currentValue).toString(); // incrementing value
                                            });
                                          },
                                        ),
                                        width: MediaQuery.of(context).size.width/15,
                                      ),
                                    ),

                                    Padding(
                                      padding: const EdgeInsets.only(left: 25.0),
                                      child: FittedBox(
                                        child: Container(
                                          child: TextFormField(
                                            controller: _controller,style: TextStyle(color: Colors.white),
                                            keyboardType: TextInputType.numberWithOptions(
                                                decimal: false, signed: false),
                                            inputFormatters: <TextInputFormatter>[
                                              WhitelistingTextInputFormatter.digitsOnly
                                            ],
                                          ),
                                          width: MediaQuery.of(context).size.width/15,
                                        ),
                                      ),
                                    ),

                                    FittedBox(
                                      child: Container(
                                        child: MaterialButton(
                                          child: Icon(
                                              Icons.add,color: Colors.white,

                                          ),
                                          onPressed: () {
                                            int currentValue = int.parse(_controller.text);
                                            setState(() {
                                              currentValue++;
                                              _controller.text =
                                                  (currentValue).toString(); // decrementing value
                                            });
                                          },
                                        ),
                                        width: MediaQuery.of(context).size.width/9,
                                      ),
                                    ),

                                 /*
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[


                                    ],
                                  ),
                                  Spacer(
                                    flex: 2,
                                  ),
                                 */


                                  ],
                                ),
                                  ),
                                ),
                              ),
                            ),
                          ),



                        ],
                      ),
                    ),

                  );


                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}








/*
import 'dart:convert';
import 'dart:developer';
import 'package:customer_ui/components/styles.dart';
import 'package:customer_ui/components/utils.dart';
import 'package:customer_ui/dataModel/cart_details_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'paymentMethod&_address_1stPage.dart';


class CartDetails extends StatefulWidget {
  const CartDetails({Key? key}) : super(key: key);

  @override
  _CartDetailsState createState() => _CartDetailsState();
}

class _CartDetailsState extends State<CartDetails> {

  var demo=[];

  Future<void> getCartName() async {
    var res = await http.post(Uri.parse("https://test.protidin.com.bd/api/v2/carts/61"),
        headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8', 'Authorization': 'Bearer $authToken'});
   // log("Response ${res.body}");
    log("Response code ${res.statusCode}");

    var dataMap=jsonDecode(res.body);
    log(dataMap[0].toString());
    var cartModel=CartDetailsModel.fromJson(dataMap[0]);
    demo=cartModel.cartItems;
    log("length ${cartModel.cartItems.length}");
    //demo=dataMap;
    setState(() {

    });
    //log("demo length "+demo.length.toString());

  }

  @override
  void initState() {
    // TODO: implement initState
    getCartName();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: kWhiteColor,
        centerTitle: true,
        title: Text(
          "Cart",
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
      body: SizedBox(
        child: Container(
          child: ListView.builder(
            itemCount: demo.length,
            itemBuilder: (_,index){
              //var data=demo[index].product_name;
              //return Text(demo[index].productName);
              return Container(
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
                        //ProductSinglePage1
                        onTap: () {
                          //Navigator.push(context, MaterialPageRoute(builder: (context) => GroceryDetails()));
                        },
                        child: Container(
                          height: 120,
                          width: MediaQuery.of(context).size.width/3,
                          child: Image.network(
                            imagePath + demo[index].productThumbnailImage,
                          ),
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
                                child: Text(demo[index].productName,style: TextStyle(
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
                                    "- 1 +",style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.w800),
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

              );


            },
          ),
        ),
      ),

    );
  }
}
*/
/*
import 'dart:convert';
import 'dart:developer';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:http/http.dart' as http;
import 'package:customer_ui/components/styles.dart';
import 'package:customer_ui/components/utils.dart';
import 'package:customer_ui/dataModel/cart_details_model.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';


void main() => runApp(CartDetails());

class CartDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final title = 'Increment Decrement Demo';
    return MaterialApp(
      title: title,
      home: NumberInputWithIncrementDecrement(),
    );
  }
}

class NumberInputWithIncrementDecrement extends StatefulWidget {
  @override
  _NumberInputWithIncrementDecrementState createState() =>
      _NumberInputWithIncrementDecrementState();
}

class _NumberInputWithIncrementDecrementState
    extends State<NumberInputWithIncrementDecrement> {
  TextEditingController _controller = TextEditingController();

  var demo=[];

  Future<void> getCartName() async {
    var res = await http.post(Uri.parse("https://test.protidin.com.bd/api/v2/carts/61"),
        headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8', 'Authorization': 'Bearer $authToken'});
    // log("Response ${res.body}");
    log("Response code ${res.statusCode}");

    var dataMap=jsonDecode(res.body);
    log(dataMap[0].toString());
    var cartModel=CartDetailsModel.fromJson(dataMap[0]);
    demo=cartModel.cartItems;
    log("length ${cartModel.cartItems.length}");
    //demo=dataMap;
    setState(() {

    });
    //log("demo length "+demo.length.toString());

  }


  Future<void> changeQuantity(id, userId, quantity) async {
    var res2 = await http.post(Uri.parse("https://test.protidin.com.bd/api/v2/carts/change-quantity"),
        headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8', 'Authorization': 'Bearer $authToken'},
        body: jsonEncode(<String, dynamic>{"id": id, "variant": "", "user_id": userId, "quantity": quantity}));

    log("Response ${res2.body}");
    log("Response code jhjk ${res2.statusCode}");

    if (res2.statusCode == 200 || res2.statusCode == 201) {
      showToast("Cart Added Successfully", context: context);
    } else {
      showToast("Something went wrong", context: context);
    }
  }


  @override
  void initState() {
    super.initState();
    getCartName();
    _controller.text = "1"; // Setting the initial value for the field.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: kWhiteColor,
        centerTitle: true,
        title: Text(
          "Cart",
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

            Container(
              height: MediaQuery.of(context).size.height/1,
              child: ListView.builder(
                itemCount: demo.length,
                itemBuilder: (_,index){
                  //var data=demo[index].product_name;
                  //return Text(demo[index].productName);
                  return Container(
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
                            //ProductSinglePage1
                            onTap: () {
                              //Navigator.push(context, MaterialPageRoute(builder: (context) => GroceryDetails()));
                            },
                            child: Container(
                              height: 120,
                              width: MediaQuery.of(context).size.width/3,
                              child: Image.network(
                                imagePath + demo[index].productThumbnailImage,
                              ),
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
                                    child: Text(demo[index].productName,style: TextStyle(
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
                                width: MediaQuery.of(context).size.width/4,
                                height: 35,
                                decoration: BoxDecoration(
                                  color: Color(0xFF9900FF),
                                  borderRadius: BorderRadius.circular(20),

                                ),

                                /*
                                Text(
                                        "- 1 +",style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.w800),
                                      ),
                                */
                                child:Container(
                                  //width: 50,
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: <Widget>[

                                    FittedBox(
                                      child: Container(
                                        child: MaterialButton(
                                          child: Icon(Icons.remove,color: Colors.white),
                                          onPressed: () {
                                            int currentValue = int.parse(_controller.text);
                                            setState(() {
                                              currentValue--;
                                              _controller.text =
                                                  (currentValue).toString(); // incrementing value
                                            });
                                          },
                                        ),
                                        width: MediaQuery.of(context).size.width/15,
                                      ),
                                    ),

                                    Padding(
                                      padding: const EdgeInsets.only(left: 25.0),
                                      child: FittedBox(
                                        child: Container(
                                          child: TextFormField(
                                            controller: _controller,style: TextStyle(color: Colors.white),
                                            keyboardType: TextInputType.numberWithOptions(
                                                decimal: false, signed: false),
                                            inputFormatters: <TextInputFormatter>[
                                              WhitelistingTextInputFormatter.digitsOnly
                                            ],
                                          ),
                                          width: MediaQuery.of(context).size.width/15,
                                        ),
                                      ),
                                    ),

                                    FittedBox(
                                      child: Container(
                                        child: MaterialButton(
                                          child: Icon(
                                              Icons.add,color: Colors.white,

                                          ),
                                          onPressed: () {
                                            int currentValue = int.parse(_controller.text);
                                            setState(() {
                                              currentValue++;
                                              _controller.text =
                                                  (currentValue).toString(); // decrementing value
                                            });
                                          },
                                        ),
                                        width: MediaQuery.of(context).size.width/9,
                                      ),
                                    ),

                                 /*
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[


                                    ],
                                  ),
                                  Spacer(
                                    flex: 2,
                                  ),
                                 */


                                  ],
                                ),
                                  ),
                                ),
                              ),
                            ),
                          ),



                        ],
                      ),
                    ),

                  );


                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}



*/