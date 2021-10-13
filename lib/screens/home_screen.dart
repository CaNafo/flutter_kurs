import 'package:flutter/material.dart';
import 'package:movies_app/widgets/movie_list.dart';
import 'package:provider/provider.dart';

import 'package:movies_app/providers/home_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 22.0, right: 22.0, top: 30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            FutureBuilder(
              future: Provider.of<HomeProvider>(context, listen: false)
                  .getContentById(1),
              builder: (context,
                      AsyncSnapshot<List<Map<String, dynamic>>?> snapshot) =>
                  snapshot.connectionState == ConnectionState.waiting
                      ? const Center()
                      : snapshot.data != null
                          ? MovieList(moviesData: snapshot.data)
                          : Text("No data"),
            ),
          ],
        ));
  }
}
