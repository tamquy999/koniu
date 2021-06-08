import 'package:flutter/material.dart';
import 'package:flutter_facebook_responsive_ui/api_connection/api_connection.dart';
import 'package:flutter_facebook_responsive_ui/models/models.dart';
import 'package:jiffy/jiffy.dart';

import '../responsive.dart';
import '../weekday_translator.dart';

class CreateMealContainer extends StatefulWidget {
  final RefreshCallback onCreate;
  final Meal meal;

  const CreateMealContainer(
      {Key key, @required this.onCreate, @required this.meal})
      : super(key: key);

  @override
  _CreateMealContainerState createState() => _CreateMealContainerState();
}

class _CreateMealContainerState extends State<CreateMealContainer> {
  final sangTextController = TextEditingController();
  final truaTextController = TextEditingController();
  final chieuTextController = TextEditingController();

  String sang = "";
  String trua = "";
  String chieu = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sang = widget.meal.bSang;
    trua = widget.meal.bTrua;
    chieu = widget.meal.bToi;
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    sangTextController.dispose();
    truaTextController.dispose();
    chieuTextController.dispose();
    super.dispose();
  }

  void _saveBtnPressed() {
    widget.meal.bSang = sangTextController.text;
    widget.meal..bTrua = truaTextController.text;
    widget.meal.bToi = chieuTextController.text;
    // setState(() {});
    createMeal(widget.meal).then((value) {
      print(value);
      sang = widget.meal.bSang;
      trua = widget.meal.bTrua;
      chieu = widget.meal.bToi;
      widget.onCreate();
    });
    // widget.onCreate();
  }

  void _editBtnPressed() {
    sangTextController.text = sang;
    truaTextController.text = trua;
    chieuTextController.text = chieu;
    sang = "";
    trua = "";
    chieu = "";
    setState(() {});
    // createMeal(widget.meal).then((value) => widget.onCreate);
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
                weekdayToVietnamese(widget.meal.ngay.weekday) +
                    Jiffy(widget.meal.ngay).format(", dd/MM/yyyy"),
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
                            sang,
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
                            trua,
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
                            chieu,
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
            sang == null || sang == ""
                ? TextButton(
                    onPressed: _saveBtnPressed,
                    child: Text(
                      "Lưu",
                      style: TextStyle(color: Colors.blue),
                    ),
                  )
                : TextButton(
                    onPressed: _editBtnPressed,
                    child: Text(
                      "Sửa",
                      style: TextStyle(color: Colors.blue),
                    ),
                  )
          ],
        ),
      ),
    );
  }
}

typedef RefreshMealCallback = void Function();
