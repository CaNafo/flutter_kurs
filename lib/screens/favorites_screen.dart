import 'package:flutter/material.dart';
import 'package:movies_app/screens/search_screen.dart';
import 'package:provider/provider.dart';

import 'package:movies_app/providers/single_movie_provider.dart';
import 'package:movies_app/providers/favourites_provider.dart';
import 'package:movies_app/widgets/single_movie.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  var chosenTab = 0;

  @override
  Widget build(BuildContext context) {
    final displaySize = MediaQuery.of(context).size;
    final favouritesProvider = Provider.of<FavouritesProvider>(context);
    final localization = AppLocalizations.of(context);

    return Padding(
      padding: const EdgeInsets.only(left: 22.0, right: 22.0, top: 30.0),
      child: Column(
        children: [
          Row(
            children: [
              CustomTabElevatedButton(
                tabTitle: localization!.all,
                active: chosenTab == 0,
                onTap: () {
                  if (chosenTab != 0) {
                    setState(
                      () {
                        chosenTab = 0;
                      },
                    );
                  }
                },
              ),
              CustomTabElevatedButton(
                tabTitle: localization.movies,
                active: chosenTab == 1,
                onTap: () {
                  if (chosenTab != 1) {
                    setState(
                      () {
                        chosenTab = 1;
                      },
                    );
                  }
                },
              ),
              CustomTabElevatedButton(
                tabTitle: localization.series,
                active: chosenTab == 2,
                onTap: () {
                  if (chosenTab != 2) {
                    setState(
                      () {
                        chosenTab = 2;
                      },
                    );
                  }
                },
              ),
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          FutureBuilder(
            future: favouritesProvider.getAllFavourites(chosenTab),
            builder: (context,
                    AsyncSnapshot<List<Map<String, dynamic>>?> snapshot) =>
                snapshot.connectionState == ConnectionState.waiting
                    ? const CircularProgressIndicator()
                    : snapshot.data != null && snapshot.data!.isNotEmpty
                        ? SizedBox(
                            height: displaySize.height * 0.6,
                            child: GridView.count(
                              crossAxisCount: 2,
                              children:
                                  List.generate(snapshot.data!.length, (index) {
                                return ChangeNotifierProvider.value(
                                  value: SingleMovieProvider(),
                                  builder: (context, child) => Stack(
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.all(2),
                                        padding: const EdgeInsets.all(5.0),
                                        decoration: BoxDecoration(
                                          color: Colors.grey,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: SingleMovie(
                                          favourites: true,
                                          displaySize: displaySize,
                                          moviesData: snapshot.data![index],
                                        ),
                                      ),
                                      Positioned(
                                        right: 3,
                                        top: 3,
                                        child: InkWell(
                                          onTap: () async {
                                            await favouritesProvider
                                                .addRemoveFavourite(
                                              false,
                                              snapshot.data![index]
                                                  ['contentId'],
                                            );
                                          },
                                          child: const Icon(
                                            Icons.favorite,
                                            color: Colors.red,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              }),
                            ),
                          )
                        : Center(
                            child: Text(
                              localization.no_fav_data,
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                          ),
          ),
        ],
      ),
    );
  }
}
