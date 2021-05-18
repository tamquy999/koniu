import 'dart:async';
import 'dart:convert';
import 'package:flutter_facebook_responsive_ui/models/api_model.dart';
import 'package:http/http.dart' as http;

final _base = "103.81.86.241:2812";
final _tokenEndpoint = "/api/login";
final _tokenURL = _base + _tokenEndpoint;

Future<Token> getToken(UserLogin userLogin) async {
  print(_tokenURL);
  final http.Response response = await http
      .post(new Uri.http(_base, _tokenEndpoint), headers: <String, String>{
    'Content-Type': 'application/x-www-form-urlencoded',
    'accept': 'application/json'
  },
          // body: jsonEncode(userLogin.toDatabaseJson()),
          body: <String, String>{
        "username": userLogin.username,
        "password": userLogin.password,
      });
  if (response.statusCode == 200) {
    return Token.fromJson(json.decode(response.body));
  } else {
    print(json.decode(response.body).toString());
    throw Exception(json.decode(response.body));
  }
}
