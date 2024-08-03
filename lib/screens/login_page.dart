import 'package:flutter/material.dart';
import 'package:standby_capstone/constants.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        color: kPrimary,
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                color: kPrimary,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(36, 72, 36, 36),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Selamat datang!',
                        style: TextStyle(
                            color: kWhite,
                            fontSize: 24,
                            fontWeight: FontWeight.bold),
                      ),
                      const Text(
                        'Silahkan masuk untuk melanjutkan',
                        style: TextStyle(
                            color: kWhite,
                            fontSize: 16,
                            fontWeight: FontWeight.normal),
                      ),
                      const SizedBox(height: 16),
                      Expanded(
                        child: Center(
                          child: Image.asset(
                              'assets/images/splash_illustration.png'),
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
                  color: kWhite,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(36.0),
                    topRight: Radius.circular(36.0),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(36, 72, 36, 36),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'username',
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'password',
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Lupa password?',
                        style: TextStyle(
                            color: kPrimary,
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 32),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('Masuk'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: kGray,
                          minimumSize: Size(double.infinity, 48.0),
                        ),
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
