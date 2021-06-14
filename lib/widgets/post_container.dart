import 'dart:math';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_responsive_ui/config/palette.dart';
import 'package:flutter_facebook_responsive_ui/models/models.dart';
import 'package:flutter_facebook_responsive_ui/screens/account_screen.dart';
import 'package:flutter_facebook_responsive_ui/screens/fullscreen_image.dart';
import 'package:flutter_facebook_responsive_ui/screens/kid_screen.dart';
import 'package:flutter_facebook_responsive_ui/widgets/widgets.dart';
import 'package:jiffy/jiffy.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class PostContainer extends StatelessWidget {
  final Post2 post;

  const PostContainer({
    Key key,
    @required this.post,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isDesktop = Responsive.isDesktop(context);
    return Card(
      margin: EdgeInsets.symmetric(
        vertical: 5.0,
        // horizontal: isDesktop ? 5.0 : 0.0,
      ),
      elevation: isDesktop ? 1.0 : 0.0,
      shape: isDesktop
          ? RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0))
          : null,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        // color: Colors.white,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _PostHeader(post: post),
                  const SizedBox(height: 4.0),
                  // Text(post.caption),
                  const SizedBox(height: 8.0),
                  post.diDenImgUrl != null
                      ? const SizedBox.shrink()
                      : const SizedBox(height: 6.0),
                ],
              ),
            ),
            post.diDenImgUrl != null
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Container(
                      child: Row(
                        children: [
                          Expanded(
                            child: post.thoiGianDen == ""
                                ? Stack(
                                    fit: StackFit.passthrough,
                                    alignment: AlignmentDirectional.bottomStart,
                                    children: [
                                      Container(
                                        color: Colors.black26,
                                        height: isDesktop ? 400.0 : 200.0,
                                        child: Icon(
                                          MdiIcons.clockOutline,
                                          size: 50.0,
                                          color: Colors.black38,
                                        ),
                                      ),
                                      ClipRect(
                                        child: BackdropFilter(
                                          filter: new ImageFilter.blur(
                                              sigmaX: 10.0, sigmaY: 10.0),
                                          child: Container(
                                            color: Palette.koniuBlue
                                                .withOpacity(0.5),
                                            height: isDesktop ? 50.0 : 30.0,
                                            child: Center(
                                              child: Text(
                                                "Đến: --:--:--",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16.0),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                : GestureDetector(
                                    child: Stack(
                                      fit: StackFit.passthrough,
                                      alignment:
                                          AlignmentDirectional.bottomStart,
                                      children: [
                                        Hero(
                                          tag: post.diDenImgUrl,
                                          child: CachedNetworkImage(
                                            imageUrl: post.diDenImgUrl,
                                            height: isDesktop ? 400.0 : 200.0,
                                            fit: BoxFit.cover,
                                            placeholder: (context, url) => Center(
                                                child:
                                                    CircularProgressIndicator()),
                                            errorWidget:
                                                (context, url, error) =>
                                                    Icon(Icons.error),
                                          ),
                                        ),
                                        ClipRect(
                                          child: BackdropFilter(
                                            filter: new ImageFilter.blur(
                                                sigmaX: 10.0, sigmaY: 10.0),
                                            child: Container(
                                              color: Palette.koniuBlue
                                                  .withOpacity(0.5),
                                              height: isDesktop ? 50.0 : 30.0,
                                              child: Center(
                                                child: Text(
                                                  "Đến: ${post.thoiGianDen}",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16.0),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    onTap: () {
                                      // Navigator.push(
                                      //   context,
                                      //   MaterialPageRoute(
                                      //     builder: (_) {
                                      //       return FullscreenImage(
                                      //           tag: post.diDenImgUrl,
                                      //           url: post.diDenImgUrl);
                                      //     },
                                      //   ),
                                      // );
                                      Navigator.push(
                                        context,
                                        PageRouteBuilder(
                                          pageBuilder: (c, a1, a2) =>
                                              FullscreenImage(
                                                  tag: post.diDenImgUrl,
                                                  url: post.diDenImgUrl),
                                          transitionsBuilder:
                                              (c, anim, a2, child) =>
                                                  FadeTransition(
                                                      opacity: anim,
                                                      child: child),
                                          // transitionDuration: Duration(milliseconds: 2000),
                                        ),
                                      );
                                    },
                                  ),
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          Expanded(
                            child: post.thoiGianVe == ""
                                ? Stack(
                                    fit: StackFit.passthrough,
                                    alignment: AlignmentDirectional.bottomStart,
                                    children: [
                                      Container(
                                        color: Colors.black26,
                                        height: isDesktop ? 400.0 : 200.0,
                                        child: Icon(
                                          MdiIcons.clockOutline,
                                          size: 50.0,
                                          color: Colors.black38,
                                        ),
                                      ),
                                      ClipRect(
                                        child: BackdropFilter(
                                          filter: new ImageFilter.blur(
                                              sigmaX: 10.0, sigmaY: 10.0),
                                          child: Container(
                                            color: Palette.koniuBlue
                                                .withOpacity(0.5),
                                            height: isDesktop ? 50.0 : 30.0,
                                            child: Center(
                                              child: Text(
                                                "Về: --:--:--",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16.0),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                : GestureDetector(
                                    child: Stack(
                                      fit: StackFit.passthrough,
                                      alignment:
                                          AlignmentDirectional.bottomStart,
                                      children: [
                                        Hero(
                                          tag: post.diVeImgUrl,
                                          child: CachedNetworkImage(
                                            imageUrl: post.diVeImgUrl,
                                            height: isDesktop ? 400.0 : 200.0,
                                            fit: BoxFit.cover,
                                            placeholder: (context, url) => Center(
                                                child:
                                                    CircularProgressIndicator()),
                                            errorWidget:
                                                (context, url, error) =>
                                                    Icon(Icons.error),
                                          ),
                                        ),
                                        ClipRect(
                                          child: BackdropFilter(
                                            filter: new ImageFilter.blur(
                                                sigmaX: 10.0, sigmaY: 10.0),
                                            child: Container(
                                              color: Palette.koniuBlue
                                                  .withOpacity(0.5),
                                              height: isDesktop ? 50.0 : 30.0,
                                              child: Center(
                                                child: Text(
                                                  "Về: ${post.thoiGianVe}",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16.0),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    onTap: () {
                                      // Navigator.push(
                                      //   context,
                                      //   MaterialPageRoute(
                                      //     builder: (_) {
                                      //       return FullscreenImage(
                                      //           tag: post.diVeImgUrl,
                                      //           url: post.diVeImgUrl);
                                      //     },
                                      //   ),
                                      // );
                                      Navigator.push(
                                        context,
                                        PageRouteBuilder(
                                          pageBuilder: (c, a1, a2) =>
                                              FullscreenImage(
                                                  tag: post.diVeImgUrl,
                                                  url: post.diVeImgUrl),
                                          transitionsBuilder:
                                              (c, anim, a2, child) =>
                                                  FadeTransition(
                                                      opacity: anim,
                                                      child: child),
                                          // transitionDuration: Duration(milliseconds: 2000),
                                        ),
                                      );
                                    },
                                  ),
                          ),
                        ],
                      ),
                    ),
                  )
                : const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}

class _PostHeader extends StatelessWidget {
  final Post2 post;

  const _PostHeader({
    Key key,
    @required this.post,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // void _showPopupMenu(Offset offset) async {
    //   double left = offset.dx;
    //   double top = offset.dy;
    //   await showMenu(
    //     context: context,
    //     position: RelativeRect.fromLTRB(left, top, 0, 0),
    //     items: [
    //       PopupMenuItem<String>(child: AccountScreen(), value: 'Doge'),
    //       PopupMenuItem<String>(child: const Text('Lion'), value: 'Lion'),
    //     ],
    //     elevation: 8.0,
    //   );
    // }

    return GestureDetector(
      onTap: () {
        // Navigator.push(
        //   context,
        //   CupertinoPageRoute(
        //     builder: (context) => KidScreen(
        //       idHS: post.idHocSinh.toString(),
        //     ),
        //   ),
        // );
        Navigator.pushNamed(context, '/kid/${post.idHocSinh.toString()}');
      },
      child: Row(
        children: [
          ProfileAvatar(
            imageUrl: post.kidObj.avtUrl,
          ),
          const SizedBox(width: 8.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  post.kidObj.hoTen,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      Jiffy(post.ngay).format("dd/MM/yyyy"),
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 12.0,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // GestureDetector(
          //   child: const Icon(Icons.more_horiz),
          //   onTapDown: (TapDownDetails details) {
          //     _showPopupMenu(details.globalPosition);
          //   },
          // ),
        ],
      ),
    );
  }
}
