import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:whatsapp_clone/common/enum/message_enum.dart';
import 'package:whatsapp_clone/features/chat/widgets/video_play.dart';

class DisplyImageFileGIF extends StatelessWidget {
  final String message;
  final MessageEnum type;

  const DisplyImageFileGIF(
      {super.key, required this.message, required this.type});

  @override
  Widget build(
    BuildContext context,
  ) {
    return type == MessageEnum.text
        ? Text(
            message,
            style: const TextStyle(fontSize: 20),
          )
        : type == MessageEnum.image
            ? CachedNetworkImage(imageUrl: message)
            : VideoPlay(message: message);
  }
}
