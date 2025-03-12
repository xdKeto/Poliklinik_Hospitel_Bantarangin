import 'package:flutter/material.dart';
import 'package:poli_admin/base/utils/app_styles.dart';

class StatusBox extends StatelessWidget {
  final String status;
  const StatusBox({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    Color color = AppStyles.accentColor;

    if (status.toLowerCase() == 'ditunda') {
      color = AppStyles.accentColor2;
    } else if (status.toLowerCase() == 'menunggu') {
      color = AppStyles.redColor;
    } else if (status.toLowerCase() == 'selesai') {
      color = AppStyles.greenColor2;
    }else if (status.toLowerCase() == 'konsultasi'){
      color = AppStyles.secondaryColor;
    }else {
      color = AppStyles.primaryColor;
    }

    return Container(
      padding: EdgeInsets.symmetric(vertical: 2.5, horizontal: 2),  
      height: 30,
      width: 100,
      decoration: BoxDecoration(
          color: color.withOpacity(0.3),
          border: Border.all(color: color, width: 2),
          borderRadius: BorderRadius.circular(12)),
      child: Center(
        child: Text(
          status.toUpperCase(),
          style: AppStyles.contentText
              .copyWith(color: color, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
