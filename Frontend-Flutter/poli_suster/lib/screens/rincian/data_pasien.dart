import 'package:flutter/material.dart';
import 'package:poli_suster/base/backend/data_controller.dart';
import 'package:poli_suster/base/global_widgets/btrb_text.dart';
import 'package:poli_suster/base/utils/app_styles.dart';

class DataPasien extends StatelessWidget {
  const DataPasien({super.key});

  @override
  Widget build(BuildContext context) {
    final pasien = DataController().antrianNow;

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
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 16),
      decoration: AppStyles.whiteBox,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Wrap(
              spacing: 32,
              runSpacing: 16,
              children: [
                btrbText(topText: 'Nama Pasien', botText: pasien.namaPasien),
                btrbText(topText: 'Nomor Rekam Medis', botText: pasien.idRm),
                btrbText(
                    topText: 'Jenis Kelamin', botText: pasien.jenisKelamin),
                btrbText(topText: 'Tempat Lahir', botText: pasien.tempatLahir),
                btrbText(
                    topText: 'Tanggal Lahir', botText: pasien.tanggalLahir),
                btrbText(topText: 'Nomor KTP/NIK', botText: pasien.nik),
                btrbText(topText: 'Nomor HP', botText: pasien.noTelp),
                btrbText(topText: 'Alamat Rumah', botText: pasien.alamat),
                btrbText(topText: 'Kota', botText: pasien.kota),
                btrbText(topText: 'Kelurahan', botText: pasien.kelurahan),
                btrbText(topText: 'Kecamatan', botText: pasien.kecamatan),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
