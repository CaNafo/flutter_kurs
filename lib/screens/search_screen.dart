import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    final double windowsHeight = MediaQuery.of(context).size.height;
    return Padding(
        padding: const EdgeInsets.only(left: 22.0, right: 22.0, top: 30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "Ovo je search screen!",
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
