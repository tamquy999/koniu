import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facebook_responsive_ui/api_connection/api_connection.dart';
import 'package:flutter_facebook_responsive_ui/bloc/authentication_bloc.dart';
import 'package:flutter_facebook_responsive_ui/config/palette.dart';
import 'package:flutter_facebook_responsive_ui/models/kidInfo_model.dart';
import 'package:flutter_facebook_responsive_ui/models/models.dart';
import 'package:flutter_facebook_responsive_ui/screens/parent_screen.dart';
import 'package:flutter_facebook_responsive_ui/screens/teacher_screen.dart';
import 'package:flutter_facebook_responsive_ui/widgets/widgets.dart';
import 'package:jiffy/jiffy.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class KidScreen extends StatefulWidget {
  final String idHS;

  const KidScreen({Key key, @required this.idHS}) : super(key: key);

  @override
  _KidScreenState createState() => _KidScreenState();
}

class _KidScreenState extends State<KidScreen> {
  KidInfo kid;
  User _user;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrUser();
  }

  Future<String> getCurrHS() async {
    getKid(widget.idHS).then((val) {
      kid = val;
      setState(() {});
      print(val);
    }).catchError((error, stackTrace) {
      print("outer: $error");
    });
    return "succes";
  }

  Future<String> getCurrUser() async {
    getUser().then((val) {
      _user = val;
      setState(() {});
      print(val);
      getCurrHS();
    }).catchError((error, stackTrace) {
      print("outer: $error");
    });
    return "succes";
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Responsive(
          mobile: _MobileKidScreen(user: _user, kid: kid),
          desktop: _DesktopKidScreen(user: _user, kid: kid),
        ),
      ),
    );
  }
}

class _MobileKidScreen extends StatefulWidget {
  final User user;
  final KidInfo kid;

  const _MobileKidScreen({Key key, @required this.kid, @required this.user})
      : super(key: key);

  @override
  __MobileKidScreenState createState() => __MobileKidScreenState();
}

