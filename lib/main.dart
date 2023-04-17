import 'package:flutter/material.dart';

import 'screens/splash.dart';


void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'tipy',
    theme: ThemeData(
      // ignore: deprecated_member_use
      accentColor: Colors.blueAccent,
    ),
    home: const Mysplash(),
  ));
}

