// To parse this JSON data, do
//
//     final lop = lopFromJson(jsonString);

import 'dart:convert';

Lop lopFromJson(String str) => Lop.fromJson(json.decode(str));

String lopToJson(Lop data) => json.encode(data.toJson());

class Lop {
  Lop({
    this.idLop,
    this.tenLop,
  });

  int idLop;
  String tenLop;

  factory Lop.fromJson(Map<String, dynamic> json) => Lop(
        idLop: json["idLop"],
        tenLop: json["TenLop"],
      );

  Map<String, dynamic> toJson() => {
        "idLop": idLop,
        "TenLop": tenLop,
      };
}
