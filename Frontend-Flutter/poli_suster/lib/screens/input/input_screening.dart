import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:poli_suster/base/global_widgets/confirm_alert.dart';
import 'package:poli_suster/base/global_widgets/the_button.dart';
import 'package:poli_suster/base/utils/app_styles.dart';
import 'package:poli_suster/screens/input/data_pasien.dart';

class InputScreening extends StatefulWidget {
  const InputScreening({super.key});

  @override
  State<InputScreening> createState() => _InputScreeningState();
}

class _InputScreeningState extends State<InputScreening> {
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
                          width: 170,
                          height: 40,
                          child: TextFormField(
                            cursorColor: Colors.black,
                            decoration: AppStyles.formBox.copyWith(),
                            onChanged: (value) {},
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
                            keyboardType:
                                TextInputType.numberWithOptions(decimal: true),
                            // inputFormatters: [
                            //   FilteringTextInputFormatter.digitsOnly
                            // ],
                            cursorColor: Colors.black,
                            decoration: AppStyles.formBox.copyWith(),
                            onChanged: (value) {},
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
                            keyboardType:
                                TextInputType.numberWithOptions(decimal: true),
                            // inputFormatters: [
                            //   FilteringTextInputFormatter.digitsOnly
                            // ],
                            cursorColor: Colors.black,
                            decoration: AppStyles.formBox.copyWith(),
                            onChanged: (value) {},
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
                            keyboardType:
                                TextInputType.numberWithOptions(decimal: true),
                            // inputFormatters: [
                            //   FilteringTextInputFormatter.digitsOnly
                            // ],
                            cursorColor: Colors.black,
                            decoration: AppStyles.formBox.copyWith(),
                            onChanged: (value) {},
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
                      'Gula Darah',
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
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            cursorColor: Colors.black,
                            decoration: AppStyles.formBox.copyWith(),
                            onChanged: (value) {},
                          ),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          'mg/dL',
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
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            cursorColor: Colors.black,
                            decoration: AppStyles.formBox.copyWith(),
                            onChanged: (value) {},
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
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            cursorColor: Colors.black,
                            decoration: AppStyles.formBox.copyWith(),
                            onChanged: (value) {},
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
                      maxLines: 4,
                      cursorColor: Colors.black,
                      decoration: AppStyles.formBox.copyWith(),
                      onChanged: (value) {},
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
                onTap: () {},
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
                          yesText: 'simpan'));
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
