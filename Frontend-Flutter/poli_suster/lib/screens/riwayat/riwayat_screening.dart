import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:poli_suster/base/backend/class/riwayat_pasien.dart';
import 'package:poli_suster/base/backend/data_controller.dart';
import 'package:poli_suster/base/utils/app_styles.dart';
import 'package:poli_suster/screens/riwayat/container_data.dart';
import 'package:poli_suster/screens/riwayat/detail_riwayat.dart';

class RiwayatScreening extends StatefulWidget {
  const RiwayatScreening({super.key});

  @override
  State<RiwayatScreening> createState() => _RiwayatScreeningState();
}

class _RiwayatScreeningState extends State<RiwayatScreening> {
  List<RiwayatPasien> riwayatPasien = [];

  DataController dataController = DataController();

  @override
  void initState() {
    super.initState();

    for (var i = 0; i < dataController.riwayatPasien.length; i++) {
      riwayatPasien.add(dataController.riwayatPasien[i]);
    }

    riwayatPasien = riwayatPasien.reversed.toList();

    // print(riwayatPasien);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          riwayatPasien.isEmpty
              ? Center(
                  child: Column(
                    children: [
                      Icon(FluentIcons.document_dismiss_16_regular,
                          color: AppStyles.greyColor, size: 86),
                      Text(
                        'Pasien tidak memiliki\nriwayat screening',
                        style: AppStyles.titleText.copyWith(
                          color: AppStyles.greyColor,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        // flex: 25,
                        child: Container(
                      // padding: EdgeInsets.all(24),
                      margin: EdgeInsets.only(right: 4),
                      child: GridView.builder(
                          shrinkWrap: true,
                          physics: ScrollPhysics(),
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 16,
                              mainAxisSpacing: 16,
                              childAspectRatio: 8 / 6),
                          itemCount: riwayatPasien.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                                onTap: () {
                                  showDialog(
                                      barrierDismissible: true,
                                      context: context,
                                      builder: (context) =>
                                          DetailRiwayat(data: riwayatPasien[index]));
                                },
                                child: ContainerData(data: riwayatPasien[index]));
                          }),
                    )),
                  ],
                )
        ],
      ),
    );
  }
}
