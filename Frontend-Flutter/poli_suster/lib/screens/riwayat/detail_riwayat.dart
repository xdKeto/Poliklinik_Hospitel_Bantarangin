import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:poli_suster/base/backend/class/health_record.dart';
import 'package:poli_suster/base/global_widgets/grey_divider.dart';
import 'package:poli_suster/base/utils/app_styles.dart';
import 'package:poli_suster/screens/riwayat/data_field.dart';

class DetailRiwayat extends StatelessWidget {
  final HealthRecord data;
  const DetailRiwayat({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        width: 800,
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: SelectionArea(
            child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  DateFormat('dd MMMM yyyy', "id_ID")
                      .format(DateTime.parse(data.tanggal))
                      .toString(),
                  style: AppStyles.subheadingText
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(
                      Icons.close,
                      color: Colors.black,
                    ))
              ],
            ),
            SizedBox(
              height: 6,
            ),
            GreyDivider(),
            SizedBox(
              height: 8,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      DataField(
                          title: "Tensi Darah",
                          data: data.tensiDarah,
                          type: "mmHg"),
                      SizedBox(
                        width: 32,
                      ),
                      DataField(
                          title: "Berat Badan",
                          data: data.beratBadan.toString(),
                          type: "kg"),
                    ],
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      DataField(
                          title: "Tinggi Badan",
                          data: data.tinggiBadan.toString(),
                          type: "cm"),
                      SizedBox(
                        width: 54,
                      ),
                      DataField(
                          title: "Suhu Tubuh",
                          data: data.suhuTubuh.toString(),
                          type: "°C"),
                    ],
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      DataField(
                          title: "Gula Darah",
                          data: data.gulaDarah.toString(),
                          type: "mg/dL"),
                      SizedBox(
                        width: 32,
                      ),
                      DataField(
                          title: "Detak / Nadi",
                          data: data.detakNadi.toString(),
                          type: "hbpm"),
                    ],
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      DataField(
                          title: "Resp. Rate",
                          data: data.respRate.toString(),
                          type: "menit"),
                    ],
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: DataField(
                          title: "Catatan Tambahan",
                          data: data.catatan,
                          type: "",
                          isLong: true,
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        )),
      ),
    );
  }
}
