import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:movies_app/providers/content_provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  var chosenTab = 0;

  @override
  Widget build(BuildContext context) {
    final windowsSize = MediaQuery.of(context).size;
    final contentProvider =
        Provider.of<ContentProvider>(context, listen: false);

    return Padding(
        padding: const EdgeInsets.only(left: 22.0, right: 22.0, top: 30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CustomSearchField(
              windowsSize: windowsSize,
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              children: [
                CustomTabElevatedButton(
                  tabTitle: "Sve",
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
                  tabTitle: "Filmovi",
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
                  tabTitle: "Serije",
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
          ],
        ));
  }
}

class CustomTabElevatedButton extends StatelessWidget {
  final bool active;
  final String tabTitle;
  final Function? onTap;

  const CustomTabElevatedButton({
    Key? key,
    this.active = false,
    this.tabTitle = "",
    @required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ElevatedButton(
        onPressed: () => onTap!(),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Text(
            tabTitle,
            style: TextStyle(
              color: !active ? Colors.grey : Colors.white,
            ),
          ),
        ),
        style: !active
            ? ButtonStyle(
                elevation: MaterialStateProperty.all(0),
                backgroundColor: MaterialStateProperty.all(
                  Colors.transparent,
                ),
              )
            : null,
      ),
    );
  }
}

class CustomSearchField extends StatelessWidget {
  const CustomSearchField({
    Key? key,
    required this.windowsSize,
  }) : super(key: key);

  final Size windowsSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(
          193,
          193,
          193,
          1,
        ),
        borderRadius: BorderRadius.circular(
          5,
        ),
      ),
      child: Row(
        children: [
          SizedBox(
            width: windowsSize.width * 0.75,
            child: const TextField(
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Search",
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: Colors.purple,
              borderRadius: BorderRadius.circular(
                5,
              ),
            ),
            child: const Icon(
              Icons.filter_list,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
