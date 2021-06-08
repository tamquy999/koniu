// import 'package:flutter_facebook_responsive_ui/models/user_model.dart';
import 'package:meta/meta.dart';

// To parse this JSON data, do
//
//     final meal = mealFromJson(jsonString);

import 'dart:convert';

List<Meal> mealFromJson(String str) =>
    List<Meal>.from(json.decode(str).map((x) => Meal.fromJson(x)));

String mealToJson(List<Meal> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Meal {
  Meal({
    this.id,
    this.idLop,
    this.bSang,
    this.bTrua,
    this.bToi,
    this.ngay,
    this.imgUrl,
  });

  int id;
  int idLop;
  String bSang;
  String bTrua;
  String bToi;
  DateTime ngay;
  String imgUrl;

  factory Meal.fromJson(Map<String, dynamic> json) => Meal(
        id: json["id"],
        idLop: json["idLop"],
        bSang: json["bSang"],
        bTrua: json["bTrua"],
        bToi: json["bToi"],
        ngay: DateTime.parse(json["Ngay"]),
        imgUrl: json["imgUrl"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "idLop": idLop,
        "bSang": bSang,
        "bTrua": bTrua,
        "bToi": bToi,
        "Ngay":
            "${ngay.year.toString().padLeft(4, '0')}-${ngay.month.toString().padLeft(2, '0')}-${ngay.day.toString().padLeft(2, '0')}",
        "imgUrl": imgUrl,
      };
}
