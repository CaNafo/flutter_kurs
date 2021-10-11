import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({Key? key}) : super(key: key);

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  YoutubePlayerController _controller = YoutubePlayerController(
    initialVideoId: 'Zw4KoorVxgg',
    flags: YoutubePlayerFlags(
      autoPlay: false,
      mute: false,
      isLive: false,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 200,
            child: YoutubePlayer(
              controller: _controller,
              liveUIColor: Colors.amber,
            ),
          ),
        ],
      ),
    );
  }
}
