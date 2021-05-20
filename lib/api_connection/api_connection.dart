import 'dart:async';
import 'package:async/async.dart';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter_facebook_responsive_ui/models/api_model.dart';
import 'package:flutter_facebook_responsive_ui/models/models.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

final _base = "127.0.0.1:2812";
final _tokenEndpoint = "/api/login";
final _tokenURL = _base + _tokenEndpoint;

Future<Token> getToken(UserLogin userLogin) async {
  print(_tokenURL);
  final http.Response response = await http
      .post(new Uri.http(_base, _tokenEndpoint), headers: <String, String>{
    'Content-Type': 'application/x-www-form-urlencoded',
    'accept': 'application/json',
  }, body: <String, String>{
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

//Return UploadedImage object ;
Future<UploadedImage> uploadImage(File image) async {
  var request = new http.MultipartRequest(
      "POST", new Uri.http(_base, "/api/upload/image"));

  request.headers['Content-Type'] = 'multipart/form-data';
  request.headers['accept'] = 'application/json';

  request.files.add(await http.MultipartFile.fromPath('image', image.path));

  http.Response res = await http.Response.fromStream(await request.send());
  if (res.statusCode == 200) {
    return UploadedImage.fromJson(json.decode(res.body));
  } else {
    throw Exception(json.decode(res.body));
  }

Future<ImageName> uploadImage2(File image) async {
  //create multipart request for POST or PATCH method
  var request = http.MultipartRequest(
      "POST", Uri.parse("http://103.81.86.241:2812/api/upload/image"));
  //add text fields
  //  request.fields["text_field"] = text;
  //create multipart using filepath, string or bytes
  var pic = await http.MultipartFile.fromPath("image", image.path);
  //add multipart to request
  request.files.add(pic);
  var response = await request.send();

  //Get the response from the server
  var responseData = await response.stream.toBytes();
  var responseString = String.fromCharCodes(responseData);
  // print(responseString);
  return ImageName.fromJson(json.decode(responseString));
}
