// To parse this JSON data, do
//
//     final teacherInfo = teacherInfoFromJson(jsonString);

import 'dart:convert';

TeacherInfo teacherInfoFromJson(String str) =>
    TeacherInfo.fromJson(json.decode(str));

String teacherInfoToJson(TeacherInfo data) => json.encode(data.toJson());

class TeacherInfo {
  TeacherInfo({
    this.id,
    this.hoTen,
    this.sdt,
    this.diaChi,
    this.avtUrl,
    this.idLop,
    this.username,
  });

  int id;
  String hoTen;
  String sdt;
  String diaChi;
  String avtUrl;
  int idLop;
  String username;

  factory TeacherInfo.fromJson(Map<String, dynamic> json) => TeacherInfo(
        id: json["id"],
        hoTen: json["HoTen"],
        sdt: json["SDT"],
        diaChi: json["DiaChi"],
        avtUrl: json["avtUrl"],
        idLop: json["idLop"],
        username: json["Username"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "HoTen": hoTen,
        "SDT": sdt,
        "DiaChi": diaChi,
        "avtUrl": avtUrl,
        "idLop": idLop,
        "Username": username,
      };
}
