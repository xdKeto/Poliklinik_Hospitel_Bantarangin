import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:poli_suster/base/backend/data_controller.dart';
import 'package:poli_suster/base/global_widgets/confirm_alert.dart';
import 'package:poli_suster/base/global_widgets/home_tabs.dart';
import 'package:poli_suster/base/utils/app_routes.dart';
import 'package:poli_suster/base/utils/app_styles.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DataController dataController = DataController();
  String? antrianStr;

  @override
  void initState() {
    super.initState();
    refreshAntrian();
  }

  Future<void> refreshAntrian() async {
    try {
      final idPoli = await dataController.getLoggedInPoli();
      await dataController.fetchAntrian(idPoli);
      if (mounted) {
        setState(() {
          if (dataController.antrianNow.nomorAntrian == 0) {
            antrianStr = "000";
          } else if (dataController.antrianNow.nomorAntrian <= 9) {
            antrianStr = "00${dataController.antrianNow.nomorAntrian}";
          } else if (dataController.antrianNow.nomorAntrian <= 99) {
            antrianStr = "0${dataController.antrianNow.nomorAntrian}";
          } else {
            antrianStr = "${dataController.antrianNow.nomorAntrian}";
          }
        });
      }
    } catch (e) {
      print('Error refreshing antrian: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyles.backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: RefreshIndicator(
            onRefresh: refreshAntrian,
            color: AppStyles.primaryColor,
            backgroundColor: Colors.white,
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
                                color: AppStyles.primaryColor,
                                fontWeight: FontWeight.w600),
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
                                        icon:
                                            FluentIcons.error_circle_12_regular,
                                        boldText:
                                            "Apakah anda yakin\ningin keluar?",
                                        yesText: 'keluar',
                                        color: AppStyles.redColor,
                                        yesFunc: () async {
                                          await DataController().userLogout();

                                          if (!context.mounted) return;
                                          Navigator.pushReplacementNamed(
                                              context, AppRoutes.login);
                                        },
                                      ));
                            },
                            child: Container(
                              decoration: AppStyles.buttonBox2(
                                  AppStyles.primaryColor, 12),
                              padding: EdgeInsets.all(8),
                              child: Center(
                                  child: Icon(
                                Icons.logout,
                                color: AppStyles.primaryColor,
                              )),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: AppStyles.whiteBox
                          .copyWith(color: AppStyles.primaryColor),
                      height: 90,
                      child: Row(
                        children: [
                          Text(
                            'Nomor antrian saat ini',
                            style: AppStyles.subheadingText.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w600),
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
                            decoration:
                                AppStyles.buttonBox(AppStyles.accentColor, 8),
                            padding: EdgeInsets.all(8),
                            child: Center(
                              child: Text(
                                antrianStr!,
                                style: AppStyles.headingText.copyWith(
                                    fontSize: 40,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
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
                Expanded(
                    child: HomeTabs(
                  refreshAntrian: refreshAntrian,
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
