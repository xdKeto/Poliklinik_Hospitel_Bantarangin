import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:poli_suster/base/backend/data_controller.dart';
import 'package:poli_suster/base/global_widgets/confirm_alert.dart';
import 'package:poli_suster/base/global_widgets/label_required.dart';
import 'package:poli_suster/base/global_widgets/loading_alert.dart';
import 'package:poli_suster/base/global_widgets/sucfail_alert.dart';
import 'package:poli_suster/base/global_widgets/the_button.dart';
import 'package:poli_suster/base/utils/app_routes.dart';
import 'package:poli_suster/base/utils/app_styles.dart';
import 'package:poli_suster/base/utils/config.dart';
import 'package:poli_suster/screens/input/data_pasien.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InputScreening extends StatefulWidget {
  final Function onScreeningComplete;

  const InputScreening({super.key, required this.onScreeningComplete});

  @override
  State<InputScreening> createState() => _InputScreeningState();
}

class _InputScreeningState extends State<InputScreening> {
  int systolic = 0;
  int diatolic = 0;
  int beratBadan = 0;
  int tinggiBadan = 0;
  int suhuTubuh = 0;
  int detakNadi = 0;
  int respRate = 0;
  String catatan = "";

  var systolicController = TextEditingController();
  var diatolicController = TextEditingController();
  var beratBadanController = TextEditingController();
  var tinggiBadanController = TextEditingController();
  var suhuTubuhController = TextEditingController();
  var detakNadiController = TextEditingController();
  var respRateController = TextEditingController();
  var catatanController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  DataController dataController = DataController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    systolicController.dispose();
    diatolicController.dispose();
    beratBadanController.dispose();
    tinggiBadanController.dispose();
    suhuTubuhController.dispose();
    detakNadiController.dispose();
    respRateController.dispose();
    catatanController.dispose();

