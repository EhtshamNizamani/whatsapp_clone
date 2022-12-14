// ignore_for_file: unnecessary_null_comparison

import 'dart:io';
import 'dart:isolate';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import 'package:whatsapp_clone/common/enum/message_enum.dart';
import 'package:whatsapp_clone/common/providers/message_reply_provider.dart';
import 'package:whatsapp_clone/common/repositories/common_firebase_storage_repository.dart';
import 'package:whatsapp_clone/common/utils/utils.dart';
import 'package:whatsapp_clone/model/chat_contact.dart';
import 'package:whatsapp_clone/model/message.dart';

import '../../../model/user_model.dart';

final chatRepositoryProvider = Provider((ref) => ChatRepository(
    auth: FirebaseAuth.instance, firestore: FirebaseFirestore.instance));

class ChatRepository {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;

  ChatRepository({
    required this.firestore,
    required this.auth,
  });

  Stream<List<ChatContact>> getChatContacts() {
    return firestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .collection('chats')
        .snapshots()
        .asyncMap((event) async {
      List<ChatContact> contact = [];
      for (var document in event.docs) {
        var chatContact = ChatContact.fromMap(document.data());
        var userData = await firestore
            .collection('users')
            .doc(chatContact.contactId)
            .get();

        var user = UserModel.fromMap(userData.data()!);

        contact.add(ChatContact(
            name: user.name,
            profilePic: user.profilePic,
            contactId: user.uid,
            timeSent: chatContact.timeSent,
            lastMessage: chatContact.lastMessage));
      }
      return contact;
    });
  }

  Stream<List<Message>> getChatStream(String recieverUserId) {
    return firestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .collection('chats')
        .doc(recieverUserId)
        .collection('messages')
        .orderBy('timeSent')
        .snapshots()
        .map((event) {
      List<Message> message = [];

      for (var document in event.docs) {
        message.add(Message.fromMap(document.data()));
      }
      return message;
    });
  }

  void _saveMessageToMessageSubCollection({
    required String reciverUserId,
    required String text,
    required String messageId,
    required String userName,
    required DateTime timeSent,
    required String reciverUsername,
    required MessageEnum messageType,
    required MessageReply? messageReply,
    required String senderUserName,
    required String reciverUserName,
  }) async {
    final message = Message(
      senderId: auth.currentUser!.uid,
      reciverId: reciverUserId,
      text: text,
      messageId: messageId,
      type: messageType,
      isSeen: false,
      timeSent: timeSent,
      replyedMessage: messageReply == null ? '' : messageReply.message,
      replyedMessageType:
          messageReply == null ? MessageEnum.text : messageReply.messageType,
      replyedTo: messageReply == null
          ? ''
          : messageReply.isMe
              ? senderUserName
              : reciverUserName,
    );

    await firestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .collection('chats')
        .doc(reciverUserId)
        .collection('messages')
        .doc(messageId)
        .set(
          message.toMap(),
        );

    await firestore
        .collection('users')
        .doc(reciverUserId)
        .collection('chats')
        .doc(auth.currentUser!.uid)
        .collection('messages')
        .doc(messageId)
        .set(
          message.toMap(),
        );
  }

  void _saveDataToContactSubCollection({
    required UserModel reciverUserData,
    required UserModel senderUserData,
    required String text,
    required DateTime timeSent,
    required String reciverUserId,
  }) async {
    // users / reciverId / chats/ currentUser/ setData
    var recieverChatContact = ChatContact(
      name: senderUserData.name,
      profilePic: senderUserData.profilePic,
      contactId: senderUserData.uid,
      timeSent: timeSent,
      lastMessage: text,
    );

    await firestore
        .collection('users')
        .doc(reciverUserId)
        .collection('chats')
        .doc(auth.currentUser!.uid)
        .set(recieverChatContact.toMap());
    // users/currentUser/chats/reciverId/ setData
    var senderChatContact = ChatContact(
      name: reciverUserData.name,
      profilePic: reciverUserData.profilePic,
      contactId: reciverUserData.uid,
      timeSent: timeSent,
      lastMessage: text,
    );

    await firestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .collection('chats')
        .doc(reciverUserId)
        .set(senderChatContact.toMap());
  }

