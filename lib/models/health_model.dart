import 'package:flutter_facebook_responsive_ui/models/user_model.dart';
import 'package:meta/meta.dart';

class Health {
  final Kid kid;
  final String month;
  final double height;
  final double weight;
  final double bmi;

  Health(
      {@required this.kid,
      @required this.month,
      @required this.height,
      @required this.weight,
      @required this.bmi});
}
