


import 'app_localizations.dart';

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get language => 'English';

  @override
  String get password => 'Password';

  @override
  String get login => 'Log in';

  @override
  String get name => 'Name';

  @override
  String get surname => 'Last name';

  @override
  String get username => 'Username';

  @override
  String get logout => 'Log out';

  @override
  String get movies => 'Movies';

  @override
  String get series => 'Series';

  @override
  String get recently_released => 'Recently released';

  @override
  String get best_rate => 'Best rated';

  @override
  String get search => 'Search';

  @override
  String get all => 'All';

  @override
  String get no_fav_data => 'No favourite content.';

  @override
  String duration(String duration) {
    return 'Duration $duration minutes';
  }

  @override
  String air_date(String date) {
    return 'Air date $date';
  }

  @override
  String get genres => 'Genres: ';

  @override
  String get seasons => 'Seasons list: ';

  @override
  String get comments => 'Comments';

  @override
  String get comment => 'Comment';

  @override
  String get send_comment => 'Send comment';

  @override
  String get enter_comment => 'Enter comment*';
}
