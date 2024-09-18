import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:standby_capstone/components/auth_input_field.dart';
import 'package:standby_capstone/constants.dart';
import 'package:standby_capstone/main.dart';
import 'package:standby_capstone/pages/forgotpass_page.dart';
import 'package:standby_capstone/components/navigations/main_navigation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Future<void> signIn() async {
    try {
      await supabase.auth.signInWithPassword(
        password: passwordController.text,
        email: emailController.text,
      );
      if (!mounted) return;
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const MainNavigation(),
        ),
      );
    } on AuthException catch (e) {
      showTopSnackBar(
        Overlay.of(context),
        CustomSnackBar.error(message: e.message.toString()),
      );
    }
  }

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
                  padding: const EdgeInsets.fromLTRB(36, 36, 36, 0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Selamat datang!',
                          style: kAuthTitleLarge,
                        ),
                        Text(
                          'Silahkan masuk untuk melanjutkan',
                          style: kTextNormal_White,
                        ),
                        const SizedBox(height: 16),
                        Center(
                          child: Image.asset(
                            'assets/images/illustration_login.png',
                            height: 256,
                          ),
                        ),
                      ],
                    ),
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
                  padding: const EdgeInsets.all(36),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 24),
                        AuthInputField(
                          hintText: 'email',
                          controller: emailController,
                          icon: Icons.email_rounded,
                          obscureText: false,
                        ),
                        const SizedBox(height: 24),
                        AuthInputField(
                          hintText: 'password',
                          controller: passwordController,
                          icon: Icons.lock_rounded,
                          obscureText: true,
                        ),
                        const SizedBox(height: 24),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const ForgotPasswordPage(),
                              ),
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
                        const SizedBox(height: 48),
                        Container(
                          height: 48,
                          width: double.infinity,
                          decoration: kEmbossDecorationGrad,
                          child: TextButton(
                            onPressed: () {
                              signIn();
                            },
                            child: Center(
                              child: Text(
                                'masuk',
                                style: kButtonTitle_White,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                      ],
                    ),
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
