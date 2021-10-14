import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:movies_app/const.dart';
import 'package:movies_app/helpers/token.dart';

class ContentProvider with ChangeNotifier {
  late final Map<int, List<Map<String, dynamic>>> _moviesList = {};
  late final Map<int, List<Map<String, dynamic>>> _seriesList = {};

  List<Map<String, dynamic>> getMoviesList(int genreId) =>
      [..._moviesList[genreId]!.toList()];
  List<Map<String, dynamic>> getSeriesList(int genreId) =>
      [..._seriesList[genreId]!.toList()];

  Future<bool> getContentByGenreAndType(int genreId, int typeId) async {
    var apiUrl = '${Constants.baseUrl}/content/by-category';
    var token = await Token.getJwtToken();

    var headers = {
      "Content-Type": "application/json",
      "Accept": "*/*",
      "Accept-Encoding": "gzip, deflate, br",
      "Authorization": "Bearer $token",
    };

    var res = await http.post(
      Uri.parse(apiUrl),
      headers: headers,
      body: jsonEncode(
        {"genreId": genreId, "contentTypeId": typeId},
      ),
    );

    if (res.statusCode != 200) return false;

    var resList = (jsonDecode(utf8.decode(res.bodyBytes)) as List)
        .map((e) => e as Map<String, dynamic>)
        .toList();

    if (typeId == 1) {
      _moviesList.addAll({genreId: resList});
    } else {
      _seriesList.addAll({genreId: resList});
    }

    return true;
  }

  Future<List<Map<String, dynamic>>?> getAllGenres() async {
    var apiUrl = Constants.baseUrl;
    var token = await Token.getJwtToken();

    var headers = {
      "Content-Type": "application/json",
      "Accept": "*/*",
      "Accept-Encoding": "gzip, deflate, br",
      "Authorization": "Bearer $token",
    };

    var res = await http.get(
      Uri.parse('$apiUrl/genre/all'),
      headers: headers,
    );

    if (res.statusCode != 200) return null;

    var resList = (jsonDecode(utf8.decode(res.bodyBytes)) as List)
        .map((e) => e as Map<String, dynamic>)
        .toList();

    return resList;
  }
}
