import 'package:flutter/material.dart';

class ErrorScreen extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final error;
  const ErrorScreen({Key? key, required this.error}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text(error)),
    );
  }
}
