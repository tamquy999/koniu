import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_responsive_ui/config/palette.dart';
import 'package:flutter_facebook_responsive_ui/models/models.dart';
import 'package:flutter_facebook_responsive_ui/widgets/widgets.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class MealTeacherContainer extends StatefulWidget {
  final Meal meal;

  const MealTeacherContainer({Key key, this.meal}) : super(key: key);

  @override
  _MealTeacherContainerState createState() => _MealTeacherContainerState();
}

class _MealTeacherContainerState extends State<MealTeacherContainer> {
  final sangTextController = TextEditingController();
  final truaTextController = TextEditingController();
  final chieuTextController = TextEditingController();

  String sang = "";
  String trua = "";
  String chieu = "";

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    sangTextController.dispose();
    super.dispose();
  }

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
      // margin: EdgeInsets.symmetric(
      //   vertical: 5.0,
      //   horizontal: 10.0,
      // ),
      // elevation: 0.0,
      // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: Container(
        padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
        // color: Colors.white,
        child: Column(
          children: [
            Container(
              alignment: Alignment.topLeft,
              child: Text(
                "Thực đơn",
                style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w900),
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
                  sang != null && sang != ""
                      ? Container(
                          margin: EdgeInsets.all(10.0),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            sangTextController.text,
                            // style: TextStyle(fontSize: 15.0),
                          ),
                        )
                      : Expanded(
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: TextField(
                              style: TextStyle(fontSize: 14.0),
                              decoration: InputDecoration(
                                  isDense: true,
                                  contentPadding:
                                      EdgeInsets.symmetric(vertical: 10.0),
                                  // border: OutlineInputBorder(),
                                  hintText: 'Nhập thực đơn buổi sáng'),
                              controller: sangTextController,
                              keyboardType: TextInputType.multiline,
                              maxLines: null,
                            ),
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
                  // Container(
                  //   margin: EdgeInsets.all(10.0),
                  //   alignment: Alignment.centerLeft,
                  //   child: Text(
                  //     widget.meal.lunch,
                  //     // style: TextStyle(fontSize: 15.0),
                  //   ),
                  // ),
                  trua != null && trua != ""
                      ? Container(
                          margin: EdgeInsets.all(10.0),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            truaTextController.text,
                            // style: TextStyle(fontSize: 15.0),
                          ),
                        )
                      : Expanded(
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: TextField(
                              style: TextStyle(fontSize: 14.0),
                              decoration: InputDecoration(
                                  isDense: true,
                                  contentPadding:
                                      EdgeInsets.symmetric(vertical: 10.0),
                                  // border: OutlineInputBorder(),
                                  hintText: 'Nhập thực đơn buổi trưa'),
                              controller: truaTextController,
                              keyboardType: TextInputType.multiline,
                              maxLines: null,
                            ),
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
                        "Chiều",
                        style: TextStyle(color: Colors.black38),
                      ),
                    ),
                  ),
                  Container(
                    height: 10.0,
                    width: 5.0,
                    color: Colors.blue.shade400,
                  ),
                  chieu != null && chieu != ""
                      ? Container(
                          margin: EdgeInsets.all(10.0),
                          alignment: Alignment.centerLeft,
                          // color: Colors.amber,
                          child: Text(
                            chieuTextController.text,
                            // style: TextStyle(fontSize: 15.0),
                          ),
                        )
                      : Expanded(
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: TextField(
                              style: TextStyle(fontSize: 14.0),
                              decoration: InputDecoration(
                                  isDense: true,
                                  contentPadding:
                                      EdgeInsets.symmetric(vertical: 10.0),
                                  // border: OutlineInputBorder(),
                                  hintText: 'Nhập thực đơn buổi chiều'),
                              controller: chieuTextController,
                              keyboardType: TextInputType.multiline,
                              maxLines: null,
                            ),
                          ),
                        ),
                ],
              ),
            ),
            SizedBox(
              height: 5.0,
            ),
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: sang != "" || trua != "" || chieu != ""
                        ? () {
                            setState(() {
                              sang = "";
                              trua = "";
                              chieu = "";
                            });
                            print(chieu);
                          }
                        : () {},
                    child: Text(
                      "Sửa",
                      style: sang != "" || trua != "" || chieu != ""
                          ? TextStyle(color: Colors.blue)
                          : TextStyle(color: Colors.grey),
                    ),
                  ),
                ),
                Expanded(
                  child: TextButton(
                    onPressed: sang != "" || trua != "" || chieu != ""
                        ? () {}
                        : () {
                            setState(() {
                              sang = sangTextController.text;
                              trua = truaTextController.text;
                              chieu = chieuTextController.text;
                            });
                            print(chieu);
                          },
                    child: Text(
                      "Lưu",
                      style: sang != "" || trua != "" || chieu != ""
                          ? TextStyle(color: Colors.grey)
                          : TextStyle(color: Colors.blue),
                    ),
                  ),
                ),
              ],
            )

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
