import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_clone/common/widget/loader.dart';
import 'package:whatsapp_clone/features/chat/widgets/bottom_chats_fields.dart';
import 'package:whatsapp_clone/features/landing/screens/auth/controller/auth_controller.dart';
import 'package:whatsapp_clone/model/user_model.dart';

import '../widgets/messages.dart';

// ignore: must_be_immutable
class MobileChatScreen extends ConsumerWidget {
  static const String routeName = '/chat_screen';
  String name;
  String uid;
  MobileChatScreen({required this.name, required this.uid, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: StreamBuilder<UserModel>(
              stream: ref.read(authControllerProvider).getUserById(uid),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Loader();
                }
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(snapshot.data!.name),
                    Text(
                      snapshot.data!.isOnline ? 'online' : 'offline',
                      style: const TextStyle(
                          fontSize: 12, fontWeight: FontWeight.normal),
                    ),
                  ],
                );
              }),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: const [
                  Icon(Icons.call),
                  SizedBox(
                    width: 10,
                  ),
                  Icon(Icons.more_vert)
                ],
              ),
            ),
          ],
        ),
        body: Column(
          children: [
            Expanded(child: ChatListMessage(recieverUserId: uid)),
            BottomChatField(
              recieverUserId: uid,
            ),
          ],
        ));
  }
}
