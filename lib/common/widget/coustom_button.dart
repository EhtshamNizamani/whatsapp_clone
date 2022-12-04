// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';

import '../../colors.dart';

// ignore: camel_case_types
class CustomBotton extends StatelessWidget {
  final text;
  final VoidCallback onPressed;
  const CustomBotton({Key? key, required this.onPressed, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          primary: tabColor, minimumSize: const Size(double.infinity, 50)),
      onPressed: onPressed,
      child: Text(
        text,
        style: const TextStyle(color: Colors.black87),
        textAlign: TextAlign.center,
      ),
    );
  }
}
