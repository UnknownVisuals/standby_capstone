import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:standby_capstone/constants.dart';

class ButtonText extends StatefulWidget {
  final String text;
  final Widget nextPage;
  final bool isPush;

  const ButtonText({
    super.key,
    required this.text,
    required this.nextPage,
    this.isPush = true,
  });

  @override
  State<ButtonText> createState() => _ButtonTextState();
}

class _ButtonTextState extends State<ButtonText> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.isPush) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => widget.nextPage,
            ),
          );
        } else {
          Navigator.pop(context);
        }
      },
      child: Container(
        height: 48.0,
        decoration: kEmbossDecoration,
        child: Center(
          child: Text(
            widget.text,
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
