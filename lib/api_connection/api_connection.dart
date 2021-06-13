import 'dart:async';
// import 'dart:ffi';
// import 'package:async/async.dart';
import 'dart:convert';
import 'dart:io';
// import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_facebook_responsive_ui/dao/user_dao.dart';
import 'package:flutter_facebook_responsive_ui/models/api_model.dart';
import 'package:flutter_facebook_responsive_ui/models/kidInfo_model.dart';
import 'package:flutter_facebook_responsive_ui/models/models.dart';
import 'package:flutter_facebook_responsive_ui/models/parentInfo_model.dart';
import 'package:flutter_facebook_responsive_ui/models/teacherInfo_model.dart';
import 'package:http/http.dart' as http;
// import 'package:http_parser/http_parser.dart';
import 'package:shared_preferences/shared_preferences.dart';

final _base = "103.81.86.241:2812";
final _tokenEndpoint = "/api/login";
final _tokenURL = _base + _tokenEndpoint;

Future<Token> getToken(UserLogin userLogin) async {
  print(_tokenURL);
  print(userLogin.username);
  print(userLogin.password);
  final http.Response response = await http
      .post(new Uri.http(_base, _tokenEndpoint), headers: <String, String>{
    'Content-Type': 'application/x-www-form-urlencoded',
    'accept': 'application/json',
  }, body: <String, String>{
    "username": userLogin.username,
    "password": userLogin.password,
  });
  if (response.statusCode == 200) {
    print(Token.fromJson(json.decode(response.body)));
    return Token.fromJson(json.decode(response.body));
  } else {
    print(json.decode(response.body).toString());
    throw Exception(json.decode(response.body));
  }
}

Future<String> getLocalToken() async {
  // String token;
  if (kIsWeb) {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('access-token');
  } else {
    UserDao dao = UserDao();
    return await dao.getUserToken(0);
  }
  // return token;
}

