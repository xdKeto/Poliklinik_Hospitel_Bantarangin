import 'package:flutter/material.dart';
import 'package:poli_suster/base/utils/app_styles.dart';
import 'package:poli_suster/screens/rincian/data_field.dart';

class DataKesehatan extends StatelessWidget {
  const DataKesehatan({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      width: double.infinity,
      decoration: AppStyles.whiteBox,
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              DataField(title: "Keluhan Utama", data: "Keluhan Utama"),
              SizedBox(
                height: 16,
              ),
              Row(
                children: [
                  Expanded(
                    child: DataField(
                        title: "Riwayat Penyakit", data: "Riwayat Penyakit"),
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Expanded(child: DataField(title: "Alergi", data: "Alergi")),
                  SizedBox(
                    width: 16,
                  ),
                  Expanded(
                      child: DataField(
                          title: "Jenis Reaksi", data: "Jenis Reaksi")),
                ],
              ),
              SizedBox(
                height: 16,
              ),
              DataField(
                  title: "Keluhan Umum Pasien", data: "Keluhan Umum Pasien"),
            ],
          ),
        ),
      ),
    );
  }
}
