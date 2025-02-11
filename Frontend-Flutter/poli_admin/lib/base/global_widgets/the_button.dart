import 'package:flutter/material.dart';
import 'package:poli_admin/base/utils/app_styles.dart';

class TheButton extends StatelessWidget {
  final String text;
  final bool isIcon;
  final Color color;
  final Color textColor;
  final Color iconColor;
  final IconData icon;
  final VoidCallback? onTapFunc;
  final bool border;
  final double horiPadding;
  final double vertPadding;
  final double borderRad;

  const TheButton(
      {super.key,
      this.borderRad = 6,
      this.horiPadding = 6,
      this.vertPadding = 8,
      required this.text,
      this.isIcon = false,
      required this.color,
      this.onTapFunc,
      this.icon = Icons.abc,
      this.textColor = Colors.black,
      this.iconColor = Colors.black,
      this.border = false});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTapFunc,
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: horiPadding, vertical: vertPadding),
        decoration:
            border ? AppStyles.buttonBox2(color, borderRad) : AppStyles.buttonBox(color, borderRad),
        child: isIcon
            ? Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    icon,
                    color: iconColor,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    text,
                    style: AppStyles.contentText.copyWith(
                        fontWeight: FontWeight.w600, color: textColor),
                  ),
                ],
              )
            : Center(
                child: Text(
                  text,
                  style: AppStyles.contentText
                      .copyWith(fontWeight: FontWeight.w600, color: textColor),
                ),
              ),
      ),
    );
  }
}
