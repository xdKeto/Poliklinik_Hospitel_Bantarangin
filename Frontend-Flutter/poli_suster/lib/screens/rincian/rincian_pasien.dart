import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:poli_suster/base/backend/data_controller.dart';
import 'package:poli_suster/base/global_widgets/confirm_alert.dart';
import 'package:poli_suster/base/global_widgets/loading_alert.dart';
import 'package:poli_suster/base/global_widgets/sucfail_alert.dart';
import 'package:poli_suster/base/global_widgets/the_button.dart';
import 'package:poli_suster/base/utils/app_routes.dart';
import 'package:poli_suster/base/utils/app_styles.dart';
import 'package:poli_suster/base/utils/config.dart';
import 'package:poli_suster/screens/rincian/data_kesehatan.dart';
import 'package:poli_suster/screens/rincian/data_pasien.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RincianPasien extends StatefulWidget {
  final Function onScreeningComplete;
  const RincianPasien({super.key, required this.onScreeningComplete});

  @override
  State<RincianPasien> createState() => _RincianPasienState();
}

class _RincianPasienState extends State<RincianPasien> {
  DataController dataController = DataController();

  void doTunda() async {
    showDialog(
        context: context,
        builder: (context) => const LoadingAlert(),
        barrierDismissible: false);

    try {
      DataController dataController = DataController();
      ResponseRequestAPI response = await dataController.apiConnector(
          Config.apiEndpoints["tundaAntrian"]!(
              dataController.antrianNow?.idAntrian.toString()),
          "put",
          "");

      if (!mounted) return;
      Navigator.pop(context);

      if (response.status == 401) {
        Navigator.pushReplacementNamed(context, AppRoutes.login);
        return;
      }

      if (response.status == 200) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.remove('current_id_antrian');

        dataController.antrianNow = null;
        dataController.detailPasien = null;

        widget.onScreeningComplete();

        if (!mounted) return;
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) {
              return SucfailAlert(
                  isSuccess: true,
                  boldText: "Tunda Berhasil",
                  italicText: "pasien berhasil ditunda");
            });

        await Future.delayed(const Duration(seconds: 2));
        if (!mounted) return;
        Navigator.pop(context);
        Navigator.pop(context);

        setState(() {});
      } else {
        if (!mounted) return;
        await showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => SucfailAlert(
                isSuccess: false,
                boldText: "Gagal mengalihkan",
                italicText: response.message));
      }
    } catch (e) {
      if (!mounted) return;
      Navigator.pop(context);
      await showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => SucfailAlert(
              isSuccess: false,
              boldText: "Input Gagal",
              italicText: e.toString()));
    }
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
                            content: Text(
                                'Tidak ada antrian saat ini, tekan "Antrian Selanjutnya" untuk memulai'),
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
                                  italicText:
                                      "Pasien akan mundur 2 antrian ke belakang",
                                  yesFunc: doTunda,
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
            style: AppStyles.contentText.copyWith(
                fontWeight: FontWeight.w600, color: AppStyles.primaryColor),
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
            style: AppStyles.contentText.copyWith(
                fontWeight: FontWeight.w600, color: AppStyles.primaryColor),
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
