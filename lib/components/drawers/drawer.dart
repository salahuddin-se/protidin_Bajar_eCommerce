import 'package:customer_ui/components/drawers/drawer_class.dart';
import 'package:customer_ui/components/drawers/drawer_class_whenlogout.dart';
import 'package:customer_ui/preferences/user_preferance.dart';
import 'package:flutter/material.dart';

class SelectDrawer extends StatefulWidget {
  const SelectDrawer({Key? key, this.callback}) : super(key: key);
  final VoidCallback? callback;

  @override
  _SelectDrawerState createState() => _SelectDrawerState();
}

class _SelectDrawerState extends State<SelectDrawer> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isLoggedin = UserPreference.getBool(UserPreference.isLoggedIn)!;
    return isLoggedin
        ? UserDrawer(
            callback: widget.callback!,
          )
        : LogoutDrawer();
  }
}
