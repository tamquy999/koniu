import 'package:meta/meta.dart';
import 'package:flutter_facebook_responsive_ui/models/models.dart';

class Post {
  final Kid kid;
  final String date;
  final String inImg;
  final String inTime;
  final String outImg;
  final String outTime;

  const Post({
    @required this.kid,
    @required this.date,
    @required this.inImg,
    @required this.inTime,
    this.outImg,
    this.outTime,
  });
}
