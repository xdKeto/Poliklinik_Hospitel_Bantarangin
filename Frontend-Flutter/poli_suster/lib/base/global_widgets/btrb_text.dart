import 'package:flutter/material.dart';
import 'package:poli_suster/base/utils/app_styles.dart';

class btrbText extends StatelessWidget {
  final String topText;
  final String botText;
  const btrbText({super.key, required this.topText, required this.botText});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          topText,
          style: AppStyles.contentText.copyWith(fontWeight: FontWeight.bold),
        ),
        Text(botText, style: AppStyles.contentText)
      ],
    );
  }
}
