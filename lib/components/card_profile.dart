import 'package:flutter/material.dart';
import 'package:standby_capstone/constants.dart';

class ProfileCard extends StatelessWidget {
  final IconData icon;
  final String name;
  final String desc;

  const ProfileCard({
    super.key,
    required this.icon,
    required this.name,
    required this.desc,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: kEmbossDecoration,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
        child: Row(
          children: [
            Icon(icon, color: kDarkGray, size: 48),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: kTextHeading_Red.copyWith(fontSize: 16)),
                  Text(desc, style: kTextNormal_Black),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
