import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_responsive_ui/api_connection/api_connection.dart';
import 'package:flutter_facebook_responsive_ui/config/palette.dart';
import 'package:flutter_facebook_responsive_ui/data/data.dart';
import 'package:flutter_facebook_responsive_ui/models/models.dart';
import 'package:flutter_facebook_responsive_ui/widgets/custom_silver_appbar.dart';
import 'package:flutter_facebook_responsive_ui/widgets/widgets.dart';
import 'package:jiffy/jiffy.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class HealthScreen extends StatefulWidget {
  @override
  _HealthScreenState createState() => _HealthScreenState();
}

class _HealthScreenState extends State<HealthScreen> {
  final TrackingScrollController _trackingScrollController =
      TrackingScrollController();

  DateTime _now = DateTime.now();

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
  DateTime _currentMonth = DateTime.now();
  List<Health> _monthHealth;
  bool _hasHealth = true;

  void _sub() {
    _monthHealth = null;
    _hasHealth = true;
    setState(() {});
    DateTime _date = Jiffy(_currentMonth).subtract(months: 1).dateTime;
    _currentMonth = _date;
    reloadList();
  }

  void _add() {
    _monthHealth = null;
    _hasHealth = true;
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
    getGVHealth(_currentMonth.toString().substring(0, 10)).then((val) {
      _monthHealth = val;
      _hasHealth = _monthHealth.length == 0 ? false : true;
      if (_monthHealth.length == 0) _monthHealth = null;
      setState(() {});
      print(val);
    }).catchError((error, stackTrace) {
      print("outer: $error");
      _hasHealth = false;
      setState(() {});
    });
    return "succes";
  }

  @override
  Widget build(BuildContext context) {
    // final Health lasthealth = lastHealth;
    // final Health health = currentHealth;

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
                    child: _hasHealth
                        ? CircularProgressIndicator()
                        : Text(
                            Jiffy(_currentMonth).format("MM/yyyy").compareTo(
                                        Jiffy(DateTime.now())
                                            .format("MM/yyyy")) ==
                                    0
                                ? "Chưa có thông tin sức khỏe"
                                : "Không có thông tin sức khỏe",
                            style: TextStyle(color: Colors.black26),
                          ),
                  ),
                )
              : SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final Health health = _monthHealth[index];
                      return HealthTeacherContainer(health: health);
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
  DateTime _currentMonth = DateTime.now();
  List<Health> _monthHealth;
  bool _hasHealth = true;

  void _sub() {
    _monthHealth = null;
    _hasHealth = true;
    setState(() {});
    DateTime _date = Jiffy(_currentMonth).subtract(months: 1).dateTime;
    _currentMonth = _date;
    reloadList();
  }

  void _add() {
    _monthHealth = null;
    _hasHealth = true;
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
    getGVHealth(_currentMonth.toString().substring(0, 10)).then((val) {
      _monthHealth = val;
      _hasHealth = _monthHealth.length == 0 ? false : true;
      if (_monthHealth.length == 0) _monthHealth = null;
      setState(() {});
      print(val);
    }).catchError((error, stackTrace) {
      print("outer: $error");
      _hasHealth = false;
      setState(() {});
    });
    return "succes";
  }

  @override
  Widget build(BuildContext context) {
    // final Health lasthealth = lastHealth;
    // final Health health = currentHealth;

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
                          child: _hasHealth
                              ? CircularProgressIndicator()
                              : Text(
                                  Jiffy(_currentMonth)
                                              .format("MM/yyyy")
                                              .compareTo(Jiffy(DateTime.now())
                                                  .format("MM/yyyy")) ==
                                          0
                                      ? "Chưa có thông tin sức khỏe"
                                      : "Không có thông tin sức khỏe",
                                  style: TextStyle(color: Colors.black26),
                                ),
                        ),
                      )
                    : SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            final Health health = _monthHealth[index];
                            return HealthTeacherContainer(health: health);
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
