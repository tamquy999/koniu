import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_facebook_responsive_ui/api_connection/api_connection.dart';
import 'package:flutter_facebook_responsive_ui/config/palette.dart';
import 'package:flutter_facebook_responsive_ui/models/models.dart';
import 'package:flutter_facebook_responsive_ui/screens/account_screen.dart';
import 'package:flutter_facebook_responsive_ui/widgets/widgets.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class CustomAppBar extends StatefulWidget {
  final List<IconData> icons;
  final int selectedIndex;
  final Function(int) onTap;

  const CustomAppBar({
    Key key,
    @required this.icons,
    @required this.selectedIndex,
    @required this.onTap,
  }) : super(key: key);
  @override
  _CustomAppBarState createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  User currentUser;
  @override
  void initState() {
    // TODO: implement initState
    getUser().then((value) {
      currentUser = value;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final Image textOnly = Image.asset(
      "assets/images/TextOnly.png",
      height: 35.0,
    );
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      height: 65.0,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(0, 2),
            blurRadius: 4.0,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
              child: Container(
            margin: const EdgeInsets.all(6.0),
            alignment: Alignment.centerLeft,
            child: textOnly,
          )),
          Container(
            height: double.infinity,
            width: 800.0,
            child: CustomTabBar(
              icons: widget.icons,
              selectedIndex: widget.selectedIndex,
              onTap: widget.onTap,
              isBottomIndicator: true,
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () {
                      // Navigator.push(
                      //   context,
                      //   CupertinoPageRoute(
                      //     builder: (context) => AccountScreen(),
                      //   ),
                      // );
                      Navigator.pushNamed(context, "/me");
                    },
                    child: Container(
                      color: Colors.white,
                      child: currentUser == null
                          ? LoadingIndicator()
                          : Row(
                              children: [
                                Text(
                                  currentUser.hoten,
                                  style: TextStyle(fontSize: 16.0),
                                ),
                                SizedBox(width: 15.0),
                                CachedNetworkImage(
                                  imageUrl: currentUser.avturl,
                                  imageBuilder: (context, imageProvider) =>
                                      Container(
                                    width: 40.0,
                                    height: 40.0,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                          image: imageProvider,
                                          fit: BoxFit.cover),
                                    ),
                                  ),
                                  placeholder: (context, url) =>
                                      CircularProgressIndicator(),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                                ),
                              ],
                            ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
