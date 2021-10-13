import 'package:shared_preferences/shared_preferences.dart';

class Token {
  static Future<String?> getJwtToken() async {
    var prefs = await SharedPreferences.getInstance();
    return prefs.getString("token");
  }

  static void saveToken(String token) async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setString("token", token);
  }
}
