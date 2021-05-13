import 'package:flutter/material.dart';
import 'package:flutter_facebook_responsive_ui/data/data.dart';
import 'package:flutter_facebook_responsive_ui/models/models.dart';
import 'package:flutter_facebook_responsive_ui/widgets/custom_silver_appbar.dart';
import 'package:flutter_facebook_responsive_ui/widgets/widgets.dart';

class MealScreen extends StatefulWidget {
  @override
  _MealScreenState createState() => _MealScreenState();
}

class _MealScreenState extends State<MealScreen> {
  final TrackingScrollController _trackingScrollController =
      TrackingScrollController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Responsive(
          mobile: _MobileMealScreen(),
          desktop: _DesktopMealScreen(),
        ),
      ),
    );
  }
}

class _MobileMealScreen extends StatelessWidget {
  final TrackingScrollController scrollController;

  const _MobileMealScreen({Key key, this.scrollController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: scrollController,
      slivers: [
        CustomSilverAppbar(),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              final Meal meal = meals[index];
              return MealContainer(meal: meal);
            },
            childCount: meals.length,
          ),
        ),
      ],
    );
  }
}

class _DesktopMealScreen extends StatelessWidget {
  final TrackingScrollController scrollController;

  const _DesktopMealScreen({Key key, this.scrollController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
