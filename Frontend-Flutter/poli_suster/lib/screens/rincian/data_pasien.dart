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
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  btrbText(topText: 'Nama Pasien', botText: pasien.namaPasien),
                  SizedBox(
                    width: 32,
                  ),
                  btrbText(topText: 'Nomor Rekam Medis', botText: pasien.idRm),
                  SizedBox(
                    width: 32,
                  ),
                  btrbText(
                      topText: 'Jenis Kelamin', botText: pasien.jenisKelamin),
                  SizedBox(
                    width: 32,
                  ),
                  btrbText(
                      topText: 'Tempat Lahir', botText: pasien.tempatLahir),
                  SizedBox(
                    width: 32,
                  ),
                  btrbText(
                      topText: 'Tanggal Lahir', botText: pasien.tanggalLahir),
                  SizedBox(
                    width: 32,
                  ),
                  btrbText(topText: 'Nomor KTP/NIK', botText: pasien.nik),
                  SizedBox(
                    width: 32,
                  ),
                  btrbText(topText: 'Nomor HP', botText: pasien.noTelp),
                  SizedBox(
                    width: 32,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 16,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  SizedBox(
                    width: 400,
                    child: btrbText(
                        topText: 'Alamat Rumah', botText: pasien.alamat),
                  ),
                  SizedBox(
                    width: 32,
                  ),
                  btrbText(topText: 'Kota', botText: pasien.kota),
                  SizedBox(
                    width: 32,
                  ),
                  btrbText(topText: 'Kelurahan', botText: pasien.kelurahan),
                  SizedBox(
                    width: 32,
                  ),
                  btrbText(topText: 'Kecamatan', botText: pasien.kecamatan),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
