import 'package:flutter/material.dart';
import 'package:flutter_facebook_responsive_ui/widgets/widgets.dart';

class TeacherScreen extends StatelessWidget {
  // final Teacher teacher;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Responsive(
          mobile: _MobileTeacherScreen(),
          desktop: _DesktopTeacherScreen(),
        ),
      ),
    );
  }
}

class _MobileTeacherScreen extends StatefulWidget {
  @override
  __MobileTeacherScreenState createState() => __MobileTeacherScreenState();
}

class __MobileTeacherScreenState extends State<_MobileTeacherScreen> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class _DesktopTeacherScreen extends StatefulWidget {
  @override
  __DesktopTeacherScreenState createState() => __DesktopTeacherScreenState();
}

class __DesktopTeacherScreenState extends State<_DesktopTeacherScreen> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
