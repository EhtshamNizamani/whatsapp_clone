import 'dart:io';
import 'package:flutter/foundation.dart' as foundation;

import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:whatsapp_clone/common/enum/message_enum.dart';
import 'package:whatsapp_clone/common/providers/message_reply_provider.dart';
import 'package:whatsapp_clone/common/utils/utils.dart';
import 'package:whatsapp_clone/features/chat/controller/chat_controller.dart';
import 'package:whatsapp_clone/features/chat/widgets/message_reply_preview.dart';
import 'package:whatsapp_clone/features/landing/screens/auth/controller/auth_controller.dart';

import '../../../colors.dart';

class BottomChatField extends ConsumerStatefulWidget {
  final String recieverUserId;
  const BottomChatField({required this.recieverUserId, Key? key})
      : super(key: key);

  @override
  ConsumerState<BottomChatField> createState() => _BottomChatFieldState();
}

class _BottomChatFieldState extends ConsumerState<BottomChatField> {
  var isInputEmpaty = false;
  var isShowEmojiContainer = false;
  bool _isRecorderInit = false;
  bool isRecording = false;
  FocusNode focusNode = FocusNode();
  FlutterSoundRecorder? _soundRecorder;
  TextEditingController messageController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _soundRecorder = FlutterSoundRecorder();
    openAudio();
    _isRecorderInit = true;
  }

  void openAudio() async {
    final status = await Permission.microphone.request();

    try {
      if (status != PermissionStatus.granted) {
        throw RecordingPermissionException('microphone Permision is not given');
      }
      await _soundRecorder!.openRecorder();
      _isRecorderInit = true;
    } catch (e) {
      showSnackBar(context: context, content: e.toString());
    }
  }

  void sendTextMessage() async {
    if (messageController.text.trim() != '') {
      ref.read(chatControllerProvider).sendTextMessage(
            context: context,
            text: messageController.text.trim(),
            recieverUserId: widget.recieverUserId,
          );
      setState(() {
        messageController.text = '';
        isInputEmpaty = false;
      });
    } else {
      var tempDir = await getTemporaryDirectory();
      var path = '${tempDir.path}/flutter_sound_acc';

      if (!_isRecorderInit) {
        return;
      }

      if (isRecording) {
        await _soundRecorder!.stopRecorder();

        sendFileMessage(File(path), MessageEnum.audio);
      } else {
        await _soundRecorder!.startRecorder(toFile: path);
      }

      setState(() {
        isRecording = !isRecording;
      });
    }
  }

  void sendFileMessage(File file, MessageEnum messageEnum) async {
    ref.read(chatControllerProvider).sendFileMessage(
        context: context,
        file: file,
        receiverUserId: widget.recieverUserId,
        messageType: messageEnum);
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

  void showEmojiContainer() {
    setState(() {
      isShowEmojiContainer = true;
    });
  }

  void hideEmojiContainer() {
    setState(() {
      isShowEmojiContainer = false;
    });
  }

  void showKeyboard() => focusNode.requestFocus();
  void hideKeyboard() => focusNode.unfocus();

  void toggelEmojiKeyboardContainer() {
    if (isShowEmojiContainer) {
      showKeyboard();
      hideEmojiContainer();
    } else {
      hideKeyboard();
      showEmojiContainer();
    }
  }

  void getGif() async {
    final gifUrl = await pickGif(context);
    if (gifUrl != null) {
      ref.read(chatControllerProvider).sendGifMessage(
          context: context,
          gifUrl: gifUrl.url,
          receiverUserId: widget.recieverUserId,
          messageType: MessageEnum.gif);
    }
  }

  @override
  void dispose() {
    if (_soundRecorder != null) {
      _soundRecorder!.closeRecorder();
      _soundRecorder = null;
    }
    messageController.dispose();
    super.dispose();

    _isRecorderInit = false;
  }

  @override
  Widget build(BuildContext context) {
    final messageReply = ref.watch(messageRepplyProvider);
    final isMessageRepyShow = messageReply != null;
    return Column(
      children: [
        isMessageRepyShow ? const MessageReplyPreview() : const SizedBox(),
        Row(
          children: [
            Expanded(
              child: TextField(
                focusNode: focusNode,
                controller: messageController,
                cursorColor: textColor,
                textAlign: TextAlign.left,
                onChanged: (value) {
                  if (value.isEmpty) {
                    setState(() {
                      isInputEmpaty = false;
                    });
                  } else {
                    setState(() {
                      isInputEmpaty = true;
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
                      width: !isInputEmpaty ? 120 : 40,
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
                            child: !isInputEmpaty
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
                    prefixIcon: SizedBox(
                      width: 100,
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: toggelEmojiKeyboardContainer,
                            icon: const Icon(
                              Icons.emoji_emotions,
                              color: Colors.grey,
                            ),
                          ),
                          IconButton(
                            onPressed: getGif,
                            icon: const Icon(
                              Icons.gif_rounded,
                              color: Colors.grey,
                            ),
                          ),
                        ],
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
                      ? const Icon(Icons.send)
                      : isRecording
                          ? const Icon(Icons.close)
                          : const Icon(Icons.mic),
                ),
              ),
            )
          ],
        ),
        isShowEmojiContainer
            ? SizedBox(
                height: 300,
                child: EmojiPicker(
                  onEmojiSelected: ((category, emoji) {
                    setState(() {
                      messageController.text =
                          messageController.text + emoji.emoji;
                    });

                    isInputEmpaty = false;
                  }),
                ),
              )
            : const SizedBox(),
      ],
    );
  }
}
