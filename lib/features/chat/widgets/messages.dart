import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:whatsapp_clone/common/enum/message_enum.dart';
import 'package:whatsapp_clone/common/providers/message_reply_provider.dart';
import 'package:whatsapp_clone/common/widget/loader.dart';
import 'package:whatsapp_clone/features/chat/controller/chat_controller.dart';
import 'package:whatsapp_clone/features/chat/widgets/sender_message_card.dart';
import '../../../model/message.dart';
import 'my_message_card.dart';

class ChatListMessage extends ConsumerStatefulWidget {
  final String recieverUserId;
  const ChatListMessage({Key? key, required this.recieverUserId})
      : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ChatListMessageState();
}

class _ChatListMessageState extends ConsumerState<ChatListMessage> {
  ScrollController messageController = ScrollController();

  void onMessageSwipe(
      {required message, required MessageEnum messageType, required isMe}) {
    ref.read(messageRepplyProvider.notifier).update((state) {
      return MessageReply(message, messageType, isMe);
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Message>>(
        stream: ref
            .watch(chatControllerProvider)
            .getChatStream(widget.recieverUserId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Loader();
          }
          SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
            messageController
                .jumpTo(messageController.position.maxScrollExtent);
          });
          return ListView.builder(
              controller: messageController,
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                var messageData = snapshot.data![index];
                var timeSent = DateFormat.Hm().format(messageData.timeSent);
                if (!messageData.isSeen &&
                    FirebaseAuth.instance.currentUser!.uid ==
                        messageData.reciverId) {
                  print(messageData.reciverId);
                  print(widget.recieverUserId);
                  ref.watch(chatControllerProvider).setIsSeen(
                      context: context,
                      receiverUserId: widget.recieverUserId,
                      messageId: messageData.messageId);
                }
                if (messageData.senderId ==
                    FirebaseAuth.instance.currentUser!.uid) {
                  return MyMessageCard(
                    onLeftSwipe: () {
                      return onMessageSwipe(
                          message: messageData.text,
                          messageType: messageData.type,
                          isMe: true);
                    },
                    replyedMessageType: messageData.replyedMessageType,
                    userName: messageData.replyedTo,
                    type: messageData.type,
                    data: timeSent,
                    message: messageData.text,
                    replyedText: messageData.replyedMessage,
                    isSeen: messageData.isSeen,
                  );
                } else {
                  return SenderMessageCard(
                    type: messageData.type,
                    data: timeSent,
                    message: messageData.text,
                    onRightSwipe: () => onMessageSwipe(
                        message: messageData.text,
                        messageType: messageData.type,
                        isMe: false),
                    replyedMessageType: messageData.replyedMessageType,
                    replyedText: messageData.replyedMessage,
                    userName: messageData.replyedTo,
                  );
                }
              });
        });
  }
}
