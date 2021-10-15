import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:movies_app/const.dart';
import 'package:movies_app/widgets/all_content.dart';
import 'package:movies_app/widgets/movie_list.dart';
import 'package:movies_app/widgets/single_content.dart';
import 'package:provider/provider.dart';

import 'package:movies_app/providers/content_provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  var chosenTab = 0;
  var searching = false;
  var searchingText = "";

  @override
  Widget build(BuildContext context) {
    final windowsSize = MediaQuery.of(context).size;
    final contentProvider = Provider.of<ContentProvider>(context);

    return SingleChildScrollView(
      child: Padding(
          padding: const EdgeInsets.only(left: 22.0, right: 22.0, top: 30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Focus(
                onFocusChange: (value) {
                  if (searchingText.isEmpty) {
                    setState(() {
                      searching = false;
                    });
                  } else {
                    setState(() {
                      searching = true;
                    });
                  }
                },
                child: CustomSearchField(
                  windowsSize: windowsSize,
                  onTextChanged: (text) {
                    searchingText = text;
                    contentProvider.searchContent(text);
                  },
                ),
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
              const SizedBox(
                height: 30,
              ),
              //Ako je odabran tab sa indexom 1 ili 2 widget SingleContent je zadužen da pozove API getAllGenres koji dohvaća sve žanrove iz baze a zatim
              //za svaki žanr pozove API getContentByGenreAndType kome proslijedi ID žanra i tip sadržaja (film/serija) (u bazi ID filma je 1, a serije 2, tako da sam indekse tabova prilagodio tome)
              // Ako odaberete tab Filmovi chosenTab index će biti 1, a u API pozivu getContentByGenreAndType se koristi kao ID tipa sadržaja
              if (chosenTab != 0 && !searching)
                SingleContent(
                  contentType: chosenTab,
                ),
              //Isto funkcioniše kao i SingleContent widget, samo se ne proslijeđuje tip sadržaja, već je napisan dupli kod sa hardkodiranim vrijednostima 1 i 2 koji dohvaća i filmove i serije.
              if (chosenTab == 0 && !searching) const AllContent(),

              //Ukoliko polje za preragu ima fokus, svi ostali widgeti (SingleContent i AllContent) se sakriju, a prikaže se MovieList widget (Widget koji se koristi i na home ekranu)
              //A njemu se proslijedi lista (searchList) koja se u provajderu popunjava kroz metodu searchContent
              if (searching) MovieList(moviesData: contentProvider.searchList),
            ],
          )),
    );
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
  final Size windowsSize;
  final Function(String) onTextChanged;

  const CustomSearchField({
    Key? key,
    required this.windowsSize,
    required this.onTextChanged,
  }) : super(key: key);

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
            child: TextField(
              onChanged: onTextChanged,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: "Search",
              ),
              style: const TextStyle(color: Colors.black),
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
