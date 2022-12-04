import 'package:flutter/material.dart';
import 'package:whatsapp_clone/colors.dart';

class TextInputBar extends StatelessWidget {
  const TextInputBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.75,
      height: MediaQuery.of(context).size.height * 0.077,
      decoration: const BoxDecoration(color: appBarColor),
      child: Row(
        children: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.emoji_emotions_outlined,
              size: 20,
              color: Colors.grey,
            ),
            hoverColor: appBarColor.withOpacity(0),
            highlightColor: appBarColor.withOpacity(0),
            splashColor: appBarColor.withOpacity(0),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.attach_file,
              size: 20,
              color: Colors.grey,
            ),
            hoverColor: appBarColor.withOpacity(0),
            highlightColor: appBarColor.withOpacity(0),
            splashColor: appBarColor.withOpacity(0),
          ),
          const Expanded(
            child: TextField(
              cursorColor: textColor,
              textAlign: TextAlign.left,
              decoration: InputDecoration(
                filled: true,
                fillColor: appBarColor,
                hoverColor: appBarColor,
                contentPadding: EdgeInsets.all(13),
                hintText: 'Type a message',
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: appBarColor)),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: appBarColor,
                    width: 0,
                  ),
                ),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Icon(Icons.send),
          )
        ],
      ),
    );
  }
}
