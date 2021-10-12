import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:movies_app/const.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  Future<bool> login(String username, String password) async {
    var apiUrl = "${Constants.baseUrl}/user/login";
    var headers = {
      "Content-Type": "application/json",
      "Accept": "*/*",
      "Accept-Encoding": "gzip, deflate, br"
    };

    var res = await http.post(
      Uri.parse(apiUrl),
      headers: headers,
      body: jsonEncode({
        "username": username,
        "password": password,
      }),
    );

    if (res.statusCode != 200) return false;
    var test = jsonDecode(res.body) as Map<String, dynamic>;
    // saveToken(.toString());
    saveToken(test['jwt'].toString());

    return true;
  }

  void saveToken(String token) async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setString("token", token);
  }

  Future<String?> getJwtToken() async {
    var prefs = await SharedPreferences.getInstance();
    return prefs.getString("token");
  }
}
