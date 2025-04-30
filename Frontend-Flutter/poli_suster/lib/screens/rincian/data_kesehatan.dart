import 'package:flutter/material.dart';
import 'package:poli_suster/base/backend/data_controller.dart';
import 'package:poli_suster/base/utils/app_styles.dart';
import 'package:poli_suster/screens/rincian/data_field.dart';

class DataKesehatan extends StatelessWidget {
  const DataKesehatan({super.key});

  @override
  Widget build(BuildContext context) {
    final pasien = DataController().detailPasien;
    // print(pasien?.keluhanUtama);
    // print(pasien?.riwayatPenyakit);
    // print(pasien?.keadaanUmumPasien);
    // print(pasien?.jenisReaksi);
    // print(pasien?.alergi);

    if (pasien == null) {
      return Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 16),
        decoration: AppStyles.whiteBox,
        child: Center(
          child: Text("Tidak ada data pasien"),
        ),
      );
    }

    return Container(
      // height: 300,
      width: double.infinity,
      decoration: AppStyles.whiteBox,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            DataField(title: "Keluhan Utama", data: pasien.keluhanUtama),
            SizedBox(
              height: 16,
            ),
            Row(
              children: [
                Expanded(
                  child: DataField(
                      title: "Riwayat Penyakit", data: pasien.riwayatPenyakit),
                ),
                SizedBox(
                  width: 16,
                ),
                Expanded(child: DataField(title: "Alergi", data: pasien.alergi)),
                SizedBox(
                  width: 16,
                ),
                Expanded(
                    child:
                        DataField(title: "Jenis Reaksi", data: pasien.jenisReaksi)),
              ],
            ),
            SizedBox(
              height: 16,
            ),
            DataField(
                title: "Keluhan Umum Pasien", data: pasien.keadaanUmumPasien),
          ],
        ),
      ),
    );
  }
}
