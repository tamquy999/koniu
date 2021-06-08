import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facebook_responsive_ui/config/palette.dart';
import 'package:flutter_facebook_responsive_ui/widgets/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

import 'bloc/login_bloc.dart';

class LoginTest extends StatefulWidget {
  @override
  _LoginTestState createState() => _LoginTestState();
}

class _LoginTestState extends State<LoginTest> {
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
          final bool isDesktop = Responsive.isDesktop(context);
          return Center(
            child: SingleChildScrollView(
              child: Card(
                color: Color(0xFFfafafa),
                // shadowColor: Colors.pink.shade100,
                shadowColor: Colors.white,
                elevation: isDesktop ? 100.0 : 0.0,
                shape: isDesktop
                    ? RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0))
                    : null,
                child: Container(
                  height:
                      isDesktop ? 600.0 : MediaQuery.of(context).size.height,
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  // color: Color(0xFFfafafa),
                  width: isDesktop ? 500.0 : double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      _logo(),
                      // _logoText(),
                      _inputField(
                          Icon(Icons.person_outline,
                              size: 30, color: Color(0xffA6B0BD)),
                          "Tài khoản",
                          false,
                          _usernameController,
                          state,
                          _onLoginButtonPressed),
                      _inputField(
                          Icon(Icons.lock_outline,
                              size: 30, color: Color(0xffA6B0BD)),
                          "Mật khẩu",
                          true,
                          _passwordController,
                          state,
                          _onLoginButtonPressed),
                      _loginBtn(state, _onLoginButtonPressed),
                      _dontHaveAcnt(),
                      _signUp(),
                      // _terms(),
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

Widget _terms() {
  return Container(
    padding: EdgeInsets.only(top: 10, bottom: 18),
    child: FlatButton(
      onPressed: () => {print("Terms pressed.")},
      child: Text(
        "Terms & Conditions",
        style: GoogleFonts.montserrat(
          textStyle: TextStyle(
            color: Color(0xffA6B0BD),
            fontWeight: FontWeight.w400,
            fontSize: 12,
          ),
        ),
      ),
    ),
  );
}

Widget _signUp() {
  return FlatButton(
    onPressed: () => {print("Sign up pressed.")},
    child: Text(
      "Đăng ký",
      style: GoogleFonts.montserrat(
        textStyle: TextStyle(
          color: Color(0xFF008FFF),
          fontWeight: FontWeight.w600,
          fontSize: 14,
        ),
      ),
    ),
  );
}

Widget _dontHaveAcnt() {
  return Text(
    "Chưa có tài khoản?",
    style: GoogleFonts.montserrat(
      textStyle: TextStyle(
        color: Color(0xffA6B0BD),
        fontWeight: FontWeight.w400,
        fontSize: 14,
      ),
    ),
  );
}

Widget _loginBtn(LoginState state, Function _onLoginButtonPressed) {
  return Container(
    width: double.infinity,
    margin: EdgeInsets.only(top: 20, bottom: 30),
    decoration: BoxDecoration(
        color: Color(0xff008FFF),
        borderRadius: BorderRadius.all(Radius.circular(50)),
        boxShadow: [
          BoxShadow(
            color: Color(0x60008FFF),
            blurRadius: 10,
            offset: Offset(0, 5),
            spreadRadius: 0,
          ),
        ]),
    child: FlatButton(
      onPressed: state is! LoginLoading ? _onLoginButtonPressed : null,
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Text(
        "Đăng nhập",
        style: GoogleFonts.montserrat(
          textStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.white,
            letterSpacing: 2,
          ),
        ),
      ),
    ),
  );
}

Widget _inputField(
    Icon prefixIcon,
    String hintText,
    bool isPassword,
    TextEditingController _controller,
    LoginState state,
    Function _onLoginButtonPressed) {
  return Container(
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
    child: TextField(
      controller: _controller,
      obscureText: isPassword,
      onSubmitted: (value) =>
          state is! LoginLoading ? _onLoginButtonPressed : null,
      style: GoogleFonts.montserrat(
        textStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: Color(0xff000912),
        ),
      ),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 20),
        hintText: hintText,
        hintStyle: TextStyle(
          color: Color(0xffA6B0BD),
        ),
        fillColor: Colors.white,
        filled: true,
        prefixIcon: prefixIcon,
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
  );
}

Widget _logoText() {
  return Container(
      margin: EdgeInsets.only(bottom: 50),
      child: Text(
        "koniu",
        style: GoogleFonts.nunito(
          textStyle: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.w800,
            color: Color(0xff000912),
            letterSpacing: 10,
          ),
        ),
      ));
}

Widget _logo() {
  return Container(
    margin: EdgeInsets.only(bottom: 50),
    child: SizedBox(
      height: 130.0,
      child: Hero(
        tag: "logo",
        child: Image.asset(
          "assets/images/Both.png",
          fit: BoxFit.contain,
        ),
      ),
    ),
  );
}
