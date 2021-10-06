import 'package:flutter/material.dart';

import 'package:movies_app/widgets/login_button_small.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double windowsHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 22.0, right: 22.0, top: 30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                "assets/images/movies.jpg",
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              "Svi filmovi na jednom mjestu!",
              style: Theme.of(context).textTheme.headline1,
              textAlign: TextAlign.left,
            ),
            SizedBox(
              height: windowsHeight * 0.15,
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                child: const Text("Sign in with Email"),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                LoginButtonSmall("Google", () {}),
                const SizedBox(
                  width: 15,
                ),
                LoginButtonSmall("Apple ID", () {})
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              "By Continuing you agree to the Terms and Conditions",
              style: Theme.of(context).textTheme.subtitle2,
            ),
          ],
        ),
      ),
    );
  }
}
