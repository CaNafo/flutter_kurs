import 'package:flutter/material.dart';

class MovieList extends StatefulWidget {
  final String title;
  final List<dynamic> listOfData;
  const MovieList(this.title, this.listOfData, {Key? key}) : super(key: key);

  @override
  _MovieListState createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
  @override
  Widget build(BuildContext context) {
    // String jad = widget.listOfData().then((value) => print(value[0]["title"]));
    final double windowsHeight = MediaQuery.of(context).size.height;
    final double windowsWidth = MediaQuery.of(context).size.width;
    return widget.listOfData.isNotEmpty
        ? Padding(
            padding: const EdgeInsets.all(5.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: windowsWidth,
                  child: Text(
                    widget.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 21,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                SizedBox(
                    height: windowsHeight * 0.2,
                    child: ListView.builder(
                        itemCount: 4,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (BuildContext context, int index) {
                          return SizedBox(
                            height: windowsWidth,
                            width: windowsWidth * 0.5,
                            child: Column(children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.asset(
                                    "assets/images/movies.jpg",
                                  ),
                                ),
                              ),
                              Text(
                                widget.listOfData[0]["title"],
                                style: const TextStyle(color: Colors.white),
                              )
                            ]),
                          );
                        })),
              ],
            ))
        : const CircularProgressIndicator.adaptive();
  }
}
