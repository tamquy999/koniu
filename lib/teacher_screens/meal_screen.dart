import 'package:flutter/material.dart';
import 'package:flutter_facebook_responsive_ui/data/data.dart';
import 'package:flutter_facebook_responsive_ui/models/models.dart';
import 'package:flutter_facebook_responsive_ui/widgets/custom_silver_appbar.dart';
import 'package:flutter_facebook_responsive_ui/widgets/widgets.dart';
import 'package:jiffy/jiffy.dart';

class MealScreen extends StatefulWidget {
  @override
  _MealScreenState createState() => _MealScreenState();
}

class _MealScreenState extends State<MealScreen> {
  final TrackingScrollController _trackingScrollController =
      TrackingScrollController();

  DateTime _currentDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Responsive(
          mobile: _MobileMealScreen(
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
          desktop: _DesktopMealScreen(
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
        ),
      ),
    );
  }
}

class _MobileMealScreen extends StatelessWidget {
  final TrackingScrollController scrollController;
  final DateTime datetime;
  final Function sub;
  final Function add;

  const _MobileMealScreen({
    Key key,
    @required this.scrollController,
    @required this.datetime,
    @required this.sub,
    @required this.add,
  }) : super(key: key);

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
              final Meal meal = meals[0];
              return MealTeacherContainer(meal: meal);
            },
            childCount: 1,
          ),
        ),
      ],
    );
  }
}

class _DesktopMealScreen extends StatelessWidget {
  final TrackingScrollController scrollController;
  final DateTime datetime;
  final Function sub;
  final Function add;

  const _DesktopMealScreen(
      {Key key, this.scrollController, this.datetime, this.sub, this.add})
      : super(key: key);

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
          child: CustomScrollView(
            controller: scrollController,
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
                sliver: SliverToBoxAdapter(),
              ),
              CustomDatePicker(datetime: datetime, sub: sub, add: add),
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 5.0),
                sliver: SliverToBoxAdapter(),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final Meal meal = meals[index];
                    return MealTeacherContainer(meal: meal);
                  },
                  childCount: meals.length,
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
