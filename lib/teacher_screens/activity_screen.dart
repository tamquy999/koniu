import 'package:flutter/material.dart';
import 'package:flutter_facebook_responsive_ui/data/data.dart';
import 'package:flutter_facebook_responsive_ui/models/models.dart';
import 'package:flutter_facebook_responsive_ui/widgets/widgets.dart';
import 'package:jiffy/jiffy.dart';

class ActivityScreen extends StatefulWidget {
  @override
  _ActivityScreenState createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
  final TrackingScrollController _trackingScrollController =
      TrackingScrollController();

  DateTime _currentDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Responsive(
          mobile: _ActivityScreenMobile(
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
          desktop: _ActivityScreenDesktop(),
        ),
      ),
    );
  }
}

class _ActivityScreenMobile extends StatelessWidget {
  final TrackingScrollController scrollController;
  final DateTime datetime;
  final Function sub;
  final Function add;

  const _ActivityScreenMobile(
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
              final Activity activity = activities[index];
              return ActivityTeacherContainer(activity: activity);
            },
            childCount: activities.length,
          ),
        ),
      ],
    );
  }
}

class _ActivityScreenDesktop extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
