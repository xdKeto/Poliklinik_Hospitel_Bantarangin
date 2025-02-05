import 'package:flutter/material.dart';
import 'package:poli_admin/base/utils/app_styles.dart';

class TheButton extends StatelessWidget {
  final String text;
  final bool isIcon;
  final Color color;
  final IconData icon;
  final VoidCallback? onTapFunc;

  const TheButton({
    super.key,
    required this.text,
    this.isIcon = false,
    required this.color,
    this.onTapFunc,
    this.icon = Icons.abc,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTapFunc,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 6, vertical: 8),
        decoration: AppStyles.buttonBox(color),
        child: isIcon
            ? Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(icon),
                  const SizedBox(width: 8),
                  Text(
                    text,
                    style: AppStyles.contentText.copyWith(
                        fontWeight: FontWeight.w600, color: Colors.black),
                  ),
                ],
              )
            : Center(
                child: Text(
                  text,
                  style: AppStyles.contentText.copyWith(
                      fontWeight: FontWeight.w600, color: Colors.black),
                ),
              ),
      ),
    );
  }
}
