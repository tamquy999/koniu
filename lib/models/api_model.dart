class UserLogin {
  String username;
  String password;
  int quyen;

  UserLogin({this.username, this.password, this.quyen = 0});

  Map<String, dynamic> toDatabaseJson() => {
        "username": this.username,
        "password": this.password,
        "quyen": this.quyen,
      };
}

class Token {
  String token;

  Token({this.token});

  factory Token.fromJson(Map<String, dynamic> json) {
    return Token(token: json['access_token']);
  }
}
