import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:standby_capstone/constants.dart';

class AuthInputField extends StatefulWidget {
  final String hintText;
  final TextEditingController controller;
  final bool numberInput;
  final IconData icon;
  final bool useObscure;

  const AuthInputField({
    super.key,
    required this.hintText,
    required this.controller,
    required this.icon,
    this.useObscure = false,
    this.numberInput = false,
  });

  @override
  State<AuthInputField> createState() => _AuthInputFieldState();
}

class _AuthInputFieldState extends State<AuthInputField> {
  late bool _isObscured;

  @override
  void initState() {
    super.initState();
    _isObscured = true;
  }

  void _toggleObscureText() {
    setState(() {
      _isObscured = !_isObscured;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: kDebossDecoration,
      padding: const EdgeInsets.only(left: 8),
      child: TextFormField(
        controller: widget.controller,
        keyboardType:
            widget.numberInput ? TextInputType.number : TextInputType.text,
        obscureText: widget.useObscure && _isObscured,
        decoration: InputDecoration(
          prefixIcon: Icon(widget.icon, color: kDarkGray),
          hintText: widget.hintText,
          hintStyle: GoogleFonts.poppins(fontSize: 16),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.all(16),
          suffixIcon: widget.useObscure
              ? IconButton(
                  icon: Icon(
                    _isObscured ? Icons.visibility_off : Icons.visibility,
                    color: kDarkGray,
                  ),
                  onPressed: _toggleObscureText,
                )
              : null,
        ),
        style: GoogleFonts.poppins(fontSize: 16),
      ),
    );
  }
}
