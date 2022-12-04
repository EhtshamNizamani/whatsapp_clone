import 'package:flutter/material.dart';
import 'package:whatsapp_clone/colors.dart';
import 'package:whatsapp_clone/features/chat/widgets/contact_list.dart';
import 'package:whatsapp_clone/features/chat/widgets/messages.dart';

import '../widget/text_input_bar.dart';
import '../widget/web_chat_apbar.dart';
import '../widget/web_profile_bar.dart';
import '../widget/web_search_bar.dart';

class WebScreenLayout extends StatefulWidget {
  const WebScreenLayout({Key? key}) : super(key: key);

  @override
  State<WebScreenLayout> createState() => _WebScreenLayoutState();
}

class _WebScreenLayoutState extends State<WebScreenLayout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: const [
                  WebProfileBar(),
                  WebSearchBar(),
                  ContactList(),
                ],
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.75,
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(
                      'https://raw.githubusercontent.com/RivaanRanawat/whatsapp-flutter-ui/main/assets/backgroundImage.png'),
                  fit: BoxFit.cover),
            ),
            child: Column(
              children: const [
                WebChatAppBar(),
                Expanded(
                    child: ChatListMessage(
                  recieverUserId: '',
                )),
                TextInputBar(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
