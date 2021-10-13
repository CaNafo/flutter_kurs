import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:movies_app/const.dart';
import 'package:movies_app/helpers/token.dart';

class ContentProvider with ChangeNotifier {
  Future<Map<String, dynamic>?> getContentDetails(int contentId) async {
    var apiUrl = Constants.baseUrl;
    var token = await Token.getJwtToken();

    var headers = {
      "Content-Type": "application/json",
      "Accept": "*/*",
      "Accept-Encoding": "gzip, deflate, br",
      "Authorization": "Bearer $token",
    };

    var res = await http.get(
      Uri.parse('$apiUrl/content/details?contentId=$contentId'),
      headers: headers,
    );

    if (res.statusCode != 200) return null;

    return jsonDecode(utf8.decode(res.bodyBytes)) as Map<String, dynamic>;
  }
}
