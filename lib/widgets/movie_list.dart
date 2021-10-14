import 'package:flutter/material.dart';
import 'package:movies_app/widgets/single_movie_provider.dart';
import 'package:provider/provider.dart';

import 'package:movies_app/const.dart';
import 'package:movies_app/providers/content_provider.dart';
import 'package:movies_app/screens/details_screen.dart';

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

class SingleMovie extends StatelessWidget {
  const SingleMovie({
    Key? key,
    required this.displaySize,
    required this.moviesData,
  }) : super(key: key);

  final Size displaySize;
  final Map<String, dynamic>? moviesData;

  @override
  Widget build(BuildContext context) {
    final contentProvider =
        Provider.of<SingleMovieProvider>(context, listen: false);
    return InkWell(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => const AlertDialog(
            elevation: 5,
            backgroundColor: Colors.transparent,
            content: SizedBox(
              height: 250,
              width: 50,
              child: CircularProgressIndicator(),
            ),
          ),
        );

        contentProvider
            .getContentDetails(
          moviesData!['contentId'],
        )
            .then((value) {
          Navigator.of(context).pop();
          if (value != null) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => ChangeNotifierProvider.value(
                  value: SingleMovieProvider.value(
                      value, moviesData!['contentId']),
                  builder: (ctx, child) => DetailsScreen(),
                ),
              ),
            );
          }
          // Navigator.pushNamed(context,DetailsScreen.routeName, arguments: {
          //   "data": value,
          //   "contentId": moviesData!['contentId']
          // });
        });
      },
      child: Container(
        padding: const EdgeInsets.all(
          8.0,
        ),
        width: displaySize.width * 0.5,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: SizedBox(
                height: displaySize.width * 0.3,
                width: displaySize.width * 0.5,
                child: Image.network(
                  moviesData!['coverLink'],
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              moviesData!["title"],
              style: const TextStyle(color: Colors.white, fontSize: 15),
            )
          ],
        ),
      ),
    );
  }
}
