import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:movies_app/const.dart';
import 'package:movies_app/helpers/token.dart';

class ContentProvider with ChangeNotifier {
  late final Map<int, List<Map<String, dynamic>>> _moviesList = {};
  late final Map<int, List<Map<String, dynamic>>> _seriesList = {};
  List<Map<String, dynamic>> _searchList = [];

  List<Map<String, dynamic>> getMoviesList(int genreId) =>
      [..._moviesList[genreId]!.toList()];
  List<Map<String, dynamic>> getSeriesList(int genreId) =>
      [..._seriesList[genreId]!.toList()];
  List<Map<String, dynamic>> get searchList => [..._searchList];

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

//Metoda koja prolazi kroz niz svih filmova i serija i dodaje elemente u listu searchList
//Na kraju se poziva ugrađena metoda notifyListeners() koja obavještava sve subskrajbere (U ovom slučaju SearchScreen) da treba da pokrenu ponovo svoju build metodu
  void searchContent(String searchText) {
    _searchList = [];

    _moviesList.forEach((key, value) {
      _addItemsToTheSearchList(searchText, _moviesList, key);
    });

    _seriesList.forEach((key, value) {
      _addItemsToTheSearchList(searchText, _seriesList, key);
    });

    notifyListeners();
  }

//Metoda koja dodaje elemente u listu _searchElements ona je izdvojena čisto da se izbjegne duplanje koda u metodi searchContent
  void _addItemsToTheSearchList(
      String searchText, Map<int, List<Map<String, dynamic>>> list, int key) {
    for (var contentElement in list[key] ?? []) {
      if (contentElement['title'].toString().toLowerCase().startsWith(
                searchText.toLowerCase(),
              ) &&
          !checkIfContentAlreadyExists(contentElement)) {
        _searchList.add(contentElement);
      }
    }
  }

//Metoda prolazi kroz sve elemente liste za pretragu i provjerava da li film/serija sa istim imenom već postoji u listi, ovo se koristi da se izbjegne duplanje elemenata
//Duplanje elementa je moguće zbog postojanja mogućnosti da jedan film/serija pripada u više različitih žanrova pa se u lsitama tretiraju kao različiti objekti

  bool checkIfContentAlreadyExists(Map<String, dynamic> content) {
    for (var searchElement in _searchList) {
      if (searchElement['title'].toString().contains(content['title'])) {
        return true;
      }
    }
    return false;
  }
}
