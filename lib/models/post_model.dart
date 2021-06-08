import 'package:meta/meta.dart';
import 'package:flutter_facebook_responsive_ui/models/models.dart';
import 'dart:convert';

// class Post {
//   final Kid kid;
//   final String date;
//   final String inImg;
//   final String inTime;
//   final String outImg;
//   final String outTime;

//   const Post({
//     @required this.kid,
//     @required this.date,
//     @required this.inImg,
//     @required this.inTime,
//     this.outImg,
//     this.outTime,
//   });
// }

// To parse this JSON data, do
//
//     final post2 = post2FromJson(jsonString);

// To parse this JSON data, do
//
//     final post2 = post2FromJson(jsonString);

List<Post2> post2FromJson(String str) =>
    List<Post2>.from(json.decode(str).map((x) => Post2.fromJson(x)));

String post2ToJson(List<Post2> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Post2 {
  Post2({
    this.id,
    this.ngay,
    this.thoiGianDen,
    this.thoiGianVe,
    this.diDenImgUrl,
    this.diVeImgUrl,
    this.ghiChu,
    this.userCreated,
    this.idHocSinh,
    this.kidObj,
  });

  int id;
  DateTime ngay;
  String thoiGianDen;
  String thoiGianVe;
  String diDenImgUrl;
  String diVeImgUrl;
  String ghiChu;
  String userCreated;
  int idHocSinh;
  KidObj kidObj;

  factory Post2.fromJson(Map<String, dynamic> json) => Post2(
        id: json["id"],
        ngay: DateTime.parse(json["Ngay"]),
        thoiGianDen: json["ThoiGianDen"],
        thoiGianVe: json["ThoiGianVe"],
        diDenImgUrl: json["DiDenImgUrl"],
        diVeImgUrl: json["DiVeImgUrl"],
        ghiChu: json["GhiChu"],
        userCreated: json["UserCreated"],
        idHocSinh: json["idHocSinh"],
        kidObj: KidObj.fromJson(json["kidObj"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "Ngay":
            "${ngay.year.toString().padLeft(4, '0')}-${ngay.month.toString().padLeft(2, '0')}-${ngay.day.toString().padLeft(2, '0')}",
        "ThoiGianDen": thoiGianDen,
        "ThoiGianVe": thoiGianVe,
        "DiDenImgUrl": diDenImgUrl,
        "DiVeImgUrl": diVeImgUrl,
        "GhiChu": ghiChu,
        "UserCreated": userCreated,
        "idHocSinh": idHocSinh,
        "kidObj": kidObj.toJson(),
      };
}
