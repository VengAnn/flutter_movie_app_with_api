import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YouTuberPlayerWidget extends StatefulWidget {
  const YouTuberPlayerWidget({super.key, required this.youtubeKey});
  final String youtubeKey;

  @override
  State<YouTuberPlayerWidget> createState() => _YouTuberPlayerWidgetState();
}

class _YouTuberPlayerWidgetState extends State<YouTuberPlayerWidget> {
  late final YoutubePlayerController _youtubeController;

  @override
  void initState() {
    _youtubeController = YoutubePlayerController(
      initialVideoId: widget.youtubeKey,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
        enableCaption: false,
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
      onEnterFullScreen: () {
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.landscapeRight,
          DeviceOrientation.landscapeLeft,
        ]);
      },
      //
      onExitFullScreen: () {
        SystemChrome.setEnabledSystemUIMode(
          SystemUiMode.manual,
          overlays: [
            SystemUiOverlay.bottom,
            SystemUiOverlay.top,
          ],
        );
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.portraitUp,
        ]);
      },
      player: YoutubePlayer(controller: _youtubeController),
      builder: (context, player) => player,
    );
  }

  @override
  void dispose() {
    _youtubeController.dispose();
    super.dispose();
  }
}
