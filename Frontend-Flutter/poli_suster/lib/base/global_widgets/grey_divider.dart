
import 'package:flutter/material.dart';
import 'package:poli_suster/base/utils/app_styles.dart';

class GreyDivider extends StatelessWidget {
  const GreyDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: AppStyles.greyColor2,
      thickness: 1,
    );
  }
}