import 'package:flutter/material.dart';
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
              Text(
                'Meet Our Supervisors',
                style: kTextHeading_Red.copyWith(fontSize: 24),
              ),
              const SizedBox(height: 24),
              const ProfileCard(
                picturePath: 'assets/peoples/SAO.jpg',
                name: 'Suryo Adhi Wibowo, S.T., M.T., Ph.D.',
                role: '1st Supervisor',
                jobdesc: 'Vice Director CoE AILO Telkom University',
              ),
              const SizedBox(height: 24),
              const ProfileCard(
                picturePath: 'assets/peoples/KRU.jpg',
                name: 'Dr. Koredianto Usman, S.T., M.Sc.',
                role: '2nd Supervisor',
                jobdesc: 'Lecturer at Telkom University',
              ),
              const SizedBox(height: 24 * 2),
              // ClipRRect(
              //   borderRadius: BorderRadius.circular(16),
              //   child: Image.asset(
              //     'assets/images/about_us.jpg',
              //     width: double.infinity,
              //   ),
              // ),
              const SizedBox(height: 12),
              Text(
                'Meet Our Team',
                style: kTextHeading_Red.copyWith(fontSize: 24),
              ),
              // Text('from left to right', style: kTextNormal_Black),
              const SizedBox(height: 24),
              const ProfileCard(
                picturePath: 'assets/peoples/HRI.jpg',
                name: 'Fakhriadi Rasyaad',
                role: 'Website Developer',
                jobdesc: 'Website & Backend Development (Storage Management)',
              ),
              const SizedBox(height: 24),
              const ProfileCard(
                picturePath: 'assets/peoples/CHA.jpg',
                name: 'Marshaniswah Syamsul',
                role: 'Artificial Intelligence & Cloud Developer',
                jobdesc:
                    'Artificial Intelligence Development & Cloud System Management',
              ),
              const SizedBox(height: 24),
              const ProfileCard(
                picturePath: 'assets/peoples/REY.jpg',
                name: 'Reynaldhi Tryana Graha',
                role: 'Mobile Application Developer',
                jobdesc:
                    'Mobile Application & Backend Development Development (Authentication)',
              ),
              const SizedBox(height: 24),
              const ProfileCard(
                picturePath: 'assets/peoples/DAM.jpg',
                name: 'Sadam Al Rasyid',
                role: 'IoT Developer',
                jobdesc:
                    'IoT Hardware & Backend Development (Realtime Database)',
              ),
              const SizedBox(height: 24),
              Text('© 2024 StandBy Incubator', style: kTextHeading_Red),
            ],
          ),
        ),
      ),
    );
  }
}
