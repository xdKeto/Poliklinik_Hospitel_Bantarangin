import 'package:flutter/material.dart';
import 'package:poli_suster/base/utils/app_styles.dart';

class BoldNRegText extends StatelessWidget {
  final String label;
  final String data;
  final String type;
  const BoldNRegText(
      {super.key, required this.label, required this.data, required this.type});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppStyles.contentText.copyWith(
              color: AppStyles.primaryColor, fontWeight: FontWeight.bold),
        ),
        Text(
          ' : $data $type',
          style: AppStyles.contentText.copyWith(color: AppStyles.primaryColor),
        )
      ],
    );
  }
}
