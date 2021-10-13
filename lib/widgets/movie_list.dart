import 'package:flutter/material.dart';
import 'package:movies_app/const.dart';

class MovieList extends StatelessWidget {
  final List<Map<String, dynamic>>? moviesData;

  const MovieList({
    key,
    @required this.moviesData,
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
            "Najgledanije",
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
            itemBuilder: (BuildContext context, int index) => SingleMovie(
              displaySize: displaySize,
              moviesData: moviesData![index],
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
    return Container(
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
                fit: BoxFit.fill,
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            moviesData!["title"],
            style: const TextStyle(color: Colors.white),
          )
        ],
      ),
    );
  }
}
