import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:movies_app/helpers/token.dart';
import 'package:movies_app/const.dart';

class AuthProvider with ChangeNotifier {
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
    Token.saveToken(test['jwt'].toString());

    return true;
  }

  Future<void> logOut() async {
    await Token.removeToken();
    notifyListeners();
  }
}
