import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  static void saveToken(String token) {
    FlutterSecureStorage().write(key: "token", value: token);
  }

  static Future<String> getToken() async {
    return FlutterSecureStorage().read(key: "token");
  }

  static void removeToken() {
    FlutterSecureStorage().delete(key: "token");
  }

  static void saveUserAndPass(String username, String password) {
    FlutterSecureStorage().write(key: "username", value: username);
    FlutterSecureStorage().write(key: "password", value: password);
  }

  static Future<Map<String, String>> loadUserAndPass() async {
    var user = await FlutterSecureStorage().read(key: "username");
    var pass = await FlutterSecureStorage().read(key: "password");
    return {"username": user, "password": pass};
  }
}
