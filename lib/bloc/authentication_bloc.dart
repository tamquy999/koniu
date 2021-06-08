import 'dart:async';
// import 'dart:html';

import 'package:bloc/bloc.dart';
import 'package:flutter_facebook_responsive_ui/api_connection/jwt_decoder.dart';
import 'package:flutter_facebook_responsive_ui/models/models.dart';
import 'package:flutter_facebook_responsive_ui/repository/user_repository.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:shared_preferences/shared_preferences.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc({@required this.userRepository})
      : assert(UserRepository != null),
        super(AuthenticationUnauthenticated());

  final UserRepository userRepository;

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is AppStarted) {
      // print("checkToken");
      bool hasToken = false;
      int permission = -1;

      if (!kIsWeb) {
        hasToken = await userRepository.hasToken();
        permission = await userRepository.getPermission();
        // print(permission);
      } else {
        // hasToken = window.localStorage["access-token"] != null ? true : false;
        // Map<String, dynamic> parsedToken =
        //     parseJwt(window.localStorage["access-token"]);
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String stringValue = prefs.getString('access-token');
        if (stringValue != null) {
          hasToken = true;
          Map<String, dynamic> parsedToken = parseJwt(stringValue);
          permission = parsedToken["quyen"];
        }
        print(stringValue);
      }

      print("hasToken" + hasToken.toString());
      if (hasToken) {
        if (permission == 1) yield AuthenticationAuthenticated_GV();
        if (permission == 2) yield AuthenticationAuthenticated_PH();
      } else {
        yield AuthenticationUnauthenticated();
      }
    }

    if (event is LoggedIn) {
      yield AuthenticationLoading();

      Map<String, dynamic> parsedToken = parseJwt(event.user.token);

      int permission = parsedToken["quyen"];

      if (kIsWeb) {
        print("web");
        // window.localStorage["access-token"] = event.user.token;
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('access-token', event.user.token);
      } else {
        print("android");
        await userRepository.persistToken(user: event.user);
      }

      if (permission == 1) yield AuthenticationAuthenticated_GV();
      if (permission == 2) yield AuthenticationAuthenticated_PH();
    }

    if (event is LoggedOut) {
      yield AuthenticationLoading();

      if (!kIsWeb)
        await userRepository.deleteToken(id: 0);
      else
      // window.localStorage.remove("access-token");
      {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.remove('access-token');
      }

      yield AuthenticationUnauthenticated();
    }
  }
}
