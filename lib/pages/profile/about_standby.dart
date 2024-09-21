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
      body: Container(
        color: kGray,
        child: const Center(
          child: Text('About StandBy'),
        ),
      ),
    );
  }
}