  void sendTextMessage({
    required String text,
    required String reciverUserId,
    required UserModel senderUser,
    required BuildContext context,
    required MessageReply? messageReply,
  }) async {
    try {
      var timeSent = DateTime.now();
      UserModel reciverUserData;
      var messageId = const Uuid().v1();

      var userDataMap =
          await firestore.collection('users').doc(reciverUserId).get();
      reciverUserData = UserModel.fromMap(userDataMap.data()!);
      _saveDataToContactSubCollection(
          reciverUserData: reciverUserData,
          senderUserData: senderUser,
          text: text,
          timeSent: timeSent,
          reciverUserId: reciverUserId);

      _saveMessageToMessageSubCollection(
        reciverUserId: reciverUserId,
        text: text,
        messageId: messageId,
        userName: senderUser.name,
        timeSent: timeSent,
        reciverUsername: reciverUserData.name,
        messageType: MessageEnum.text,
        messageReply: messageReply,
        reciverUserName: reciverUserData.name,
        senderUserName: senderUser.name,
      );
    } catch (e) {
      showSnackBar(context: context, content: e.toString());
    }
  }

  void sendFileMessage({
    required BuildContext context,
    required String receiverUserId,
    required ProviderRef ref,
    required File file,
    required UserModel senderUserData,
    required MessageEnum messageType,
    required MessageReply? messageReply,
  }) async {
    try {
      var timeSent = DateTime.now();
      var messageId = Uuid().v1();
      var imageUrl = await ref
          .read(commonFirebaserStorageRepositoryProvider)
          .storeFileToFirebase(
              'chat/${messageType.type}/${senderUserData.uid}/$receiverUserId/$messageId',
              file);

      UserModel receiverUserData;
      var userModelData =
          await firestore.collection('users').doc(receiverUserId).get();
      receiverUserData = UserModel.fromMap(userModelData.data()!);
      String lastMessage;
      switch (messageType) {
        case MessageEnum.audio:
          lastMessage = '???? Audio';
          break;
        case MessageEnum.gif:
          lastMessage = 'GIF';
          break;
        case MessageEnum.video:
          lastMessage = '???? Video';
          break;
        case MessageEnum.image:
          lastMessage = '???? Image';
          break;
        default:
          lastMessage = '???? Image';
      }
      _saveDataToContactSubCollection(
        reciverUserData: receiverUserData,
        senderUserData: senderUserData,
        text: lastMessage,
        timeSent: timeSent,
        reciverUserId: receiverUserId,
      );
      _saveMessageToMessageSubCollection(
          reciverUserId: receiverUserId,
          text: imageUrl,
          messageId: messageId,
          userName: senderUserData.name,
          timeSent: timeSent,
          reciverUsername: receiverUserData.name,
          messageType: messageType,
          messageReply: messageReply,
          reciverUserName: receiverUserData.name,
          senderUserName: senderUserData.name);
    } catch (e) {
      showSnackBar(context: context, content: e.toString());
    }
  }

  void sendGIFMessage({
    required String gifUrl,
    required String reciverUserId,
    required UserModel senderUser,
    required MessageEnum messageType,
    required BuildContext context,
    required MessageReply? messageReply,
  }) async {
    try {
      var timeSent = DateTime.now();
      String lastMessage;
      UserModel reciverUserData;
      var messageId = const Uuid().v1();
      var userDataMap =
          await firestore.collection('users').doc(reciverUserId).get();
      reciverUserData = UserModel.fromMap(userDataMap.data()!);

      _saveDataToContactSubCollection(
          reciverUserData: reciverUserData,
          senderUserData: senderUser,
          text: 'GIF',
          timeSent: timeSent,
          reciverUserId: reciverUserId);

      _saveMessageToMessageSubCollection(
          reciverUserId: reciverUserId,
          text: gifUrl,
          messageId: messageId,
          userName: senderUser.name,
          timeSent: timeSent,
          reciverUsername: reciverUserData.name,
          messageType: MessageEnum.gif,
          messageReply: messageReply,
          reciverUserName: reciverUserData.name,
          senderUserName: senderUser.name);
    } catch (e) {
      showSnackBar(context: context, content: e.toString());
    }
  }

  void setIsSeen(
      {required BuildContext context,
      required receiverUserId,
      required messageId}) async {
    try {
      await firestore
          .collection('users')
          .doc(auth.currentUser!.uid)
          .collection('chats')
          .doc(receiverUserId)
          .collection('messages')
          .doc(messageId)
          .update({'isSeen': true});

      await firestore
          .collection('users')
          .doc(receiverUserId)
          .collection('chats')
          .doc(auth.currentUser!.uid)
          .collection('messages')
          .doc(messageId)
          .update({
        'isSeen': true,
      });
      print(messageId);
    } catch (e) {
      print(e);
      showSnackBar(context: context, content: e.toString());
    }
  }
}
