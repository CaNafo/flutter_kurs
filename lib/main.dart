import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:movies_app/l10n/l10n.dart';
import 'package:provider/provider.dart';

import 'package:movies_app/helpers/token.dart';
import 'package:movies_app/providers/auth_provider.dart';
import 'package:movies_app/providers/localization_provider.dart';
import 'package:movies_app/screens/login_screen.dart';
import 'package:movies_app/screens/tabs_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: SharedPreferences.getInstance(),
      builder: (context, snapshot) => snapshot.connectionState ==
              ConnectionState.waiting
          ? const Center()
          : MultiProvider(
              providers: [
                ChangeNotifierProvider(
                  create: (_) => AuthProvider(),
                ),
                ChangeNotifierProvider(
                  create: (_) =>
                      LocalizationProvider(snapshot.data as SharedPreferences),
                ),
              ],
              builder: (context, child) => MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'Movies app',
                theme: ThemeData(
                  primarySwatch: Colors.blue,
                  scaffoldBackgroundColor: const Color.fromRGBO(26, 26, 26, 1),
                  appBarTheme: const AppBarTheme(
                    backgroundColor: Color.fromRGBO(26, 26, 26, 1),
                    elevation: 0,
                  ),
                  textTheme: const TextTheme(
                    headline1: TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                    headline2: TextStyle(
                      color: Colors.white,
                      fontSize: 35,
                      fontWeight: FontWeight.w300,
                    ),
                    subtitle2: TextStyle(
                      color: Color.fromRGBO(
                        193,
                        193,
                        193,
                        1,
                      ),
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                    subtitle1: TextStyle(
                      color: Color.fromRGBO(
                        193,
                        193,
                        193,
                        1,
                      ),
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                    caption: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                    bodyText1: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                    bodyText2: TextStyle(
                      color: Color.fromRGBO(
                        193,
                        193,
                        193,
                        1,
                      ),
                      fontSize: 20,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  elevatedButtonTheme: ElevatedButtonThemeData(
                    style: ButtonStyle(
                      elevation: MaterialStateProperty.all(2),
                      shadowColor: MaterialStateProperty.all(Colors.grey),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            37,
                          ),
                        ),
                      ),
                      padding: MaterialStateProperty.all(
                        const EdgeInsets.symmetric(vertical: 15),
                      ),
                      backgroundColor: MaterialStateProperty.all(
                        const Color.fromRGBO(30, 144, 255, 1),
                      ),
                    ),
                  ),
                ),
                locale: Provider.of<LocalizationProvider>(context).locale,
                supportedLocales: L10n.all,
                localizationsDelegates: const [
                  AppLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                ],
                home: FutureBuilder(
                  future: Token.getJwtToken(),
                  builder: (ctx, snapshot) =>
                      snapshot.connectionState == ConnectionState.waiting
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : snapshot.data != null
                              ? const TabsScreen()
                              : const LoginScreen(),
                ),
                initialRoute: "/",
                routes: {
                  TabsScreen.routeName: (context) => const TabsScreen(),
                },
              ),
            ),
    );
  }
}
