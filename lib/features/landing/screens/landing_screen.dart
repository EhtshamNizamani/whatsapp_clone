import 'package:flutter/material.dart';
import 'package:whatsapp_clone/colors.dart';
import 'package:whatsapp_clone/common/widget/coustom_button.dart';
import 'package:whatsapp_clone/features/landing/screens/auth/screen/login_screen.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({Key? key}) : super(key: key);
  navigateToLoginScreen(BuildContext context) {
    Navigator.pushNamed(context, LoginScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: size.height * 0.05),
            const Text(
              'Welcome to WhatsApp',
              style: TextStyle(fontSize: 37),
            ),
            SizedBox(height: size.height / 9),
            Image.asset(
              'images/bg.png',
              width: size.width * 0.85,
              height: size.height * 0.45,
              color: tabColor,
            ),
            SizedBox(height: size.height / 9),
            const Center(
              child: Text(
                'Read our pricy policy: Tap agree and continue accept the terms of services ',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: greyColor),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
                width: size.width * 0.75,
                child: CustomBotton(
                  onPressed: () => navigateToLoginScreen(context),
                  text: 'AGREE AND CONTINUE',
                ))
          ],
        ),
      ),
    );
  }
}
