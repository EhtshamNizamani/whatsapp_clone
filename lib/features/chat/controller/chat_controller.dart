import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_clone/common/enum/message_enum.dart';
import 'package:whatsapp_clone/common/providers/message_reply_provider.dart';
import 'package:whatsapp_clone/features/chat/repository/chat_repository.dart';
import 'package:whatsapp_clone/features/chat/widgets/message_reply_preview.dart';
import 'package:whatsapp_clone/features/landing/screens/auth/controller/auth_controller.dart';
import 'package:whatsapp_clone/model/chat_contact.dart';

import '../../../model/message.dart';

final chatControllerProvider = Provider((ref) {
  final chatRepository = ref.watch(chatRepositoryProvider);
  return ChatController(chatRepository: chatRepository, ref: ref);
});

class ChatController {
  final ChatRepository chatRepository;
  final ProviderRef ref;

  ChatController({
    required this.chatRepository,
    required this.ref,
  });

  Stream<List<ChatContact>> getChatContacts() {
    return chatRepository.getChatContacts();
  }

  Stream<List<Message>> getChatStream(String recieverUserId) {
    return chatRepository.getChatStream(recieverUserId);
  }

  void sendTextMessage({
    required BuildContext context,
    required String text,
    required String recieverUserId,
  }) {
    final messageReply = ref.watch(messageRepplyProvider);

    ref
        .read(userDataAuthProvider)
        .whenData((value) => chatRepository.sendTextMessage(
              text: text,
              reciverUserId: recieverUserId,
              senderUser: value!,
              context: context,
              messageReply: messageReply,
            ));

    ref.read(messageRepplyProvider.notifier).update((state) => null);
  }

  void sendFileMessage({
    required BuildContext context,
    required File file,
    required String receiverUserId,
    required MessageEnum messageType,
  }) {
    final messageReply = ref.watch(messageRepplyProvider);

    ref.read(userDataAuthProvider).whenData(
          (value) => chatRepository.sendFileMessage(
            context: context,
            receiverUserId: receiverUserId,
            ref: ref,
            file: file,
            senderUserData: value!,
            messageType: messageType,
            messageReply: messageReply,
          ),
        );
    ref.read(messageRepplyProvider.notifier).update((state) => null);
  }

  void sendGifMessage({
    required BuildContext context,
    required String gifUrl,
    required String receiverUserId,
    required MessageEnum messageType,
  }) {
    //https://giphy.com/gifs/studiosoriginals-my-everything-love-you-forever-are-7NtRRRUPt0NQSPs8rd
    // https://i.giphy.com/media/7NtRRRUPt0NQSPs8rd/200.gif
    final getIndex = gifUrl.lastIndexOf('-') + 1;
    final lastPart = gifUrl.substring(getIndex);
    final messageReply = ref.watch(messageRepplyProvider);
    String newUrl = 'https://i.giphy.com/media/$lastPart/200.gif';
    ref.read(userDataAuthProvider).whenData(
          (value) => chatRepository.sendGIFMessage(
            messageType: messageType,
            gifUrl: newUrl,
            reciverUserId: receiverUserId,
            senderUser: value!,
            context: context,
            messageReply: messageReply,
          ),
        );
    ref.read(messageRepplyProvider.notifier).update((state) => null);
  }

  void setIsSeen(
      {required BuildContext context,
      required receiverUserId,
      required messageId}) {
    chatRepository.setIsSeen(
        context: context, receiverUserId: receiverUserId, messageId: messageId);
  }
}
