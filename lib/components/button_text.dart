import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:standby_capstone/constants.dart';
import 'package:standby_capstone/screens/monitoring_page.dart';

class ButtonText extends StatefulWidget {
  final String text;
  final double fontSize;
  final FontWeight fontWeight;

  const ButtonText({
    super.key,
    required this.text,
    this.fontSize = 16.0,
    this.fontWeight = FontWeight.bold,
  });

  @override
  State<ButtonText> createState() => _ButtonTextState();
}

class _ButtonTextState extends State<ButtonText> {
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    Offset offset = isPressed ? const Offset(-4, -4) : const Offset(4, 4);
    double blurRadius = 8.0;

    return GestureDetector(
      onTap: () {
        setState(() {
          isPressed = !isPressed;
        });
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const MonitoringPage(),
          ),
        );
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        height: 48.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          color: kGray,
          boxShadow: [
            BoxShadow(
              color: isPressed ? kDebossShadowWhite : kEmbossShadowBlack,
              offset: offset,
              blurRadius: blurRadius,
              inset: isPressed,
            ),
            BoxShadow(
              color: isPressed ? kDebossShadowBlack : kEmbossShadowWhite,
              offset: -offset,
              blurRadius: blurRadius,
              inset: isPressed,
            ),
          ],
        ),
        child: Center(
          child: Text(
            widget.text,
            style: GoogleFonts.poppins(
              fontSize: widget.fontSize,
              fontWeight: widget.fontWeight,
            ),
          ),
        ),
      ),
    );
  }
}
