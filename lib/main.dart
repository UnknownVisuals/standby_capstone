import 'package:flutter/material.dart';
import 'package:standby_capstone/screens/splash_page.dart';

void main() {
  runApp(const StandBy());
}

class StandBy extends StatelessWidget {
  const StandBy({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'StandBy',
      theme: ThemeData(),
      home: const SplashScreen(),
    );
  }
}
