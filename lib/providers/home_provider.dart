import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:movies_app/const.dart';
import 'package:http/http.dart' as http;

class HomeProvider extends ChangeNotifier {
  Future<void> getContentById(int genreId) async {
    var apiUrl = '${Constants.baseUrl}/content/by-category';

    var headers = {
      "Content-Type": "application/json",
      "Accept": "*/*",
      "Accept-Encoding": "gzip, deflate, br",
      "Authorization":
          "Bearer eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJuaWtvbGEiLCJleHAiOjE2NjU0ODY2MjUsImlhdCI6MTYzMzk1MDYyNX0.WQ7K4M4hW1QQYHxX_vSbMmcQsQOoxgn-0zgltDzRENM",
    };

    var res = await http.post(
      Uri.parse(apiUrl),
      headers: headers,
      body: jsonEncode({"genreId": genreId}),
    );

    var a = jsonDecode(res.body) as List<dynamic>;

    log((a[0] as Map<String, dynamic>)['contentType']['name'].toString());
  }
}