    super.dispose();
  }

  void doScreening() async {
    if (validateRequiredFields()) {
      try {
        systolic = int.parse(systolicController.text);
        diatolic = int.parse(diatolicController.text);
        beratBadan = int.parse(beratBadanController.text);
        tinggiBadan = int.parse(tinggiBadanController.text);
        suhuTubuh = int.parse(suhuTubuhController.text);
        detakNadi = int.parse(detakNadiController.text);
        respRate = int.parse(respRateController.text);
        catatan = catatanController.text; // Catatan can be empty

        showDialog(
            context: context,
            builder: (context) => const LoadingAlert(),
            barrierDismissible: false);
        DataController dataController = DataController();
        ResponseRequestAPI response = await dataController.apiConnector(
            Config.apiEndpoints["inputScreening"]!(
                dataController.antrianNow?.idAntrian.toString()),
            "post",
            {
              "systolic": systolic,
              "diatolic": diatolic,
              "berat_badan": beratBadan,
              "suhu_tubuh": suhuTubuh,
              "tinggi_badan": tinggiBadan,
              "detak_nadi": detakNadi,
              "laju_respirasi": respRate,
              "keterangan": catatan
            });

        if (!mounted) return;
        Navigator.pop(context);

        if (response.status == 401) {
          Navigator.pushReplacementNamed(context, AppRoutes.login);
          return;
        }

        if (response.status == 200) {
          clearForms();

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
                    boldText: "Input Berhasil",
                    italicText: "data screening pasien berhasil");
              });

          await Future.delayed(const Duration(seconds: 2));
          if (!mounted) return;
          Navigator.pop(context);
        } else {
          if (!mounted) return;
          Navigator.pop(context);
          await showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => SucfailAlert(
                  isSuccess: false,
                  boldText: "Input Gagal",
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
  }

  void doAlihkan() async {
    showDialog(
        context: context,
        builder: (context) => const LoadingAlert(),
        barrierDismissible: false);

    try {
      DataController dataController = DataController();
      ResponseRequestAPI response = await dataController.apiConnector(
          Config.apiEndpoints["alihkanScreening"]!(
              dataController.antrianNow?.idAntrian.toString()),
          "put",
          "");

      if (!mounted) return;
      Navigator.pop(context);

      if (response.status == 200) {
        clearForms();

        final prefs = await SharedPreferences.getInstance();
        await prefs.remove('current_id_antrian');

        dataController.antrianNow = null;
        dataController.detailPasien = null;

        widget.onScreeningComplete();

        if (!mounted) return;
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => SucfailAlert(
                isSuccess: true,
                boldText: "Berhasil dialihkan",
                italicText: "berhasil mengalihkan pasien"));

        await Future.delayed(const Duration(seconds: 2));
        if (!mounted) return;
        Navigator.pop(context);
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
          builder: (context) => SucfailAlert(
              isSuccess: false,
              boldText: "Gagal mengalihkan",
              italicText: e.toString()));
    }
  }

  void clearForms({bool skipPop = false}) {
    setState(() {
      systolicController.clear();
      diatolicController.clear();
      beratBadanController.clear();
      tinggiBadanController.clear();
      suhuTubuhController.clear();
      detakNadiController.clear();
      respRateController.clear();
      catatanController.clear();
    });

    Navigator.pop(context);
  }

  bool validateRequiredFields() {
    bool isValid = true;
    String errorMessage = "";

    if (systolicController.text.isEmpty) {
      errorMessage = "Tensi Darah (Systolic) wajib diisi";
      isValid = false;
    } else if (diatolicController.text.isEmpty) {
      errorMessage = "Tensi Darah (Diatolic) wajib diisi";
      isValid = false;
    } else if (beratBadanController.text.isEmpty) {
      errorMessage = "Berat Badan wajib diisi";
      isValid = false;
    } else if (tinggiBadanController.text.isEmpty) {
      errorMessage = "Tinggi Badan wajib diisi";
      isValid = false;
    } else if (suhuTubuhController.text.isEmpty) {
      errorMessage = "Suhu Tubuh wajib diisi";
      isValid = false;
    } else if (detakNadiController.text.isEmpty) {
      errorMessage = "Detak Nadi wajib diisi";
      isValid = false;
    } else if (respRateController.text.isEmpty) {
      errorMessage = "Resp. Rate wajib diisi";
      isValid = false;
    }

    if (!isValid) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
          backgroundColor: AppStyles.redColor,
        ),
      );
    }

    return isValid;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DataPasien(),
          SizedBox(
            height: 16,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Form(
              key: _formKey,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      LabelRequired(
                          text: "Tensi Darah",
                          style: AppStyles.contentText.copyWith(
                              color: AppStyles.primaryColor,
                              fontWeight: FontWeight.bold)),
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 72,
                            height: 40,
                            child: TextFormField(
                              controller: systolicController,
                              keyboardType: TextInputType.numberWithOptions(
                                  decimal: true),
                              cursorColor: Colors.black,
                              decoration: AppStyles.formBox.copyWith(),
                              onChanged: (value) {
                                systolic = int.parse(value);
                              },
                            ),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            '/',
                            style: AppStyles.contentText.copyWith(
                                color: AppStyles.primaryColor,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          SizedBox(
                            width: 72,
                            height: 40,
                            child: TextFormField(
                              controller: diatolicController,
                              keyboardType: TextInputType.numberWithOptions(
                                  decimal: true),
                              cursorColor: Colors.black,
                              decoration: AppStyles.formBox.copyWith(),
                              onChanged: (value) {
                                diatolic = int.parse(value);
                              },
                            ),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            'mmHG',
                            style: AppStyles.contentText.copyWith(
                                color: AppStyles.primaryColor,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    width: 32,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      LabelRequired(
                          text: "Berat Badan",
                          style: AppStyles.contentText.copyWith(
                              color: AppStyles.primaryColor,
                              fontWeight: FontWeight.bold)),
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 170,
                            height: 40,
                            child: TextFormField(
                              controller: beratBadanController,
                              keyboardType: TextInputType.numberWithOptions(
                                  decimal: true),
                              cursorColor: Colors.black,
                              decoration: AppStyles.formBox.copyWith(),
                              onChanged: (value) {
                                beratBadan = int.parse(value);
                              },
                            ),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            'kg',
                            style: AppStyles.contentText.copyWith(
                                color: AppStyles.primaryColor,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    width: 32,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      LabelRequired(
                          text: "Tinggi Badan",
                          style: AppStyles.contentText.copyWith(
                              color: AppStyles.primaryColor,
                              fontWeight: FontWeight.bold)),
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 170,
                            height: 40,
                            child: TextFormField(
                              controller: tinggiBadanController,
                              keyboardType: TextInputType.numberWithOptions(
                                  decimal: true),
                              cursorColor: Colors.black,
                              decoration: AppStyles.formBox.copyWith(),
                              onChanged: (value) {
                                tinggiBadan = int.parse(value);
                              },
                            ),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            'cm',
                            style: AppStyles.contentText.copyWith(
                                color: AppStyles.primaryColor,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    width: 32,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      LabelRequired(
                          text: "Suhu Tubuh",
                          style: AppStyles.contentText.copyWith(
                              color: AppStyles.primaryColor,
                              fontWeight: FontWeight.bold)),
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 170,
                            height: 40,
                            child: TextFormField(
                              controller: suhuTubuhController,
                              keyboardType: TextInputType.numberWithOptions(
                                  decimal: true),
                              cursorColor: Colors.black,
                              decoration: AppStyles.formBox.copyWith(),
                              onChanged: (value) {
                                suhuTubuh = int.parse(value);
                              },
                            ),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            '°C',
                            style: AppStyles.contentText.copyWith(
                                color: AppStyles.primaryColor,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      )
                    ],
                  ),
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    LabelRequired(
                        text: "Detak / Nadi",
                        style: AppStyles.contentText.copyWith(
                            color: AppStyles.primaryColor,
                            fontWeight: FontWeight.bold)),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 170,
                          height: 40,
                          child: TextFormField(
                            controller: detakNadiController,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            cursorColor: Colors.black,
                            decoration: AppStyles.formBox.copyWith(),
                            onChanged: (value) {
                              detakNadi = int.parse(value);
                            },
                          ),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          'hbpm',
                          style: AppStyles.contentText.copyWith(
                              color: AppStyles.primaryColor,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    )
                  ],
                ),
                SizedBox(
                  width: 32,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    LabelRequired(
                        text: "Resp. Rate",
                        style: AppStyles.contentText.copyWith(
                            color: AppStyles.primaryColor,
                            fontWeight: FontWeight.bold)),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 170,
                          height: 40,
                          child: TextFormField(
                            controller: respRateController,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            cursorColor: Colors.black,
                            decoration: AppStyles.formBox.copyWith(),
                            onChanged: (value) {
                              respRate = int.parse(value);
                            },
                          ),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          'menit',
                          style: AppStyles.contentText.copyWith(
                              color: AppStyles.primaryColor,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 16,
          ),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Catatan Tambahan',
                      style: AppStyles.contentText.copyWith(
                          color: AppStyles.primaryColor,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                      controller: catatanController,
                      maxLines: 4,
                      cursorColor: Colors.black,
                      decoration: AppStyles.formBox.copyWith(),
                      onChanged: (value) {
                        catatan = value;
                      },
                    )
                  ],
                ),
              ),
              SizedBox(
                width: 32,
              )
            ],
          ),
          SizedBox(
            height: 16,
          ),
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
                                  boldText:
                                      'Apakah anda ingin menyimpan\ndata poliklinik baru?',
                                  yesText: 'simpan',
                                  yesFunc: () {
                                    doAlihkan();
                                  },
                                ));
                      },
                child: TheButton(
                  text: "Alihkan Screening",
                  color: AppStyles.primaryColor,
                  textColor: AppStyles.primaryColor,
                  border: true,
                  vertPadding: 6,
                  opacity: dataController.antrianNow == null ? 0.5 : 1.0,
                ),
              ),
              SizedBox(
                width: 16,
              ),
              InkWell(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) => ConfirmAlert(
                            icon: FluentIcons.error_circle_12_regular,
                            boldText: 'Apakah anda ingin reset semua field?',
                            yesText: 'reset',
                            yesFunc: clearForms,
                          ));
                },
                child: TheButton(
                  text: 'Reset',
                  color: AppStyles.greyBtnColor,
                  iconColor: AppStyles.greyBtnColor,
                  textColor: AppStyles.greyBtnColor,
                  hoverable: true,
                  isIcon: true,
                  icon: Icons.restart_alt,
                  hoverIcon: Icons.restart_alt,
                  border: true,
                  vertPadding: 4,
                  horiPadding: 12,
                ),
              ),
              SizedBox(
                width: 16,
              ),
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
                                  boldText:
                                      'Apakah anda ingin menyimpan\ndata poliklinik baru?',
                                  yesText: 'simpan',
                                  yesFunc: () {
                                    doScreening();
                                  },
                                ));
                      },
                child: TheButton(
                  text: 'Simpan',
                  color: AppStyles.accentColor,
                  iconColor: AppStyles.accentColor,
                  textColor: AppStyles.accentColor,
                  hoverable: true,
                  isIcon: true,
                  icon: Icons.save,
                  hoverIcon: Icons.save,
                  border: true,
                  vertPadding: 4,
                  horiPadding: 12,
                  opacity: dataController.antrianNow == null ? 0.5 : 1.0,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
