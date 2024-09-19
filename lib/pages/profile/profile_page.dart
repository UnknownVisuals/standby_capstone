import 'package:flutter/material.dart';
import 'package:standby_capstone/components/button_icon_text.dart';
import 'package:standby_capstone/constants.dart';
import 'package:standby_capstone/main.dart';
import 'package:standby_capstone/pages/profile/about_standby.dart';
import 'package:standby_capstone/pages/profile/about_us.dart';
import 'package:standby_capstone/pages/profile/manage_staff.dart';
import 'package:standby_capstone/pages/login_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final User? user = supabase.auth.currentUser;
  Map<String, dynamic>? userProfiles;

  @override
  void initState() {
    super.initState();
    fetchUserProfile();
  }

  Future<void> fetchUserProfile() async {
    final response = await supabase
        .from('profiles')
        .select()
        .eq('id', user?.id as Object)
        .single();
    setState(() {
      userProfiles = response;
    });
  }

  Future<void> signOut() async {
    await supabase.auth.signOut();
    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginPage(),
      ),
    );
  }

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
                          userProfiles?['full_name']?.toString() ??
                              'Full name not found',
                          style: kTextHeading_Red,
                        ),
                        Text(
                          user?.email ?? 'Email not found',
                          style: kTextNormal_Black,
                        ),
                        Text(
                          'Role: Not set',
                          style: kTextHeading_Black,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              const ButtonIconText(
                icon: Icons.person_add_alt_rounded,
                text: 'Manage Staff',
                nextPage: ManageStaff(),
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
              Container(
                height: 48,
                width: double.infinity,
                decoration: kEmbossDecorationGrad,
                child: TextButton(
                  onPressed: signOut,
                  child: Center(
                    child: Text(
                      'keluar',
                      style: kButtonTitle_White,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
