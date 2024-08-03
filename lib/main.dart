import 'package:flutter/material.dart';
import 'package:standby_capstone/splash_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'StandBy',
      theme: ThemeData(),
      home: const SplashScreen(),
    );
  }
}
