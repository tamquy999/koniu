import 'package:meta/meta.dart';
import 'package:flutter_facebook_responsive_ui/models/models.dart';

// class Activity {
//   final Teacher teacher;
//   final String time;
//   final String caption;
//   final String imageUrl;

//   const Activity({
//     @required this.teacher,
//     @required this.time,
//     @required this.caption,
//     this.imageUrl,
//   });
// }

// To parse this JSON data, do
//
//     final activity = activityFromJson(jsonString);

import 'dart:convert';

List<Activity> activityFromJson(String str) =>
    List<Activity>.from(json.decode(str).map((x) => Activity.fromJson(x)));

String activityToJson(List<Activity> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Activity {
  Activity({
    this.id,
    this.idGiaoVien,
    this.ngay,
    this.thongTin,
    this.imgUrl,
    this.idLop,
    this.gio,
    this.nguoiTao,
  });

  int id;
  int idGiaoVien;
  DateTime ngay;
  String thongTin;
  String imgUrl;
  int idLop;
  String gio;
  NguoiTao nguoiTao;

  factory Activity.fromJson(Map<String, dynamic> json) => Activity(
        id: json["id"],
        idGiaoVien: json["idGiaoVien"],
        ngay: DateTime.parse(json["Ngay"]),
        thongTin: json["ThongTin"],
        imgUrl: json["imgUrl"],
        idLop: json["idLop"],
        gio: json["Gio"],
        nguoiTao: NguoiTao.fromJson(json["NguoiTao"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "idGiaoVien": idGiaoVien,
        "Ngay":
            "${ngay.year.toString().padLeft(4, '0')}-${ngay.month.toString().padLeft(2, '0')}-${ngay.day.toString().padLeft(2, '0')}",
        "ThongTin": thongTin,
        "imgUrl": imgUrl,
        "idLop": idLop,
        "Gio": gio,
        "NguoiTao": nguoiTao.toJson(),
      };
}

class NguoiTao {
  NguoiTao({
    this.username,
    this.hoTen,
    this.avtUrl,
    this.sdt,
    this.diaChi,
    this.idUser,
    this.idDangNhap,
  });

  String username;
  String hoTen;
  String avtUrl;
  String sdt;
  String diaChi;
  int idUser;
  int idDangNhap;

  factory NguoiTao.fromJson(Map<String, dynamic> json) => NguoiTao(
        username: json["Username"],
        hoTen: json["HoTen"],
        avtUrl: json["avtUrl"],
        sdt: json["SDT"],
        diaChi: json["DiaChi"],
        idUser: json["idUser"],
        idDangNhap: json["idDangNhap"],
      );

  Map<String, dynamic> toJson() => {
        "Username": username,
        "HoTen": hoTen,
        "avtUrl": avtUrl,
        "SDT": sdt,
        "DiaChi": diaChi,
        "idUser": idUser,
        "idDangNhap": idDangNhap,
      };
}
