import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:movies_app/const.dart';
import 'package:http/http.dart' as http;

class LoginProvider extends ChangeNotifier {
  Future<bool> login(String username, String password) async {
    var apiUrl = Constants.baseUrl + "/user/login";
    var headers = {
      "Content-Type": "application/json",
      "Accept": "*/*",
      "Accept-Encoding": "gzip, deflate, br",
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

    return true;
  }
}
