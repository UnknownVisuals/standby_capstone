import 'package:flutter/material.dart';
import 'package:standby_capstone/pages/deep_menu_navigation.dart';
import 'package:standby_capstone/constants.dart';

class AboutStandby extends StatefulWidget {
  const AboutStandby({super.key});

  @override
  State<AboutStandby> createState() => _AboutStandbyState();
}

class _AboutStandbyState extends State<AboutStandby> {
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
              'StandBy adalah sebuah sistem untuk mempermudah proses standardisasi inkubator bayi. Aplikasi mobile ini merupakan salah satu bagian dari sistem StandBy.',
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
