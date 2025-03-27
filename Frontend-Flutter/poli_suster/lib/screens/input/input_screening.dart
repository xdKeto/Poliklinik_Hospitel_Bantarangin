import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:poli_suster/base/backend/data_controller.dart';
import 'package:poli_suster/base/global_widgets/confirm_alert.dart';
import 'package:poli_suster/base/global_widgets/loading_alert.dart';
import 'package:poli_suster/base/global_widgets/sucfail_alert.dart';
import 'package:poli_suster/base/global_widgets/the_button.dart';
import 'package:poli_suster/base/utils/app_styles.dart';
import 'package:poli_suster/base/utils/config.dart';
import 'package:poli_suster/screens/input/data_pasien.dart';

class InputScreening extends StatefulWidget {
  final Future<void> Function() refreshAntrian;
  final VoidCallback? onScreeningComplete;

  const InputScreening(
      {super.key, required this.refreshAntrian, this.onScreeningComplete});

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
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final context2 = context;

      Navigator.pop(context);
      showDialog(
          context: context,
          builder: (context) => LoadingAlert(),
          barrierDismissible: false);

      DataController dataController = DataController();
      ResponseRequestAPI response = await dataController.apiConnector(
          Config.apiEndpoints["inputScreening"]!(
              dataController.antrianNow.idAntrian.toString()),
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
      if (!context.mounted) return;
      Navigator.pop(context2);

      if (response.status == 200) {
        if (!context.mounted) return;

        await showDialog(
            context: context2,
            builder: (context) {
              return SucfailAlert(
                  isSuccess: true,
                  boldText: "Input Berhasil",
                  italicText: "data screening pasien berhasil");
            });
        clearForms();
        await widget.refreshAntrian();
        widget.onScreeningComplete?.call();
      } else {
        if (!context.mounted) return;
        await showDialog(
            context: context2,
            builder: (context) => SucfailAlert(
                isSuccess: false,
                boldText: "Input Gagal",
                italicText: response.message));
      }
    }
  }

  void clearForms() {
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
                      Text(
                        'Tensi Darah',
                        style: AppStyles.contentText.copyWith(
                            color: AppStyles.primaryColor,
                            fontWeight: FontWeight.bold),
                      ),
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
                      Text(
                        'Berat Badan',
                        style: AppStyles.contentText.copyWith(
                            color: AppStyles.primaryColor,
                            fontWeight: FontWeight.bold),
                      ),
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
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Field ini wajib diisi';
                                }
                                return null;
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
                      Text(
                        'Tinggi Badan',
                        style: AppStyles.contentText.copyWith(
                            color: AppStyles.primaryColor,
                            fontWeight: FontWeight.bold),
                      ),
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
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Field ini wajib diisi';
                                }
                                return null;
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
                      Text(
                        'Suhu Tubuh',
                        style: AppStyles.contentText.copyWith(
                            color: AppStyles.primaryColor,
                            fontWeight: FontWeight.bold),
                      ),
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
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Field ini wajib diisi';
                                }
                                return null;
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
                    Text(
                      'Detak / Nadi',
                      style: AppStyles.contentText.copyWith(
                          color: AppStyles.primaryColor,
                          fontWeight: FontWeight.bold),
                    ),
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
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Field ini wajib diisi';
                              }

                              return null;
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
                    Text(
                      'Resp. Rate',
                      style: AppStyles.contentText.copyWith(
                          color: AppStyles.primaryColor,
                          fontWeight: FontWeight.bold),
                    ),
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
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Field ini wajib diisi';
                              }
                              return null;
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
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Field ini wajib diisi';
                        }
                        return null;
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
                onTap: () {
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
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
