// To parse this JSON data, do
//
//     final parentInfo = parentInfoFromJson(jsonString);

import 'dart:convert';

ParentInfo parentInfoFromJson(String str) =>
    ParentInfo.fromJson(json.decode(str));

String parentInfoToJson(ParentInfo data) => json.encode(data.toJson());

class ParentInfo {
  ParentInfo({
    this.id,
    this.hoTen,
    this.sdt,
    this.diaChi,
    this.soCmnd,
    this.avtUrl,
    this.username,
    this.listKid,
  });

  int id;
  String hoTen;
  String sdt;
  String diaChi;
  String soCmnd;
  String avtUrl;
  String username;
  List<ListKid> listKid;

  factory ParentInfo.fromJson(Map<String, dynamic> json) => ParentInfo(
        id: json["id"],
        hoTen: json["HoTen"],
        sdt: json["SDT"],
        diaChi: json["DiaChi"],
        soCmnd: json["SoCMND"],
        avtUrl: json["avtUrl"],
        username: json["Username"],
        listKid:
            List<ListKid>.from(json["listKid"].map((x) => ListKid.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "HoTen": hoTen,
        "SDT": sdt,
        "DiaChi": diaChi,
        "SoCMND": soCmnd,
        "avtUrl": avtUrl,
        "Username": username,
        "listKid": List<dynamic>.from(listKid.map((x) => x.toJson())),
      };
}

class ListKid {
  ListKid({
    this.id,
    this.avtUrl,
    this.hoTen,
    this.ngaySinh,
    this.idLop,
    this.idPh,
  });

  int id;
  String avtUrl;
  String hoTen;
  DateTime ngaySinh;
  int idLop;
  int idPh;

  factory ListKid.fromJson(Map<String, dynamic> json) => ListKid(
        id: json["id"],
        avtUrl: json["avtUrl"],
        hoTen: json["HoTen"],
        ngaySinh: DateTime.parse(json["NgaySinh"]),
        idLop: json["idLop"],
        idPh: json["idPH"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "avtUrl": avtUrl,
        "HoTen": hoTen,
        "NgaySinh":
            "${ngaySinh.year.toString().padLeft(4, '0')}-${ngaySinh.month.toString().padLeft(2, '0')}-${ngaySinh.day.toString().padLeft(2, '0')}",
        "idLop": idLop,
        "idPH": idPh,
      };
}
