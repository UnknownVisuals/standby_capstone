import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:standby_capstone/constants.dart';

class InfoCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const InfoCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    Offset offset = const Offset(4, 4);
    double blurRadius = 8.0;
    return Container(
      height: 128,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        color: kGray,
        boxShadow: [
          BoxShadow(
            color: kEmbossShadowBlack,
            offset: offset,
            blurRadius: blurRadius,
          ),
          BoxShadow(
            color: kEmbossShadowWhite,
            offset: -offset,
            blurRadius: blurRadius,
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.topLeft,
              padding: const EdgeInsets.all(12),
              height: 128,
              child: Icon(
                icon,
                size: 48,
                color: kDarkGray,
              ),
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    width: double.infinity,
                    child: Text(
                      title,
                      textAlign: TextAlign.right,
                      style: GoogleFonts.poppins(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: kPrimary,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.bottomRight,
                    padding: const EdgeInsets.all(12),
                    width: double.infinity,
                    child: Text(
                      subtitle,
                      textAlign: TextAlign.right,
                      style: GoogleFonts.poppins(fontSize: 16, color: kBlack),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}