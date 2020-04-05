// import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:dtaxi_driver/src/bloc/authentication/authentication_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SecureStorage {
  static void saveToken(String token) async {
    // FlutterSecureStorage().write(key: "token", value: token);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }

  static Future<String> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
    // return FlutterSecureStorage().read(key: "token");
  }

  static void removeToken() async {
    // FlutterSecureStorage().delete(key: "token");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("token");
  }

  static void saveUserAndPass(String username, String password) async {
    // FlutterSecureStorage().write(key: "username", value: username);
    // FlutterSecureStorage().write(key: "password", value: password);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', username);
    await prefs.setString('password', password);
  }

  static Future<Map<String, String>> loadUserAndPass() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var user = prefs.getString('username');
    var pass = prefs.getString('password');

    return {"username": user, "password": pass};
  }

  static void saveUserData(AuthenticationModel model) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('user.id', model.driver.id);
    await prefs.setString('user.userId', model.driver.userId);
    await prefs.setString('user.fullname', model.fullname);
    await prefs.setString('user.profileImageId', model.profileImageId);
    await prefs.setString('user.score', model.driver.score.toString());
    await prefs.setString('user.phone', model.driver.phone);
    await prefs.setString('user.state', model.driver.state);
  }

  static Future<void> saveDriverData(Driver model) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('user.id', model.id);
    if (model.userId != null)
      await prefs.setString('user.userId', model.userId);
    if (model.score != null)
      await prefs.setString('user.score', model.score.toString());
    if (model.phone != null) await prefs.setString('user.phone', model.phone);
    if (model.state != null) await prefs.setString('user.state', model.state);
  }

  static Future<AuthenticationModel> getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var fullname = prefs.getString('user.fullname');
    var profileImageId = prefs.getString('user.profileImageId');

    var id = prefs.getString('user.id');
    var userId = prefs.getString('user.userId');
    var score = prefs.getString('user.score');
    var phone = prefs.getString('user.phone');
    var state = prefs.getString('user.state');

    Driver driver = new Driver(id, fullname, userId,
        score: num.parse(score), phone: phone, state: state);

    return new AuthenticationModel(
        null, fullname, {"name": "DRIVER"}, profileImageId, driver);
  }
}
