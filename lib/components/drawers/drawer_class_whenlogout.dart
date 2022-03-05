import 'package:customer_ui/welcomeScreen/sigininform.dart';
import 'package:flutter/material.dart';

// Drawer buildDrawerClassWhenLogout(BuildContext context, double block, {VoidCallback? callback}) {
//   return Drawer(
//     child:Column(
//       children: [
//         SizedBox(
//           height: 20,
//         ),
//         Container(
//           height: MediaQuery.of(context).size.height / 1.38,
//           color: Color(0xFF9900FF),
//           child: Column(
//             children: [
//               SizedBox(
//                 height: 20,
//               ),
//               Padding(
//                 padding: const EdgeInsets.fromLTRB(10, 5, 20, 0),
//                 child: InkWell(
//                   onTap: () {
//                     Navigator.pop(context);
//                   },
//                   child: Align(
//                     alignment: Alignment.topRight,
//                     child: Container(
//                       //color: Colors.white,
//                       //height: 40,
//                       width: 40,
//                       child: Image.asset(
//                         "assets/img_186.png",
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: 20,
//               ),
//               Container(
//                 //color: Colors.white,
//                 height: MediaQuery.of(context).size.height / 3.5,
//                 width: MediaQuery.of(context).size.width / 1.5,
//                 child: Image.asset(
//                   "assets/img_199.png",
//                   //color: Colors.white,
//                 ),
//               ),
//               SizedBox(
//                 height: 30,
//               ),
//               Text(
//                 "Still have log in yet ?",
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 22,
//                   fontWeight: FontWeight.w700,
//                   fontFamily: 'CeraProMedium',
//                 ),
//               ),
//               SizedBox(
//                 height: 5,
//               ),
//               Text(
//                 "Log in to get all your favourite items\n and exciting offers",
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 13,
//                   fontWeight: FontWeight.w400,
//                   fontFamily: 'CeraProMedium',
//                 ),
//                 textAlign: TextAlign.center,
//               ),
//               SizedBox(
//                 height: 25,
//               ),
//               InkWell(
//                 onTap: () {
//                   //Navigator.push(context, MaterialPageRoute(builder: (context) => SignInPage()));
//                 },
//                 child: Container(
//                   decoration: BoxDecoration(
//                     border: Border.all(color: Colors.white, width: 2),
//                     borderRadius: BorderRadius.circular(20.0),
//                   ),
//                   height: 35,
//                   width: 100,
//                   child: Center(
//                     child: Text(
//                       "Log in",
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 15,
//                         fontWeight: FontWeight.w700,
//                         fontFamily: 'CeraProMedium',
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//         SizedBox(
//           height: 20,
//         ),
//         Container(
//           width: MediaQuery.of(context).size.width / 1.5,
//           child: Row(
//             children: [
//               Container(
//                 //color: Colors.white,
//                 height: 20,
//                 width: 20,
//                 child: Image.asset(
//                   "assets/img_149.png",
//                   color: Color(0xFF9900FF),
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.fromLTRB(45, 0, 0, 0),
//               ),
//               Text(
//                 'Track Order',
//                 style: TextStyle(
//                   fontSize: 15,
//                   fontWeight: FontWeight.w500,
//                   fontFamily: "CeraProBold",
//                   color: Color(0xFF515151),
//                 ),
//               ),
//             ],
//           ),
//         ),
//         SizedBox(
//           height: 15,
//         ),
//         Divider(
//           color: Colors.grey[400],
//           thickness: 1,
//         ),
//         SizedBox(
//           height: 15,
//         ),
//         Align(
//           alignment: Alignment.centerLeft,
//           child: Padding(
//             padding: const EdgeInsets.only(left: 40.0),
//             child: Text(
//               "Help Center",
//               style: TextStyle(
//                 color: Color(0xFF515151),
//                 fontSize: 12,
//                 fontWeight: FontWeight.w400,
//                 fontFamily: 'CeraProMedium',
//               ),
//               textAlign: TextAlign.center,
//             ),
//           ),
//         ),
//         SizedBox(
//           height: 15,
//         ),
//         Align(
//           alignment: Alignment.centerLeft,
//           child: Padding(
//             padding: const EdgeInsets.only(left: 40.0),
//             child: Text(
//               "Settings",
//               style: TextStyle(
//                 color: Color(0xFF515151),
//                 fontSize: 12,
//                 fontWeight: FontWeight.w400,
//                 fontFamily: 'CeraProMedium',
//               ),
//               textAlign: TextAlign.center,
//             ),
//           ),
//         ),
//         SizedBox(
//           height: 15,
//         ),
//         Align(
//           alignment: Alignment.centerLeft,
//           child: Padding(
//             padding: const EdgeInsets.only(left: 40.0),
//             child: Text(
//               "Terms & condition / Privacy",
//               style: TextStyle(
//                 color: Color(0xFF515151),
//                 fontSize: 12,
//                 fontWeight: FontWeight.w400,
//                 fontFamily: 'CeraProMedium',
//               ),
//               textAlign: TextAlign.center,
//             ),
//           ),
//         ),
//       ],
//     ),
//   );
// }

class LogoutDrawer extends StatefulWidget {
  const LogoutDrawer({Key? key}) : super(key: key);

  @override
  _LogoutDrawerState createState() => _LogoutDrawerState();
}

class _LogoutDrawerState extends State<LogoutDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          SizedBox(
            height: 0,
          ),
          Container(
            //height: MediaQuery.of(context).size.height / 1.38,
            height: MediaQuery.of(context).size.height / 1.5,
            color: Color(0xFF9900FF),
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 5, 20, 0),
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Align(
                      alignment: Alignment.topRight,
                      child: Container(
                        //color: Colors.white,
                        //height: 40,
                        width: 40,
                        child: Image.asset(
                          "assets/img_186.png",
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  //color: Colors.white,
                  height: MediaQuery.of(context).size.height / 3.5,
                  width: MediaQuery.of(context).size.width / 1.5,
                  child: Image.asset(
                    "assets/img_199.png",
                    //color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  "Still have log in yet ?",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'CeraProMedium',
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "Log in to get all your favourite items\n and exciting offers",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'CeraProMedium',
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 25,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => SignInPage()));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white, width: 2),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    height: 35,
                    width: 100,
                    child: Center(
                      child: Text(
                        "Log in",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'CeraProMedium',
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Container(
            width: MediaQuery.of(context).size.width / 1.5,
            child: Row(
              children: [
                Container(
                  //color: Colors.white,
                  height: 20,
                  width: 20,
                  child: Image.asset(
                    "assets/img_149.png",
                    color: Color(0xFF9900FF),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(45, 0, 0, 0),
                ),
                Text(
                  'Track Order',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    fontFamily: "CeraProBold",
                    color: Color(0xFF515151),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Divider(
            color: Colors.grey[400],
            thickness: 1,
          ),
          SizedBox(
            height: 15,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 40.0),
              child: Text(
                "Help Center",
                style: TextStyle(
                  color: Color(0xFF515151),
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'CeraProMedium',
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 40.0),
              child: Text(
                "Settings",
                style: TextStyle(
                  color: Color(0xFF515151),
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'CeraProMedium',
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 40.0),
              child: Text(
                "Terms & condition / Privacy",
                style: TextStyle(
                  color: Color(0xFF515151),
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'CeraProMedium',
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
