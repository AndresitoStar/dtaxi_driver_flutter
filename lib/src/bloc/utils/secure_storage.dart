import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  static void saveToken(String token) {
    FlutterSecureStorage().write(key: "token", value: token);
  }

  static Future<String> getToken() async {
    return FlutterSecureStorage().read(key: "token").then((val) => val);
  }
}
