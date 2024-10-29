import 'dart:async';

import 'package:flutter/material.dart';
import 'package:standby_capstone/components/auth_input_field.dart';
import 'package:standby_capstone/constants.dart';
import 'package:standby_capstone/main.dart';
import 'package:standby_capstone/pages/forgotpass_page.dart';
import 'package:standby_capstone/pages/main_navigation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isLoading = false;
  bool _redirecting = false;
  late final TextEditingController _emailController = TextEditingController();
  late final TextEditingController _passwordController =
      TextEditingController();
  late final StreamSubscription<AuthState> _authStateSubscription;

  Future<void> _signIn() async {
    try {
      setState(() {
        _isLoading = true;
      });
      await supabase.auth.signInWithPassword(
        password: _passwordController.text.trim(),
        email: _emailController.text.trim(),
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
    } catch (e) {
      showTopSnackBar(
        Overlay.of(context),
        const CustomSnackBar.error(message: 'Unexpected error occurred'),
      );
    } finally {
      if (mounted) {
        setState(() {
          _emailController.clear();
          _passwordController.clear();
          _isLoading = false;
        });
      }
    }
  }

  @override
  void initState() {
    _authStateSubscription = supabase.auth.onAuthStateChange.listen(
      (data) {
        if (_redirecting) return;
        final session = data.session;
        if (session != null) {
          if (!mounted) return;
          _redirecting = true;
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const MainNavigation()),
          );
        }
      },
      onError: (error) {
        if (!mounted) return;
        if (error is AuthException) {
          showTopSnackBar(
            Overlay.of(context),
            CustomSnackBar.error(message: error.message.toString()),
          );
        } else {
          showTopSnackBar(
            Overlay.of(context),
            const CustomSnackBar.error(message: 'Unexpected error occurred'),
          );
        }
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _authStateSubscription.cancel();
    super.dispose();
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
                          'Welcome!',
                          style: kAuthTitleLarge,
                        ),
                        Text(
                          'Please login to continue',
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
                          hintText: 'Email',
                          controller: _emailController,
                          icon: Icons.email_rounded,
                        ),
                        const SizedBox(height: 24),
                        AuthInputField(
                          hintText: 'Password',
                          controller: _passwordController,
                          icon: Icons.lock_rounded,
                          useObscure: true,
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
                              'Forgot password?',
                              textAlign: TextAlign.right,
                              style: kForgotPassword,
                            ),
                          ),
                        ),
                        const SizedBox(height: 48),
                        Container(
                          height: 48,
                          width: double.infinity,
                          decoration: kEmbossDecorationGrad,
                          child: TextButton(
                            onPressed: _signIn,
                            child: Center(
                              child: _isLoading
                                  ? const CircularProgressIndicator(
                                      valueColor:
                                          AlwaysStoppedAnimation(kWhite),
                                    )
                                  : Text(
                                      'Login',
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
