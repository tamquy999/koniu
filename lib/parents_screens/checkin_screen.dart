import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_responsive_ui/config/palette.dart';
import 'package:flutter_facebook_responsive_ui/data/data.dart';
import 'package:flutter_facebook_responsive_ui/models/models.dart';
import 'package:flutter_facebook_responsive_ui/parents_screens/screens.dart';
import 'package:flutter_facebook_responsive_ui/widgets/custom_silver_appbar.dart';
import 'package:flutter_facebook_responsive_ui/widgets/widgets.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class CheckinScreen extends StatefulWidget {
  @override
  _CheckinScreenState createState() => _CheckinScreenState();
}

class _CheckinScreenState extends State<CheckinScreen> {
  final TrackingScrollController _trackingScrollController =
      TrackingScrollController();

  DateTime _now = DateTime.now();

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
          desktop: _CheckinScreenDesktop(
              scrollController: _trackingScrollController),
        ),
      ),
    );
  }
}

class _CheckinScreenMobile extends StatelessWidget {
  final TrackingScrollController scrollController;
  final DateTime datetime;
  final Function sub;
  final Function add;

  const _CheckinScreenMobile({
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
        CustomMonthPicker(datetime: datetime, sub: sub, add: add),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              final Post post = posts[index];
              return PostContainer(post: post);
            },
            childCount: posts.length,
          ),
        ),
      ],
    );
  }
}

class _CheckinScreenDesktop extends StatelessWidget {
  final TrackingScrollController scrollController;

  const _CheckinScreenDesktop({
    Key key,
    @required this.scrollController,
  }) : super(key: key);

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
          width: 600.0,
          child: CustomScrollView(
            controller: scrollController,
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 10.0),
                sliver: SliverToBoxAdapter(),
              ),
              SliverToBoxAdapter(
                child: CreatePostContainer(currentUser: currentUser),
              ),
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 5.0),
                sliver: SliverToBoxAdapter(),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final Post post = posts[index];
                    return PostContainer(post: post);
                  },
                  childCount: posts.length,
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
