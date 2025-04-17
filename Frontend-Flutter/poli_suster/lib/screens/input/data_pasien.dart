import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:poli_suster/base/backend/data_controller.dart';
import 'package:poli_suster/base/utils/app_styles.dart';

class DataPasien extends StatefulWidget {
  const DataPasien({super.key});

  @override
  State<DataPasien> createState() => _DataPasienState();
}

class _DataPasienState extends State<DataPasien> {
  DataController dataController = DataController();
  String formattedDate = DateFormat('dd MMMM yyyy', 'id_ID').format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              dataController.antrianNow?.namaPasien ?? "",
              style: AppStyles.subheadingText
                  .copyWith(fontWeight: FontWeight.bold, color: AppStyles.primaryColor),
            ),
            Text(
              formattedDate,
              style: AppStyles.subheadingText
                  .copyWith(fontWeight: FontWeight.bold, color: AppStyles.primaryColor),
            ),
          ],
        ),
        SizedBox(
          height: 8,
        ),
        Text(
          'No. rekam medis: ${dataController.antrianNow?.idRm}',
          style: AppStyles.contentText,
        ),
        Text(
          'Jenis kelamin: ${dataController.antrianNow?.jenisKelamin}',
          style: AppStyles.contentText,
        ),
        Text(
          'Umur: ${dataController.antrianNow?.umur} tahun',
          style: AppStyles.contentText,
        ),
      ],
    );
  }
}
