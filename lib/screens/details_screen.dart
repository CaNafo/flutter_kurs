import 'dart:developer';
import 'package:provider/provider.dart';

import 'package:flutter/material.dart';
import 'package:movies_app/providers/content_provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({Key? key}) : super(key: key);
  static const routeName = '/content-details';

  @override
  Widget build(BuildContext context) {
    final routeArguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final contentDetails = routeArguments['data'] as Map<String, dynamic>;
    final contentId = routeArguments['contentId'] as int;

    final _controller = YoutubePlayerController(
      initialVideoId: contentDetails['trailerLink'],
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
        isLive: false,
      ),
    );
    final theme = Theme.of(context);
    var textEditingController = TextEditingController();

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.center,
                child: Text(
                  contentDetails['title'],
                  style: theme.textTheme.headline2,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                height: 200,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: YoutubePlayer(
                    controller: _controller,
                    liveUIColor: Colors.amber,
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                "Trajanje: ${contentDetails['duration']} minuta",
                style: theme.textTheme.subtitle1,
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                "Godina izdavanja: ${contentDetails['year']}",
                style: theme.textTheme.subtitle1,
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                "Žanrovi:",
                style: theme.textTheme.subtitle1,
              ),
              Container(
                padding: const EdgeInsets.only(left: 10),
                height: 50,
                child: ListView.builder(
                  itemCount: contentDetails['genres'].length,
                  itemBuilder: (context, index) => Text(
                    '- ${contentDetails['genres'][index]['name']}',
                    style: theme.textTheme.subtitle2,
                  ),
                ),
              ),
              if (contentDetails['seasons'].length > 0)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Lista sezona: ",
                      style: theme.textTheme.subtitle1,
                    ),
                    SizedBox(
                      height: 100,
                      child: ListView.builder(
                        itemCount: contentDetails['seasons'].length,
                        itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.only(
                            left: 10,
                          ),
                          child: Text(
                            "- ${contentDetails['seasons'][index]['name']} broj epizoda ${contentDetails['seasons'][index]['episodes'].length}",
                            style: theme.textTheme.subtitle2,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/line.png',
                    scale: 3,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Komentari",
                    style: theme.textTheme.subtitle1,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Image.asset(
                    'assets/images/line.png',
                    scale: 3,
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              ChangeNotifierProvider.value(
                value: ContentProvider(),
                builder: (context, child) => Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(left: 10),
                      height: 150,
                      child: ListView.builder(
                        itemCount: contentDetails['contentComments'].length,
                        itemBuilder: (context, index) => Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  contentDetails['contentComments'][index]
                                      ['user']['firstName'],
                                  style: theme.textTheme.caption,
                                ),
                                Text(
                                  contentDetails['contentComments'][index]
                                      ['comment'],
                                  style: theme.textTheme.subtitle1,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        TextField(
                          controller: textEditingController,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            final contentProvider =
                                Provider.of<ContentProvider>(context,
                                    listen: false);
                            contentProvider.addComment(
                              1,
                              contentId,
                              "Ovo je neki komentar",
                            );
                          },
                          child: const Text("Pošalji komentar"),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
