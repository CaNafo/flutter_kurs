import 'package:flutter/material.dart';
import 'package:movies_app/l10n/l10n.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalizationProvider with ChangeNotifier {
  late Locale _locale;

  LocalizationProvider(SharedPreferences locale) {
    var tempLocale = locale.getString("locale");
    if (tempLocale != null) {
      if (!L10n.all.contains(
        Locale(tempLocale),
      )) return;
      _locale = Locale(tempLocale);
    } else {
      _locale = const Locale("en");
    }

    SharedPreferences.getInstance();
  }

  Locale get locale => _locale;

  void setLocale(Locale locale) {
    if (!L10n.all.contains(locale)) return;
    _locale = locale;
    saveLocale(locale.languageCode);
    notifyListeners();
  }

  void saveLocale(String locale) async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setString("locale", locale);
  }

  void resetLocale() {
    _locale = const Locale('en');
    notifyListeners();
  }
}
