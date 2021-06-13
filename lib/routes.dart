import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_responsive_ui/screens/account_screen.dart';
import 'package:flutter_facebook_responsive_ui/screens/kid_screen.dart';
import 'package:flutter_facebook_responsive_ui/screens/parent_screen.dart';
import 'package:flutter_facebook_responsive_ui/screens/parents_screens/screens.dart';
import 'package:flutter_facebook_responsive_ui/screens/teacher_screens/screens.dart';
import 'package:flutter_facebook_responsive_ui/screens/teacher_screen.dart';

class Flurorouter {
  static final FluroRouter router = FluroRouter();

  static Handler _checkinParentHandler = Handler(
      handlerFunc: (BuildContext context, Map<String, dynamic> params) =>
          CheckinScreen());

  static Handler _meHandler = Handler(
      handlerFunc: (BuildContext context, Map<String, dynamic> params) =>
          AccountScreen());

  static Handler _kidHandler = Handler(
      handlerFunc: (BuildContext context, Map<String, dynamic> params) =>
          KidScreen(idHS: params['idHS'][0]));

  static Handler _parentHandler = Handler(
      handlerFunc: (BuildContext context, Map<String, dynamic> params) =>
          ParentScreen(idPH: params['idPH'][0]));

  static Handler _teacherHandler = Handler(
      handlerFunc: (BuildContext context, Map<String, dynamic> params) =>
          TeacherScreen(idGV: params['idGV'][0]));

  // ok its all set now .....
  // now lets have a handler for passing parameter tooo....

  static void setupRouter() {
    router.define(
      '/',
      handler: _checkinParentHandler,
    );
    router.define(
      '/me',
      handler: _meHandler,
      transitionType: TransitionType.inFromRight,
    );
    router.define(
      '/kid/:idHS',
      handler: _kidHandler,
      transitionType: TransitionType.inFromRight,
    );
    router.define(
      '/parent/:idPH',
      handler: _parentHandler,
      transitionType: TransitionType.inFromRight,
    );
    router.define(
      '/teacher/:idGV',
      handler: _teacherHandler,
      transitionType: TransitionType.inFromRight,
    );
  }
}
