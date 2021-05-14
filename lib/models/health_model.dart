import 'package:meta/meta.dart';

import 'kid_model.dart';

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
