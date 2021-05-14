import 'package:flutter/material.dart';
import 'package:flutter_facebook_responsive_ui/data/data.dart';
import 'package:flutter_facebook_responsive_ui/models/models.dart';
import 'package:flutter_facebook_responsive_ui/widgets/custom_silver_appbar.dart';
import 'package:flutter_facebook_responsive_ui/widgets/widgets.dart';

class ActivityScreen extends StatefulWidget {
  @override
  _ActivityScreenState createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
  final TrackingScrollController _trackingScrollController =
      TrackingScrollController();

  DateTime _now = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Responsive(
          mobile: _MobileActivityScreen(
            scrollController: _trackingScrollController,
            datetime: _now,
            sub: () {
              setState(() {
                DateTime _month = new DateTime(_now.year, _now.month - 1);
                _now = _month;
                // print(_now);
              });
            },
            add: () {
              setState(() {
                DateTime _month = new DateTime(_now.year, _now.month + 1);
                _now = _month;
                // print(_now);
              });
            },
          ),
          desktop: _DesktopActivityScreen(),
        ),
      ),
    );
  }
}

class _MobileActivityScreen extends StatelessWidget {
  final TrackingScrollController scrollController;
  final DateTime datetime;
  final Function sub;
  final Function add;

  const _MobileActivityScreen(
      {Key key,
      @required this.scrollController,
      @required this.datetime,
      @required this.sub,
      @required this.add})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: scrollController,
      slivers: [
        CustomSilverAppbar(),
        CustomMonthPicker(datetime: datetime, sub: sub, add: add),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              final Activity activity = activities[index];
              return ActivityContainer(activity: activity);
            },
            childCount: activities.length,
          ),
        ),
      ],
    );
  }
}

class _DesktopActivityScreen extends StatelessWidget {
  final TrackingScrollController scrollController;

  const _DesktopActivityScreen({Key key, this.scrollController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
