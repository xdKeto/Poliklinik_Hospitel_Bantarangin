import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:poli_suster/base/backend/data_controller.dart';
import 'package:poli_suster/base/global_widgets/confirm_alert.dart';
import 'package:poli_suster/base/global_widgets/the_button.dart';
import 'package:poli_suster/base/utils/app_styles.dart';
import 'package:poli_suster/screens/rincian/data_kesehatan.dart';
import 'package:poli_suster/screens/rincian/data_pasien.dart';

class RincianPasien extends StatefulWidget {
  const RincianPasien({super.key});

  @override
  State<RincianPasien> createState() => _RincianPasienState();
}

class _RincianPasienState extends State<RincianPasien> {
  DataController dataController = DataController();

  void doTunda() async {
    
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                onTap: dataController.antrianNow == null
                    ? () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Tidak ada antrian saat ini, tekan "Antrian Selanjutnya" untuk memulai'),
                            backgroundColor: AppStyles.redColor,
                          ),
                        );
                      }
                    : () {
                        showDialog(
                            context: context,
                            builder: (context) => ConfirmAlert(
                                  icon: FluentIcons.error_circle_12_regular,
                                  boldText: "Tunda Antrian Pasien?",
                                  yesText: "tunda",
                                  color: AppStyles.redColor,
                                  italicText: "Pasien akan mundur 2 antrian ke belakang",
                                  yesFunc: () {

                                  },
                                ));
                      },
                child: TheButton(
                  icon: FluentIcons.previous_16_regular,
                  iconColor: AppStyles.primaryColor,
                  isIcon: true,
                  text: "Tunda Antrian",
                  color: AppStyles.primaryColor,
                  textColor: AppStyles.primaryColor,
                  border: true,
                  vertPadding: 4,
                  horiPadding: 12,
                  opacity: dataController.antrianNow == null ? 0.5 : 1.0,
                ),
              ),
            ],
          ),
          Text(
            'Data Pasien',
            style: AppStyles.contentText.copyWith(fontWeight: FontWeight.w600, color: AppStyles.primaryColor),
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
            style: AppStyles.contentText.copyWith(fontWeight: FontWeight.w600, color: AppStyles.primaryColor),
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
