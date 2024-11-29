import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:google_fonts/google_fonts.dart';

const kWhite = Color(0xFFEEEEEE);
const kGray = Color(0xFFDDDDDD);
const kPrimary = Color(0xFFE3383A);
const kPrimaryGrad = Color(0xFFD3321D);
const kDarkGray = Color(0xFF444444);
const kBlack = Color(0xFF222222);

const kEmbossShadowBlack = Color(0x44000000);
const kEmbossShadowWhite = Color(0xDDFFFFFF);
const kDebossShadowBlack = Color(0x88000000);
const kDebossShadowWhite = Color(0xFFFFFFFF);

final BoxDecoration kEmbossDecorationGrad = BoxDecoration(
  borderRadius: BorderRadius.circular(16.0),
  gradient: const LinearGradient(
    colors: <Color>[kPrimary, kPrimaryGrad],
  ),
  boxShadow: const [
    BoxShadow(
      color: kEmbossShadowBlack,
      offset: Offset(4, 4),
      blurRadius: 8.0,
    ),
    BoxShadow(
      color: kEmbossShadowWhite,
      offset: Offset(-4, -4),
      blurRadius: 8.0,
    ),
  ],
);

final BoxDecoration kEmbossDecoration = BoxDecoration(
  borderRadius: BorderRadius.circular(16.0),
  color: kGray,
  boxShadow: const [
    BoxShadow(
      color: kEmbossShadowBlack,
      offset: Offset(4, 4),
      blurRadius: 8.0,
    ),
    BoxShadow(
      color: kEmbossShadowWhite,
      offset: Offset(-4, -4),
      blurRadius: 8.0,
    ),
  ],
);

final BoxDecoration kDebossDecoration = BoxDecoration(
  borderRadius: BorderRadius.circular(16.0),
  color: kGray,
  boxShadow: const [
    BoxShadow(
      color: kDebossShadowBlack,
      offset: Offset(2, 2),
      blurRadius: 4.0,
      inset: true,
    ),
    BoxShadow(
      color: kDebossShadowWhite,
      offset: Offset(-2, -2),
      blurRadius: 4.0,
      inset: true,
    ),
  ],
);

final TextStyle kAuthTitleLarge = GoogleFonts.poppins(
  color: kWhite,
  fontSize: 24,
  fontWeight: FontWeight.bold,
);

final TextStyle kAppbarTitle = GoogleFonts.poppins(
  color: kBlack,
  fontSize: 16,
  fontWeight: FontWeight.bold,
);

final TextStyle kForgotPassword = GoogleFonts.poppins(
  color: kPrimary,
  fontSize: 14,
  fontWeight: FontWeight.bold,
  decoration: TextDecoration.underline,
  decorationColor: kPrimary,
  decorationThickness: 2,
);

final TextStyle kButtonTitle_White = GoogleFonts.poppins(
  color: kWhite,
  fontSize: 16,
  fontWeight: FontWeight.bold,
);
final TextStyle kButtonTitle_Black = GoogleFonts.poppins(
  color: kBlack,
  fontSize: 16,
  fontWeight: FontWeight.bold,
);

final TextStyle kTextHeading_Red = GoogleFonts.poppins(
  color: kPrimary,
  fontSize: 14,
  fontWeight: FontWeight.bold,
);

final TextStyle kTextHeading_Black = GoogleFonts.poppins(
  color: kBlack,
  fontSize: 14,
  fontWeight: FontWeight.bold,
);

final TextStyle kTextNormal_White = GoogleFonts.poppins(
  color: kWhite,
  fontSize: 14,
  fontWeight: FontWeight.normal,
);

final TextStyle kTextNormal_Black = GoogleFonts.poppins(
  color: kBlack,
  fontSize: 14,
  fontWeight: FontWeight.normal,
);

final TextStyle kMonitor = GoogleFonts.poppins(
  color: kPrimary,
  fontSize: 24,
  fontWeight: FontWeight.bold,
);

final TextStyle kMonitorDescription = GoogleFonts.poppins(
  color: kBlack,
  fontSize: 16,
  fontWeight: FontWeight.normal,
);
