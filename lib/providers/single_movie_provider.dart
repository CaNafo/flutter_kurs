import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'package:movies_app/const.dart';
import 'package:movies_app/helpers/token.dart';

class SingleMovieProvider with ChangeNotifier {
  late String _contentTitle;
  late String _trailerLink;
  late int _duration;
  late int _year;
  late List<dynamic> _genres;
  late List<dynamic> _seasons;
  late List<dynamic> _contentComments;
  late int _contentId;
  late bool _isFavorite = false;

  String get contentTitle => _contentTitle;

  String get trailerLink => _trailerLink;

  int get duration => _duration;

  int get year => _year;

  bool get isFavorite => _isFavorite;

  List<dynamic> get genres => [..._genres];

  List<dynamic> get seasons => [..._seasons];

  List<dynamic> get conentComments => [..._contentComments];

  SingleMovieProvider();
  SingleMovieProvider.value(Map<String, dynamic> data, int contentId) {
    populateData(data, contentId);
  }

  void populateData(Map<String, dynamic> data, int contentId) {
    _contentTitle = data['title'];
    _trailerLink = data['trailerLink'];
    _duration = data['duration'];
    _year = data['year'];
    _genres = data['genres'];
    _seasons = data['seasons'];
    _contentComments = data['contentComments'];
    _contentId = contentId;
    _isFavorite = data['favourite'];
  }

  int get conentId => _contentId;

  void _addComment(String name, String surname, String comment) {
    _contentComments.add(
      {
        "user": {
          "firstName": name,
          "lastName": surname,
        },
        "comment": comment
      },
    );
    notifyListeners();
  }

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

  Future<bool> addCommentApiCall(
    int contentId,
    String comment,
  ) async {
    var apiUrl = Constants.baseUrl;
    var token = await Token.getJwtToken();
    var parsedToken = await Token.decodeJWT();

    var headers = {
      "Content-Type": "application/json",
      "Accept": "*/*",
      "Accept-Encoding": "gzip, deflate, br",
      "Authorization": "Bearer $token",
    };

    var res = await http.post(
      Uri.parse('$apiUrl/user/comment'),
      body: jsonEncode(
        {
          "userId": parsedToken!['userId'],
          "contentId": contentId,
          "comment": comment,
          "replayId": null
        },
      ),
      headers: headers,
    );

    if (res.statusCode == 200) {
      _addComment(parsedToken['firstName'], parsedToken['lastName'], comment);
    }

    return res.statusCode == 200;
  }

  Future<void> addToFavorites() async {
    var apiUrl = Constants.baseUrl;
    var token = await Token.getJwtToken();
    var parsedToken = await Token.decodeJWT();

    _isFavorite = !_isFavorite;
    var headers = {
      "Content-Type": "application/json",
      "Accept": "*/*",
      "Accept-Encoding": "gzip, deflate, br",
      "Authorization": "Bearer $token",
    };

    var res = await http.post(
      Uri.parse('$apiUrl/user/favour'),
      body: jsonEncode(
        {
          "userId": parsedToken!['userId'],
          "contentId": _contentId,
          "favourite": _isFavorite
        },
      ),
      headers: headers,
    );

    if (res.statusCode == 200) {
      notifyListeners();
    } else {
      _isFavorite = !_isFavorite;
    }
  }
}
