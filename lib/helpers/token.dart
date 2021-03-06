import 'package:jwt_decode/jwt_decode.dart';
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

  static Future<Map<String, dynamic>?> decodeJWT() async {
    var token = await getJwtToken();
    if (token == null) return null;

    Map<String, dynamic> payload = Jwt.parseJwt(token);
    return (payload);
  }

  static Future<void> removeToken() async {
    var prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}
