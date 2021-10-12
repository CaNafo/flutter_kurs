import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:movies_app/providers/auth_provider.dart';
import 'package:movies_app/screens/login_screen.dart';
import 'package:movies_app/screens/tabs_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AuthProvider(),
      builder: (context, child) => MaterialApp(
        title: 'Movies app',
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
        home: FutureBuilder(
          future:
              Provider.of<AuthProvider>(context, listen: false).getJwtToken(),
          builder: (ctx, snapshot) =>
              snapshot.connectionState == ConnectionState.waiting
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : snapshot.data != null
                      ? const TabsScreen()
                      : const LoginScreen(),
        ),
        routes: {
          TabsScreen.routeName: (context) => const TabsScreen(),
        },
      ),
    );
  }
}
