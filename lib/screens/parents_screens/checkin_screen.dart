// import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_responsive_ui/api_connection/api_connection.dart';
import 'package:flutter_facebook_responsive_ui/config/palette.dart';
import 'package:flutter_facebook_responsive_ui/data/data.dart';
import 'package:flutter_facebook_responsive_ui/models/models.dart';

import 'package:flutter_facebook_responsive_ui/widgets/custom_silver_appbar.dart';
import 'package:flutter_facebook_responsive_ui/widgets/widgets.dart';
import 'package:jiffy/jiffy.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class CheckinScreen extends StatefulWidget {
  @override
  _CheckinScreenState createState() => _CheckinScreenState();
}

class _CheckinScreenState extends State<CheckinScreen> {
  final TrackingScrollController _trackingScrollController =
      TrackingScrollController();

  @override
  void dispose() {
    _trackingScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Responsive(
          mobile: _CheckinScreenMobile(
            scrollController: _trackingScrollController,
          ),
          desktop: _CheckinScreenDesktop(
            scrollController: _trackingScrollController,
          ),
        ),
      ),
    );
  }
}

class _CheckinScreenMobile extends StatefulWidget {
  final TrackingScrollController scrollController;
  // final DateTime datetime;
  // final Function sub;
  // final Function add;

  const _CheckinScreenMobile({
    Key key,
    @required this.scrollController,
    // @required this.datetime,
    // @required this.sub,
    // @required this.add,
  }) : super(key: key);

  @override
  __CheckinScreenMobileState createState() => __CheckinScreenMobileState();
}

class __CheckinScreenMobileState extends State<_CheckinScreenMobile> {
  List<Post2> _monthPosts;
  bool _hasPost = true;
  DateTime _currentMonth = DateTime.now();

  void _sub() {
    _monthPosts = null;
    _hasPost = true;
    setState(() {});
    DateTime _date = Jiffy(_currentMonth).subtract(months: 1).dateTime;
    _currentMonth = _date;
    reloadList();
  }

  void _add() {
    _monthPosts = null;
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
    getMonthPost(_currentMonth.toString().substring(0, 10)).then((val) {
      _monthPosts = val;
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
          _monthPosts == null
              ? SliverFillRemaining(
                  child: Center(
                    child: _hasPost
                        ? CircularProgressIndicator()
                        : Text(
                            "Chưa có thông tin điểm danh",
                            style: TextStyle(color: Colors.black26),
                          ),
                  ),
                )
              : SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final Post2 post = _monthPosts[index];
                      return PostContainer(post: post);
                    },
                    childCount: _monthPosts.length,
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

class _CheckinScreenDesktop extends StatefulWidget {
  final TrackingScrollController scrollController;
  // final DateTime datetime;
  // final Function sub;
  // final Function add;

  const _CheckinScreenDesktop({
    Key key,
    @required this.scrollController,
    // this.datetime,
    // this.sub,
    // this.add,
  }) : super(key: key);
  @override
  __CheckinScreenDesktopState createState() => __CheckinScreenDesktopState();
}

class __CheckinScreenDesktopState extends State<_CheckinScreenDesktop> {
  List<Post2> _monthPosts;
  bool _hasPost = true;
  DateTime _currentMonth = DateTime.now();

  void _sub() {
    _monthPosts = null;
    _hasPost = true;
    setState(() {});
    DateTime _date = Jiffy(_currentMonth).subtract(months: 1).dateTime;
    _currentMonth = _date;
    reloadList();
  }

  void _add() {
    _monthPosts = null;
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
    getMonthPost(_currentMonth.toString().substring(0, 10)).then((val) {
      _monthPosts = val;
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
                _monthPosts == null
                    ? SliverFillRemaining(
                        child: Center(
                          child: _hasPost
                              ? CircularProgressIndicator()
                              : Text(
                                  "Chưa có thông tin điểm danh",
                                  style: TextStyle(color: Colors.black26),
                                ),
                        ),
                      )
                    : SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            final Post2 post = _monthPosts[index];
                            return PostContainer(post: post);
                          },
                          childCount: _monthPosts.length,
                        ),
                      ),
              ],
            ),
            onRefresh: () {
              return reloadList().then((value) => null);
            },
          ),
          // child: CustomScrollView(
          //   controller: widget.scrollController,
          //   slivers: [
          //     SliverPadding(
          //       padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
          //       sliver: SliverToBoxAdapter(),
          //     ),
          //     CustomMonthPicker(datetime: _currentMonth, sub: _sub, add: _add),
          //     SliverPadding(
          //       padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 5.0),
          //       sliver: SliverToBoxAdapter(),
          //     ),
          //     // SliverList(
          //     //   delegate: SliverChildBuilderDelegate(
          //     //     (context, index) {
          //     //       final Post post = _monthPosts[index];
          //     //       return PostContainer(post: post);
          //     //     },
          //     //     childCount: _monthPosts.length,
          //     //   ),
          //     // ),
          //   ],
          // ),
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
