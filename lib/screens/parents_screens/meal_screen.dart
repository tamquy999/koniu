import 'package:flutter/material.dart';
import 'package:flutter_facebook_responsive_ui/api_connection/api_connection.dart';
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

  DateTime _now = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Responsive(
          mobile:
              _MobileMealScreen(scrollController: _trackingScrollController),
          desktop:
              _DesktopMealScreen(scrollController: _trackingScrollController),
        ),
      ),
    );
  }
}

class _MobileMealScreen extends StatefulWidget {
  final TrackingScrollController scrollController;

  const _MobileMealScreen({Key key, @required this.scrollController})
      : super(key: key);
  @override
  __MobileMealScreenState createState() => __MobileMealScreenState();
}

class __MobileMealScreenState extends State<_MobileMealScreen> {
  List<Meal> _monthMeals;
  bool _hasPost = true;
  DateTime _currentMonth = DateTime.now();

  void _sub() {
    _monthMeals = null;
    _hasPost = true;
    setState(() {});
    DateTime _date = Jiffy(_currentMonth).subtract(months: 1).dateTime;
    _currentMonth = _date;
    reloadList();
  }

  void _add() {
    _monthMeals = null;
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
    getMeals(_currentMonth.toString().substring(0, 10)).then((val) {
      _monthMeals = val;
      _hasPost = _monthMeals.length == 0 || _monthMeals == null ? false : true;
      if (_monthMeals.length == 0 || _monthMeals == null) _monthMeals = null;
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
    return CustomScrollView(
      controller: widget.scrollController,
      physics:
          const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      slivers: [
        CustomSilverAppbar(),
        CustomMonthPicker(datetime: _currentMonth, sub: _sub, add: _add),
        _monthMeals == null
            ? SliverFillRemaining(
                child: Center(
                  // child: Text(_hasPost.toString()),
                  child: _hasPost
                      ? CircularProgressIndicator()
                      : Text(
                          Jiffy(_currentMonth).format("MM/yyyy").compareTo(
                                      Jiffy(DateTime.now())
                                          .format("MM/yyyy")) ==
                                  0
                              ? "Ch??a c?? th??ng tin th???c ????n"
                              : "Kh??ng c?? th??ng tin th???c ????n",
                          style: TextStyle(color: Colors.black26),
                        ),
                ),
              )
            : SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final Meal meal = _monthMeals[index];
                    return MealContainer(meal: meal);
                  },
                  childCount: _monthMeals.length,
                ),
              ),
      ],
    );
  }
}

class _DesktopMealScreen extends StatefulWidget {
  final TrackingScrollController scrollController;

  const _DesktopMealScreen({Key key, this.scrollController}) : super(key: key);

  @override
  __DesktopMealScreenState createState() => __DesktopMealScreenState();
}

class __DesktopMealScreenState extends State<_DesktopMealScreen> {
  List<Meal> _monthMeals;
  bool _hasPost = true;
  DateTime _currentMonth = DateTime.now();

  void _sub() {
    _monthMeals = null;
    _hasPost = true;
    setState(() {});
    DateTime _date = Jiffy(_currentMonth).subtract(months: 1).dateTime;
    _currentMonth = _date;
    reloadList();
  }

  void _add() {
    _monthMeals = null;
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
    getMeals(_currentMonth.toString().substring(0, 10)).then((val) {
      _monthMeals = val;

      _hasPost = _monthMeals.length == 0 || _monthMeals == null ? false : true;
      if (_monthMeals.length == 0 || _monthMeals == null) _monthMeals = null;
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
                _monthMeals == null
                    ? SliverFillRemaining(
                        child: Center(
                          // child: Text(_hasPost.toString()),
                          child: _hasPost
                              ? CircularProgressIndicator()
                              : Text(
                                  Jiffy(_currentMonth)
                                              .format("MM/yyyy")
                                              .compareTo(Jiffy(DateTime.now())
                                                  .format("MM/yyyy")) ==
                                          0
                                      ? "Ch??a c?? th??ng tin th???c ????n"
                                      : "Kh??ng c?? th??ng tin th???c ????n",
                                  style: TextStyle(color: Colors.black26),
                                ),
                        ),
                      )
                    : SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            final Meal meal = _monthMeals[index];
                            return MealContainer(meal: meal);
                          },
                          childCount: _monthMeals.length,
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
