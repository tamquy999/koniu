import 'dart:io';
import 'dart:math';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_responsive_ui/api_connection/api_connection.dart';
import 'package:flutter_facebook_responsive_ui/config/palette.dart';
import 'package:flutter_facebook_responsive_ui/models/api_model.dart';
import 'package:flutter_facebook_responsive_ui/models/models.dart';
import 'package:flutter_facebook_responsive_ui/screens/account_screen.dart';
import 'package:flutter_facebook_responsive_ui/screens/fullscreen_image.dart';
import 'package:flutter_facebook_responsive_ui/screens/kid_screen.dart';
import 'package:flutter_facebook_responsive_ui/screens/parent_screen.dart';
import 'package:flutter_facebook_responsive_ui/widgets/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jiffy/jiffy.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:path_provider/path_provider.dart';

class CheckinContainer extends StatefulWidget {
  final RefreshCheckinCallback onCreate;
  final Post2 post;

  const CheckinContainer({Key key, this.post, this.onCreate}) : super(key: key);

  @override
  _CheckinContainerState createState() => _CheckinContainerState();
}

class _CheckinContainerState extends State<CheckinContainer> {
  File _image;
  final picker = ImagePicker();

  Future takeImage(bool isDesktop, bool isDen) async {
    final pickedFile = isDesktop
        ? await picker.getImage(source: ImageSource.gallery, maxWidth: 1080.0)
        : await picker.getImage(source: ImageSource.camera, maxWidth: 1080.0);

    // // getting a directory path for saving
    final Directory extDir = await getApplicationDocumentsDirectory();
    String dirPath = extDir.path;
    final String filePath = '$dirPath/image.png';
    print(filePath);
    File(filePath).writeAsString("anc");

    // // copy the file to a new path
    // final File newImage = await _image.copy(filePath);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
        return;
      }
    });

    UploadedImage uimage;
    uploadImage(_image).then((value) {
      uimage = value;
      Post2 tempPost = widget.post;
      isDen
          ? tempPost.diDenImgUrl = uimage.linkImg
          : tempPost.diVeImgUrl = uimage.linkImg;
      updatePost(tempPost).then((value) {
        print(value);
        // setState(() {});
        widget.onCreate();
      });
    });
  }

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
        child: Padding(
          padding: const EdgeInsets.fromLTRB(12.0, 4.0, 12.0, 4.0),
          child: ExpandablePanel(
            header: _PostHeader(post: widget.post),
            collapsed: Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      color: Palette.koniuBlue.withOpacity(0.5),
                      height: isDesktop ? 50.0 : 30.0,
                      child: Center(
                        child: Text(
                          widget.post.thoiGianDen == ""
                              ? "Đến: --:--"
                              : "Đến: ${widget.post.thoiGianDen}",
                          style: TextStyle(color: Colors.white, fontSize: 16.0),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10.0),
                  Expanded(
                    child: Container(
                      color: Palette.koniuBlue.withOpacity(0.5),
                      height: isDesktop ? 50.0 : 30.0,
                      child: Center(
                        child: Text(
                          widget.post.thoiGianVe == ""
                              ? "Về: --:--"
                              : "Về: ${widget.post.thoiGianVe}",
                          style: TextStyle(color: Colors.white, fontSize: 16.0),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            expanded: Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: Container(
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        child: Stack(
                          fit: StackFit.passthrough,
                          alignment: AlignmentDirectional.bottomStart,
                          children: [
                            widget.post.diDenImgUrl == ""
                                ? Container(
                                    color: Colors.black26,
                                    height: isDesktop ? 400.0 : 200.0,
                                    child: Icon(
                                      Icons.add_a_photo_outlined,
                                      size: 50.0,
                                      color: Palette.koniuBlue,
                                    ),
                                  )
                                : Hero(
                                    tag: widget.post.diDenImgUrl,
                                    child: CachedNetworkImage(
                                      imageUrl: widget.post.diDenImgUrl,
                                      height: isDesktop ? 400.0 : 200.0,
                                      fit: BoxFit.cover,
                                      placeholder: (context, url) =>
                                          CircularProgressIndicator(),
                                      errorWidget: (context, url, error) =>
                                          Icon(Icons.error),
                                    ),
                                  ),
                            ClipRect(
                              child: BackdropFilter(
                                filter: new ImageFilter.blur(
                                    sigmaX: 10.0, sigmaY: 10.0),
                                child: Container(
                                  color: Palette.koniuBlue.withOpacity(0.5),
                                  height: isDesktop ? 50.0 : 30.0,
                                  child: Center(
                                    child: Text(
                                      widget.post.thoiGianDen == ""
                                          ? "Đến: --:--"
                                          : "Đến: ${widget.post.thoiGianDen}",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16.0),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        onTap: widget.post.diDenImgUrl != ""
                            ? () {
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //     builder: (_) {
                                //       return FullscreenImage(
                                //           tag: widget.post.diDenImgUrl,
                                //           url: widget.post.diDenImgUrl);
                                //     },
                                //   ),
                                // );
                                Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                    pageBuilder: (c, a1, a2) => FullscreenImage(
                                        tag: widget.post.diDenImgUrl,
                                        url: widget.post.diDenImgUrl),
                                    transitionsBuilder: (c, anim, a2, child) =>
                                        FadeTransition(
                                            opacity: anim, child: child),
                                    // transitionDuration: Duration(milliseconds: 2000),
                                  ),
                                );
                              }
                            : () {
                                print("camera");
                                takeImage(isDesktop, true);
                              },
                      ),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Expanded(
                      child: widget.post.diDenImgUrl == ""
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
                                      color: Palette.koniuBlue.withOpacity(0.5),
                                      height: isDesktop ? 50.0 : 30.0,
                                      child: Center(
                                        child: Text(
                                          "Về: --:--",
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
                                alignment: AlignmentDirectional.bottomStart,
                                children: [
                                  widget.post.diVeImgUrl == ""
                                      ? Container(
                                          color: Colors.black26,
                                          height: isDesktop ? 400.0 : 200.0,
                                          child: Icon(
                                            Icons.add_a_photo_outlined,
                                            size: 50.0,
                                            color: Palette.koniuBlue,
                                          ),
                                        )
                                      : Hero(
                                          tag: widget.post.diVeImgUrl,
                                          child: CachedNetworkImage(
                                            imageUrl: widget.post.diVeImgUrl,
                                            height: isDesktop ? 400.0 : 200.0,
                                            fit: BoxFit.cover,
                                            placeholder: (context, url) =>
                                                CircularProgressIndicator(),
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
                                        color:
                                            Palette.koniuBlue.withOpacity(0.5),
                                        height: isDesktop ? 50.0 : 30.0,
                                        child: Center(
                                          child: Text(
                                            widget.post.thoiGianVe == ""
                                                ? "Về: --:--"
                                                : "Về: ${widget.post.thoiGianVe}",
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
                              onTap: widget.post.diVeImgUrl != ""
                                  ? () {
                                      // Navigator.push(
                                      //   context,
                                      //   MaterialPageRoute(
                                      //     builder: (_) {
                                      //       return FullscreenImage(
                                      //           tag: widget.post.diVeImgUrl,
                                      //           url: widget.post.diVeImgUrl);
                                      //     },
                                      //   ),
                                      // );
                                      Navigator.push(
                                        context,
                                        PageRouteBuilder(
                                          pageBuilder: (c, a1, a2) =>
                                              FullscreenImage(
                                                  tag: widget.post.diVeImgUrl,
                                                  url: widget.post.diVeImgUrl),
                                          transitionsBuilder:
                                              (c, anim, a2, child) =>
                                                  FadeTransition(
                                                      opacity: anim,
                                                      child: child),
                                          // transitionDuration: Duration(milliseconds: 2000),
                                        ),
                                      );
                                    }
                                  : () {
                                      print("camera");
                                      takeImage(isDesktop, false);
                                    },
                            ),
                    ),
                  ],
                ),
              ),
            ),
          ),
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
          ProfileAvatar(imageUrl: post.kidObj.avtUrl),
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

typedef RefreshCheckinCallback = void Function();
