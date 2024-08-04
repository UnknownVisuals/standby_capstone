import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:standby_capstone/constants.dart';
import 'package:standby_capstone/screens/login_page.dart';

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
      child: Scaffold(
        backgroundColor: kGray,
        body: Center(
          child: Text(
            'StandBy',
            style: GoogleFonts.poppins(
              color: kPrimary,
              fontSize: 40,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
