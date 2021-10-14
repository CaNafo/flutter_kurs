import 'package:flutter/material.dart';
import 'package:movies_app/widgets/expandable_movies_list.dart';
import 'package:movies_app/widgets/movie_list.dart';
import 'package:provider/provider.dart';

import 'package:movies_app/providers/content_provider.dart';

class AllContent extends StatelessWidget {
  const AllContent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final contentProvider = Provider.of<ContentProvider>(context);
    final mediaQuery = MediaQuery.of(context);

    return FutureBuilder(
      future: contentProvider.getAllGenres(),
      builder: (context, AsyncSnapshot<List<Map<String, dynamic>>?> snapshot) =>
          snapshot.connectionState == ConnectionState.waiting
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : snapshot.data != null
                  ? SizedBox(
                      height: mediaQuery.size.height * 0.55,
                      child: ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) => Column(
                          children: [
                            FutureBuilder(
                              future: contentProvider.getContentByGenreAndType(
                                  snapshot.data![index]['genreId'], 1),
                              builder: (context,
                                      AsyncSnapshot<List<Map<String, dynamic>>?>
                                          moviesSnapshot) =>
                                  moviesSnapshot.connectionState ==
                                          ConnectionState.waiting
                                      ? Container(
                                          color: Colors.grey,
                                        )
                                      : ExpandableMoviesList(
                                          title:
                                              '${snapshot.data![index]['name']} (Filmovi)',
                                          child: MovieList(
                                            moviesData: moviesSnapshot.data,
                                          ),
                                        ),
                            ),
                            FutureBuilder(
                              future: contentProvider.getContentByGenreAndType(
                                  snapshot.data![index]['genreId'], 2),
                              builder: (context,
                                      AsyncSnapshot<List<Map<String, dynamic>>?>
                                          moviesSnapshot) =>
                                  moviesSnapshot.connectionState ==
                                          ConnectionState.waiting
                                      ? Container(
                                          color: Colors.grey,
                                        )
                                      : ExpandableMoviesList(
                                          title:
                                              '${snapshot.data![index]['name']} (Serije)',
                                          child: MovieList(
                                            moviesData: moviesSnapshot.data,
                                          ),
                                        ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : const Text(
                      "No data available.",
                    ),
    );
  }
}
