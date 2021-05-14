import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facebook_responsive_ui/config/palette.dart';
import 'package:flutter_facebook_responsive_ui/login/bloc/login_bloc.dart';

class LoginForm extends StatefulWidget {
  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _onLoginButtonPressed() {
      BlocProvider.of<LoginBloc>(context).add(LoginButtonPressed(
        username: _usernameController.text,
        password: _passwordController.text,
      ));
    }

    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginFaliure) {
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text('${state.error}'),
            backgroundColor: Colors.red,
          ));
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          return SingleChildScrollView(
            child: Container(
              // height: MediaQuery.of(context).size.height,
              child: Form(
                child: Padding(
                  padding: EdgeInsets.all(40.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.1),
                      SizedBox(
                        height: 130.0,
                        child: Hero(
                          tag: "logo",
                          child: Image.asset(
                            "assets/images/IconOnly.png",
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      SizedBox(height: 30.0),
                      TextFormField(
                        decoration: InputDecoration(
                            labelText: 'Tên đăng nhập',
                            icon: Icon(Icons.person)),
                        controller: _usernameController,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                            labelText: 'Mật khẩu', icon: Icon(Icons.security)),
                        controller: _passwordController,
                        obscureText: true,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.85,
                        height: MediaQuery.of(context).size.width * 0.22,
                        child: Padding(
                          padding: EdgeInsets.only(top: 30.0),
                          child: TextButton(
                            onPressed: state is! LoginLoading
                                ? _onLoginButtonPressed
                                : null,
                            child: Text(
                              'Đăng nhập',
                              style: TextStyle(
                                fontSize: 20.0,
                              ),
                            ),
                            style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all<Color>(
                                  Colors.white),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Palette.koniuBlue),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                  // side: BorderSide(color: Colors.red),
                                ),
                              ),
                            ),
                            // shape: StadiumBorder(
                            //   side: BorderSide(
                            //     color: Colors.black,
                            //     width: 2,
                            //   ),
                            // ),
                          ),
                        ),
                      ),
                      Container(
                        child: state is LoginLoading
                            ? CircularProgressIndicator()
                            : null,
                      ),
                      // SizedBox(height: 80.0)
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
