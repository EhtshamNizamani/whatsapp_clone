// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import 'package:whatsapp_clone/colors.dart';
import 'package:whatsapp_clone/common/enum/message_enum.dart';
import 'package:whatsapp_clone/features/chat/widgets/display_image_file_GIF.dart';

class MyMessageCard extends StatelessWidget {
  String message;
  String data;
  MessageEnum type;
  MyMessageCard(
      {Key? key, required this.type, required this.data, required this.message})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: ConstrainedBox(
        constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width - 45,
            minWidth: MediaQuery.of(context).size.width * 0.3),
        child: Card(
          elevation: 1,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          color: messageColor,
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          child: Stack(
            children: [
              Padding(
                padding: MessageEnum.text == type
                    ? const EdgeInsets.only(
                        left: 10, right: 100, top: 5, bottom: 20)
                    : const EdgeInsets.only(
                        left: 5, right: 5, top: 5, bottom: 5),
                child: DisplyImageFileGIF(
                  message: message,
                  type: type,
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
                    const Icon(
                      Icons.done_all,
                      color: Colors.white60,
                    )
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