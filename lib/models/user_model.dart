import 'package:flutter/cupertino.dart';

class User {
  int id;
  String username;
  String token;
  int quyen;

  User({this.id, this.username, this.token, this.quyen = 0});

  factory User.fromDatabaseJson(Map<String, dynamic> data) => User(
        id: data['id'],
        username: data['username'],
        token: data['access_token'],
        quyen: data['quyen'],
      );

  Map<String, dynamic> toDatabaseJson() => {
        "id": this.id,
        "username": this.username,
        "access_token": this.token,
        "quyen": this.quyen
      };
}
