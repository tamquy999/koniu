class KidObj {
  KidObj({
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

  factory KidObj.fromJson(Map<String, dynamic> json) => KidObj(
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
