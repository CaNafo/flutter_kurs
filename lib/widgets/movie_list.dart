import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:movies_app/const.dart';
import 'package:movies_app/widgets/single_movie.dart';
import 'package:movies_app/providers/single_movie_provider.dart';

class MovieList extends StatelessWidget {
  final List<Map<String, dynamic>>? moviesData;
  final String? title;

  const MovieList({
    key,
    @required this.moviesData,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final displaySize = MediaQuery.of(context).size;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: 10.0,
          ),
          child: Text(
            title ?? "",
            style: Theme.of(context).textTheme.subtitle2,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              10,
            ),
            color: Constants.moviesListContainerColor,
          ),
          padding: const EdgeInsets.only(
            right: 8,
          ),
          height: displaySize.height * 0.2,
          child: ListView.builder(
            itemCount: moviesData!.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) =>
                ChangeNotifierProvider.value(
              value: SingleMovieProvider(),
              builder: (context, child) => SingleMovie(
                displaySize: displaySize,
                moviesData: moviesData![index],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
