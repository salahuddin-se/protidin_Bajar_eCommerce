import 'package:flutter/cupertino.dart';

class SizeConfig {
  static MediaQueryData? _mediaQueryData;
  static double screenWidth = 0;
  static double screenHeight = 0;
  static double block = 0;
  static Orientation orientation = Orientation.portrait;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData!.size.width;
    screenHeight = _mediaQueryData!.size.height;
    block = screenWidth / 100;
    orientation = _mediaQueryData!.orientation;
  }
}