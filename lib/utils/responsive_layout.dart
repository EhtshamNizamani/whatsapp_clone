// ignore_for_file: must_be_immutable

import 'package:flutter/cupertino.dart';

class ResponsiveLayout extends StatelessWidget {
  Widget mobileScreenLayout;
  Widget webScreenLayout;
  ResponsiveLayout(
      {Key? key,
      required this.mobileScreenLayout,
      required this.webScreenLayout})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth > 900) {
        return webScreenLayout;
      } else {
        return mobileScreenLayout;
      }
    });
  }
}
