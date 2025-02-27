  import 'package:flutter/material.dart';
import 'package:poli_suster/base/utils/app_styles.dart';

class DataPasien extends StatefulWidget {
  const DataPasien({super.key});

  @override
  State<DataPasien> createState() => _DataPasienState();
}

class _DataPasienState extends State<DataPasien> {
  @override
  Widget build(BuildContext context) {
    return Column(
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
      ],
    );
  }
}
