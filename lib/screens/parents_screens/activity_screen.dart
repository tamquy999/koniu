import 'package:flutter/material.dart';
import 'package:flutter_facebook_responsive_ui/api_connection/api_connection.dart';
import 'package:flutter_facebook_responsive_ui/data/data.dart';
import 'package:flutter_facebook_responsive_ui/models/models.dart';
import 'package:flutter_facebook_responsive_ui/widgets/custom_silver_appbar.dart';
import 'package:flutter_facebook_responsive_ui/widgets/widgets.dart';
import 'package:jiffy/jiffy.dart';

class ActivityScreen extends StatefulWidget {
  @override
  _ActivityScreenState createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
  final TrackingScrollController _trackingScrollController =
      TrackingScrollController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Responsive(
          mobile: _MobileActivityScreen(
            scrollController: _trackingScrollController,
          ),
          desktop: _DesktopActivityScreen(
            scrollController: _trackingScrollController,
          ),
        ),
      ),
    );
  }
}

class _MobileActivityScreen extends StatefulWidget {
  final TrackingScrollController scrollController;

  const _MobileActivityScreen({Key key, @required this.scrollController})
      : super(key: key);
  @override
  __MobileActivityScreenState createState() => __MobileActivityScreenState();
}

class __MobileActivityScreenState extends State<_MobileActivityScreen> {
  DateTime _currentDate = DateTime.now();
  List<Activity> _dailyActivities;
  bool _hasPost = true;

  void _sub() {
    _dailyActivities = null;
    _hasPost = true;
    setState(() {});
    DateTime _date = Jiffy(_currentDate).subtract(days: 1).dateTime;
    _currentDate = _date;
    reloadList();
  }

  void _add() {
    _dailyActivities = null;
    _hasPost = true;
    setState(() {});
    DateTime _date = Jiffy(_currentDate).add(days: 1).dateTime;
    _currentDate = _date;
    reloadList();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    reloadList();
  }

  Future<String> reloadList() async {
    getPHAct(_currentDate.toString().substring(0, 10)).then((val) {
      _dailyActivities = val;
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
          CustomDatePicker(datetime: _currentDate, sub: _sub, add: _add),
          _dailyActivities == null
              ? SliverFillRemaining(
                  child: Center(
                    // child: Text(_hasPost.toString()),
                    child: _hasPost
                        ? CircularProgressIndicator()
                        : Text(
                            "Chưa có hoạt động trong ngày",
                            style: TextStyle(color: Colors.black26),
                          ),
                  ),
                )
              : SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final Activity activity = _dailyActivities[index];
                      return ActivityContainer(activity: activity);
                    },
                    childCount: _dailyActivities.length,
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

class _DesktopActivityScreen extends StatefulWidget {
  final TrackingScrollController scrollController;

  const _DesktopActivityScreen({Key key, this.scrollController})
      : super(key: key);
  @override
  __DesktopActivityScreenState createState() => __DesktopActivityScreenState();
}

class __DesktopActivityScreenState extends State<_DesktopActivityScreen> {
  DateTime _currentDate = DateTime.now();
  List<Activity> _dailyActivities;
  bool _hasPost = true;

  void _sub() {
    _dailyActivities = null;
    _hasPost = true;
    setState(() {});
    DateTime _date = Jiffy(_currentDate).subtract(days: 1).dateTime;
    _currentDate = _date;
    reloadList();
  }

  void _add() {
    _dailyActivities = null;
    _hasPost = true;
    setState(() {});
    DateTime _date = Jiffy(_currentDate).add(days: 1).dateTime;
    _currentDate = _date;
    reloadList();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    reloadList();
  }

  Future<String> reloadList() async {
    getPHAct(_currentDate.toString().substring(0, 10)).then((val) {
      _dailyActivities = val;
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
                CustomDatePicker(datetime: _currentDate, sub: _sub, add: _add),
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 5.0),
                  sliver: SliverToBoxAdapter(),
                ),
                _dailyActivities == null
                    ? SliverFillRemaining(
                        child: Center(
                          // child: Text(_hasPost.toString()),
                          child: _hasPost
                              ? CircularProgressIndicator()
                              : Text(
                                  "Chưa có hoạt động trong ngày",
                                  style: TextStyle(color: Colors.black26),
                                ),
                        ),
                      )
                    : SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            final Activity activity = _dailyActivities[index];
                            return ActivityContainer(activity: activity);
                          },
                          childCount: _dailyActivities.length,
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
