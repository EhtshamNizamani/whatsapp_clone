import 'package:audioplayers/audioplayers.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp_clone/common/enum/message_enum.dart';
import 'package:whatsapp_clone/features/chat/widgets/video_play.dart';

class DisplyImageFileGIF extends StatelessWidget {
  final String message;
  final MessageEnum type;

  DisplyImageFileGIF({super.key, required this.message, required this.type});
  bool isPlaying = false;
  final AudioPlayer audioPlayer = AudioPlayer();
  @override
  Widget build(BuildContext context) {
    return type == MessageEnum.text
        ? Text(
            message,
            style: const TextStyle(fontSize: 20),
          )
        : type == MessageEnum.image
            ? CachedNetworkImage(
                imageUrl: message,
                height: 200,
              )
            : type == MessageEnum.gif
                ? CachedNetworkImage(imageUrl: message)
                : type == MessageEnum.audio
                    ? StatefulBuilder(builder: (context, setState) {
                        return IconButton(
                          onPressed: () async {
                            if (isPlaying) {
                              audioPlayer.pause();
                            } else {
                              await audioPlayer.setSource(UrlSource(message));
                              audioPlayer.resume();
                            }
                            setState(() {
                              isPlaying = !isPlaying;
                            });
                          },
                          constraints: const BoxConstraints(minWidth: 100),
                          icon: isPlaying
                              ? const Icon(Icons.pause_circle)
                              : const Icon(Icons.play_circle),
                        );
                      })
                    : VideoPlay(message: message);
  }
}
