import 'dart:io';
import 'dart:math';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_responsive_ui/api_connection/api_connection.dart';
import 'package:flutter_facebook_responsive_ui/config/palette.dart';
import 'package:flutter_facebook_responsive_ui/models/api_model.dart';
import 'package:flutter_facebook_responsive_ui/models/models.dart';
import 'package:flutter_facebook_responsive_ui/parents_screens/screens.dart';
import 'package:flutter_facebook_responsive_ui/widgets/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:path_provider/path_provider.dart';

class CheckinContainer extends StatefulWidget {
  final Post post;

  const CheckinContainer({Key key, this.post}) : super(key: key);

  @override
  _CheckinContainerState createState() => _CheckinContainerState();
}

class _CheckinContainerState extends State<CheckinContainer> {
  File _image;
  final picker = ImagePicker();

  Future takeImage() async {
    final pickedFile =
        await picker.getImage(source: ImageSource.camera, maxWidth: 1080.0);

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
      }
    });

    // ImageName uimage = await uploadImage(_image);
    // print(uimage.imageName);
  }

  @override
  Widget build(BuildContext context) {
    final _chars = 'abcdefghijklmnopqrstuvwxyz';
    Random _rnd = Random();

    String getRandomString(int length) =>
        String.fromCharCodes(Iterable.generate(
            length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

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
                          "Đến: --:--",
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
                          "Về: --:--",
                          style: TextStyle(color: Colors.white, fontSize: 16.0),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            expanded: widget.post.inImg != null
                ? Padding(
                    padding: const EdgeInsets.only(top: 15.0),
                    child: Container(
                      child: Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              child: Hero(
                                tag: "abcd",
                                child: Stack(
                                  fit: StackFit.passthrough,
                                  alignment: AlignmentDirectional.bottomStart,
                                  children: [
                                    Container(
                                      color: Colors.black26,
                                      height: 200.0,
                                      child: Icon(
                                        Icons.add_a_photo_outlined,
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
                                              "Đến: --:--",
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
                              ),
                              onTap: _image != null
                                  ? () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) {
                                            return FullscreenImage(
                                                tag: "abc",
                                                url: widget.post.inImg);
                                          },
                                        ),
                                      );
                                    }
                                  : () {
                                      print("camera");
                                      takeImage();
                                    },
                            ),
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          Expanded(
                            child: GestureDetector(
                              child: Hero(
                                tag: "abcd",
                                child: Stack(
                                  fit: StackFit.passthrough,
                                  alignment: AlignmentDirectional.bottomStart,
                                  children: [
                                    Container(
                                      color: Colors.black26,
                                      height: 200.0,
                                      child: Icon(
                                        Icons.add_a_photo_outlined,
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
                                ),
                              ),
                              onTap: () {
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //     builder: (_) {
                                //       return FullscreenImage(
                                //           tag: "abc", url: widget.post.inImg);
                                //     },
                                //   ),
                                // );
                                print("camera");
                                takeImage();
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : const SizedBox.shrink(),
          ),
        ),
        // child: Column(
        //   children: [
        //     Padding(
        //       padding: const EdgeInsets.symmetric(horizontal: 12.0),
        //       child: Column(
        //         crossAxisAlignment: CrossAxisAlignment.stretch,
        //         children: [
        //           _PostHeader(post: widget.post),
        //           const SizedBox(height: 4.0),
        //           // Text(widget.post.caption),
        //           const SizedBox(height: 8.0),
        //           widget.post.inImg != null
        //               ? const SizedBox.shrink()
        //               : const SizedBox(height: 6.0),
        //         ],
        //       ),
        //     ),
        //     widget.post.inImg != null
        //         ? Padding(
        //             padding: const EdgeInsets.symmetric(horizontal: 10.0),
        //             child: Container(
        //               child: Row(
        //                 children: [
        //                   Expanded(
        //                     child: GestureDetector(
        //                       child: Hero(
        //                         tag: "abcd",
        //                         child: Stack(
        //                           fit: StackFit.passthrough,
        //                           alignment: AlignmentDirectional.bottomStart,
        //                           children: [
        //                             Container(
        //                               color: Colors.black26,
        //                               height: 200.0,
        //                               child: Icon(
        //                                 Icons.add_a_photo_outlined,
        //                                 size: 50.0,
        //                                 color: Colors.black38,
        //                               ),
        //                             ),
        //                             ClipRect(
        //                               child: BackdropFilter(
        //                                 filter: new ImageFilter.blur(
        //                                     sigmaX: 10.0, sigmaY: 10.0),
        //                                 child: Container(
        //                                   color: Palette.koniuBlue
        //                                       .withOpacity(0.5),
        //                                   height: isDesktop ? 50.0 : 30.0,
        //                                   child: Center(
        //                                     child: Text(
        //                                       "Đến",
        //                                       style: TextStyle(
        //                                           color: Colors.white,
        //                                           fontSize: 16.0),
        //                                     ),
        //                                   ),
        //                                 ),
        //                               ),
        //                             ),
        //                           ],
        //                         ),
        //                       ),
        //                       onTap: _image != null
        //                           ? () {
        //                               Navigator.push(
        //                                 context,
        //                                 MaterialPageRoute(
        //                                   builder: (_) {
        //                                     return FullscreenImage(
        //                                         tag: "abc",
        //                                         url: widget.post.inImg);
        //                                   },
        //                                 ),
        //                               );
        //                             }
        //                           : () {
        //                               print("camera");
        //                               takeImage();
        //                             },
        //                     ),
        //                   ),
        //                   SizedBox(
        //                     width: 10.0,
        //                   ),
        //                   Expanded(
        //                     child: GestureDetector(
        //                       child: Hero(
        //                         tag: "abcd",
        //                         child: Stack(
        //                           fit: StackFit.passthrough,
        //                           alignment: AlignmentDirectional.bottomStart,
        //                           children: [
        //                             Container(
        //                               color: Colors.black26,
        //                               height: 200.0,
        //                               child: Icon(
        //                                 Icons.add_a_photo_outlined,
        //                                 size: 50.0,
        //                                 color: Colors.black38,
        //                               ),
        //                             ),
        //                             ClipRect(
        //                               child: BackdropFilter(
        //                                 filter: new ImageFilter.blur(
        //                                     sigmaX: 10.0, sigmaY: 10.0),
        //                                 child: Container(
        //                                   color: Palette.koniuBlue
        //                                       .withOpacity(0.5),
        //                                   height: isDesktop ? 50.0 : 30.0,
        //                                   child: Center(
        //                                     child: Text(
        //                                       "Về",
        //                                       style: TextStyle(
        //                                           color: Colors.white,
        //                                           fontSize: 16.0),
        //                                     ),
        //                                   ),
        //                                 ),
        //                               ),
        //                             ),
        //                           ],
        //                         ),
        //                       ),
        //                       onTap: () {
        //                         // Navigator.push(
        //                         //   context,
        //                         //   MaterialPageRoute(
        //                         //     builder: (_) {
        //                         //       return FullscreenImage(
        //                         //           tag: "abc", url: widget.post.inImg);
        //                         //     },
        //                         //   ),
        //                         // );
        //                         print("camera");
        //                         takeImage();
        //                       },
        //                     ),
        //                   ),
        //                 ],
        //               ),
        //             ),
        //           )
        //         : const SizedBox.shrink(),
        //   ],
        // ),
      ),
    );
  }
}

class _PostHeader extends StatelessWidget {
  final Post post;

  const _PostHeader({
    Key key,
    @required this.post,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void _showPopupMenu(Offset offset) async {
      double left = offset.dx;
      double top = offset.dy;
      await showMenu(
        context: context,
        position: RelativeRect.fromLTRB(left, top, 0, 0),
        items: [
          PopupMenuItem<String>(child: AccountScreen(), value: 'Doge'),
          PopupMenuItem<String>(child: const Text('Lion'), value: 'Lion'),
        ],
        elevation: 8.0,
      );
    }

    return Row(
      children: [
        ProfileAvatar(imageUrl: post.kid.imageUrl),
        const SizedBox(width: 8.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                post.kid.name,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
              Row(
                children: [
                  Text(
                    post.date,
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
    );
  }
}
