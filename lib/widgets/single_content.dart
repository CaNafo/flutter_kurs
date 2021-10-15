import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:movies_app/widgets/expandable_movies_list.dart';
import 'package:movies_app/widgets/movie_list.dart';
import 'package:provider/provider.dart';

import 'package:movies_app/providers/content_provider.dart';

class SingleContent extends StatelessWidget {
  final int? contentType;
  const SingleContent({
    Key? key,
    this.contentType,
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
                        itemBuilder: (context, index) => FutureBuilder(
                          future: contentProvider.getContentByGenreAndType(
                              snapshot.data![index]['genreId'],
                              contentType ?? 1),
                          builder: (context, moviesSnapshot) => moviesSnapshot
                                      .connectionState ==
                                  ConnectionState.waiting
                              ? Container(
                                  color: Colors.grey,
                                )
                              : ExpandableMoviesList(
                                  title: snapshot.data![index]['name'],
                                  child: MovieList(
                                    moviesData: contentType == 1
                                        ? contentProvider.getMoviesList(
                                            snapshot.data![index]['genreId'])
                                        : contentProvider.getSeriesList(
                                            snapshot.data![index]['genreId']),
                                  ),
                                ),
                        ),
                      ),
                    )
                  : const Text(
                      "No data available.",
                    ),
    );
  }
}
