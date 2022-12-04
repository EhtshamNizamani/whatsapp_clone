import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_clone/colors.dart';
import 'package:whatsapp_clone/features/landing/screens/auth/controller/auth_controller.dart';

class OTPScreen extends ConsumerWidget {
  static const routeName = '/OTP_screen';
  const OTPScreen({Key? key, required this.verificationId}) : super(key: key);
  final String verificationId;

  void verifyOTP(WidgetRef ref, BuildContext context, String userOTP) {
    ref.read(authControllerProvider).verifyOTP(
        verificationId: verificationId, context: context, userOTP: userOTP);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: backgroundColor,
        title: const Text('Verifing your phone number'),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text('We have sent an SMS with a code.'),
            Container(
              alignment: Alignment.center,
              width: size.width * .5,
              child: TextField(
                onChanged: (val) {
                  if (val.trim().length == 6) {
                    verifyOTP(ref, context, val.trim());
                  }
                },
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 40),
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: '- - - - - -',
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
