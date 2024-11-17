import 'package:flutter/material.dart';
import 'package:standby_capstone/main.dart';
import 'package:standby_capstone/pages/deep_menu_navigation.dart';
import 'package:standby_capstone/constants.dart';
import 'package:standby_capstone/pages/profile/admin/add_staff_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class ManageStaffPage extends StatefulWidget {
  const ManageStaffPage({super.key});

  @override
  State<ManageStaffPage> createState() => _ManageStaffPageState();
}

class _ManageStaffPageState extends State<ManageStaffPage> {
  final staffStream = supabase.from('profiles').stream(primaryKey: ['id']);
  bool _isAdmin = false;

  Future<void> _getProfile() async {
    try {
      final userId = supabase.auth.currentUser?.id;
      if (userId == null) return;

      final data = await supabase
          .from('profiles')
          .select('is_admin')
          .eq('id', userId)
          .single();

      if (!mounted) return;

      setState(() {
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
      appBar: const DeepMenuAppbar(title: 'Manage Staff'),
      body: StreamBuilder(
        stream: staffStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(kPrimary),
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (!snapshot.hasData || (snapshot.data as List).isEmpty) {
            return const Center(
              child: Text('No staff data available.'),
            );
          }

          final staffs =
              (snapshot.data as List<dynamic>).cast<Map<String, dynamic>>();

          return ListView.builder(
            padding: const EdgeInsets.all(24),
            itemCount: staffs.length,
            itemBuilder: (context, index) {
              final staff = staffs[index];
              final avatarUrl = staff['avatar_url'] ?? '';

              return Container(
                decoration: kEmbossDecoration,
                margin: const EdgeInsets.only(bottom: 24),
                child: ListTile(
                  leading: CircleAvatar(
                    maxRadius: 32,
                    foregroundImage: avatarUrl.isNotEmpty
                        ? NetworkImage(avatarUrl)
                        : const AssetImage(
                            'assets/images/illustration_forgotpass.png'),
                    backgroundColor: kPrimary,
                  ),
                  title: Text(
                    staff['full_name'] ?? 'Full name not found',
                    style: kTextHeading_Red,
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        staff['email'] ?? 'Email not found',
                        style: kTextNormal_Black,
                      ),
                      Text(
                        staff['is_admin'] == true ? 'Admin' : 'Staff',
                        style: kTextHeading_Black,
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: _isAdmin
          ? FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddStaffPage(),
                  ),
                );
              },
              backgroundColor: kPrimary,
              shape: const CircleBorder(),
              child: const Icon(
                Icons.add_rounded,
                color: kWhite,
              ),
            )
          : null,
    );
  }
}
