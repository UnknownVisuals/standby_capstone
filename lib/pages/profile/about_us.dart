import 'package:flutter/material.dart';
import 'package:standby_capstone/pages/deep_menu_navigation.dart';
import 'package:standby_capstone/constants.dart';

class AboutUs extends StatefulWidget {
  const AboutUs({super.key});

  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DeepMenuAppbar(title: 'About Us'),
      body: Container(
        color: kGray,
        child: const Center(
          child: Text('About Us'),
        ),
      ),
    );
  }
}
