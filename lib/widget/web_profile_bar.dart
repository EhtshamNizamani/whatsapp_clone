import 'package:flutter/material.dart';

import 'package:whatsapp_clone/colors.dart';
import 'package:whatsapp_clone/info.dart';

class WebProfileBar extends StatelessWidget {
  const WebProfileBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.25,
      height: MediaQuery.of(context).size.height * 0.077,
      decoration: const BoxDecoration(color: appBarColor),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(info[0]['profilePic'].toString()),
            ),
            Row(
              children: [
                IconButton(
                    highlightColor: backgroundColor,
                    hoverColor: backgroundColor,
                    focusColor: backgroundColor,
                    onPressed: () {},
                    icon: const Icon(Icons.message, color: Colors.grey)),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.more_vert,
                    color: Colors.grey,
                  ),
                  highlightColor: backgroundColor,
                  hoverColor: backgroundColor,
                  focusColor: backgroundColor,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
