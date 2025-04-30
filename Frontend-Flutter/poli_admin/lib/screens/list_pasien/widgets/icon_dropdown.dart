import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:poli_admin/base/backend/class/data_printing.dart';
import 'package:poli_admin/base/backend/data_controller.dart';
import 'package:poli_admin/base/backend/pdf_api.dart';
import 'package:poli_admin/base/global_widgets/confirm_alert.dart';
import 'package:poli_admin/base/global_widgets/loading_alert.dart';
import 'package:poli_admin/base/global_widgets/sucfail_alert.dart';
import 'package:poli_admin/base/utils/app_styles.dart';
import 'package:poli_admin/base/utils/config.dart';
import 'package:printing/printing.dart';

class IconDropdown extends StatefulWidget {
  final String status;
  final int id;
  const IconDropdown({super.key, required this.status, required this.id});

  @override
  State<IconDropdown> createState() => _IconDropdownState();
}

class _IconDropdownState extends State<IconDropdown> {
  bool privData = false;
  bool privLabel = false;
  bool privGelang = false;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    listPriv();
  }

  void listPriv() async {
    var temp1 = await DataController().cekPriv(3);
    var temp2 = await DataController().cekPriv(4);
    var temp3 = await DataController().cekPriv(5);

    setState(() {
      privData = temp1;
      privLabel = temp2;
      privGelang = temp3;
      loading = false;
    });
  }

  List<MenuItem> privItems() {
    List<MenuItem> items = [];

    if (privData) {
      items.add(MenuItems.dataPasien);
    }

    if (privLabel) {
      items.add(MenuItems.labelPasien);
    }

    if (privGelang) {
      items.add(MenuItems.gelangPasien);
    }

    return items;
  }

  /// menunggu = cetak data, tunda, batal
  /// screening = cetak data, tunda
  /// pra-konsultasi = cetak data, tunda
  /// konsultasi = cetak data, cetak label, cetak gelang
  /// selesai = cetak data, cetak label, cetak gelang
  /// ditunda = masukkan antrian, batalkan
  /// dibatalkan = -
  ///

  List<MenuItem> dropdownItems() {
    List<MenuItem> items = privItems();
    if (widget.status.toLowerCase() == 'menunggu') {
      return [MenuItems.dataPasien, MenuItems.tundaPasien, MenuItems.batalAntrian];
    } else if (widget.status.toLowerCase() == 'screening' ||
        widget.status.toLowerCase() == 'pra-konsultasi') {
      return [MenuItems.dataPasien, MenuItems.tundaPasien];
    } else if (widget.status.toLowerCase() == 'konsultasi' ||
        widget.status.toLowerCase() == 'selesai') {
      return items;
    } else if (widget.status.toLowerCase() == 'ditunda') {
      return [MenuItems.masukAntrian, MenuItems.batalAntrian];
    } else if (widget.status.toLowerCase() == 'dibatalkan') {
      return [];
    }

    return items;
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return LoadingAnimationWidget.horizontalRotatingDots(color: Colors.black, size: 20);
    }

    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        customButton: Icon(Icons.more_horiz),
        items: dropdownItems()
            .map((item) => DropdownMenuItem(value: item, child: MenuItems.buildItem(item)))
            .toList(),
        onChanged: (value) {
          MenuItems.onChanged(context, value as MenuItem, widget.id);
        },
        dropdownStyleData: DropdownStyleData(
            width: 180,
            padding: const EdgeInsets.symmetric(vertical: 6),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              // color: Colors.redAccent,
            ),
            offset: Offset(8, 0),
            direction: DropdownDirection.left),
      ),
    );
  }
}

class MenuItem {
  const MenuItem({required this.text, required this.icon});

  final String text;
  final IconData icon;
}

class MenuItems {
  static const dataPasien =
      MenuItem(text: 'Cetak Data', icon: FluentIcons.document_one_page_16_regular);
  static const gelangPasien = MenuItem(text: 'Cetak Gelang', icon: FluentIcons.patient_20_regular);
  static const labelPasien = MenuItem(text: 'Cetak Label', icon: FluentIcons.bookmark_16_regular);
  static const tundaPasien = MenuItem(text: 'Tunda Antrian', icon: FluentIcons.previous_16_regular);
  static const masukAntrian =
      MenuItem(text: 'Masuk Antrian', icon: FluentIcons.people_queue_20_regular);
  static const batalAntrian = MenuItem(text: "Batalkan Antrian", icon: Icons.close);

  static Widget buildItem(MenuItem item) {
    return Row(
      children: [
        Icon(
          item.icon,
          size: 20,
        ),
        SizedBox(
          width: 4,
        ),
        Expanded(
          child: Text(
            item.text,
            style: AppStyles.contentText.copyWith(color: AppStyles.textColor),
          ),
        )
      ],
    );
  }

