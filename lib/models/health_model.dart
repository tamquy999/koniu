// To parse this JSON data, do
//
//     final health = healthFromJson(jsonString);

import 'dart:convert';

import 'models.dart';

List<Health> healthFromJson(String str) =>
    List<Health>.from(json.decode(str).map((x) => Health.fromJson(x)));

String healthToJson(List<Health> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Health {
  Health({
    this.id,
    this.idHs,
    this.chieuCao,
    this.canNang,
    this.bmi,
    this.danhGia,
    this.ghiChu,
    this.ngay,
    this.kidObj,
  });

  int id;
  int idHs;
  double chieuCao;
  double canNang;
  double bmi;
  String danhGia;
  String ghiChu;
  DateTime ngay;
  KidObj kidObj;

  factory Health.fromJson(Map<String, dynamic> json) => Health(
        id: json["id"],
        idHs: json["idHS"],
        chieuCao: json["chieuCao"],
        canNang: json["canNang"],
        bmi: json["BMI"],
        danhGia: json["DanhGia"],
        ghiChu: json["GhiChu"],
        ngay: DateTime.parse(json["Ngay"]),
        kidObj: KidObj.fromJson(json["kidObj"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "idHS": idHs,
        "chieuCao": chieuCao,
        "canNang": canNang,
        "BMI": bmi,
        "DanhGia": danhGia,
        "GhiChu": ghiChu,
        "Ngay":
            "${ngay.year.toString().padLeft(4, '0')}-${ngay.month.toString().padLeft(2, '0')}-${ngay.day.toString().padLeft(2, '0')}",
        "kidObj": kidObj.toJson(),
      };
}
