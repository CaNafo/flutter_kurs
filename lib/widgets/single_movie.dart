import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:movies_app/screens/details_screen.dart';
import 'package:movies_app/providers/single_movie_provider.dart';

class SingleMovie extends StatelessWidget {
  final Size displaySize;
  final Map<String, dynamic>? moviesData;
  final bool favourites;
  const SingleMovie({
    Key? key,
    required this.displaySize,
    required this.moviesData,
    this.favourites = false,
  }) : super(key: key);

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
                    value,
                    moviesData!['contentId'],
                  ),
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
        padding: EdgeInsets.all(
          favourites ? 0 : 8.0,
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
