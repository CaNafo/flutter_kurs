import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:movies_app/widgets/all_content.dart';
import 'package:movies_app/widgets/movie_list.dart';
import 'package:movies_app/widgets/single_content.dart';
import 'package:movies_app/providers/content_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
    final localization = AppLocalizations.of(context);

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
                    tabTitle: localization!.all,
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
                    tabTitle: localization.movies,
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
                    tabTitle: localization.series,
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
              //Ako je odabran tab sa indexom 1 ili 2 widget SingleContent je zadu??en da pozove API getAllGenres koji dohva??a sve ??anrove iz baze a zatim
              //za svaki ??anr pozove API getContentByGenreAndType kome proslijedi ID ??anra i tip sadr??aja (film/serija) (u bazi ID filma je 1, a serije 2, tako da sam indekse tabova prilagodio tome)
              // Ako odaberete tab Filmovi chosenTab index ??e biti 1, a u API pozivu getContentByGenreAndType se koristi kao ID tipa sadr??aja
              if (chosenTab != 0 && !searching)
                SingleContent(
                  contentType: chosenTab,
                ),
              //Isto funkcioni??e kao i SingleContent widget, samo se ne proslije??uje tip sadr??aja, ve?? je napisan dupli kod sa hardkodiranim vrijednostima 1 i 2 koji dohva??a i filmove i serije.
              if (chosenTab == 0 && !searching) const AllContent(),

              //Ukoliko polje za preragu ima fokus, svi ostali widgeti (SingleContent i AllContent) se sakriju, a prika??e se MovieList widget (Widget koji se koristi i na home ekranu)
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
    final localization = AppLocalizations.of(context);
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
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: localization!.search,
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
