import 'package:flutter/cupertino.dart';
import 'dart:convert';

class DbUser {
  int id;
  int userid;
  String username;
  String token;
  int quyen;

  DbUser({this.id, this.userid, this.username, this.token, this.quyen = 0});

  factory DbUser.fromDatabaseJson(Map<String, dynamic> data) => DbUser(
        id: data['id'],
        userid: data['userid'],
        username: data['username'],
        token: data['access_token'],
        quyen: data['quyen'],
      );

  Map<String, dynamic> toDatabaseJson() => {
        "id": this.id,
        "userid": this.userid,
        "username": this.username,
        "access_token": this.token,
        "quyen": this.quyen
      };
}

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    this.username,
    this.hoten,
    this.sdt,
    this.diachi,
    this.avturl,
    this.quyen,
  });

  String username;
  String hoten;
  String sdt;
  String diachi;
  String avturl;
  int quyen;

  factory User.fromJson(Map<String, dynamic> json) => User(
        username: json["username"],
        hoten: json["hoten"],
        sdt: json["sdt"],
        diachi: json["diachi"],
        avturl: json["avturl"],
        quyen: json["quyen"],
      );

  Map<String, dynamic> toJson() => {
        "username": username,
        "hoten": hoten,
        "sdt": sdt,
        "diachi": diachi,
        "avturl": avturl,
        "quyen": quyen,
      };
}
