import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:standby_capstone/constants.dart';
import 'package:standby_capstone/components/input_text.dart';
import 'package:standby_capstone/components/button_text.dart';
import 'package:standby_capstone/screens/forgotpass_page.dart';
import 'package:standby_capstone/screens/monitoring_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimary,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                color: kPrimary,
                child: Padding(
                  padding: const EdgeInsets.all(36),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Selamat datang!',
                        style: GoogleFonts.poppins(
                          color: kWhite,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Silahkan masuk untuk melanjutkan',
                        style: GoogleFonts.poppins(
                          color: kWhite,
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Expanded(
                        child: Center(
                          child: Image.asset(
                              'assets/images/illustration_login.png'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: kGray,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(36.0),
                    topRight: Radius.circular(36.0),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(36, 72, 36, 36),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const InputText(hintText: 'username'),
                      const SizedBox(height: 16),
                      const InputText(hintText: 'password'),
                      const SizedBox(height: 16),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const ForgotPasswordPage()),
                          );
                        },
                        child: SizedBox(
                          width: double.infinity,
                          child: Text(
                            'Lupa password?',
                            textAlign: TextAlign.right,
                            style: GoogleFonts.poppins(
                              color: kPrimary,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                              decorationColor: kPrimary,
                              decorationThickness: 2,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),
                      const ButtonText(
                        text: 'Masuk',
                        nextPage: MonitoringPage(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
