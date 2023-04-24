import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:tipy/screens/login.dart';



class Mysplash extends StatelessWidget {
  const Mysplash({super.key});

  @override
  Widget build(BuildContext context) {
    return  AnimatedSplashScreen(
      splash: Image.asset("assets/images/Calculator.png"),
      nextScreen: LoginPageNew(),
      splashTransition: SplashTransition.fadeTransition,
      splashIconSize: 250,
      backgroundColor: Colors.white,
      duration: 3000,
    );
  }
}