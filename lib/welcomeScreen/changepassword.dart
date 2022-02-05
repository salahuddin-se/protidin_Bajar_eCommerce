import 'package:flutter/material.dart';

import 'signupform.dart';
//import 'Language.dart';

class ChangePassword extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<ChangePassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      //backgroundColor: Colors.indigo[50],
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 130,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: Container(
                height: 70,
                width: 340,
                child: Image.asset(
                  "assets/img_20.png",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              height: 75,
            ),
            Center(
              child: Container(
                height: 120,
                width: 330,
                child: Image.asset("assets/img_25.png"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 0.150,
                    color: Colors.cyan,
                  ),
                  //color: Color(0xFFEFFCF9),
                  //color: Color(0xFFEEFAF1),
                  color: Colors.deepPurple[50],
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 5, //spread radius
                      blurRadius: 5, // blur radius
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                width: 320,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                    ),

                    Container(
                      height: 20,
                      width: 25,
                      // child: Image.network(
                      //     "https://www.pngkit.com/png/full/208-2084108_cell-phone-icon-blue.png"
                      // ),
                    ),

                    //Padding(padding: const EdgeInsets.only(right: 30),),

                    Container(
                      child: TextFormField(
                        enabled: false,
                        decoration: InputDecoration(
                          hintText: 'New Password',
                        ),
                      ),
                      width: 260,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 0.150,
                    color: Colors.cyan,
                  ),
                  //color: Color(0xFFEFFCF9),
                  //color: Color(0xFFEEFAF1),
                  color: Colors.deepPurple[50],
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 5, //spread radius
                      blurRadius: 5, // blur radius
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                width: 320,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                    ),

                    Container(
                      height: 20,
                      width: 25,
                      // child: Image.network(
                      //     "https://www.pngkit.com/png/full/208-2084108_cell-phone-icon-blue.png"
                      // ),
                    ),

                    //Padding(padding: const EdgeInsets.only(right: 30),),

                    Container(
                      child: TextFormField(
                        enabled: false,
                        decoration: InputDecoration(
                          hintText: 'Confirm NewPassword',
                        ),
                      ),
                      width: 260,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Container(
              width: 340,
              height: 50,
              decoration: BoxDecoration(
                border: Border.all(
                  width: 0.150,
                  color: Colors.cyan,
                ),
                color: Colors.deepPurpleAccent,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 5, //spread radius
                    blurRadius: 5, // blur radius
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpPage()));
                },
                child: Container(
                  child: Center(
                    child: Text(
                      "Submit",
                      style: TextStyle(color: Colors.white),
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
