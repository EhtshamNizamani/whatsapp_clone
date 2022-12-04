import 'package:flutter/material.dart';
import 'package:whatsapp_clone/features/landing/screens/auth/screen/login_screen.dart';
import 'package:whatsapp_clone/features/landing/screens/auth/screen/user_information_screen.dart';
import 'package:whatsapp_clone/features/select_contacts/screen/select_contact_screen.dart';
import 'package:whatsapp_clone/features/chat/screen/mobile_chat_screen.dart';

import 'common/error_screen.dart';
import 'features/landing/screens/auth/screen/otp_screen.dart';

Route<dynamic> generateRoute(RouteSettings setting) {
  switch (setting.name) {
    case LoginScreen.routeName:
      {
        return MaterialPageRoute(builder: (context) => const LoginScreen());
      }
    case OTPScreen.routeName:
      {
        final verificationId = setting.arguments as String;
        return MaterialPageRoute(
            builder: (context) => OTPScreen(
                  verificationId: verificationId,
                ));
      }
    case UserInformationScreen.routeName:
      {
        return MaterialPageRoute(
            builder: (context) => const UserInformationScreen());
      }
    case SelectContactScreen.routeName:
      {
        return MaterialPageRoute(
            builder: (context) => const SelectContactScreen());
      }
    case MobileChatScreen.routeName:
      final userData = setting.arguments as Map<String, dynamic>;
      final name = userData['name'];
      final uid = userData['uid'];
      {
        return MaterialPageRoute(
            builder: (context) => MobileChatScreen(name: name, uid: uid));
      }

    default:
      {
        return MaterialPageRoute(
            builder: (context) =>
                const ErrorScreen(error: 'Something went wrong'));
      }
  }
}
