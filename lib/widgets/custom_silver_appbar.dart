import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_responsive_ui/parents_screens/screens.dart';

class CustomSilverAppbar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      brightness: Brightness.light,
      backgroundColor: Colors.white,
      title: Hero(
        tag: "logo",
        child: Image.asset(
          "assets/images/TextOnly.png",
          height: 25.0,
        ),
      ),
      // title: Image(
      //   image: AssetImage("assets/images/TextOnly.png"),
      // ),
      centerTitle: false,
      floating: true,
      actions: [
        IconButton(
          icon: Icon(Icons.account_circle),
          iconSize: 30.0,
          color: Colors.black45,
          onPressed: () {
            Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) => AccountScreen(),
              ),
            );
          },
        ),
      ],
    );
  }
}
