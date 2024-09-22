import 'package:flutter/material.dart';
import 'package:standby_capstone/constants.dart';

class DeepMenuAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const DeepMenuAppbar({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: kGray,
      surfaceTintColor: kGray,
      leading: Padding(
        padding: const EdgeInsets.only(left: 16.0),
        child: Image.asset(
          'assets/logo/logo_icon.png',
          height: 40,
        ),
      ),
      title: Text(title, style: kAppbarTitle),
      actions: [
        IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.close),
        )
      ],
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
