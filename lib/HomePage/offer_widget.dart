import 'package:flutter/material.dart';

class OfferWidget extends StatelessWidget {

  Color? color;


  OfferWidget({this.color});

  // ${list[index].references
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage("assets/img_37.png"), fit: BoxFit.cover),

        color: color,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 5, //spread radius
            blurRadius: 7, // blur radius
            offset: Offset(0, 2),
          ),
        ],
      ),
      height: 170,
      width: MediaQuery.of(context).size.width / 1.4,
      child: Row(
        children: [

          SizedBox(
            height: 120,
            width: 160,
            child: Image.asset("assets/img_38.png"),
          ),
          Expanded(
            child: SizedBox(
              height: 140,
              width: 150,
              child: Image.asset("assets/img_39.png"),
            ),
          ),
        ],
      ),
    );
  }
}
