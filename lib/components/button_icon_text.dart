import 'package:flutter/material.dart';
import 'package:standby_capstone/constants.dart';

class ButtonIconText extends StatefulWidget {
  final IconData icon;
  final String text;
  final Widget nextPage;
  final bool isPush;

  const ButtonIconText({
    super.key,
    required this.icon,
    required this.text,
    required this.nextPage,
    this.isPush = true,
  });

  @override
  State<ButtonIconText> createState() => _ButtonIconTextState();
}

class _ButtonIconTextState extends State<ButtonIconText> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => widget.nextPage,
          ),
        );
      },
      child: Container(
        width: double.infinity,
        decoration: kEmbossDecoration,
        child: Padding(
          padding: const EdgeInsetsDirectional.symmetric(
            horizontal: 24,
            vertical: 16,
          ),
          child: Row(
            children: [
              Icon(
                widget.icon,
                color: kPrimary,
                size: 24,
              ),
              const SizedBox(width: 24),
              Text(widget.text, style: kTextHeadingBlack),
            ],
          ),
        ),
      ),
    );
  }
}
