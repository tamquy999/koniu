import 'package:meta/meta.dart';
import 'package:flutter_facebook_responsive_ui/models/models.dart';

class Activity {
  final Teacher teacher;
  final String time;
  final String caption;
  final String imageUrl;

  const Activity({
    @required this.teacher,
    @required this.time,
    @required this.caption,
    this.imageUrl,
  });
}
