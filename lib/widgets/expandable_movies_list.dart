import 'package:flutter/material.dart';
import 'package:movies_app/const.dart';

class ExpandableMoviesList extends StatefulWidget {
  final Widget? child;
  final String? title;
  const ExpandableMoviesList({
    Key? key,
    @required this.child,
    @required this.title,
  }) : super(key: key);

  @override
  _ExpandableMoviesListState createState() => _ExpandableMoviesListState();
}

class _ExpandableMoviesListState extends State<ExpandableMoviesList> {
  var showContent = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        bottom: 30,
      ),
      padding: const EdgeInsets.all(
        8,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          10,
        ),
        color: Constants.moviesListContainerColor,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: () {
              setState(() {
                showContent = !showContent;
              });
            },
            child: Row(
              children: [
                Text(widget.title ?? ""),
                const Expanded(
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Icon(Icons.arrow_drop_down, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          if (showContent)
            Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                widget.child ?? const Center(),
              ],
            )
        ],
      ),
    );
  }
}
