import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:movies_app/const.dart';
import 'package:movies_app/helpers/token.dart';

class FavouritesProvider with ChangeNotifier {
  Future<List<Map<String, dynamic>>?> getAllFavourites(int typeID) async {
    var token = await Token.getJwtToken();

    var apiUrl = "${Constants.baseUrl}/user/favourite-movies";
    var headers = {
      "Content-Type": "application/json",
      "Accept": "*/*",
      "Accept-Encoding": "gzip, deflate, br",
      "Authorization": "Bearer $token"
    };

    var res = await http.get(
      Uri.parse(apiUrl),
      headers: headers,
    );

    if (res.statusCode != 200) return null;
    var resList = (jsonDecode(utf8.decode(res.bodyBytes)) as List)
        .map((e) => e as Map<String, dynamic>)
        .toList();

    if (typeID != 0) {
      for (var element in resList) {
        if (element['contentType']['contentTypeId'] != typeID) {
          resList.remove(element);
        }
      }
    }

    return resList;
  }

  Future<bool> addRemoveFavourite(bool fav, int contentID) async {
    var token = await Token.getJwtToken();
    var parsedToken = await Token.decodeJWT();

    var apiUrl = "${Constants.baseUrl}/user/favour";
    var headers = {
      "Content-Type": "application/json",
      "Accept": "*/*",
      "Accept-Encoding": "gzip, deflate, br",
      "Authorization": "Bearer $token",
    };
    var res = await http.post(
      Uri.parse(apiUrl),
      headers: headers,
      body: jsonEncode({
        "userId": parsedToken!['userId'],
        "contentId": contentID,
        "favourite": fav,
      }),
    );

    if (res.statusCode != 200) return false;

    notifyListeners();
    return true;
  }
}