  static void onChanged(BuildContext context, MenuItem item, int id) async {
    switch (item) {
      case MenuItems.dataPasien:
        print('print data');
        break;
      case MenuItems.gelangPasien:
        print('print gelang');
        showDialog(
            context: context, builder: (context) => LoadingAlert(), barrierDismissible: false);

        DataPrinting dataPrinting = await DataController().fetchDataPrinting(id.toString());
        final String tanggal = DateFormat('dd/mm/yyyy').format(DateTime.now());
        final String jam = DateFormat('HH:mm').format(DateTime.now());

        try {
          final pdfData = await PdfApi.cetakGelang(dataPrinting.namaPasien,
              dataPrinting.namaDokter ?? '', dataPrinting.tanggalLahir, tanggal, jam);

          if (!context.mounted) return;
          Navigator.pop(context);

          await Printing.layoutPdf(onLayout: (format) => pdfData).catchError((error) {
            throw Exception("Failed to print: $error");
          });
        } catch (e) {
          if (!context.mounted) return;
          Navigator.pop(context);
          showDialog(
              context: context,
              builder: (context) => SucfailAlert(
                  isSuccess: false, boldText: "Gagal", italicText: "Gagal membuat gelang: $e"));
        }

        break;
      case MenuItems.labelPasien:
        print('print label');
        showDialog(
            context: context, builder: (context) => LoadingAlert(), barrierDismissible: false);

        DataPrinting dataPrinting = await DataController().fetchDataPrinting(id.toString());
        final String tanggal = DateFormat('dd/mm/yyyy').format(DateTime.now());
        final String jam = DateFormat('HH:mm').format(DateTime.now());

        // generate pdf
        try {
          final pdfData = await PdfApi.cetakLabel(
              dataPrinting.namaDokter ?? '',
              dataPrinting.namaPasien,
              dataPrinting.jenisKelamin,
              dataPrinting.tanggalLahir,
              tanggal,
              jam,
              dataPrinting.umur);

          if (!context.mounted) return;
          Navigator.pop(context);

          await Printing.layoutPdf(onLayout: (format) => pdfData).catchError((error) {
            throw Exception("Failed to print: $error");
          });
        } catch (e) {
          if (!context.mounted) return;
          showDialog(
              context: context,
              builder: (context) => SucfailAlert(
                  isSuccess: false, boldText: "Gagal", italicText: "Gagal membuat label: $e"));
        }

        break;
      case MenuItems.tundaPasien:
        print('$id ditunda');
        showDialog(
            context: context,
            builder: (context) => ConfirmAlert(
                  icon: FluentIcons.previous_16_regular,
                  boldText: "Tunda Antrian?",
                  yesText: "tunda",
                  yesFunc: () async {
                    ResponseRequestAPI response = await DataController().apiConnector(
                        Config.apiEndpoints["tundaAntrian"]!(id.toString()), "put", "");

                    if (!context.mounted) return;
                    Navigator.pop(context);
                    if (response.status == 200) {
                      showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (context) {
                            Future.delayed(Duration(seconds: 1), () {
                              if (context.mounted) {
                                Navigator.pop(context);

                                // if (context.mounted) {
                                //   Navigator.pushReplacementNamed(
                                //       context, AppRoutes.dashboard);
                                // }
                              }
                            });

                            return SucfailAlert(
                                isSuccess: true,
                                boldText: "Berhasil",
                                italicText: "antrian berhasil ditunda");
                          });
                    } else {
                      showDialog(
                        context: context,
                        builder: (context) => SucfailAlert(
                          isSuccess: false,
                          boldText: "Gagal",
                          italicText: response.message,
                        ),
                      );
                    }
                  },
                ));
        break;
      case MenuItems.masukAntrian:
        print('$id masuk antrian');
        showDialog(
            context: context,
            builder: (context) => ConfirmAlert(
                  icon: FluentIcons.next_16_regular,
                  boldText: "Masukkan ke Antrian?",
                  yesText: "masukkan",
                  yesFunc: () async {
                    ResponseRequestAPI response = await DataController()
                        .apiConnector(Config.apiEndpoints["putAntrian"]!(id.toString()), "put", "");

                    if (!context.mounted) return;
                    Navigator.pop(context);
                    if (response.status == 200) {
                      showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (context) {
                            Future.delayed(Duration(seconds: 1), () {
                              if (context.mounted) {
                                Navigator.pop(context);

                                // if (context.mounted) {
                                //   Navigator.pushReplacementNamed(
                                //       context, AppRoutes.dashboard);
                                // }
                              }
                            });

                            return SucfailAlert(
                                isSuccess: true,
                                boldText: "Berhasil",
                                italicText: "antrian berhasil dimasukkan");
                          });
                    } else {
                      showDialog(
                        context: context,
                        builder: (context) => SucfailAlert(
                          isSuccess: false,
                          boldText: "Gagal",
                          italicText: response.message,
                        ),
                      );
                    }
                  },
                ));
        break;
      case MenuItems.batalAntrian:
        print('$id batal antrian');
        showDialog(
            context: context,
            builder: (context) => ConfirmAlert(
                  icon: FluentIcons.error_circle_12_regular,
                  color: AppStyles.redColor,
                  boldText: "Batalkan Antrian?",
                  yesText: "batal",
                  yesFunc: () async {
                    ResponseRequestAPI response = await DataController().apiConnector(
                        Config.apiEndpoints["batalAntrian"]!(id.toString()), "put", "");

                    if (!context.mounted) return;
                    Navigator.pop(context);
                    if (response.status == 200) {
                      showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (context) {
                            Future.delayed(Duration(seconds: 1), () {
                              if (context.mounted) {
                                Navigator.pop(context);

                                // if (context.mounted) {
                                //   Navigator.pushReplacementNamed(
                                //       context, AppRoutes.dashboard);
                                // }
                              }
                            });

                            return SucfailAlert(
                                isSuccess: true,
                                boldText: "Berhasil",
                                italicText: "antrian berhasil dibatalkan");
                          });
                    } else {
                      showDialog(
                        context: context,
                        builder: (context) => SucfailAlert(
                          isSuccess: false,
                          boldText: "Gagal",
                          italicText: response.message,
                        ),
                      );
                    }
                  },
                ));
        break;
    }
  }
}
