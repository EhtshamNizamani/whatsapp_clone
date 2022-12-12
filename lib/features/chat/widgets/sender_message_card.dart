import 'package:flutter/material.dart';
import 'package:swipe_to/swipe_to.dart';

import 'package:whatsapp_clone/colors.dart';

import '../../../common/enum/message_enum.dart';
import 'display_image_file_GIF.dart';

// ignore: must_be_immutable
class SenderMessageCard extends StatelessWidget {
  String message;
  String data;
  MessageEnum type;
  String replyedText;
  String userName;
  MessageEnum replyedMessageType;
  VoidCallback onRightSwipe;
  SenderMessageCard({
    Key? key,
    required this.replyedText,
    required this.userName,
    required this.replyedMessageType,
    required this.onRightSwipe,
    required this.type,
    required this.data,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var isReplying = replyedText.isNotEmpty;
    return SwipeTo(
      onRightSwipe: onRightSwipe,
      child: Align(
        alignment: Alignment.centerLeft,
        child: ConstrainedBox(
          constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width - 45,
              minWidth: MediaQuery.of(context).size.width * 0.4),
          child: Card(
            elevation: 1,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            color: senderMessageColor,
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            child: Stack(
              children: [
                Padding(
                  padding: isReplying
                      ? const EdgeInsets.only(
                          left: 5, right: 5, top: 5, bottom: 5)
                      : MessageEnum.text == type
                          ? const EdgeInsets.only(
                              left: 10, right: 100, top: 5, bottom: 20)
                          : const EdgeInsets.only(
                              left: 5, right: 5, top: 5, bottom: 5),
                  child: Column(
                    children: [
                      if (isReplying) ...[
                        Text(
                          userName,
                          style: const TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 16),
                        ),
                        Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: backgroundColor.withOpacity(.6)),
                            padding: const EdgeInsets.all(8),
                            child: DisplyImageFileGIF(
                                message: replyedText,
                                type: replyedMessageType)),
                      ],
                      DisplyImageFileGIF(
                        message: message,
                        type: type,
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 2,
                  right: 20,
                  child: Row(
                    children: [
                      Text(
                        data,
                        style: const TextStyle(fontSize: 13),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
