import 'package:flutter/material.dart';
import 'package:flutter_facebook_responsive_ui/api_connection/api_connection.dart';
import 'package:flutter_facebook_responsive_ui/data/data.dart';
import 'package:flutter_facebook_responsive_ui/models/models.dart';
import 'package:flutter_facebook_responsive_ui/widgets/date_picker.dart';
import 'package:flutter_facebook_responsive_ui/widgets/widgets.dart';
import 'package:jiffy/jiffy.dart';

class CheckinScreenTeacher extends StatefulWidget {
  @override
  _CheckinScreenTeacherState createState() => _CheckinScreenTeacherState();
}

class _CheckinScreenTeacherState extends State<CheckinScreenTeacher> {
  final TrackingScrollController _trackingScrollController =
      TrackingScrollController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Responsive(
          mobile: _CheckinScreenTeacherMobile(
              scrollController: _trackingScrollController),
          desktop: _CheckinScreenTeacherDesktop(),
        ),
      ),
    );
  }
}

class _CheckinScreenTeacherMobile extends StatefulWidget {
  final TrackingScrollController scrollController;

  const _CheckinScreenTeacherMobile({Key key, this.scrollController})
      : super(key: key);
  @override
  __CheckinScreenTeacherMobileState createState() =>
      __CheckinScreenTeacherMobileState();
}

class __CheckinScreenTeacherMobileState
    extends State<_CheckinScreenTeacherMobile> {
  List<Post2> _dailyPosts;
  DateTime _currentDate = DateTime.now();
  bool _hasPost = true;

  void _sub() {
    _dailyPosts = null;
    _hasPost = true;
    setState(() {});
    DateTime _date = Jiffy(_currentDate).subtract(days: 1).dateTime;
    _currentDate = _date;
    reloadList();
  }

  void _add() {
    _dailyPosts = null;
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
    getGVPost(Jiffy(_currentDate).format("yyyy-MM-dd")).then((val) {
      _dailyPosts = val;
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
          _dailyPosts == null
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
                      final Post2 post = _dailyPosts[index];
                      return CheckinContainer(onCreate: reloadList, post: post);
                    },
                    childCount: _dailyPosts.length,
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

class _CheckinScreenTeacherDesktop extends StatefulWidget {
  final TrackingScrollController scrollController;

  const _CheckinScreenTeacherDesktop({Key key, this.scrollController})
      : super(key: key);

  @override
  __CheckinScreenTeacherDesktopState createState() =>
      __CheckinScreenTeacherDesktopState();
}

class __CheckinScreenTeacherDesktopState
    extends State<_CheckinScreenTeacherDesktop> {
  List<Post2> _dailyPosts;
  DateTime _currentDate = DateTime.now();
  bool _hasPost = true;

  void _sub() {
    _dailyPosts = null;
    _hasPost = true;
    setState(() {});
    DateTime _date = Jiffy(_currentDate).subtract(days: 1).dateTime;
    _currentDate = _date;
    reloadList();
  }

  void _add() {
    _dailyPosts = null;
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
    getGVPost(Jiffy(_currentDate).format("yyyy-MM-dd")).then((val) {
      _dailyPosts = val;
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
                _dailyPosts == null
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
                            final Post2 post = _dailyPosts[index];
                            return CheckinContainer(
                                onCreate: reloadList, post: post);
                          },
                          childCount: _dailyPosts.length,
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
