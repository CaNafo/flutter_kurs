


import 'app_localizations.dart';

/// The translations for Bosnian (`bs`).
class AppLocalizationsBs extends AppLocalizations {
  AppLocalizationsBs([String locale = 'bs']) : super(locale);

  @override
  String get language => 'BiH';

  @override
  String get password => 'Lozinka';

  @override
  String get login => 'Prijavi se';

  @override
  String get name => 'Ime';

  @override
  String get surname => 'Prezime';

  @override
  String get username => 'Korisničko ime';

  @override
  String get logout => 'Odjavi me';

  @override
  String get movies => 'Filmovi';

  @override
  String get series => 'Serije';

  @override
  String get recently_released => 'Najnovije';

  @override
  String get best_rate => 'Najbolje ocjene';

  @override
  String get search => 'Pretraga';

  @override
  String get all => 'Sve';

  @override
  String get no_fav_data => 'Omiljeni sadržaj nije dodat.';

  @override
  String duration(String duration) {
    return 'Trajanje $duration minuta';
  }

  @override
  String air_date(String date) {
    return 'Godina izdavanja $date';
  }

  @override
  String get genres => 'Žanrovi: ';

  @override
  String get seasons => 'Lista sezona: ';

  @override
  String get comments => 'Komentari';

  @override
  String get comment => 'Komentar';

  @override
  String get send_comment => 'Pošalji komentar';

  @override
  String get enter_comment => 'Unesite komentar*';
}
