import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:standby_capstone/constants.dart';
import 'package:standby_capstone/firebase_options.dart';
import 'package:standby_capstone/pages/login_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL'] ?? '',
    anonKey: dotenv.env['SUPABASE_ANON_KEY'] ?? '',
  );
  runApp(const StandBy());
}

final supabase = Supabase.instance.client;

class StandBy extends StatelessWidget {
  const StandBy({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'StandBy',
      theme: ThemeData(colorSchemeSeed: kPrimary),
      home: const LoginPage(),
    );
  }
}
