import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_responsive_ui/api_connection/api_connection.dart';
import 'package:flutter_facebook_responsive_ui/config/palette.dart';
// import 'package:flutter_facebook_responsive_ui/data/data.dart';
import 'package:flutter_facebook_responsive_ui/models/models.dart';
import 'package:flutter_facebook_responsive_ui/widgets/custom_silver_appbar.dart';
import 'package:flutter_facebook_responsive_ui/widgets/widgets.dart';
import 'package:jiffy/jiffy.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../kid_screen.dart';

class HealthScreen extends StatefulWidget {
  @override
  _HealthScreenState createState() => _HealthScreenState();
}

class _HealthScreenState extends State<HealthScreen> {
  final TrackingScrollController _trackingScrollController =
      TrackingScrollController();

  // DateTime _now = DateTime.now();

  // Health health = currentHealth;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Responsive(
          mobile:
              _MobileHealthScreen(scrollController: _trackingScrollController),
          desktop:
              _DesktopHealthScreen(scrollController: _trackingScrollController),
        ),
      ),
    );
  }
}

class _MobileHealthScreen extends StatefulWidget {
  final TrackingScrollController scrollController;

  const _MobileHealthScreen({Key key, this.scrollController}) : super(key: key);
  @override
  __MobileHealthScreenState createState() => __MobileHealthScreenState();
}

class __MobileHealthScreenState extends State<_MobileHealthScreen> {
  List<Health> _monthHealth;
  bool _hasPost = true;
  DateTime _currentMonth = DateTime.now();

  void _sub() {
    _monthHealth = null;
    _hasPost = true;
    setState(() {});
    DateTime _date = Jiffy(_currentMonth).subtract(months: 1).dateTime;
    _currentMonth = _date;
    reloadList();
  }

  void _add() {
    _monthHealth = null;
    _hasPost = true;
    setState(() {});
    DateTime _date = Jiffy(_currentMonth).add(months: 1).dateTime;
    _currentMonth = _date;
    reloadList();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    reloadList();
  }

  Future<String> reloadList() async {
    getPHHealth(_currentMonth.toString().substring(0, 10)).then((val) {
      _monthHealth = val;
      _hasPost = true;
      setState(() {});
      print(val);
    }).catchError((error, stackTrace) {
      print("outer: $error");
      _hasPost = false;
      setState(() {});
    });
    return "succes";
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      child: CustomScrollView(
        controller: widget.scrollController,
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        slivers: [
          CustomSilverAppbar(),
          CustomMonthPicker(datetime: _currentMonth, sub: _sub, add: _add),
          _monthHealth == null
              ? SliverFillRemaining(
                  child: Center(
                    // child: Text(_hasPost.toString()),
                    child: _hasPost
                        ? CircularProgressIndicator()
                        : Text(
                            "Chưa có thông tin sức khỏe",
                            style: TextStyle(color: Colors.black26),
                          ),
                  ),
                )
              : SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final Health health = _monthHealth[index];
                      return HealthContainer(health: health);
                    },
                    childCount: _monthHealth.length,
                  ),
                ),
        ],
      ),
      onRefresh: () {
        return reloadList().then((value) => null);
      },
    );
  }
}

class _DesktopHealthScreen extends StatefulWidget {
  final TrackingScrollController scrollController;

  const _DesktopHealthScreen({Key key, this.scrollController})
      : super(key: key);
  @override
  __DesktopHealthScreenState createState() => __DesktopHealthScreenState();
}

class __DesktopHealthScreenState extends State<_DesktopHealthScreen> {
  List<Health> _monthHealth;
  bool _hasPost = true;
  DateTime _currentMonth = DateTime.now();

  void _sub() {
    _monthHealth = null;
    _hasPost = true;
    setState(() {});
    DateTime _date = Jiffy(_currentMonth).subtract(months: 1).dateTime;
    _currentMonth = _date;
    reloadList();
  }

  void _add() {
    _monthHealth = null;
    _hasPost = true;
    setState(() {});
    DateTime _date = Jiffy(_currentMonth).add(months: 1).dateTime;
    _currentMonth = _date;
    reloadList();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    reloadList();
  }

  Future<String> reloadList() async {
    getPHHealth(_currentMonth.toString().substring(0, 10)).then((val) {
      _monthHealth = val;
      _hasPost = true;
      setState(() {});
      print(val);
    }).catchError((error, stackTrace) {
      print("outer: $error");
      _hasPost = false;
      setState(() {});
    });
    return "succes";
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          flex: 2,
          child: Align(
            alignment: Alignment.centerLeft,
          ),
        ),
        const Spacer(),
        Container(
          width: 800.0,
          child: RefreshIndicator(
            child: CustomScrollView(
              controller: widget.scrollController,
              physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              slivers: [
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
                  sliver: SliverToBoxAdapter(),
                ),
                CustomMonthPicker(
                    datetime: _currentMonth, sub: _sub, add: _add),
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 5.0),
                  sliver: SliverToBoxAdapter(),
                ),
                _monthHealth == null
                    ? SliverFillRemaining(
                        child: Center(
                          // child: Text(_hasPost.toString()),
                          child: _hasPost
                              ? CircularProgressIndicator()
                              : Text(
                                  "Chưa có thông tin sức khỏe",
                                  style: TextStyle(color: Colors.black26),
                                ),
                        ),
                      )
                    : SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            final Health health = _monthHealth[index];
                            return HealthContainer(health: health);
                          },
                          childCount: _monthHealth.length,
                        ),
                      ),
              ],
            ),
            onRefresh: () {
              return reloadList().then((value) => null);
            },
          ),
        ),
        const Spacer(),
        Flexible(
          flex: 2,
          child: Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
            ),
          ),
        ),
      ],
    );
  }
}

class HealthContainer extends StatefulWidget {
  final Health health;

  const HealthContainer({Key key, this.health}) : super(key: key);

  @override
  _HealthContainerState createState() => _HealthContainerState();
}

class _HealthContainerState extends State<HealthContainer> {
  Health lasthealth;

  @override
  void initState() {
    // TODO: implement initState
    DateTime lastmonth = Jiffy(widget.health.ngay).subtract(months: 1).dateTime;
    print("lastmonth" + lastmonth.toString());
    print("widget.health.idHs" + widget.health.idHs.toString());
    getOneHealth(1, lastmonth.toString().substring(0, 10)).then((val) {
      lasthealth = val;
      print("ngay trc" + lasthealth.ngay.toString());
      setState(() {});
    }).catchError((error, stackTrace) {
      print("outer last month: $error");
      lasthealth = null;
      setState(() {});
    });
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
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(2.0, 2.0, 2.0, 5.0),
              child: _HealthHeader(
                health: widget.health,
              ),
            ),
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
                                                      color: Colors.green),
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
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Expanded(
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
                                                      color: Colors.green),
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
                  ),
                ],
              ),
            )
          ],
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
        Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (context) => KidScreen(
              idHS: health.idHs.toString(),
            ),
          ),
        );
      },
      child: Row(
        children: [
          ProfileAvatar(
            imageUrl: health.kidObj.avtUrl,
          ),
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
                      health.ngay.toString(),
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
