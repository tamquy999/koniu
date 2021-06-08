import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_responsive_ui/config/palette.dart';
import 'package:flutter_facebook_responsive_ui/models/models.dart';
import 'package:flutter_facebook_responsive_ui/widgets/teacher/create_meal_container.dart';
import 'package:flutter_facebook_responsive_ui/widgets/weekday_translator.dart';
import 'package:flutter_facebook_responsive_ui/widgets/widgets.dart';
import 'package:jiffy/jiffy.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class MealTeacherContainer extends StatefulWidget {
  final RefreshMealCallback onCreate;
  final Meal meal;

  const MealTeacherContainer({Key key, this.onCreate, this.meal})
      : super(key: key);

  @override
  _MealTeacherContainerState createState() => _MealTeacherContainerState();
}

class _MealTeacherContainerState extends State<MealTeacherContainer> {
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    super.dispose();
  }

  void testCallback2() {
    print("callback2");
  }

  @override
  Widget build(BuildContext context) {
    final bool isDesktop = Responsive.isDesktop(context);

    return Jiffy(widget.meal.ngay)
                .format("dd/MM/yyyy")
                .compareTo(Jiffy(DateTime.now()).format("dd/MM/yyyy")) ==
            0
        ? CreateMealContainer(onCreate: widget.onCreate, meal: widget.meal)
        : Card(
            margin: EdgeInsets.symmetric(
              vertical: 5.0,
              // horizontal: isDesktop ? 5.0 : 0.0,
            ),
            elevation: isDesktop ? 1.0 : 0.0,
            shape: isDesktop
                ? RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0))
                : null,
            // margin: EdgeInsets.symmetric(
            //   vertical: 5.0,
            //   horizontal: 10.0,
            // ),
            // elevation: 0.0,
            // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
            child: Container(
              padding: const EdgeInsets.all(10.0),
              // color: Colors.white,
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.topLeft,
                    child: Text(
                      weekdayToVietnamese(widget.meal.ngay.weekday) +
                          Jiffy(widget.meal.ngay).format(", dd/MM/yyyy"),
                      style: TextStyle(
                          fontSize: 15.0, fontWeight: FontWeight.w900),
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  IntrinsicHeight(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          // child: Icon(Icons.breakfast_dining),
                          child: Container(
                            width: 40.0,
                            alignment: Alignment.center,
                            child: Text(
                              "Sáng",
                              style: TextStyle(color: Colors.black38),
                            ),
                          ),
                        ),
                        Container(
                          height: 10.0,
                          width: 5.0,
                          color: Colors.yellow,
                        ),
                        Container(
                          margin: EdgeInsets.all(10.0),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            widget.meal.bSang,
                            // style: TextStyle(fontSize: 15.0),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  IntrinsicHeight(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: Container(
                            alignment: Alignment.centerLeft,
                            // child: Icon(Icons.lunch_dining),
                            child: Container(
                              width: 40.0,
                              alignment: Alignment.center,
                              child: Text(
                                "Trưa",
                                style: TextStyle(color: Colors.black38),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: 10.0,
                          width: 5.0,
                          color: Colors.green.shade300,
                        ),
                        Container(
                          margin: EdgeInsets.all(10.0),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            widget.meal.bTrua,
                            // style: TextStyle(fontSize: 15.0),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  IntrinsicHeight(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          // child: Icon(Icons.dinner_dining),
                          child: Container(
                            width: 40.0,
                            alignment: Alignment.center,
                            child: Text(
                              "Tối",
                              style: TextStyle(color: Colors.black38),
                            ),
                          ),
                        ),
                        Container(
                          height: 10.0,
                          width: 5.0,
                          color: Colors.blue.shade400,
                        ),
                        Container(
                          margin: EdgeInsets.all(10.0),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            widget.meal.bToi,
                            // style: TextStyle(fontSize: 15.0),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Container(
                  //   color: Colors.amber,
                  //   height: 30.0,
                  // ),
                  // Container(
                  //   color: Colors.amber,
                  //   height: 30.0,
                  // ),
                  // Container(
                  //   color: Colors.amber,
                  //   height: 30.0,
                  // ),
                ],
              ),
            ),
          );
  }
}
