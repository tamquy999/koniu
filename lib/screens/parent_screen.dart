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
import 'package:flutter_facebook_responsive_ui/models/parentInfo_model.dart';
import 'package:flutter_facebook_responsive_ui/screens/kid_screen.dart';
import 'package:flutter_facebook_responsive_ui/widgets/widgets.dart';
import 'package:jiffy/jiffy.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class ParentScreen extends StatefulWidget {
  final String idPH;

  const ParentScreen({Key key, this.idPH}) : super(key: key);

  @override
  _ParentScreenState createState() => _ParentScreenState();
}

class _ParentScreenState extends State<ParentScreen> {
  ParentInfo parent;
  User _user;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrUser();
  }

  Future<String> getCurrPH(String idPH) async {
    getParent(idPH).then((val) {
      parent = val;
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
      print(_user.id);
      widget.idPH != null
          ? getCurrPH(widget.idPH)
          : getCurrPH(_user.id.toString());
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
          mobile: _MobileParentScreen(user: _user, parent: parent),
          desktop: _DesktopParentScreen(user: _user, parent: parent),
        ),
      ),
    );
  }
}

class _MobileParentScreen extends StatefulWidget {
  final User user;
  final ParentInfo parent;

  const _MobileParentScreen(
      {Key key, @required this.parent, @required this.user})
      : super(key: key);

  @override
  __MobileParentScreenState createState() => __MobileParentScreenState();
}

class __MobileParentScreenState extends State<_MobileParentScreen> {
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
      body: widget.parent == null
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
                          imageUrl: widget.parent.avtUrl,
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
                          widget.parent.hoTen,
                          style: TextStyle(
                              fontSize: 20.0, fontWeight: FontWeight.w400),
                        ),
                        SizedBox(height: 5.0),
                        Text("username: ${widget.parent.username}"),
                        SizedBox(height: 5.0),
                        Text("Phụ huynh"),
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
                                              widget.parent.sdt,
                                              style: TextStyle(fontSize: 16.0),
                                            ),
                                          ),
                                          SizedBox(height: 5.0),
                                          Container(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              "Số điện thoại",
                                              style: TextStyle(
                                                fontSize: 12.0,
                                                color: Colors.black45,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    GestureDetector(
                                      child: Icon(Icons.message),
                                      onTap: () =>
                                          launch("sms://${widget.parent.sdt}"),
                                    ),
                                    SizedBox(width: 20.0),
                                    GestureDetector(
                                      child: Icon(Icons.phone),
                                      onTap: () =>
                                          launch("tel://${widget.parent.sdt}"),
                                    ),
                                  ],
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
                                              widget.parent.diaChi,
                                              style: TextStyle(fontSize: 16.0),
                                            ),
                                          ),
                                          SizedBox(height: 5.0),
                                          Container(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              "Địa chỉ",
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
                                Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            height: 50.0,
                                            child: ListView.builder(
                                              scrollDirection: Axis.horizontal,
                                              itemCount:
                                                  widget.parent.listKid.length,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                final ListKid listkid = widget
                                                    .parent.listKid[index];
                                                return Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 10.0),
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      Navigator.push(
                                                        context,
                                                        CupertinoPageRoute(
                                                          builder: (context) =>
                                                              KidScreen(
                                                            idHS: listkid.id
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
                                                              listkid.avtUrl),
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                          SizedBox(height: 5.0),
                                          Container(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              "Các con",
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
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 20.0),
                        widget.parent.username == widget.user.username
                            ? TextButton(
                                onPressed: () {
                                  BlocProvider.of<AuthenticationBloc>(context)
                                      .add(LoggedOut());
                                  Navigator.pop(context);
                                },
                                child: Text("Đăng xuất"),
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.black12),
                                  foregroundColor:
                                      MaterialStateProperty.all(Colors.black),
                                ),
                              )
                            : SizedBox.shrink(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}

class _DesktopParentScreen extends StatefulWidget {
  final User user;
  final ParentInfo parent;

  const _DesktopParentScreen(
      {Key key, @required this.parent, @required this.user})
      : super(key: key);

  @override
  __DesktopParentScreenState createState() => __DesktopParentScreenState();
}

class __DesktopParentScreenState extends State<_DesktopParentScreen> {
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
      body: widget.parent == null
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
                          imageUrl: widget.parent.avtUrl,
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
                          widget.parent.hoTen,
                          style: TextStyle(
                              fontSize: 20.0, fontWeight: FontWeight.w400),
                        ),
                        SizedBox(height: 5.0),
                        Text("username: ${widget.parent.username}"),
                        SizedBox(height: 5.0),
                        Text("Phụ huynh"),
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
                                                widget.parent.sdt,
                                                style:
                                                    TextStyle(fontSize: 16.0),
                                              ),
                                            ),
                                            SizedBox(height: 5.0),
                                            Container(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                "Số điện thoại",
                                                style: TextStyle(
                                                  fontSize: 12.0,
                                                  color: Colors.black45,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      GestureDetector(
                                        child: Icon(Icons.message),
                                        onTap: () => launch(
                                            "sms://${widget.parent.sdt}"),
                                      ),
                                      SizedBox(width: 20.0),
                                      GestureDetector(
                                        child: Icon(Icons.phone),
                                        onTap: () => launch(
                                            "tel://${widget.parent.sdt}"),
                                      ),
                                    ],
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
                                                widget.parent.diaChi,
                                                style:
                                                    TextStyle(fontSize: 16.0),
                                              ),
                                            ),
                                            SizedBox(height: 5.0),
                                            Container(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                "Địa chỉ",
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
                                  Row(
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
                                                    .parent.listKid.length,
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int index) {
                                                  final ListKid listkid = widget
                                                      .parent.listKid[index];
                                                  return Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 10.0),
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        Navigator.push(
                                                          context,
                                                          CupertinoPageRoute(
                                                            builder:
                                                                (context) =>
                                                                    KidScreen(
                                                              idHS: listkid.id
                                                                  .toString(),
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(50.0),
                                                        child:
                                                            CachedNetworkImage(
                                                                height: 50.0,
                                                                width: 50.0,
                                                                fit:
                                                                    BoxFit.fill,
                                                                imageUrl: listkid
                                                                    .avtUrl),
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                            SizedBox(height: 5.0),
                                            Container(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                "Các con",
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
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20.0),
                        widget.parent.username == widget.user.username
                            ? TextButton(
                                onPressed: () {
                                  BlocProvider.of<AuthenticationBloc>(context)
                                      .add(LoggedOut());
                                  Navigator.pop(context);
                                },
                                child: Text("Đăng xuất"),
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.black12),
                                  foregroundColor:
                                      MaterialStateProperty.all(Colors.black),
                                ),
                              )
                            : SizedBox.shrink(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
