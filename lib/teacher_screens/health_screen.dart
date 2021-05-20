import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_responsive_ui/config/palette.dart';
import 'package:flutter_facebook_responsive_ui/data/data.dart';
import 'package:flutter_facebook_responsive_ui/models/models.dart';
import 'package:flutter_facebook_responsive_ui/widgets/custom_silver_appbar.dart';
import 'package:flutter_facebook_responsive_ui/widgets/widgets.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class HealthScreen extends StatefulWidget {
  @override
  _HealthScreenState createState() => _HealthScreenState();
}

class _HealthScreenState extends State<HealthScreen> {
  final TrackingScrollController _trackingScrollController =
      TrackingScrollController();

  DateTime _now = DateTime.now();

  Health health = currentHealth;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Responsive(
          mobile: _MobileHealthScreen(
            scrollController: _trackingScrollController,
            health: health,
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
          desktop: _DesktopHealthScreen(
            scrollController: _trackingScrollController,
            health: health,
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
        ),
      ),
    );
  }
}

class _MobileHealthScreen extends StatelessWidget {
  final TrackingScrollController scrollController;
  final Health health;
  final DateTime datetime;
  final Function sub;
  final Function add;

  const _MobileHealthScreen({
    Key key,
    @required this.scrollController,
    @required this.health,
    @required this.datetime,
    @required this.sub,
    @required this.add,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Health lasthealth = lastHealth;
    // final Health health = currentHealth;

    return CustomScrollView(
      controller: scrollController,
      slivers: [
        CustomSilverAppbar(),
        CustomMonthPicker(datetime: datetime, sub: sub, add: add),
        // SliverList(
        //   delegate: SliverChildBuilderDelegate(
        //     (context, index) {
        //       final Health activity = activities[index];
        //       return HealthContainer(activity: activity);
        //     },
        //     childCount: healths.length,
        //   ),
        // ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              final Health health = healths[index];
              return HealthTeacherContainer(
                datetime: datetime,
                health: health,
                lasthealth: lasthealth,
              );
            },
            childCount: posts.length,
          ),
        ),
        SliverFillRemaining(
          hasScrollBody: false,
          child: datetime.month > DateTime.now().month
              ? Center(
                  child: Text(
                    "Chưa có thông tin sức khỏe tháng này",
                    style: TextStyle(color: Colors.black26),
                  ),
                )
              : HealthTeacherContainer(
                  datetime: datetime,
                  health: health,
                  lasthealth: lasthealth,
                ),
        ),
      ],
    );
  }
}

class _DesktopHealthScreen extends StatelessWidget {
  final TrackingScrollController scrollController;
  final Health health;
  final DateTime datetime;
  final Function sub;
  final Function add;

  const _DesktopHealthScreen(
      {Key key,
      this.scrollController,
      this.health,
      this.datetime,
      this.sub,
      this.add})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Health lasthealth = lastHealth;
    final Health health = currentHealth;

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
          child: CustomScrollView(
            controller: scrollController,
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
                sliver: SliverToBoxAdapter(),
              ),
              CustomMonthPicker(datetime: datetime, sub: sub, add: add),
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 5.0),
                sliver: SliverToBoxAdapter(),
              ),
              SliverFillRemaining(
                hasScrollBody: false,
                child: datetime.month >= DateTime.now().month
                    ? Center(
                        child: Text(
                          "Chưa có thông tin sức khỏe tháng này",
                          style: TextStyle(color: Colors.black26),
                        ),
                      )
                    : HealthTeacherContainer(
                        datetime: datetime,
                        health: health,
                        lasthealth: lasthealth,
                      ),
              ),
            ],
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
