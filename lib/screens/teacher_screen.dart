import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facebook_responsive_ui/api_connection/api_connection.dart';
import 'package:flutter_facebook_responsive_ui/bloc/authentication_bloc.dart';
import 'package:flutter_facebook_responsive_ui/config/palette.dart';
import 'package:flutter_facebook_responsive_ui/models/models.dart';
import 'package:flutter_facebook_responsive_ui/models/teacherInfo_model.dart';
import 'package:flutter_facebook_responsive_ui/widgets/widgets.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class TeacherScreen extends StatefulWidget {
  final String idGV;

  const TeacherScreen({Key key, this.idGV}) : super(key: key);

  @override
  _TeacherScreenState createState() => _TeacherScreenState();
}

class _TeacherScreenState extends State<TeacherScreen> {
  TeacherInfo teacher;
  User _user;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrUser();
  }

  Future<String> getCurrGV(String idGV) async {
    getGV(idGV).then((val) {
      teacher = val;
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
      widget.idGV != null ? getCurrGV(widget.idGV) : getCurrGV("1");
    }).catchError((error, stackTrace) {
      print("outer: $error");
    });
    return "succes";
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: teacher == null
          ? LoadingIndicator()
          : Scaffold(
              body: Responsive(
                mobile: _MobileTeacherScreen(user: _user, teacher: teacher),
                desktop: _DesktopTeacherScreen(user: _user, teacher: teacher),
              ),
            ),
    );
  }
}

class _MobileTeacherScreen extends StatefulWidget {
  final User user;
  final TeacherInfo teacher;

  const _MobileTeacherScreen({Key key, @required this.teacher, this.user})
      : super(key: key);

  @override
  __MobileTeacherScreenState createState() => __MobileTeacherScreenState();
}

class __MobileTeacherScreenState extends State<_MobileTeacherScreen> {
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
      body: widget.teacher == null
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
                          imageUrl: widget.teacher.avtUrl,
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
                          widget.teacher.hoTen,
                          style: TextStyle(
                              fontSize: 20.0, fontWeight: FontWeight.w400),
                        ),
                        SizedBox(height: 5.0),
                        Text("username: ${widget.teacher.username}"),
                        SizedBox(height: 5.0),
                        Text("Giáo viên"),
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
                                              widget.teacher.sdt,
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
                                          launch("sms://${widget.teacher.sdt}"),
                                    ),
                                    SizedBox(width: 20.0),
                                    GestureDetector(
                                      child: Icon(Icons.phone),
                                      onTap: () =>
                                          launch("tel://${widget.teacher.sdt}"),
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
                                              widget.teacher.diaChi,
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
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 20.0),
                        widget.teacher.username == widget.user.username
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

class _DesktopTeacherScreen extends StatefulWidget {
  final User user;
  final TeacherInfo teacher;

  const _DesktopTeacherScreen({Key key, @required this.teacher, this.user})
      : super(key: key);

  @override
  __DesktopTeacherScreenState createState() => __DesktopTeacherScreenState();
}

class __DesktopTeacherScreenState extends State<_DesktopTeacherScreen> {
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
      body: widget.teacher == null
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
                          imageUrl: widget.teacher.avtUrl,
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
                          widget.teacher.hoTen,
                          style: TextStyle(
                              fontSize: 20.0, fontWeight: FontWeight.w400),
                        ),
                        SizedBox(height: 5.0),
                        Text("username: ${widget.teacher.username}"),
                        SizedBox(height: 5.0),
                        Text("Giáo viên"),
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
                                                widget.teacher.sdt,
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
                                            "sms://${widget.teacher.sdt}"),
                                      ),
                                      SizedBox(width: 20.0),
                                      GestureDetector(
                                        child: Icon(Icons.phone),
                                        onTap: () => launch(
                                            "tel://${widget.teacher.sdt}"),
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
                                                widget.teacher.diaChi,
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
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20.0),
                        widget.teacher.username == widget.user.username
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