Future<User> getUser() async {
  // print(_tokenURL);
  String token = await getLocalToken();
  // if (kIsWeb) {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   token = prefs.getString('access-token');
  // } else {
  //   UserDao dao = UserDao();
  //   token = await dao.getUserToken(0);
  // }
  final http.Response response =
      await http.get(new Uri.http(_base, "/api/me"), headers: <String, String>{
    // 'Content-Type': 'application/x-www-form-urlencoded',
    'accept': 'application/json',
    'access-token': token
    // 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MiwidXNlcm5hbWUiOiJQSFRlbyIsInF1eWVuIjoyLCJleHAiOjE2MjQ0MzM2MTR9.1dJ4WUefbR7zNUsVfu5HW7MYzH_ceOjhzH5Z2emW2To'
  });
  if (response.statusCode == 200) {
    return User.fromJson(json.decode(utf8.decode(response.bodyBytes)));
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

// Post
Future<List<Post2>> getMonthPost(String date) async {
  String token = await getLocalToken();

  print("GetMonthPost()");
  final http.Response response = await http.get(
      new Uri.http(_base, "/api/postkid/get", <String, String>{'Ngay': date}),
      headers: <String, String>{
        // 'Content-Type': 'application/x-www-form-urlencoded',
        'accept': 'application/json',
        'access-token': token
        // 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MiwidXNlcm5hbWUiOiJQSFRlbyIsInF1eWVuIjoyLCJleHAiOjE2MjQ0MzM2MTR9.1dJ4WUefbR7zNUsVfu5HW7MYzH_ceOjhzH5Z2emW2To'
      });

  // var rb = response.body;
  // print(rb);

  if (response.statusCode == 200) {
    // store json data into list
    var list = json.decode(utf8.decode(response.bodyBytes)) as List;
    // print(list[0]);

    // iterate over the list and map each object in list to Post2 by calling Post2.fromJson
    List<Post2> posts = list.map((i) => Post2.fromJson(i)).toList();

    // print(posts.runtimeType); //returns List<Post2>
    // print(posts[1].thoiGianDen); //returns Post2

    return posts;
  } else {
    print(json.decode(response.body).toString());
    throw Exception(json.decode(response.body));
  }
}

Future<List<Post2>> getGVPost(String date) async {
  String token = await getLocalToken();

  print("GetGVPost()");
  final http.Response response = await http.get(
      new Uri.http(_base, "/api/postkid/getGV", <String, String>{'Ngay': date}),
      headers: <String, String>{
        // 'Content-Type': 'application/x-www-form-urlencoded',
        'accept': 'application/json',
        'access-token': token
        // 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MiwidXNlcm5hbWUiOiJQSFRlbyIsInF1eWVuIjoyLCJleHAiOjE2MjQ0MzM2MTR9.1dJ4WUefbR7zNUsVfu5HW7MYzH_ceOjhzH5Z2emW2To'
      });

  // var rb = response.body;
  // print(rb);

  if (response.statusCode == 200) {
    // store json data into list
    var list = json.decode(utf8.decode(response.bodyBytes)) as List;
    // print(list[0]);

    // iterate over the list and map each object in list to Post2 by calling Post2.fromJson
    List<Post2> posts = list.map((i) => Post2.fromJson(i)).toList();

    // print(posts.runtimeType); //returns List<Post2>
    // print(posts[1].thoiGianDen); //returns Post2

    return posts;
  } else {
    print(json.decode(response.body).toString());
    throw Exception(json.decode(response.body));
  }
}

Future<String> updatePost(Post2 post) async {
  print(post.diDenImgUrl);
  print(post.diVeImgUrl);
  String token = await getLocalToken();

  var jsonBody = post.toJson();

  final http.Response response =
      await http.post(new Uri.http(_base, "/api/post/update"),
          headers: <String, String>{
            'accept': 'application/json',
            'access-token': token,
            'Content-Type': 'application/json',
          },
          body: jsonEncode(jsonBody));

  if (response.statusCode == 200) {
    return "update success";
  } else {
    print(json.decode(response.body).toString());
    throw Exception(json.decode(response.body));
  }
}

// Activity
Future<List<Activity>> getPHAct(String date) async {
  String token = await getLocalToken();

  print("GetPHAct");
  final http.Response response = await http.get(
      new Uri.http(
          _base, "/api/activities/get", <String, String>{'Ngay': date}),
      headers: <String, String>{
        // 'Content-Type': 'application/x-www-form-urlencoded',
        'accept': 'application/json',
        'access-token': token
        // 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MiwidXNlcm5hbWUiOiJQSFRlbyIsInF1eWVuIjoyLCJleHAiOjE2MjQ0MzM2MTR9.1dJ4WUefbR7zNUsVfu5HW7MYzH_ceOjhzH5Z2emW2To'
      });

  // var rb = response.body;
  // print(rb);

  if (response.statusCode == 200) {
    // store json data into list
    var list = json.decode(utf8.decode(response.bodyBytes)) as List;
    // print(list[0]);

    // iterate over the list and map each object in list to Post2 by calling Post2.fromJson
    List<Activity> activities = list.map((i) => Activity.fromJson(i)).toList();

    // print(posts.runtimeType); //returns List<Post2>
    // print(posts[1].thoiGianDen); //returns Post2

    return activities;
  } else {
    print(json.decode(response.body).toString());
    throw Exception(json.decode(response.body));
  }
}

Future<String> createActivity(String moTa, String imgUrl) async {
  // print(_tokenURL);
  String token = await getLocalToken();

  final http.Response response =
      await http.post(new Uri.http(_base, "/api/activities"),
          headers: <String, String>{
            'accept': 'application/json',
            'access-token': token,
            'Content-Type': 'application/json',
          },
          body: jsonEncode({'ThongTin': moTa, 'imgUrl': imgUrl}));

  if (response.statusCode == 200) {
    return "Create success";
  } else {
    print(json.decode(response.body).toString());
    throw Exception(json.decode(response.body));
  }
}

// Meal
Future<List<Meal>> getMeals(String date) async {
  String token = await getLocalToken();

  print("GetMeals");
  final http.Response response = await http.get(
      new Uri.http(_base, "/api/meal/get", <String, String>{'Ngay': date}),
      headers: <String, String>{
        // 'Content-Type': 'application/x-www-form-urlencoded',
        'accept': 'application/json',
        'access-token': token
        // 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MiwidXNlcm5hbWUiOiJQSFRlbyIsInF1eWVuIjoyLCJleHAiOjE2MjQ0MzM2MTR9.1dJ4WUefbR7zNUsVfu5HW7MYzH_ceOjhzH5Z2emW2To'
      });

  // var rb = response.body;
  // print(rb);

  if (response.statusCode == 200) {
    // store json data into list
    var list = json.decode(utf8.decode(response.bodyBytes)) as List;
    // print(list[0]);

    // iterate over the list and map each object in list to Post2 by calling Post2.fromJson
    List<Meal> meals = list.map((i) => Meal.fromJson(i)).toList();

    // print(posts.runtimeType); //returns List<Post2>
    // print(posts[1].thoiGianDen); //returns Post2

    return meals;
  } else {
    print(json.decode(response.body).toString());
    throw Exception(json.decode(response.body));
  }
}

Future<String> createMeal(Meal meal) async {
  // print(_tokenURL);
  String token = await getLocalToken();

  final http.Response response =
      await http.post(new Uri.http(_base, "/api/meal"),
          headers: <String, String>{
            'accept': 'application/json',
            'access-token': token,
            'Content-Type': 'application/json',
          },
          body: jsonEncode({
            'bSang': meal.bSang,
            'bTrua': meal.bTrua,
            'bToi': meal.bToi,
          }));

  if (response.statusCode == 200) {
    return "Create meal success";
  } else {
    print(json.decode(response.body).toString());
    throw Exception(json.decode(response.body));
  }
}

// Health
Future<List<Health>> getGVHealth(String date) async {
  String token = await getLocalToken();
  print(date);

  print("getGVHealth()");
  final http.Response response = await http.get(
      new Uri.http(
          _base, "/api/healthkid/getGV", <String, String>{'Ngay': date}),
      headers: <String, String>{
        // 'Content-Type': 'application/x-www-form-urlencoded',
        'accept': 'application/json',
        'access-token': token
      });

  if (response.statusCode == 200) {
    // store json data into list
    var list = json.decode(utf8.decode(response.bodyBytes)) as List;

    // iterate over the list and map each object in list to Post2 by calling Post2.fromJson
    List<Health> healths = list.map((i) => Health.fromJson(i)).toList();

    return healths;
  } else {
    print(json.decode(response.body).toString());
    throw Exception(json.decode(response.body));
  }
}

Future<List<Health>> getPHHealth(String date) async {
  String token = await getLocalToken();
  print(date);

  print("getPHHealth()");
  final http.Response response = await http.get(
      new Uri.http(
          _base, "/api/healthkid/getPH", <String, String>{'Ngay': date}),
      headers: <String, String>{
        // 'Content-Type': 'application/x-www-form-urlencoded',
        'accept': 'application/json',
        'access-token': token
      });

  if (response.statusCode == 200) {
    // store json data into list
    var list = json.decode(utf8.decode(response.bodyBytes)) as List;

    // iterate over the list and map each object in list to Post2 by calling Post2.fromJson
    List<Health> healths = list.map((i) => Health.fromJson(i)).toList();

    return healths;
  } else {
    print(json.decode(response.body).toString());
    throw Exception(json.decode(response.body));
  }
}

Future<Health> getOneHealth(int idHS, String date) async {
  String token = await getLocalToken();
  print(date);

  print("getOneHealth()");
  final http.Response response = await http.get(
      new Uri.http(_base, "/api/healthkid/getHealth",
          <String, String>{'idHS': idHS.toString(), 'Ngay': date}),
      headers: <String, String>{
        // 'Content-Type': 'application/x-www-form-urlencoded',
        'accept': 'application/json',
        'access-token': token
      });

  if (response.statusCode == 200) {
    return Health.fromJson(json.decode(utf8.decode(response.bodyBytes)));
  } else {
    print(json.decode(response.body).toString());
    throw Exception(json.decode(response.body));
  }

  // if (response.statusCode == 200) {
  //   // store json data into list
  //   var list = json.decode(utf8.decode(response.bodyBytes)) as List;

  //   // iterate over the list and map each object in list to Post2 by calling Post2.fromJson
  //   List<Health> healths = list.map((i) => Health.fromJson(i)).toList();

  //   return healths;
  // } else {
  //   print(json.decode(response.body).toString());
  //   throw Exception(json.decode(response.body));
  // }
}

Future<String> updateHealth(Health health) async {
  // print(_tokenURL);
  String token = await getLocalToken();

  final http.Response response =
      await http.post(new Uri.http(_base, "/api/health/update"),
          headers: <String, String>{
            'accept': 'application/json',
            'access-token': token,
            'Content-Type': 'application/json',
          },
          body: jsonEncode({
            'id': health.id,
            'idHS': health.idHs,
            'chieuCao': health.chieuCao,
            'canNang': health.canNang,
          }));

  if (response.statusCode == 200) {
    return "update health success";
  } else {
    print(json.decode(response.body).toString());
    throw Exception(json.decode(response.body));
  }
}

// Info
Future<KidInfo> getKid(String idHS) async {
  String token = await getLocalToken();

  final http.Response response = await http.get(
      new Uri.http(_base, "/api/getHSPH", <String, String>{'idHS': idHS}),
      headers: <String, String>{
        // 'Content-Type': 'application/x-www-form-urlencoded',
        'accept': 'application/json',
        'access-token': token
      });
  if (response.statusCode == 200) {
    return KidInfo.fromJson(json.decode(utf8.decode(response.bodyBytes)));
  } else {
    print(json.decode(response.body).toString());
    throw Exception(json.decode(response.body));
  }
}

Future<ParentInfo> getParent(String idPH) async {
  String token = await getLocalToken();

  final http.Response response = await http.get(
      new Uri.http(_base, "/api/getPHHS", <String, String>{'idPH': idPH}),
      headers: <String, String>{
        // 'Content-Type': 'application/x-www-form-urlencoded',
        'accept': 'application/json',
        'access-token': token
      });
  if (response.statusCode == 200) {
    return ParentInfo.fromJson(json.decode(utf8.decode(response.bodyBytes)));
  } else {
    print(json.decode(response.body).toString());
    throw Exception(json.decode(response.body));
  }
}

Future<TeacherInfo> getGV(String idGV) async {
  String token = await getLocalToken();

  final http.Response response = await http.get(
      new Uri.http(_base, "/api/getGV", <String, String>{'idGV': idGV}),
      headers: <String, String>{
        // 'Content-Type': 'application/x-www-form-urlencoded',
        'accept': 'application/json',
        'access-token': token
      });
  if (response.statusCode == 200) {
    return TeacherInfo.fromJson(json.decode(utf8.decode(response.bodyBytes)));
  } else {
    print(json.decode(response.body).toString());
    throw Exception(json.decode(response.body));
  }
}
