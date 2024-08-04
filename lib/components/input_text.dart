import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:standby_capstone/constants.dart';

class InputText extends StatefulWidget {
  final String hintText;
  final double fontSize;
  final FontWeight fontWeight;

  const InputText({
    super.key,
    required this.hintText,
    this.fontSize = 16.0,
    this.fontWeight = FontWeight.normal,
  });

  @override
  State<InputText> createState() => _InputTextState();
}

class _InputTextState extends State<InputText> {
  @override
  Widget build(BuildContext context) {
    return Focus(
      onFocusChange: (hasFocus) {
        setState(() {
          hasFocus;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        decoration: kDebossDecoration,
        child: TextFormField(
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: widget.hintText,
            hintStyle: GoogleFonts.poppins(
              fontSize: widget.fontSize,
              fontWeight: widget.fontWeight,
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          ),
          style: GoogleFonts.poppins(
            fontSize: widget.fontSize,
            fontWeight: widget.fontWeight,
          ),
        ),
      ),
    );
  }
}
