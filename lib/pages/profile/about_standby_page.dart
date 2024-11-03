import 'package:flutter/material.dart';
import 'package:standby_capstone/pages/deep_menu_navigation.dart';
import 'package:standby_capstone/constants.dart';

class AboutStandbyPage extends StatefulWidget {
  const AboutStandbyPage({super.key});

  @override
  State<AboutStandbyPage> createState() => _AboutStandbyPageState();
}

class _AboutStandbyPageState extends State<AboutStandbyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DeepMenuAppbar(title: 'About StandBy'),
      backgroundColor: kGray,
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: Image.asset('assets/logo/logo.png', height: 96)),
            const SizedBox(height: 36),
            Text(
              'StandBy adalah sebuah platform yang menyediakan automasi dan informasi mengenai standarisasi inkubator bayi, berdasarkan dengan Standar Nasional Indonesia (SNI).',
              style: kTextNormal_Black,
            ),
            const SizedBox(height: 24),
            Text(
              'Developed by REY\n© 2024 StandBy Incubator',
              style: kTextHeading_Red,
            ),
          ],
        ),
      ),
    );
  }
}
