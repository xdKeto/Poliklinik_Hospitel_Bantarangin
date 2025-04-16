import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:poli_suster/base/backend/data_controller.dart';
import 'package:poli_suster/base/global_widgets/confirm_alert.dart';
import 'package:poli_suster/base/global_widgets/home_tabs.dart';
import 'package:poli_suster/base/global_widgets/the_button.dart';
import 'package:poli_suster/base/utils/app_routes.dart';
import 'package:poli_suster/base/utils/app_styles.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DataController dataController = DataController();
  String antrianStr = "000";

  @override
  void initState() {
    super.initState();
    displayData();
  }

  void updateQueueDisplay() {
    setState(() {
      antrianStr = "000";
    });
  }

  Future<void> displayData() async {
    try {
      if (mounted) {
        setState(() {
          if (dataController.antrianNow?.nomorAntrian == 0 ||
              dataController.antrianNow?.nomorAntrian == null) {
            antrianStr = "000";
          } else if (dataController.antrianNow?.nomorAntrian != null &&
              dataController.antrianNow!.nomorAntrian <= 9) {
            antrianStr = "00${dataController.antrianNow?.nomorAntrian}";
          } else if (dataController.antrianNow?.nomorAntrian != null &&
              dataController.antrianNow!.nomorAntrian <= 99) {
            antrianStr = "0${dataController.antrianNow?.nomorAntrian}";
          } else {
            antrianStr = "${dataController.antrianNow?.nomorAntrian}";
          }
        });
      }
    } catch (e) {
      print('Error displaying data antrian: $e');
    }
  }

  Future<void> doGetAntrian() async {
    try {
      final idPoli = await dataController.getLoggedInPoli();
      final tokenValid = await dataController.isTokenValid();
      final result = await dataController.nextPatient(idPoli);

      if (!tokenValid && mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Sesi habis, silakan login kembali')));
        Navigator.pushReplacementNamed(context, AppRoutes.login);
        return;
      }

      if (result == null && mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Tidak ada antrian lagi')));
        return;
      }

      if (mounted) {
        setState(() {
          if (dataController.antrianNow?.nomorAntrian == 0 ||
              dataController.antrianNow?.nomorAntrian == null) {
            antrianStr = "000";
          } else if (dataController.antrianNow?.nomorAntrian != null &&
              dataController.antrianNow!.nomorAntrian <= 9) {
            antrianStr = "00${dataController.antrianNow?.nomorAntrian}";
          } else if (dataController.antrianNow?.nomorAntrian != null &&
              dataController.antrianNow!.nomorAntrian <= 99) {
            antrianStr = "0${dataController.antrianNow?.nomorAntrian}";
          } else {
            antrianStr = "${dataController.antrianNow?.nomorAntrian}";
          }
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal memuat antrian berikutnya: $e')),
        );
      }
    }
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: AppStyles.backgroundColor,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              children: [
                SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      height: 50,
                      child: Row(
                        children: [
                          Text(
                            'Welcome, ${dataController.nama}',
                            style: AppStyles.headingText.copyWith(
                                color: AppStyles.primaryColor, fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          VerticalDivider(
                            color: AppStyles.primaryColor,
                            thickness: 2,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          InkWell(
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (context) => ConfirmAlert(
                                        icon: FluentIcons.error_circle_12_regular,
                                        boldText: "Apakah anda yakin\ningin keluar?",
                                        yesText: 'keluar',
                                        color: AppStyles.redColor,
                                        yesFunc: () async {
                                          await DataController().userLogout();

                                          if (!context.mounted) return;
                                          Navigator.pushReplacementNamed(context, AppRoutes.login);
                                        },
                                      ));
                            },
                            child: Container(
                              decoration: AppStyles.buttonBox2(AppStyles.primaryColor, 12),
                              padding: EdgeInsets.all(8),
                              child: Center(
                                  child: Icon(
                                Icons.logout,
                                color: AppStyles.primaryColor,
                              )),
                            ),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          InkWell(
                            onTap: dataController.antrianNow != null
                                ? () {
                                    // Show message that there's an active screening
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                            'Selesaikan atau tunda screening pasien saat ini terlebih dahulu'),
                                        backgroundColor: AppStyles.redColor,
                                      ),
                                    );
                                  }
                                : () {
                                    showDialog(
                                        context: context,
                                        builder: (context) => ConfirmAlert(
                                              icon: FluentIcons.error_circle_12_regular,
                                              boldText: "Antrian selanjutnya?",
                                              yesText: "selanjutnya",
                                              italicText:
                                                  "Memanggil antrian paling atas di status Tunggu",
                                              yesFunc: () => doGetAntrian(),
                                            ));
                                  },
                            child: TheButton(
                              text: "Antrian Selanjutnya",
                              color: AppStyles.primaryColor,
                              textColor: AppStyles.primaryColor,
                              border: true,
                              vertPadding: 4,
                              horiPadding: 12,
                              opacity: dataController.antrianNow != null ? 0.5 : 1.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: AppStyles.whiteBox.copyWith(color: AppStyles.primaryColor),
                      height: 90,
                      child: Row(
                        children: [
                          Text(
                            'Nomor antrian saat ini',
                            style: AppStyles.subheadingText
                                .copyWith(color: Colors.white, fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          VerticalDivider(
                            color: Colors.white,
                            thickness: 2,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Container(
                            decoration: AppStyles.buttonBox(AppStyles.accentColor, 8),
                            padding: EdgeInsets.all(8),
                            child: Center(
                              child: Text(
                                antrianStr,
                                style: AppStyles.headingText.copyWith(
                                    fontSize: 40, color: Colors.black, fontWeight: FontWeight.bold),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 24,
                ),
                Expanded(child: HomeTabs(onScreeningComplete: updateQueueDisplay)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
