import 'package:flutter/material.dart';
import 'package:standby_capstone/screens/login_page.dart';
import 'package:standby_capstone/constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const LoginPage()),
        );
      },
      child: const Scaffold(
        backgroundColor: kWhite,
        body: Center(
          child: Text(
            'StandBy',
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
              color: kPrimary,
            ),
          ),
        ),
      ),
    );
  }
}
