// To parse this JSON data, do
//
//     final kidInfo = kidInfoFromJson(jsonString);

import 'dart:convert';

KidInfo kidInfoFromJson(String str) => KidInfo.fromJson(json.decode(str));

String kidInfoToJson(KidInfo data) => json.encode(data.toJson());

class KidInfo {
  KidInfo({
    this.id,
    this.avtUrl,
    this.hoTen,
    this.ngaySinh,
    this.idLop,
    this.idPh,
    this.tenLop,
    this.listGv,
    this.parentObj,
  });

  int id;
  String avtUrl;
  String hoTen;
  DateTime ngaySinh;
  int idLop;
  int idPh;
  String tenLop;
  List<ListGV> listGv;
  ParentObj parentObj;

  factory KidInfo.fromJson(Map<String, dynamic> json) => KidInfo(
        id: json["id"],
        avtUrl: json["avtUrl"],
        hoTen: json["HoTen"],
        ngaySinh: DateTime.parse(json["NgaySinh"]),
        idLop: json["idLop"],
        idPh: json["idPH"],
        tenLop: json["TenLop"],
        listGv:
            List<ListGV>.from(json["listGV"].map((x) => ListGV.fromJson(x))),
        parentObj: ParentObj.fromJson(json["ParentObj"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "avtUrl": avtUrl,
        "HoTen": hoTen,
        "NgaySinh":
            "${ngaySinh.year.toString().padLeft(4, '0')}-${ngaySinh.month.toString().padLeft(2, '0')}-${ngaySinh.day.toString().padLeft(2, '0')}",
        "idLop": idLop,
        "idPH": idPh,
        "TenLop": tenLop,
        "listGV": List<dynamic>.from(listGv.map((x) => x.toJson())),
        "ParentObj": parentObj.toJson(),
      };
}

class ListGV {
  ListGV({
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

  factory ListGV.fromJson(Map<String, dynamic> json) => ListGV(
        id: json["id"],
        hoTen: json["HoTen"],
        sdt: json["SDT"],
        diaChi: json["DiaChi"],
        avtUrl: json["avtUrl"],
        idLop: json["idLop"] == null ? null : json["idLop"],
        username: json["Username"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "HoTen": hoTen,
        "SDT": sdt,
        "DiaChi": diaChi,
        "avtUrl": avtUrl,
        "idLop": idLop == null ? null : idLop,
        "Username": username,
      };
}

class ParentObj {
  ParentObj({
    this.id,
    this.hoTen,
    this.sdt,
    this.diaChi,
    this.soCmnd,
    this.avtUrl,
    this.username,
  });

  int id;
  String hoTen;
  String sdt;
  String diaChi;
  String soCmnd;
  String avtUrl;
  String username;

  factory ParentObj.fromJson(Map<String, dynamic> json) => ParentObj(
        id: json["id"],
        hoTen: json["HoTen"],
        sdt: json["SDT"],
        diaChi: json["DiaChi"],
        soCmnd: json["SoCMND"] == null ? null : json["SoCMND"],
        avtUrl: json["avtUrl"],
        username: json["Username"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "HoTen": hoTen,
        "SDT": sdt,
        "DiaChi": diaChi,
        "SoCMND": soCmnd == null ? null : soCmnd,
        "avtUrl": avtUrl,
        "Username": username,
      };
}
