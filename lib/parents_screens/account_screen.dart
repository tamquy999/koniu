import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facebook_responsive_ui/bloc/authentication_bloc.dart';
import 'package:flutter_facebook_responsive_ui/config/palette.dart';
import 'package:flutter_facebook_responsive_ui/data/data.dart';
import 'package:url_launcher/url_launcher.dart';

class AccountScreen extends StatelessWidget {
  _makingPhoneCall() async {
    const url = 'tel:9876543210';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        iconTheme: IconThemeData(
          color: Colors.black45, //change your color here
        ),
        backgroundColor: Colors.white,
        title: Text(
          "Tài khoản",
          style: TextStyle(color: Palette.koniuBlue),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 20.0),
                  CachedNetworkImage(
                    imageUrl:
                        'https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80',
                    imageBuilder: (context, imageProvider) => Container(
                      width: 120.0,
                      height: 120.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: imageProvider, fit: BoxFit.cover),
                      ),
                    ),
                    placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    "Nguyễn Ngọc Dương",
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.w400),
                  ),
                  SizedBox(height: 5.0),
                  Text("id:12358719"),
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
                              "Info",
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
                                        "0388789009",
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
                                onTap: () => launch("sms://0388789009"),
                              ),
                              SizedBox(width: 20.0),
                              GestureDetector(
                                child: Icon(Icons.phone),
                                onTap: () => launch("tel://0388789009"),
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
                                        "Phụ huynh mẫu mực nhất nhà nhất xóm nhất xã nhất huyện nhất tỉnh nhất nước chất châu lục nhất thế giới",
                                        style: TextStyle(fontSize: 16.0),
                                      ),
                                    ),
                                    SizedBox(height: 5.0),
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "Mô tả",
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
                  TextButton(
                    onPressed: () {
                      BlocProvider.of<AuthenticationBloc>(context)
                          .add(LoggedOut());
                      Navigator.pop(context);
                    },
                    child: Text("Đăng xuất"),
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.black12),
                      foregroundColor: MaterialStateProperty.all(Colors.black),
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
