import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:standby_capstone/components/auth_input_field.dart';
import 'package:standby_capstone/pages/deep_menu_navigation.dart';
import 'package:standby_capstone/constants.dart';
import 'package:standby_capstone/main.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class AddStaffPage extends StatefulWidget {
  const AddStaffPage({super.key});

  @override
  State<AddStaffPage> createState() => _AddStaffPageState();
}

class _AddStaffPageState extends State<AddStaffPage> {
  String? _avatarUrl;
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isAdmin = false;
  bool _isLoading = false;

  Future<void> _signUp() async {
    if (_passwordController.text != _confirmPasswordController.text) {
      showTopSnackBar(
        Overlay.of(context),
        const CustomSnackBar.error(message: "Passwords do not match!"),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final AuthResponse authResponse = await supabase.auth.signUp(
        password: _passwordController.text,
        email: _emailController.text,
        emailRedirectTo: 'io.supabase.flutterquickstart://login-callback/',
        data: {
          'full_name': _fullNameController.text,
          'is_admin': _isAdmin,
          'avatar_url': _avatarUrl,
        },
      );

      if (!mounted) return;

      showTopSnackBar(
        Overlay.of(context),
        CustomSnackBar.success(
            message:
                "Account ${authResponse.user?.email} successfully created!"),
      );
    } on AuthException catch (e) {
      showTopSnackBar(
        Overlay.of(context),
        CustomSnackBar.error(message: e.message.toString()),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _uploadImage() async {
    final picker = ImagePicker();
    final imageFile = await picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 300,
      maxHeight: 300,
    );

    if (imageFile == null) return;

    setState(() => _isLoading = true);

    try {
      final bytes = await imageFile.readAsBytes();
      final fileExt = imageFile.path.split('.').last;
      final fileName = '${DateTime.now().toIso8601String()}.$fileExt';
      final filePath = fileName;

      await supabase.storage.from('avatars').uploadBinary(
            filePath,
            bytes,
            fileOptions: FileOptions(contentType: imageFile.mimeType),
          );

      final imageUrlResponse = await supabase.storage
          .from('avatars')
          .createSignedUrl(filePath, 60 * 60 * 24 * 365 * 10);

      setState(() {
        _avatarUrl = imageUrlResponse;
      });

      if (!mounted) return;

      showTopSnackBar(
        Overlay.of(context),
        const CustomSnackBar.success(message: 'Profile image updated!'),
      );
    } on StorageException catch (e) {
      if (!mounted) return;
      showTopSnackBar(
        Overlay.of(context),
        CustomSnackBar.error(message: e.message.toString()),
      );
    } catch (e) {
      if (!mounted) return;
      showTopSnackBar(
        Overlay.of(context),
        const CustomSnackBar.error(message: 'Unexpected error occurred'),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kGray,
      appBar: const DeepMenuAppbar(title: 'Add Staff'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              CircleAvatar(
                maxRadius: 64,
                foregroundImage: _avatarUrl != null
                    ? NetworkImage(_avatarUrl!)
                    : const AssetImage(
                            'assets/images/illustration_forgotpass.png')
                        as ImageProvider,
                backgroundColor: kPrimary,
              ),
              const SizedBox(height: 24),
              Container(
                height: 48,
                width: 128 + 64,
                decoration: kEmbossDecorationGrad,
                child: TextButton(
                  onPressed: _uploadImage,
                  child: Center(
                    child: Text(
                      'Upload Image',
                      style: kButtonTitle_White,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              AuthInputField(
                hintText: 'Full Name',
                controller: _fullNameController,
                icon: Icons.person_rounded,
              ),
              const SizedBox(height: 24),
              AuthInputField(
                hintText: 'Email',
                controller: _emailController,
                icon: Icons.mail_rounded,
              ),
              const SizedBox(height: 24),
              AuthInputField(
                hintText: 'Password',
                controller: _passwordController,
                icon: Icons.lock_rounded,
                useObscure: true,
              ),
              const SizedBox(height: 24),
              AuthInputField(
                hintText: 'Confirm Password',
                controller: _confirmPasswordController,
                icon: Icons.lock_rounded,
                useObscure: true,
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
                      groupValue: _isAdmin,
                      onChanged: (bool? value) {
                        setState(() {
                          _isAdmin = value ?? false;
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: RadioListTile<bool>(
                      title: Text('Admin', style: kTextHeading_Black),
                      activeColor: kPrimary,
                      value: true,
                      groupValue: _isAdmin,
                      onChanged: (bool? value) {
                        setState(() {
                          _isAdmin = value ?? false;
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
                  onPressed: _signUp,
                  child: Center(
                    child: _isLoading
                        ? const CircularProgressIndicator(color: kWhite)
                        : Text(
                            'Add Staff',
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
