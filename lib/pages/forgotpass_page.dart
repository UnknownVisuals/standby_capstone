import 'package:flutter/material.dart';
import 'package:standby_capstone/components/button_text.dart';
import 'package:standby_capstone/constants.dart';
import 'package:standby_capstone/pages/login_page.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimary,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                color: kPrimary,
                child: Padding(
                  padding: const EdgeInsets.all(36),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Lupa password?',
                        style: kAuthTitleLarge,
                      ),
                      Text(
                        'Silahkan hubungi Admin untuk mengganti password',
                        style: kTextNormal_White,
                      ),
                      const SizedBox(height: 16),
                      Expanded(
                        child: Center(
                          child: Image.asset(
                            'assets/images/illustration_forgotpass.png',
                            height: 256,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(36),
                decoration: const BoxDecoration(
                  color: kGray,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(36.0),
                    topRight: Radius.circular(36.0),
                  ),
                ),
                child: const Center(
                  child: ButtonText(
                    text: 'Back',
                    nextPage: LoginPage(),
                    isPush: false,
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
