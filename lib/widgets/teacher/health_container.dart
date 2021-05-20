import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_responsive_ui/config/palette.dart';
import 'package:flutter_facebook_responsive_ui/models/models.dart';

import '../widgets.dart';

class HealthTeacherContainer extends StatelessWidget {
  final DateTime datetime;
  final Health health;
  final Health lasthealth;

  const HealthTeacherContainer(
      {Key key,
      @required this.datetime,
      @required this.health,
      @required this.lasthealth})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isDesktop = Responsive.isDesktop(context);
    return Card(
      margin: EdgeInsets.symmetric(
        vertical: 5.0,
        // horizontal: isDesktop ? 5.0 : 0.0,
      ),
      elevation: isDesktop ? 1.0 : 0.0,
      shape: isDesktop
          ? RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0))
          : null,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        // color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(12.0, 4.0, 12.0, 4.0),
          child: ExpandablePanel(
            header: _HealthHeader(health: health),
            collapsed: Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      // color: Palette.koniuBlue.withOpacity(0.5),
                      height: isDesktop ? 50.0 : 30.0,
                      child: Center(
                        child: Text(
                          "Chiều cao: ",
                          style: TextStyle(fontSize: 16.0),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10.0),
                  Expanded(
                    child: Container(
                      // color: Palette.koniuBlue.withOpacity(0.5),
                      height: isDesktop ? 50.0 : 30.0,
                      child: Center(
                        child: Text(
                          "Cân nặng: ",
                          style: TextStyle(fontSize: 16.0),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            expanded: SizedBox.shrink(),
          ),
        ),
      ),
    );
  }
}

class _HealthHeader extends StatelessWidget {
  final Health health;

  const _HealthHeader({
    Key key,
    @required this.health,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ProfileAvatar(imageUrl: health.kid.imageUrl),
        const SizedBox(width: 8.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                health.kid.name,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
              Row(
                children: [
                  Text(
                    health.month,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 12.0,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
