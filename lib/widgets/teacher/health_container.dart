import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_responsive_ui/api_connection/api_connection.dart';
import 'package:flutter_facebook_responsive_ui/config/palette.dart';
import 'package:flutter_facebook_responsive_ui/models/models.dart';
import 'package:flutter_facebook_responsive_ui/screens/kid_screen.dart';
import 'package:jiffy/jiffy.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../widgets.dart';

class HealthTeacherContainer extends StatefulWidget {
  final Health health;

  const HealthTeacherContainer({Key key, @required this.health})
      : super(key: key);

  @override
  _HealthTeacherContainerState createState() => _HealthTeacherContainerState();
}

class _HealthTeacherContainerState extends State<HealthTeacherContainer> {
  final _ccaoController = TextEditingController();
  final _nangController = TextEditingController();
  Health lasthealth;

  // String _ccaoController.text = "";
  // String _nangController.text = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _ccaoController.text = widget.health.chieuCao.toString();
    _nangController.text = widget.health.canNang.toString();
    // lasthealth = widget.health;
    DateTime lastmonth = Jiffy(widget.health.ngay).subtract(months: 1).dateTime;
    // print(lastmonth);
    getOneHealth(widget.health.idHs, lastmonth.toString().substring(0, 10))
        .then((val) {
      lasthealth = val;
      print(lasthealth.ngay);
      setState(() {});
    }).catchError((error, stackTrace) {
      print("outer: $error");
      lasthealth = null;
      setState(() {});
    });
  }

  void _updateHealth(Health updatedHealth) {
    updateHealth(updatedHealth).then((val) {
      getOneHealth(widget.health.idHs,
              widget.health.ngay.toString().substring(0, 10))
          .then((val) {
        widget.health.bmi = val.bmi;
        setState(() {});
        Navigator.pop(context);
      }).catchError((error, stackTrace) {
        print("outer: $error");
        setState(() {});
      });
    }).catchError((error, stackTrace) {
      print("outer: $error");
      setState(() {});
    });
  }

  Future<void> _showDialog(String caoORnang) async {
    _ccaoController.text = widget.health.chieuCao.toString();
    _nangController.text = widget.health.canNang.toString();
    return caoORnang == "cao"
        ? {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text('Nhập chiều cao'),
                  content: TextField(
                    onChanged: (value) {},
                    controller: _ccaoController,
                    decoration: InputDecoration(hintText: "Chiều cao"),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text("Hủy"),
                    ),
                    TextButton(
                      onPressed: () {
                        _ccaoController.text = _ccaoController.text;
                        widget.health.chieuCao =
                            double.parse(_ccaoController.text);
                        _updateHealth(widget.health);
                        // setState(() {});
                        // Navigator.pop(context);
                      },
                      child: Text("Lưu"),
                    ),
                  ],
                );
              },
            )
          }
        : showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('Nhập cân nặng'),
                content: TextField(
                  onChanged: (value) {},
                  controller: _nangController,
                  decoration: InputDecoration(hintText: "Cân nặng"),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("Hủy"),
                  ),
                  TextButton(
                    onPressed: () {
                      _nangController.text = _nangController.text;
                      widget.health.canNang =
                          double.parse(_nangController.text);
                      _updateHealth(widget.health);
                      // setState(() {});
                      // Navigator.pop(context);
                    },
                    child: Text("Lưu"),
                  ),
                ],
              );
            },
          );
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
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        // color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(12.0, 4.0, 12.0, 4.0),
          child: ExpandablePanel(
            header: _HealthHeader(health: widget.health),
            collapsed: Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      child: Container(
                        color: Palette.koniuBlue.withOpacity(0.6),
                        // height: isDesktop ? 50.0 : 30.0,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                          child: Column(
                            children: [
                              Text(
                                "Cân nặng (kg)",
                                style: TextStyle(color: Colors.white),
                              ),
                              Text(
                                _nangController.text != ""
                                    ? _nangController.text
                                    : "?",
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      onTap: () => _showDialog("_nangController.text"),
                    ),
                  ),
                  SizedBox(width: 10.0),
                  Expanded(
                    child: GestureDetector(
                      child: Container(
                        color: Palette.koniuBlue.withOpacity(0.6),
                        // height: isDesktop ? 50.0 : 30.0,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                          child: Column(
                            children: [
                              Text(
                                "Chiều cao (cm)",
                                style: TextStyle(color: Colors.white),
                              ),
                              Text(
                                _ccaoController.text != ""
                                    ? _ccaoController.text
                                    : "?",
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      onTap: () => _showDialog("cao"),
                    ),
                  ),
                ],
              ),
            ),
            expanded: Column(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 5.0),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 5.0),
                  height: 120.0,
                  decoration: BoxDecoration(
                    color: Palette.koniuBlue,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Column(
                            children: [
                              Expanded(
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  child: Icon(
                                    MdiIcons.babyFaceOutline,
                                    color: Colors.white,
                                    size: 30.0,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  alignment: Alignment.bottomLeft,
                                  // color: Colors.red.shade200,
                                  child: Text(
                                    "Chỉ số BMI (kg/m\u00B2)",
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  alignment: Alignment.bottomLeft,
                                  // color: Colors.red.shade100,
                                  child: Text(
                                    widget.health.danhGia != "" &&
                                            widget.health.danhGia != ""
                                        ? widget.health.danhGia
                                        : "?",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Column(
                            children: [
                              Expanded(
                                flex: 2,
                                child: Container(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    widget.health.bmi.toString(),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 30.0,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  width: double.infinity,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: Colors.white24,
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  child: Text(
                                    lasthealth != null
                                        ? "Tháng trước: ${lasthealth.bmi.toString()}"
                                        : "Tháng trước: ?",
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 5.0),
                  height: 150.0,
                  // color: Colors.amber,
                  child: Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.blue.shade50,
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Column(
                                children: [
                                  Expanded(
                                    flex: 3,
                                    child: Row(
                                      children: [
                                        Text(
                                          "Cân nặng",
                                          style: TextStyle(fontSize: 16.0),
                                        ),
                                        Expanded(
                                          child: Container(
                                            alignment: Alignment.centerRight,
                                            child: Icon(MdiIcons.scaleBalance),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    flex: 4,
                                    child: Container(
                                      alignment: Alignment.bottomLeft,
                                      child: Text(
                                        widget.health.canNang != null
                                            ? widget.health.canNang.toString()
                                            : "?",
                                        style: TextStyle(
                                          fontSize: 35.0,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Row(
                                      children: [
                                        Text("kg"),
                                        Expanded(
                                          child: Container(
                                            alignment: Alignment.centerRight,
                                            child: lasthealth != null
                                                ? widget.health.canNang <
                                                        lasthealth.canNang
                                                    ? Text(
                                                        "▼ ${(lasthealth.canNang - widget.health.canNang).toStringAsFixed(1)} kg",
                                                        style: TextStyle(
                                                            color: Colors.red))
                                                    : Text(
                                                        "▲ ${(widget.health.canNang - lasthealth.canNang).toStringAsFixed(1)} kg",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.green),
                                                      )
                                                : Text("?"),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          onTap: () => _showDialog("_nangController.text"),
                        ),
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Expanded(
                        child: GestureDetector(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.blue.shade50,
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Column(
                                children: [
                                  Expanded(
                                    flex: 3,
                                    child: Row(
                                      children: [
                                        Text(
                                          "Chiều cao",
                                          style: TextStyle(fontSize: 16.0),
                                        ),
                                        Expanded(
                                          child: Container(
                                            alignment: Alignment.centerRight,
                                            child: Icon(MdiIcons.ruler),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    flex: 4,
                                    child: Container(
                                      alignment: Alignment.bottomLeft,
                                      child: Text(
                                        widget.health.chieuCao != null
                                            ? widget.health.chieuCao.toString()
                                            : "?",
                                        style: TextStyle(
                                          fontSize: 35.0,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Row(
                                      children: [
                                        Text("cm"),
                                        Expanded(
                                          child: Container(
                                            alignment: Alignment.centerRight,
                                            child: lasthealth != null
                                                ? widget.health.chieuCao <
                                                        lasthealth.chieuCao
                                                    ? Text(
                                                        "▼ ${(lasthealth.chieuCao - widget.health.chieuCao).toStringAsFixed(1)} cm",
                                                        style: TextStyle(
                                                            color: Colors.red),
                                                      )
                                                    : Text(
                                                        "▲ ${(widget.health.chieuCao - lasthealth.chieuCao).toStringAsFixed(1)} cm",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.green),
                                                      )
                                                : Text("?"),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          onTap: () => _showDialog("cao"),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
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
    return GestureDetector(
      onTap: () {
        // Navigator.push(
        //   context,
        //   CupertinoPageRoute(
        //     builder: (context) => KidScreen(
        //       idHS: health.idHs.toString(),
        //     ),
        //   ),
        // );
        Navigator.pushNamed(context, '/kid/${health.idHs.toString()}');
      },
      child: Row(
        children: [
          ProfileAvatar(imageUrl: health.kidObj.avtUrl),
          const SizedBox(width: 8.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  health.kidObj.hoTen,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      Jiffy(health.ngay).format("dd/MM/yyyy"),
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
      ),
    );
  }
}
