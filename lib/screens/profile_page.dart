import 'package:flutter/material.dart';
import 'package:standby_capstone/components/button_icon_text.dart';
import 'package:standby_capstone/constants.dart';
import 'package:standby_capstone/screens/about_standby.dart';
import 'package:standby_capstone/screens/about_us.dart';
import 'package:standby_capstone/screens/add_remove_staff.dart';
import 'package:standby_capstone/screens/login_page.dart';
import 'package:standby_capstone/screens/main_page.dart';

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
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 64,
                margin: const EdgeInsets.only(bottom: 24),
                // decoration: kEmbossDecoration,
                child: Row(
                  children: [
                    const CircleAvatar(
                      maxRadius: 32,
                      foregroundImage: AssetImage(
                          'assets/images/illustration_forgotpass.png'),
                      backgroundColor: kPrimary,
                    ),
                    const SizedBox(width: 24),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Reynaldhi Tryana Graha',
                          style: kTextHeadingRed,
                        ),
                        Text(
                          'reynaldhi0@gmail.com',
                          style: kTextNormal,
                        ),
                        Text(
                          'Admin',
                          style: kTextHeadingBlack,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              const ButtonIconText(
                icon: Icons.person_add_alt_rounded,
                text: 'Add/Remove Staff',
                nextPage: AddRemoveStaff(),
              ),
              const SizedBox(height: 24),
              const ButtonIconText(
                icon: Icons.info_rounded,
                text: 'About StandBy',
                nextPage: AboutStandby(),
              ),
              const SizedBox(height: 24),
              const ButtonIconText(
                icon: Icons.groups_rounded,
                text: 'About Us',
                nextPage: AboutUs(),
              ),
              const Spacer(),
              const ButtonIconText(
                icon: Icons.exit_to_app_rounded,
                text: 'Sign Out',
                nextPage: LoginPage(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
