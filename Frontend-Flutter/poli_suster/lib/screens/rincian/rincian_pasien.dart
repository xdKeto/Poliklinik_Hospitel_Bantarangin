import 'package:flutter/material.dart';
import 'package:poli_suster/base/utils/app_styles.dart';
import 'package:poli_suster/screens/rincian/data_kesehatan.dart';
import 'package:poli_suster/screens/rincian/data_pasien.dart';

class RincianPasien extends StatefulWidget {
  const RincianPasien({super.key});

  @override
  State<RincianPasien> createState() => _RincianPasienState();
}

class _RincianPasienState extends State<RincianPasien> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Data Pasien',
            style: AppStyles.contentText.copyWith(
                fontWeight: FontWeight.w600, color: AppStyles.primaryColor),
          ),
          SizedBox(
            height: 8,
          ),
          DataPasien(),
          SizedBox(
            height: 16,
          ),
          Text(
            'Data Kesehatan',
            style: AppStyles.contentText.copyWith(
                fontWeight: FontWeight.w600, color: AppStyles.primaryColor),
          ),
          SizedBox(
            height: 8,
          ),
          DataKesehatan(),

        ],
      ),
    );
  }
}
