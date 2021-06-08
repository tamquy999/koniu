import 'dart:async';
import 'package:flutter_facebook_responsive_ui/api_connection/api_connection.dart';
import 'package:flutter_facebook_responsive_ui/dao/user_dao.dart';
import 'package:flutter_facebook_responsive_ui/models/api_model.dart';
import 'package:flutter_facebook_responsive_ui/models/user_model.dart';
import 'package:meta/meta.dart';
import 'package:jwt_decode/jwt_decode.dart';

class UserRepository {
  final userDao = UserDao();

  Future<DbUser> authenticate({
    @required String username,
    @required String password,
  }) async {
    UserLogin userLogin = UserLogin(username: username, password: password);
    Token token = await getToken(userLogin);

    Map<String, dynamic> payload = Jwt.parseJwt(token.token);
    int userid = payload['id'];
    int quyen = payload['id'];

    DbUser user = DbUser(
      id: 0,
      userid: userid,
      username: username,
      token: token.token,
      quyen: quyen,
    );
    return user;
  }

  Future<void> persistToken({@required DbUser user}) async {
    // write token with the user to the database
    await userDao.createUser(user);
  }

  Future<void> deleteToken({@required int id}) async {
    await userDao.deleteUser(id);
  }

  Future<bool> hasToken() async {
    bool result = await userDao.checkUser(0);
    print("dao" + result.toString());
    return result;
  }

  Future<int> getPermission() async {
    int result = await userDao.getUserPermission(0);
    return result;
  }

  Future<String> getUserToken() async {
    String result = await userDao.getUserToken(0);
    return result;
  }
}
