import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:translator_app/auth/mainpage.dart';

class Splash extends StatelessWidget {
  const Splash({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      backgroundColor: const Color(0xff151716),
      splash: Center(
        child: Image.asset(
          'assets/gi.png',
        ),
      ),
      nextScreen: const MainPage(),
      //pageTransitionType: PageTransitionType.scale,
    );
  }
}
