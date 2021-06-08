// import 'package:flutter/material.dart';
// import 'package:flutter_facebook_responsive_ui/config/palette.dart';
// import 'package:flutter_facebook_responsive_ui/login/login.dart';
// import 'package:flutter_facebook_responsive_ui/parents_screens/screens.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Koniu',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         visualDensity: VisualDensity.adaptivePlatformDensity,
//         scaffoldBackgroundColor: Palette.scaffold,
//       ),
//       home: LoginScreen(),
//     );
//   }
// }
//
import 'package:flutter/material.dart';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facebook_responsive_ui/login/login_page.dart';

import 'bloc/authentication_bloc.dart';
import 'config/palette.dart';
import 'repository/user_repository.dart';
import 'screens/parents_screens/nav_screen.dart';
import 'screens/teacher_screens/screens.dart';
import 'widgets/widgets.dart';

class SimpleBlocDelegate extends BlocDelegate {
  @override
  void onEvent(Bloc bloc, Object event) {
    super.onEvent(bloc, event);
    print(event);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print(transition);
  }

  @override
  void onError(Bloc bloc, Object error, StackTrace stacktrace) {
    super.onError(bloc, error, stacktrace);
    print(error);
  }
}

void main() {
  // BlocSupervisor.delegate = SimpleBlocDelegate();
  final userRepository = UserRepository();

  runApp(BlocProvider<AuthenticationBloc>(
    create: (context) {
      return AuthenticationBloc(userRepository: userRepository)
        ..add(AppStarted());
    },
    child: App(userRepository: userRepository),
  ));
}

class App extends StatelessWidget {
  final UserRepository userRepository;

  App({Key key, @required this.userRepository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        scaffoldBackgroundColor: Palette.scaffold,
      ),
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state is AuthenticationUninitialized) {
            return Scaffold(
              body: Center(
                child: Text('Splash Screen'),
              ),
            );
          }
          if (state is AuthenticationAuthenticated_PH) {
            return NavScreen();
          }
          if (state is AuthenticationAuthenticated_GV) {
            return NavScreenTeacher();
          }
          if (state is AuthenticationUnauthenticated) {
            return LoginPage(
              userRepository: userRepository,
            );
            // return NavScreen();
          }
          if (state is AuthenticationLoading) {
            return LoadingIndicator();
          }
        },
      ),
    );
  }
}

class BlocDelegate {
  Future<void> Function(dynamic error, StackTrace stack, {dynamic context})
      logger;

  /// Called whenever an [event] is `added` to any [bloc] with the given [bloc] and [event].
  /// A great spot to add universal logging/analytics.
  @mustCallSuper
  void onEvent(Bloc bloc, Object event) => null;

  /// Called whenever a transition occurs in any [bloc] with the given [bloc] and [transition].
  /// A [transition] occurs when a new `event` is `added` and `mapEventToState` executed.
  /// [onTransition] is called before a [bloc]'s state has been updated.
  /// A great spot to add universal logging/analytics.
  @mustCallSuper
  void onTransition(Bloc bloc, Transition transition) => null;

  /// Called whenever an [error] is thrown in any [bloc]
  /// with the given [bloc], [error], and [stacktrace].
  /// The [stacktrace] argument may be `null` if the state stream received an error without a [stacktrace].
  /// A great spot to add universal error handling.
  @mustCallSuper
  void onError(Bloc bloc, Object error, StackTrace stacktrace) => null;
}
