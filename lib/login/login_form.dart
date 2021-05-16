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
  bool _obscureText = true;

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
                            "assets/images/Both.png",
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      SizedBox(height: 50.0),
                      // TextFormField(
                      //   decoration: InputDecoration(
                      //       labelText: 'Tài khoản',
                      //       icon: Icon(Icons.person_outline)),
                      //   controller: _usernameController,
                      // ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(50),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black,
                              blurRadius: 25,
                              offset: Offset(0, 5),
                              spreadRadius: -25,
                            ),
                          ],
                        ),
                        margin: EdgeInsets.only(bottom: 20),
                        child: TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          autofocus: false,
                          controller: _usernameController,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 20),
                            hintText: "Tài khoản",
                            hintStyle: TextStyle(
                              color: Color(0xffA6B0BD),
                            ),
                            fillColor: Colors.white,
                            filled: true,
                            prefixIcon: Icon(Icons.person_outline),
                            prefixIconConstraints: BoxConstraints(
                              minWidth: 75,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(50),
                              ),
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(50),
                              ),
                              borderSide: BorderSide(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      // TextFormField(
                      //   decoration: InputDecoration(
                      //     contentPadding:
                      //         EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      //     border: OutlineInputBorder(
                      //         borderRadius: BorderRadius.circular(32.0)),
                      //     labelText: 'Mật khẩu',
                      //     // icon: Icon(Icons.lock_outline),
                      //   ),
                      //   controller: _passwordController,
                      //   obscureText: true,
                      // ),
                      SizedBox(height: 20.0),
                      TextFormField(
                        autofocus: false,
                        obscureText: _obscureText,
                        keyboardType: TextInputType.text,
                        controller: _passwordController,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          contentPadding:
                              EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(32.0)),
                          suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                _obscureText = !_obscureText;
                              });
                            },
                            child: Icon(
                              _obscureText
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              semanticLabel: _obscureText
                                  ? 'show password'
                                  : 'hide password',
                            ),
                          ),
                        ),
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
