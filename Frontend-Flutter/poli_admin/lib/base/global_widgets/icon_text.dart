import 'package:flutter/material.dart';

class IconText extends StatelessWidget {
  final IconData icon;
  final String? text;
  final bool isIcon;
  final TextStyle? style;
  final Color iconColor;
  const IconText(
      {super.key,
      required this.icon,
      this.text,
      required this.isIcon, this.style, required this.iconColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(12),
      ),
      child: isIcon
          ? Row(
              children: [
                Icon(
                  icon,
                  color: iconColor,
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  text!,
                  style: style,
                )
              ],
            )
          : Row(
              children: [
                Icon(
                  icon,
                  color: iconColor,
                ),
              ],
            ),
    );
  }
}
