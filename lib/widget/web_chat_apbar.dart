import 'package:flutter/material.dart';
import 'package:whatsapp_clone/colors.dart';
import 'package:whatsapp_clone/info.dart';

class WebChatAppBar extends StatelessWidget {
  const WebChatAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.75,
      height: MediaQuery.of(context).size.height * 0.077,
      decoration: const BoxDecoration(
        color: webAppBarColor,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Row(
            children: [
              CircleAvatar(
                  backgroundImage: NetworkImage(
                info[0]['profilePic'].toString(),
              )),
              const SizedBox(
                width: 20,
              ),
              Text(info[0]['name'].toString()),
            ],
          ),
          Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.video_call),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.call,
                ),
              ),
              const Text('|'),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.search_outlined,
                ),
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
