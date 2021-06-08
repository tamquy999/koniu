import 'package:flutter_facebook_responsive_ui/database/user_database.dart';
import 'package:flutter_facebook_responsive_ui/models/user_model.dart';

class UserDao {
  final dbProvider = DatabaseProvider.dbProvider;

  Future<int> createUser(DbUser user) async {
    final db = await dbProvider.database;

    var result = db.insert(userTable, user.toDatabaseJson());
    return result;
  }

  Future<int> deleteUser(int id) async {
    final db = await dbProvider.database;
    var result = await db.delete(userTable, where: "id = ?", whereArgs: [id]);
    return result;
  }

  Future<bool> checkUser(int id) async {
    final db = await dbProvider.database;
    print(db);
    try {
      List<Map> users =
          await db.query(userTable, where: 'id = ?', whereArgs: [id]);
      print("user" + users.toString());
      if (users.length > 0) {
        return true;
      } else {
        return false;
      }
    } catch (error) {
      return false;
    }
  }

  Future<String> getUserToken(int id) async {
    final db = await dbProvider.database;
    print(db);
    try {
      List<Map> users =
          await db.query(userTable, where: 'id = ?', whereArgs: [id]);
      // print("user" + users.toString());
      if (users.length > 0) {
        return users[0]["access_token"];
      } else {
        return "";
      }
    } catch (error) {
      return "";
    }
  }

  Future<int> getUserPermission(int id) async {
    final db = await dbProvider.database;
    print(db);
    try {
      List<Map> users =
          await db.query(userTable, where: 'id = ?', whereArgs: [id]);
      // print("user" + users.toString());
      if (users.length > 0) {
        return users[0]["quyen"];
      } else {
        return -1;
      }
    } catch (error) {
      return -1;
    }
  }
}
