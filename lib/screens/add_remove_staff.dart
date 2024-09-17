import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:standby_capstone/constants.dart';
import 'package:standby_capstone/main.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AddRemoveStaff extends StatefulWidget {
  const AddRemoveStaff({super.key});

  @override
  State<AddRemoveStaff> createState() => _AddRemoveStaffState();
}

class _AddRemoveStaffState extends State<AddRemoveStaff> {
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final roleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: kGray,
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              Container(
                decoration: kDebossDecoration,
                padding: const EdgeInsets.only(left: 8),
                child: TextFormField(
                  controller: fullNameController,
                  decoration: InputDecoration(
                    prefixIcon:
                        const Icon(Icons.person_rounded, color: kDarkGray),
                    hintText: 'full name',
                    hintStyle: GoogleFonts.poppins(fontSize: 16),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.all(16),
                  ),
                  style: GoogleFonts.poppins(fontSize: 16),
                ),
              ),
              const SizedBox(height: 24),
              Container(
                decoration: kDebossDecoration,
                padding: const EdgeInsets.only(left: 8),
                child: TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                    prefixIcon:
                        const Icon(Icons.email_rounded, color: kDarkGray),
                    hintText: 'email',
                    hintStyle: GoogleFonts.poppins(fontSize: 16),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.all(16),
                  ),
                  style: GoogleFonts.poppins(fontSize: 16),
                ),
              ),
              const SizedBox(height: 24),
              Container(
                decoration: kDebossDecoration,
                padding: const EdgeInsets.only(left: 8),
                child: TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    prefixIcon:
                        const Icon(Icons.lock_rounded, color: kDarkGray),
                    hintText: 'password',
                    hintStyle: GoogleFonts.poppins(fontSize: 16),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.all(16),
                  ),
                  style: GoogleFonts.poppins(fontSize: 16),
                ),
              ),
              const SizedBox(height: 24),
              Container(
                decoration: kDebossDecoration,
                padding: const EdgeInsets.only(left: 8),
                child: TextFormField(
                  controller: confirmPasswordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    prefixIcon:
                        const Icon(Icons.lock_rounded, color: kDarkGray),
                    hintText: 'confirm password',
                    hintStyle: GoogleFonts.poppins(fontSize: 16),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.all(16),
                  ),
                  style: GoogleFonts.poppins(fontSize: 16),
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () async {
                  if (passwordController.text !=
                      confirmPasswordController.text) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Passwords do not match"),
                      ),
                    );
                    return;
                  }

                  final scaffoldMessenger = ScaffoldMessenger.of(context);
                  final AuthResponse authResponse = await supabase.auth.signUp(
                    password: passwordController.text,
                    email: emailController.text,
                    data: {
                      'full_name': fullNameController.text,
                      'role': roleController.text,
                    },
                  );
                  scaffoldMessenger.showSnackBar(
                    SnackBar(
                      content:
                          Text("User ${authResponse.user?.email} created!"),
                    ),
                  );
                },
                child: const Text('Add Staff'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
