import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:movies_app/widgets/movie_list.dart';
import 'package:movies_app/widgets/simple_tab.dart';
import 'package:movies_app/providers/home_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var showMovies = true;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context);

    return Padding(
        padding: const EdgeInsets.only(left: 22.0, right: 22.0, top: 30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                SimpleTab(
                  tabTitle: localization!.movies,
                  onTap: () {
                    setState(() {
                      showMovies = !showMovies;
                    });
                  },
                  active: showMovies,
                ),
                const SizedBox(
                  width: 20,
                ),
                SimpleTab(
                  tabTitle: localization.series,
                  onTap: () {
                    setState(() {
                      showMovies = !showMovies;
                    });
                  },
                  active: !showMovies,
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Column(
              children: [
                FutureBuilder(
                  future: Provider.of<HomeProvider>(context, listen: false)
                      .getContentByReleaseDate(
                    showMovies ? 1 : 2,
                  ),
                  builder: (context,
                          AsyncSnapshot<List<Map<String, dynamic>>?>
                              snapshot) =>
                      snapshot.connectionState == ConnectionState.waiting
                          ? const Center()
                          : snapshot.data != null
                              ? MovieList(
                                  moviesData: snapshot.data,
                                  title: localization.recently_released,
                                )
                              : const Text(
                                  "No data",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                  ),
                                ),
                ),
                const SizedBox(
                  height: 30,
                ),
                FutureBuilder(
                  future: Provider.of<HomeProvider>(context, listen: false)
                      .getContentByRating(
                    showMovies ? 1 : 2,
                  ),
                  builder: (context,
                          AsyncSnapshot<List<Map<String, dynamic>>?>
                              snapshot) =>
                      snapshot.connectionState == ConnectionState.waiting
                          ? const Center()
                          : snapshot.data != null
                              ? MovieList(
                                  moviesData: snapshot.data,
                                  title: localization.best_rate,
                                )
                              : const Text(
                                  "No data",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                  ),
                                ),
                ),
              ],
            ),
          ],
        ));
  }
}
