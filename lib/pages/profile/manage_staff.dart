import 'package:flutter/material.dart';
import 'package:standby_capstone/components/auth_input_field.dart';
import 'package:standby_capstone/pages/deep_menu_navigation.dart';
import 'package:standby_capstone/constants.dart';
import 'package:standby_capstone/main.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class ManageStaff extends StatefulWidget {
  const ManageStaff({super.key});

  @override
  State<ManageStaff> createState() => _ManageStaffState();
}

class _ManageStaffState extends State<ManageStaff> {
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool isAdmin = false;

  final staffStream = supabase.from('profiles').stream(primaryKey: ['id']);

  Future<void> signUp() async {
    try {
      if (passwordController.text != confirmPasswordController.text) {
        showTopSnackBar(
          Overlay.of(context),
          const CustomSnackBar.error(message: "Passwords do not match!"),
        );
        return;
      }

      final AuthResponse authResponse = await supabase.auth.signUp(
        password: passwordController.text,
        email: emailController.text,
        data: {
          'full_name': fullNameController.text,
          'is_admin': isAdmin,
        },
      );

      if (!mounted) return;

      showTopSnackBar(
        Overlay.of(context),
        CustomSnackBar.success(
            message:
                "Account ${authResponse.user?.email} succesfully created!"),
      );
    } on AuthException catch (e) {
      showTopSnackBar(
        Overlay.of(context),
        CustomSnackBar.error(message: e.message.toString()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DeepMenuAppbar(title: 'Manage Staff'),
      body: Container(
        color: kGray,
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            StreamBuilder(
              stream: staffStream,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Text('No staff data available.');
                }

                final staffs = snapshot.data as List<Map<String, dynamic>>;

                return Expanded(
                  child: ListView.builder(
                    itemCount: staffs.length,
                    itemBuilder: (context, index) {
                      final staff = staffs[index];
                      return Container(
                        decoration: kEmbossDecoration,
                        margin: const EdgeInsets.only(bottom: 24),
                        padding: const EdgeInsets.only(left: 12),
                        child: ListTile(
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
                                staff['is_admin'] ? 'Admin' : 'Staff',
                                style: kTextHeading_Black,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
            AuthInputField(
              hintText: 'Full Name',
              controller: fullNameController,
              icon: Icons.person_rounded,
              obscureText: false,
            ),
            const SizedBox(height: 24),
            AuthInputField(
              hintText: 'Email',
              controller: emailController,
              icon: Icons.mail_rounded,
              obscureText: false,
            ),
            const SizedBox(height: 24),
            AuthInputField(
              hintText: 'Password',
              controller: passwordController,
              icon: Icons.lock_rounded,
              obscureText: true,
            ),
            const SizedBox(height: 24),
            AuthInputField(
              hintText: 'Confirm Password',
              controller: confirmPasswordController,
              icon: Icons.lock_rounded,
              obscureText: true,
            ),
            const SizedBox(height: 24),
            Text('Account Role:', style: kTextHeading_Red),
            Row(
              children: [
                Expanded(
                  child: RadioListTile<bool>(
                    title: Text('Staff', style: kTextHeading_Black),
                    activeColor: kPrimary,
                    value: false,
                    groupValue: isAdmin,
                    onChanged: (bool? value) {
                      setState(() {
                        isAdmin = value ?? false;
                      });
                    },
                  ),
                ),
                Expanded(
                  child: RadioListTile<bool>(
                    title: Text('Admin', style: kTextHeading_Black),
                    activeColor: kPrimary,
                    value: true,
                    groupValue: isAdmin,
                    onChanged: (bool? value) {
                      setState(() {
                        isAdmin = value ?? false;
                      });
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 36),
            Container(
              height: 48,
              width: double.infinity,
              decoration: kEmbossDecorationGrad,
              child: TextButton(
                onPressed: signUp,
                child: Center(
                  child: Text(
                    'add staff',
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
