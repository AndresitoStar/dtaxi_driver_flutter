// import 'package:flutter_secure_storage/flutter_secure_storage.dart';

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
}
