import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
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

                if (messageData.senderId ==
                    FirebaseAuth.instance.currentUser!.uid) {
                  return MyMessageCard(
                    type: messageData.type,
                    data: timeSent,
                    message: messageData.text,
                  );
                } else {
                  return SenderMessageCard(
                    type: messageData.type,
                    data: timeSent,
                    message: messageData.text,
                  );
                }
              });
        });
  }
}
