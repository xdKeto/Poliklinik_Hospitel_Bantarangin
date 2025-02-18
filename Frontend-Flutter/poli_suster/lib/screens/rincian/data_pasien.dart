import 'package:flutter/material.dart';
import 'package:poli_suster/base/global_widgets/btrb_text.dart';
import 'package:poli_suster/base/utils/app_styles.dart';

class DataPasien extends StatelessWidget {
  const DataPasien({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
            padding: EdgeInsets.all(16),
            decoration: AppStyles.whiteBox,
            child: Column(
              children: [
                Row(
                  children: [
                    btrbText(topText: 'Nama Pasien', botText: 'John Doe'),
                    SizedBox(
                      width: 32,
                    ),
                    btrbText(
                        topText: 'Nomor Rekam Medis', botText: 'RM2024001'),
                    SizedBox(
                      width: 32,
                    ),
                    btrbText(topText: 'Jenis Kelamin', botText: 'Laki-laki'),
                    SizedBox(
                      width: 32,
                    ),
                    btrbText(topText: 'Tempat Lahir', botText: 'Surabaya'),
                    SizedBox(
                      width: 32,
                    ),
                    btrbText(topText: 'Tanggal Lahir', botText: '2/18/2025'),
                    SizedBox(
                      width: 32,
                    ),
                    btrbText(
                        topText: 'Nomor KTP/NIK', botText: '3201021405980001'),
                    SizedBox(
                      width: 32,
                    ),
                    btrbText(topText: 'Nomor HP', botText: '081243567891'),
                    SizedBox(
                      width: 32,
                    ),
                  ],
                ),
                SizedBox(
                  height: 16,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 400,
                      child: btrbText(
                          topText: 'Alamat Rumah',
                          botText:
                              'Jl. Contoh Raya No. 99, Sukamaju, Damai Sejahtera, Kota Bahagia, 12345, Indonesia'),
                    ),
                    SizedBox(
                      width: 32,
                    ),
                    btrbText(
                        topText: 'Nomor Rekam Medis', botText: 'RM2024001'),
                    SizedBox(
                      width: 32,
                    ),
                    btrbText(topText: 'Jenis Kelamin', botText: 'Laki-laki'),
                    SizedBox(
                      width: 32,
                    ),
                  ],
                ),
              ],
            ),
          );
  }
}