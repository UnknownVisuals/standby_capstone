import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:standby_capstone/constants.dart';

class InfoCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final double width;

  const InfoCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.width = double.infinity,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 128,
      width: width,
      padding: const EdgeInsets.all(12),
      decoration: kEmbossDecoration,
      child: Row(
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.topLeft,
              height: double.infinity,
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
                    alignment: Alignment.topRight,
                    // width: double.infinity,
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
                    // width: double.infinity,
                    child: Text(
                      subtitle,
                      textAlign: TextAlign.right,
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        color: kBlack,
                      ),
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
