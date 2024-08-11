import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:standby_capstone/firebase_options.dart';
import 'package:standby_capstone/screens/login_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
