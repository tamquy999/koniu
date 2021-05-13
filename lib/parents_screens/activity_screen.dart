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

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Responsive(
          mobile: _MobileActivityScreen(),
          desktop: _DesktopActivityScreen(),
        ),
      ),
    );
  }
}

class _MobileActivityScreen extends StatelessWidget {
  final TrackingScrollController scrollController;

  const _MobileActivityScreen({Key key, this.scrollController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: scrollController,
      slivers: [
        CustomSilverAppbar(),
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
