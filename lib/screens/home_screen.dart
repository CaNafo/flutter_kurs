import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final double windowsHeight = MediaQuery.of(context).size.height;
    return Padding(
        padding: const EdgeInsets.only(left: 22.0, right: 22.0, top: 30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "Ovo je home screen!",
              style: Theme.of(context).textTheme.headline1,
              textAlign: TextAlign.left,
            ),
            SizedBox(
              height: windowsHeight * 0.15,
            ),
          ],
        ));
  }
}
