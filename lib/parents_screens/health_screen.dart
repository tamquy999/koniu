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
    final Health health = currentHealth;

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
        //     childCount: posts.length,
        //   ),
        // ),
        SliverFillRemaining(
          hasScrollBody: false,
          child: datetime.month > DateTime.now().month
              ? Center(
                  child: Text(
                    "Chưa có thông tin sức khỏe tháng này",
                    style: TextStyle(color: Colors.black26),
                  ),
                )
              : HealthContainer(
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
                    : HealthContainer(
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

class HealthContainer extends StatelessWidget {
  final DateTime datetime;
  final Health health;
  final Health lasthealth;

  const HealthContainer(
      {Key key,
      @required this.datetime,
      @required this.health,
      @required this.lasthealth})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isDesktop = Responsive.isDesktop(context);
    return Column(
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.symmetric(
              horizontal: isDesktop ? 0.0 : 10.0, vertical: 5.0),
          height: 120.0,
          decoration: BoxDecoration(
              color: Palette.koniuBlue,
              borderRadius: BorderRadius.circular(10.0)),
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
                            "Chỉ số BMI (kg/m2)",
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
                            "Bình thường",
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
                            health.bmi.toString(),
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
                            "Tháng trước: ${lasthealth.bmi.toString()}",
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
          margin: EdgeInsets.symmetric(
              horizontal: isDesktop ? 0.0 : 10.0, vertical: 5.0),
          height: 180.0,
          // color: Colors.amber,
          child: Row(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
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
                              health.weight.toString(),
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
                                  child: health.weight > lasthealth.weight
                                      ? Text(
                                          "▲ ${(health.weight - lasthealth.weight).toStringAsFixed(1)} kg",
                                          style: TextStyle(color: Colors.green),
                                        )
                                      : Text(
                                          "▼ ${(lasthealth.weight - health.weight).toStringAsFixed(1)} kg",
                                          style: TextStyle(color: Colors.red),
                                        ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Expanded(
                          flex: 2,
                          child: Container(
                            width: double.infinity,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.blue.shade200,
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: Text(
                              "Bình thường",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
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
                    color: Colors.white,
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
                              health.height.toString(),
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
                                  child: health.height > lasthealth.height
                                      ? Text(
                                          "▲ ${(health.height - lasthealth.height).toStringAsFixed(1)} cm",
                                          style: TextStyle(color: Colors.green),
                                        )
                                      : Text(
                                          "▼ ${(lasthealth.height - health.height).toStringAsFixed(1)} cm",
                                          style: TextStyle(color: Colors.red),
                                        ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Expanded(
                          flex: 2,
                          child: Container(
                            width: double.infinity,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.blue.shade200,
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: Text(
                              "Bình thường",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
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
    );
  }
}
