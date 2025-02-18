import 'package:flutter/material.dart';
import 'package:poli_suster/base/utils/app_styles.dart';

class InputScreening extends StatefulWidget {
  const InputScreening({super.key});

  @override
  State<InputScreening> createState() => _InputScreeningState();
}

class _InputScreeningState extends State<InputScreening> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'John Doe',
                style: AppStyles.subheadingText.copyWith(
                    fontWeight: FontWeight.bold, color: AppStyles.primaryColor),
              ),
              Text(
                '01 Januari 2024',
                style: AppStyles.subheadingText.copyWith(
                    fontWeight: FontWeight.bold, color: AppStyles.primaryColor),
              ),
            ],
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            'No. rekam medis: RM2024001',
            style: AppStyles.contentText,
          ),
          Text(
            'Jenis kelamin: Laki-laki',
            style: AppStyles.contentText,
          ),
          Text(
            'Umur: 22 tahun',
            style: AppStyles.contentText,
          ),
          SizedBox(height: 16,),
          
        ],
      ),
    );
  }
}
