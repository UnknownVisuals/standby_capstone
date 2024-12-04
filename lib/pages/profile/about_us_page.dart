import 'package:flutter/material.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:standby_capstone/components/card_profile.dart';
import 'package:standby_capstone/pages/deep_menu_navigation.dart';
import 'package:standby_capstone/constants.dart';

class AboutUsPage extends StatefulWidget {
  const AboutUsPage({super.key});

  @override
  State<AboutUsPage> createState() => _AboutUsPageState();
}

class _AboutUsPageState extends State<AboutUsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DeepMenuAppbar(title: 'About Us'),
      backgroundColor: kGray,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  'assets/images/about_us.jpg',
                  width: double.infinity,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Meet Our Team',
                style: kTextHeading_Red.copyWith(fontSize: 24),
              ),
              Text('from left to right', style: kTextNormal_Black),
              const SizedBox(height: 24),
              const ProfileCard(
                icon: Symbols.language_rounded,
                name: 'Fakhriadi Rasyaad',
                desc: 'Frontend Develover for StandBy',
              ),
              const SizedBox(height: 24),
              const ProfileCard(
                icon: Symbols.network_intelligence_rounded,
                name: 'Marshaniswah Syamsul',
                desc: 'Artificial Intelligence Developer for StandBy',
              ),
              const SizedBox(height: 24),
              const ProfileCard(
                icon: Symbols.smartphone_rounded,
                name: 'Reynaldhi Tryana Graha',
                desc: 'Mobile Application Developer for StandBy',
              ),
              const SizedBox(height: 24),
              const ProfileCard(
                icon: Symbols.home_iot_device_rounded,
                name: 'Sadam Al Rasyid',
                desc: 'IoT Developer for StandBy',
              ),
              const SizedBox(height: 24),
              Text(
                '© 2024 StandBy Incubator',
                style: kTextHeading_Red,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
