import 'package:flutter/material.dart';
import 'package:whatsapp_clone/colors.dart';

class WebSearchBar extends StatelessWidget {
  const WebSearchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        alignment: Alignment.center,
        height: 30,
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(color: dividerColor),
          ),
        ),
        child: const TextField(
          cursorColor: textColor,
          textAlign: TextAlign.left,
          decoration: InputDecoration(
            filled: true,
            fillColor: searchBarColor,
            suffixIcon: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Icon(Icons.search),
            ),
            contentPadding: EdgeInsets.all(13),
            hintText: 'Search or start new chat',
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: tabColor, width: 2),
            ),
          ),
        ),
      ),
    );
  }
}
