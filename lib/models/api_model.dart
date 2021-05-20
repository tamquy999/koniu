class UserLogin {
  String username;
  String password;

  UserLogin({this.username, this.password});

  Map<String, dynamic> toDatabaseJson() =>
      {"username": this.username, "password": this.password};
}

class Token {
  String token;

  Token({this.token});

  factory Token.fromJson(Map<String, dynamic> json) {
    return Token(token: json['token']);
  }
}

class ImageName {
  String imageName;

  ImageName({this.imageName});

  factory ImageName.fromJson(Map<String, dynamic> json) {
    return ImageName(imageName: json['ImageName']);
  }
}
