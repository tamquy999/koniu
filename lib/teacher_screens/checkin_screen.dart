import 'package:flutter/material.dart';
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

  DateTime _currentDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Responsive(
          mobile: _CheckinScreenTeacherMobile(
            scrollController: _trackingScrollController,
            datetime: _currentDate,
            sub: () => setState(() {
              DateTime _date = Jiffy(_currentDate).subtract(days: 1).dateTime;
              _currentDate = _date;
              print(_currentDate);
            }),
            add: () => setState(() {
              DateTime _date = Jiffy(_currentDate).add(days: 1).dateTime;
              _currentDate = _date;
              print(_currentDate);
            }),
          ),
          desktop: _CheckinScreenTeacherDesktop(),
        ),
      ),
    );
  }
}

class _CheckinScreenTeacherMobile extends StatelessWidget {
  final TrackingScrollController scrollController;
  final DateTime datetime;
  final Function sub;
  final Function add;

  const _CheckinScreenTeacherMobile(
      {Key key, this.scrollController, this.datetime, this.sub, this.add})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: scrollController,
      slivers: [
        CustomSilverAppbar(),
        CustomDatePicker(datetime: datetime, sub: sub, add: add),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              final Post post = posts[index];
              return CheckinContainer(post: post);
            },
            childCount: posts.length,
          ),
        ),
      ],
    );
  }
}

class _CheckinScreenTeacherDesktop extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
