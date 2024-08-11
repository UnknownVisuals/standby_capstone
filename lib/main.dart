import 'package:flutter/material.dart';
import 'package:standby_capstone/screens/login_page.dart';

void main() {
  runApp(const StandBy());
}

class StandBy extends StatelessWidget {
  const StandBy({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'StandBy',
      theme: ThemeData.light(),
      home: const LoginPage(),
    );
  }
}
