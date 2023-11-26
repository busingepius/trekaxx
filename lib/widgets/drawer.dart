import 'package:flutter/material.dart';

import 'custom_text.dart';

class DrawerA extends StatelessWidget {
  final String text1, text2;
  final Function onTap;

  DrawerA({Key key, this.text1, this.text2, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
              accountName: CustomText(
                text: text1,
                size: 18,
                weight: FontWeight.bold,
              ),
              accountEmail: CustomText(
                text: text2,
              )),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: CustomText(text: "Log out"),
            onTap: onTap,
          )
        ],
      ),
    );
  }
}
