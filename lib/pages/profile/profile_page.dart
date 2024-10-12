import 'package:flutter/material.dart';
import 'package:standby_capstone/components/button_icon_text.dart';
import 'package:standby_capstone/constants.dart';
import 'package:standby_capstone/main.dart';
import 'package:standby_capstone/pages/profile/about_standby.dart';
import 'package:standby_capstone/pages/profile/about_us.dart';
import 'package:standby_capstone/pages/profile/manage_staff.dart';
import 'package:standby_capstone/pages/login_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool _loading = true;
  String? _avatarUrl;
  String _fullName = '';
  String _email = '';
  bool _isAdmin = false;

  Future<void> _getProfile() async {
    setState(() {
      _loading = true;
    });

    try {
      final userId = supabase.auth.currentSession?.user.id;
      if (userId == null) return;
      final data =
          await supabase.from('profiles').select().eq('id', userId).single();
      if (!mounted) return;
      setState(() {
        _avatarUrl = data['avatar_url'] ?? '';
        _fullName = data['full_name'] ?? 'Full name not found';
        _email = data['email'] ?? 'Email not found';
        _isAdmin = data['is_admin'] ?? false;
      });
    } on PostgrestException catch (e) {
      showTopSnackBar(
        Overlay.of(context),
        CustomSnackBar.error(message: e.message.toString()),
      );
    } catch (e) {
      showTopSnackBar(
        Overlay.of(context),
        const CustomSnackBar.error(message: 'Unexpected error occurred'),
      );
    } finally {
      if (mounted) {
        setState(() {
          _loading = false;
        });
      }
    }
  }

  Future<void> _signOut() async {
    try {
      await supabase.auth.signOut();
      if (!mounted) return;
    } on AuthException catch (e) {
      showTopSnackBar(
        Overlay.of(context),
        CustomSnackBar.error(message: e.message.toString()),
      );
    } catch (e) {
      showTopSnackBar(
        Overlay.of(context),
        const CustomSnackBar.error(message: 'Unexpected error occurred'),
      );
    } finally {
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const LoginPage()),
        );
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _getProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kGray,
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: _loading
            ? const Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: 64,
                    margin: const EdgeInsets.only(bottom: 24),
                    child: Row(
                      children: [
                        CircleAvatar(
                          maxRadius: 32,
                          foregroundImage: _avatarUrl != null &&
                                  _avatarUrl!.isNotEmpty
                              ? NetworkImage(_avatarUrl!)
                              : const AssetImage(
                                      'assets/images/illustration_forgotpass.png')
                                  as ImageProvider,
                          backgroundColor: kPrimary,
                        ),
                        const SizedBox(width: 24),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _fullName,
                              style: kTextHeading_Red,
                            ),
                            Text(
                              _email,
                              style: kTextNormal_Black,
                            ),
                            Text(
                              _isAdmin ? 'Admin' : 'Staff',
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
                      onPressed: _signOut,
                      child: Center(
                        child: Text(
                          'Sign out',
                          style: kButtonTitle_White,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
