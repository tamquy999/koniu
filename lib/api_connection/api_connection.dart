import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter_facebook_responsive_ui/models/api_model.dart';
import 'package:http/http.dart' as http;

final _base = "https://reqres.in";
final _tokenEndpoint = "/api/login";
final _tokenURL = _base + _tokenEndpoint;

Future<Token> getToken(UserLogin userLogin) async {
  print(_tokenURL);
  final http.Response response = await http.post(
    _tokenURL,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(userLogin.toDatabaseJson()),
  );
  if (response.statusCode == 200) {
    return Token.fromJson(json.decode(response.body));
  } else {
    print(json.decode(response.body).toString());
    throw Exception(json.decode(response.body));
  }
}

Future<ImageName> uploadImage(File image) async {
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
