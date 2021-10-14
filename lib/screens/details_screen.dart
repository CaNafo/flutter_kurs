import 'package:movies_app/providers/auth_provider.dart';
import 'package:movies_app/widgets/single_movie_provider.dart';
import 'package:provider/provider.dart';

import 'package:flutter/material.dart';
import 'package:movies_app/providers/content_provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class DetailsScreen extends StatelessWidget {
  DetailsScreen({Key? key}) : super(key: key);
  static const routeName = '/content-details';
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final detailsProvider = Provider.of<SingleMovieProvider>(context);

    final _controller = YoutubePlayerController(
      initialVideoId: detailsProvider.trailerLink,
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
                  detailsProvider.contentTitle,
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
                "Trajanje: ${detailsProvider.duration} minuta",
                style: theme.textTheme.subtitle1,
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                "Godina izdavanja: ${detailsProvider.year}",
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
                  itemCount: detailsProvider.genres.length,
                  itemBuilder: (context, index) => Text(
                    '- ${detailsProvider.genres[index]['name']}',
                    style: theme.textTheme.subtitle2,
                  ),
                ),
              ),
              if (detailsProvider.seasons.length > 0)
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
                        itemCount: detailsProvider.seasons.length,
                        itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.only(
                            left: 10,
                          ),
                          child: Text(
                            "- ${detailsProvider.seasons[index]['name']} broj epizoda ${detailsProvider.seasons[index]['episodes'].length}",
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
              Consumer<SingleMovieProvider>(
                builder: (context, provider, child) => Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(left: 10),
                      height: 150,
                      child: ListView.builder(
                        itemCount: detailsProvider.conentComments.length,
                        itemBuilder: (context, index) => Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      detailsProvider.conentComments[index]
                                          ['user']['firstName'],
                                      style: theme.textTheme.caption,
                                    ),
                                    const SizedBox(
                                      width: 2,
                                    ),
                                    Text(
                                      detailsProvider.conentComments[index]
                                          ['user']['lastName'],
                                      style: theme.textTheme.caption,
                                    ),
                                  ],
                                ),
                                Text(
                                  detailsProvider.conentComments[index]
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
                        Form(
                          key: _formKey,
                          child: TextFormField(
                            controller: textEditingController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Unesite komentar*";
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              hintText: 'Unesite komentar',
                              labelText: 'Komentar',
                              labelStyle: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w300,
                              ),
                              hintStyle: TextStyle(
                                color: Colors.white,
                              ),
                              prefixIcon: Icon(
                                Icons.edit,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              provider.addCommentApiCall(
                                detailsProvider.conentId,
                                textEditingController.text,
                              );
                            }
                          },
                          child: const Text("Pošalji komentar"),
                          style: ButtonStyle(
                            foregroundColor:
                                MaterialStateProperty.all(Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
