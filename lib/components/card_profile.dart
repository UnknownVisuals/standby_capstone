import 'package:flutter/material.dart';
import 'package:standby_capstone/constants.dart';

class ProfileCard extends StatelessWidget {
  final String picturePath;
  final String name;
  final String role;
  final String jobdesc;

  const ProfileCard({
    super.key,
    required this.picturePath,
    required this.name,
    required this.role,
    required this.jobdesc,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: kEmbossDecoration,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              maxRadius: 40,
              foregroundImage: AssetImage(picturePath) as ImageProvider,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: kTextHeading_Red.copyWith(fontSize: 16)),
                  Text(role, style: kTextHeading_Black),
                  Text(jobdesc, style: kTextNormal_Black),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
