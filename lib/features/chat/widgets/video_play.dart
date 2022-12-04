import 'package:cached_video_player/cached_video_player.dart';
import 'package:flutter/material.dart';

class VideoPlay extends StatefulWidget {
  final String message;
  const VideoPlay({Key? key, required this.message}) : super(key: key);

  @override
  State<VideoPlay> createState() => _VideoPlayState();
}

class _VideoPlayState extends State<VideoPlay> {
  late CachedVideoPlayerController controller;
  bool isPlay = true;
  @override
  void initState() {
    super.initState();

    controller = CachedVideoPlayerController.network(widget.message);

    controller.initialize().then((value) {
      controller.play();
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Stack(children: [
        CachedVideoPlayer(controller),
        Align(
          child: IconButton(
              onPressed: () {
                if (isPlay) {
                  controller.pause();
                } else {
                  controller.play();
                }
                setState(() {
                  isPlay = !isPlay;
                });
              },
              icon:
                  isPlay ? Icon(Icons.pause_circle) : Icon(Icons.play_circle)),
        )
      ]),
    );
  }
}
