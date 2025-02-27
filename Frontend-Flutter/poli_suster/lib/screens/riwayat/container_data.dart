import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:poli_suster/base/class/event.dart';
import 'package:poli_suster/base/global_widgets/bold_n_reg_text.dart';
import 'package:poli_suster/base/utils/app_styles.dart';

class ContainerData extends StatelessWidget {
  final HealthRecord data;
  const ContainerData({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: AppStyles.whiteBox,
      padding: EdgeInsets.all(8),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                DateFormat('dd MMMM yyyy', "id_ID")
                    .format(DateTime.parse(data.tanggal))
                    .toString(),
                style: AppStyles.subheadingText.copyWith(
                    color: AppStyles.primaryColor, fontWeight: FontWeight.bold),
              ),
              Icon(
                FluentIcons.arrow_expand_16_regular,
                color: AppStyles.primaryColor,
              )
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
          ),
          // BoldNRegText(
          //     label: "Tensi Darah", data: data.tensiDarah, type: "mmHg"),
          // SizedBox(
          //   height: 8,
          // ),
          // BoldNRegText(
          //     label: "Tinggi Badan",
          //     data: data.tinggiBadan.toString(),
          //     type: "cm"),
          // SizedBox(
          //   height: 8,
          // ),
          // BoldNRegText(
          //     label: "Gula Darah",
          //     data: data.gulaDarah.toString(),
          //     type: "mg/dL"),
          // SizedBox(
          //   height: 8,
          // ),
          // BoldNRegText(
          //     label: "Berat Badan",
          //     data: data.beratBadan.toString(),
          //     type: "kg"),
          // SizedBox(
          //   height: 8,
          // ),
          // BoldNRegText(
          //     label: "Suhu Tubuh", data: data.suhuTubuh.toString(), type: "°C"),
          // SizedBox(
          //   height: 8,
          // ),
          // BoldNRegText(
          //     label: "Detak/Nadi",
          //     data: data.detakNadi.toString(),
          //     type: "bpm"),
          // SizedBox(
          //   height: 8,
          // ),
          // BoldNRegText(
          //     label: "Resp. Rate",
          //     data: data.respRate.toString(),
          //     type: "/menit"),
          // SizedBox(
          //   height: 8,
          // ),
        ],
      ),
    );
  }
}
