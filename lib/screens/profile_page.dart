import 'package:flutter/material.dart';
import 'package:standby_capstone/constants.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: kGray,
        child: const Center(
          child: Text("Profile Page"),
        ),
      ),
    );
  }
}