class __MobileKidScreenState extends State<_MobileKidScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        iconTheme: IconThemeData(
          color: Colors.black45, //change your color here
        ),
        backgroundColor: Colors.white,
        // title: Text(
        //   "Tài khoản",
        //   style: TextStyle(color: Palette.koniuBlue),
        // ),
        // centerTitle: true,
      ),
      body: widget.kid == null
          ? LoadingIndicator()
          : SingleChildScrollView(
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 20.0),
                        CachedNetworkImage(
                          imageUrl: widget.kid.avtUrl,
                          imageBuilder: (context, imageProvider) => Container(
                            width: 120.0,
                            height: 120.0,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: imageProvider, fit: BoxFit.cover),
                            ),
                          ),
                          placeholder: (context, url) =>
                              CircularProgressIndicator(),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                        ),
                        SizedBox(height: 10.0),
                        Text(
                          widget.kid.hoTen,
                          style: TextStyle(
                              fontSize: 20.0, fontWeight: FontWeight.w400),
                        ),
                        // SizedBox(height: 5.0),
                        // Text("username: ${_user.username}"),
                        // SizedBox(height: 5.0),
                        // if (_user.quyen == 1) Text("Giáo viên"),
                        // if (_user.quyen == 2) Text("Phụ huynh"),
                        SizedBox(height: 20.0),
                        Container(
                          color: Colors.white,
                          // height: 80.0,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 10.0),
                            child: Column(
                              children: [
                                Container(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    "Thông tin",
                                    style: TextStyle(color: Palette.koniuBlue),
                                  ),
                                ),
                                SizedBox(height: 15.0),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        children: [
                                          Container(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              Jiffy(widget.kid.ngaySinh)
                                                  .format("dd/MM/yyyy"),
                                              style: TextStyle(fontSize: 16.0),
                                            ),
                                          ),
                                          SizedBox(height: 5.0),
                                          Container(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              "Ngày sinh",
                                              style: TextStyle(
                                                fontSize: 12.0,
                                                color: Colors.black45,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 15.0),
                                widget.user.quyen == 1
                                    ? Row(
                                        children: [
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    Navigator.push(
                                                      context,
                                                      CupertinoPageRoute(
                                                        builder: (context) =>
                                                            ParentScreen(
                                                          idPH: widget.kid.idPh
                                                              .toString(),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50.0),
                                                    child: CachedNetworkImage(
                                                        height: 50.0,
                                                        width: 50.0,
                                                        fit: BoxFit.fill,
                                                        imageUrl:
                                                            widget.kid.avtUrl),
                                                  ),
                                                ),
                                                SizedBox(height: 5.0),
                                                Container(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    "Phụ huynh",
                                                    style: TextStyle(
                                                      fontSize: 12.0,
                                                      color: Colors.black45,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      )
                                    : Row(
                                        children: [
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  height: 50.0,
                                                  child: ListView.builder(
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    itemCount: widget
                                                        .kid.listGv.length,
                                                    itemBuilder:
                                                        (BuildContext context,
                                                            int index) {
                                                      final ListGV listgv =
                                                          widget.kid
                                                              .listGv[index];
                                                      return Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                right: 10.0),
                                                        child: GestureDetector(
                                                          onTap: () {
                                                            Navigator.push(
                                                              context,
                                                              CupertinoPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        TeacherScreen(
                                                                  idGV: listgv
                                                                      .id
                                                                      .toString(),
                                                                ),
                                                              ),
                                                            );
                                                          },
                                                          child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        50.0),
                                                            child: CachedNetworkImage(
                                                                height: 50.0,
                                                                width: 50.0,
                                                                fit:
                                                                    BoxFit.fill,
                                                                imageUrl: listgv
                                                                    .avtUrl),
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ),
                                                SizedBox(height: 5.0),
                                                Container(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    "Giáo viên",
                                                    style: TextStyle(
                                                      fontSize: 12.0,
                                                      color: Colors.black45,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                // lít
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}

class _DesktopKidScreen extends StatefulWidget {
  final User user;
  final KidInfo kid;

  const _DesktopKidScreen({Key key, @required this.kid, @required this.user})
      : super(key: key);

  @override
  __DesktopKidScreenState createState() => __DesktopKidScreenState();
}

class __DesktopKidScreenState extends State<_DesktopKidScreen> {
  @override
  Widget build(BuildContext context) {
    final bool isDesktop = Responsive.isDesktop(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        iconTheme: IconThemeData(
          color: Colors.black45, //change your color here
        ),
        backgroundColor: Colors.white,
        // title: Text(
        //   "Tài khoản",
        //   style: TextStyle(color: Palette.koniuBlue),
        // ),
        // centerTitle: true,
      ),
      body: widget.kid == null
          ? LoadingIndicator()
          : SingleChildScrollView(
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 20.0),
                        CachedNetworkImage(
                          imageUrl: widget.kid.avtUrl,
                          imageBuilder: (context, imageProvider) => Container(
                            width: 120.0,
                            height: 120.0,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: imageProvider, fit: BoxFit.cover),
                            ),
                          ),
                          placeholder: (context, url) =>
                              CircularProgressIndicator(),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                        ),
                        SizedBox(height: 10.0),
                        Text(
                          widget.kid.hoTen,
                          style: TextStyle(
                              fontSize: 20.0, fontWeight: FontWeight.w400),
                        ),
                        // SizedBox(height: 5.0),
                        // Text("username: ${_user.username}"),
                        // SizedBox(height: 5.0),
                        // if (_user.quyen == 1) Text("Giáo viên"),
                        // if (_user.quyen == 2) Text("Phụ huynh"),
                        SizedBox(height: 20.0),
                        Card(
                          margin: EdgeInsets.symmetric(
                            vertical: 5.0,
                            // horizontal: isDesktop ? 5.0 : 0.0,
                          ),
                          elevation: isDesktop ? 1.0 : 0.0,
                          shape: isDesktop
                              ? RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0))
                              : null,
                          child: Container(
                            width: isDesktop ? 600.0 : 0,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 10.0),
                              child: Column(
                                children: [
                                  Container(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      "Thông tin",
                                      style:
                                          TextStyle(color: Palette.koniuBlue),
                                    ),
                                  ),
                                  SizedBox(height: 15.0),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          children: [
                                            Container(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                Jiffy(widget.kid.ngaySinh)
                                                    .format("dd/MM/yyyy"),
                                                style:
                                                    TextStyle(fontSize: 16.0),
                                              ),
                                            ),
                                            SizedBox(height: 5.0),
                                            Container(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                "Ngày sinh",
                                                style: TextStyle(
                                                  fontSize: 12.0,
                                                  color: Colors.black45,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 15.0),
                                  widget.user.quyen == 1
                                      ? Row(
                                          children: [
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {
                                                      Navigator.push(
                                                        context,
                                                        CupertinoPageRoute(
                                                          builder: (context) =>
                                                              ParentScreen(
                                                            idPH: widget
                                                                .kid.idPh
                                                                .toString(),
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50.0),
                                                      child: CachedNetworkImage(
                                                          height: 50.0,
                                                          width: 50.0,
                                                          fit: BoxFit.fill,
                                                          imageUrl: widget
                                                              .kid.avtUrl),
                                                    ),
                                                  ),
                                                  SizedBox(height: 5.0),
                                                  Container(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Text(
                                                      "Phụ huynh",
                                                      style: TextStyle(
                                                        fontSize: 12.0,
                                                        color: Colors.black45,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        )
                                      : Row(
                                          children: [
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    height: 50.0,
                                                    child: ListView.builder(
                                                      scrollDirection:
                                                          Axis.horizontal,
                                                      itemCount: widget
                                                          .kid.listGv.length,
                                                      itemBuilder:
                                                          (BuildContext context,
                                                              int index) {
                                                        final ListGV listgv =
                                                            widget.kid
                                                                .listGv[index];
                                                        return Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  right: 10.0),
                                                          child:
                                                              GestureDetector(
                                                            onTap: () {
                                                              Navigator.push(
                                                                context,
                                                                CupertinoPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          TeacherScreen(
                                                                    idGV: listgv
                                                                        .id
                                                                        .toString(),
                                                                  ),
                                                                ),
                                                              );
                                                            },
                                                            child: ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          50.0),
                                                              child: CachedNetworkImage(
                                                                  height: 50.0,
                                                                  width: 50.0,
                                                                  fit: BoxFit
                                                                      .fill,
                                                                  imageUrl: listgv
                                                                      .avtUrl),
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                  SizedBox(height: 5.0),
                                                  Container(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Text(
                                                      "Giáo viên",
                                                      style: TextStyle(
                                                        fontSize: 12.0,
                                                        color: Colors.black45,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                  // lít
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
