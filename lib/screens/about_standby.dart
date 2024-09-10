import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
      body: Container(
        color: kGray,
        child: const Center(
          child: Text('About StandBy'),
        ),
      ),
    );
  }
}
