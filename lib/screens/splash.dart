import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';

import 'homescreen.dart';

class Mysplash extends StatelessWidget {
  const Mysplash({super.key});

  @override
  Widget build(BuildContext context) {
    return  AnimatedSplashScreen(
      splash: Image.asset("assets/images/Calculator.png"),
      nextScreen: Home(),
      splashTransition: SplashTransition.fadeTransition,
      splashIconSize: 250,
      backgroundColor: Colors.white,
      duration: 3000,
    );
  }
}