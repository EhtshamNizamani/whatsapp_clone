import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_clone/common/enum/message_enum.dart';
import 'package:whatsapp_clone/common/utils/utils.dart';
import 'package:whatsapp_clone/features/chat/controller/chat_controller.dart';

import '../../../colors.dart';

class BottomChatField extends ConsumerStatefulWidget {
  final String recieverUserId;
  const BottomChatField({required this.recieverUserId, Key? key})
      : super(key: key);

  @override
  ConsumerState<BottomChatField> createState() => _BottomChatFieldState();
}

class _BottomChatFieldState extends ConsumerState<BottomChatField> {
  var isInputEmpaty = true;
  TextEditingController messageController = TextEditingController();
  void sendTextMessage() {
    if (messageController.text.trim() != null) {
      ref.read(chatControllerProvider).sendTextMessage(
          context: context,
          text: messageController.text.trim(),
          recieverUserId: widget.recieverUserId);
    }
    setState(() {
      messageController.text = '';
    });
  }

  void sendFileMessage(File file, MessageEnum messageEnum) async {
    if (isInputEmpaty) {
      ref.read(chatControllerProvider).sendFileMessage(
          context: context,
          file: file,
          receiverUserId: widget.recieverUserId,
          messageType: messageEnum);
    }
  }

  void selectImage() async {
    File? image = await pickImageFromGellrey(context);
    if (image != null) {
      sendFileMessage(image, MessageEnum.image);
    }
  }

  void selectVideo() async {
    File? video = await pickVideoFromGellery(context);
    if (video != null) {
      sendFileMessage(video, MessageEnum.video);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: messageController,
            cursorColor: textColor,
            textAlign: TextAlign.left,
            onChanged: (value) {
              if (value.isEmpty) {
                setState(() {
                  isInputEmpaty = true;
                });
              } else {
                setState(() {
                  isInputEmpaty = false;
                });
              }
            },
            decoration: InputDecoration(
                filled: true,
                fillColor: appBarColor,
                hoverColor: appBarColor,
                contentPadding: const EdgeInsets.all(13),
                hintText: 'Type a message',
                enabledBorder: UnderlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: const BorderSide(color: appBarColor)),
                focusedBorder: UnderlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: const BorderSide(
                    color: appBarColor,
                    width: 0,
                  ),
                ),
                suffixIcon: SizedBox(
                  width: isInputEmpaty ? 120 : 40,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        onPressed: selectVideo,
                        icon: const Icon(
                          Icons.attach_file,
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(
                        child: isInputEmpaty
                            ? IconButton(
                                onPressed: selectImage,
                                icon: const Icon(
                                  Icons.camera,
                                  color: Colors.grey,
                                ),
                              )
                            : null,
                      ),
                    ],
                  ),
                ),
                prefixIcon: const SizedBox(
                  width: 40,
                  child: Icon(
                    Icons.emoji_emotions,
                    color: Colors.grey,
                  ),
                )),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 5, left: 5),
          child: GestureDetector(
            onTap: sendTextMessage,
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50), color: tabColor),
              child: isInputEmpaty
                  ? const Icon(Icons.mic)
                  : const Icon(Icons.send),
            ),
          ),
        )
      ],
    );
  }
}
