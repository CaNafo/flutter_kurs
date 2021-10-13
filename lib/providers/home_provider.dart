import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:movies_app/const.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class HomeProvider extends ChangeNotifier {
  Future<List<Map<String, dynamic>>?> getContentById(int genreId) async {
    var apiUrl = '${Constants.baseUrl}/content/by-category';
    var token = await getJwtToken();

    var headers = {
      "Content-Type": "application/json",
      "Accept": "*/*",
      "Accept-Encoding": "gzip, deflate, br",
      "Authorization": "Bearer $token",
    };

    var res = await http.post(
      Uri.parse(apiUrl),
      headers: headers,
      body: jsonEncode({"genreId": genreId}),
    );

    if (res.statusCode != 200) return null;

    var resList = (jsonDecode(utf8.decode(res.bodyBytes)) as List)
        .map((e) => e as Map<String, dynamic>)
        .toList();

    return resList;
  }

  Future<String?> getJwtToken() async {
    var prefs = await SharedPreferences.getInstance();
    return prefs.getString("token");
  }
}
