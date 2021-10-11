import 'package:flutter/material.dart';
import 'package:movies_app/providers/login_provider.dart';
import 'package:movies_app/screens/home_screen.dart';
import 'package:movies_app/screens/login_screen.dart';
import 'package:movies_app/screens/tabs_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movies',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: const Color.fromRGBO(26, 26, 26, 1),
        textTheme: const TextTheme(
          headline1: TextStyle(
            color: Colors.white,
            fontSize: 40,
            fontWeight: FontWeight.bold,
          ),
          subtitle2: TextStyle(
            color: Colors.grey,
            fontSize: 13,
            fontWeight: FontWeight.w500,
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
      home: ChangeNotifierProvider(
        create: (context) => LoginProvider(),
        child: const LoginScreen(),
      ),
      routes: {
        // When navigating to the "/second" route, build the SecondScreen widget.
        TabsScreen.routeName: (context) => const TabsScreen(),
      },
    );
  }
}
