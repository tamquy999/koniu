import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_responsive_ui/models/models.dart';
import 'package:flutter_facebook_responsive_ui/screens/account_screen.dart';

class CustomSilverAppbar extends StatelessWidget {
  final User user;

  const CustomSilverAppbar({Key key, this.user}) : super(key: key);

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
            // Navigator.push(
            //   context,
            //   CupertinoPageRoute(
            //     builder: (context) => AccountScreen(),
            //   ),
            // );
            Navigator.pushNamed(context, "/me");
          },
        ),
      ],
    );
  }
}
