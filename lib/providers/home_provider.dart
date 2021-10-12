import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:movies_app/const.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class HomeProvider extends ChangeNotifier {
  Future<List> getContentById(int genreId) async {
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

    var resList = jsonDecode(res.body) as List<dynamic>;

    return resList;
    // log((a[0] as Map<String, dynamic>)['contentType']['name'].toString());
    // log(a.toString());
  }

  Future<String?> getJwtToken() async {
    var prefs = await SharedPreferences.getInstance();
    // notifyListeners();
    return prefs.getString("token");
  }
}
