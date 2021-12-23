import 'package:customer_ui/components/styles.dart';
import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final double? height;
  final double? width;
  final Widget? child;
  final VoidCallback? callback;

  ButtonWidget({this.height, this.width, this.child, this.callback});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: kPrimaryColor,
      onPressed: callback,
      height: height! * 0.06,
      minWidth: width,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      child: child,
    );
  }
}