import 'package:flutter/material.dart';
import 'package:flutter_facebook_responsive_ui/config/palette.dart';

class MoreScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black45, //change your color here
        ),
        backgroundColor: Colors.white,
        title: Text(
          "More",
          style: TextStyle(color: Palette.koniuBlue),
        ),
        centerTitle: true,
      ),
    );
  }
}
