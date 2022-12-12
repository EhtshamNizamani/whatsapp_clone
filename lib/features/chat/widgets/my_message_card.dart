// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import 'package:whatsapp_clone/colors.dart';
import 'package:whatsapp_clone/common/enum/message_enum.dart';
import 'package:whatsapp_clone/features/chat/widgets/display_image_file_GIF.dart';
import 'package:swipe_to/swipe_to.dart';

class MyMessageCard extends StatelessWidget {
  String message;
  String data;
  MessageEnum type;
  String replyedText;
  String userName;
  MessageEnum replyedMessageType;
  VoidCallback onLeftSwipe;
  bool isSeen;
  MyMessageCard({
    Key? key,
    required this.isSeen,
    required this.userName,
    required this.replyedMessageType,
    required this.replyedText,
    required this.type,
    required this.data,
    required this.message,
    required this.onLeftSwipe,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isReplying = replyedText.isNotEmpty;
    return SwipeTo(
      onLeftSwipe: onLeftSwipe,
      child: Align(
        alignment: Alignment.centerRight,
        child: ConstrainedBox(
          constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width - 45,
              minWidth: MediaQuery.of(context).size.width * 0.3),
          child: Card(
            elevation: 1,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            color: messageColor,
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
                              message: replyedText, type: replyedMessageType),
                        ),
                      ],
                      DisplyImageFileGIF(
                        message: message,
                        type: type,
                      ),
                      isReplying
                          ? SizedBox(
                              height: 20,
                            )
                          : SizedBox()
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
                      const SizedBox(
                        width: 5,
                      ),
                      Icon(
                        isSeen ? Icons.done_all : Icons.done,
                        color: isSeen ? Colors.green : Colors.white60,
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
