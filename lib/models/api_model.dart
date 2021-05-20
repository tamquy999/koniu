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

class UploadedImage {
  String linkImg;

  UploadedImage({
    this.linkImg,
  });

  factory UploadedImage.fromJson(Map<String, dynamic> json) => UploadedImage(
        linkImg: json['ImageName'],
      );
}
class ImageName {
  String imageName;

  ImageName({this.imageName});

  factory ImageName.fromJson(Map<String, dynamic> json) {
    return ImageName(imageName: json['ImageName']);
  }
}
