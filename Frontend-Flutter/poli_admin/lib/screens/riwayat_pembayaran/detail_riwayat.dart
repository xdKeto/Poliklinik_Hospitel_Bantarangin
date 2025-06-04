import 'package:data_table_2/data_table_2.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:poli_admin/base/backend/class/detail_transaksi.dart';
import 'package:poli_admin/base/backend/data_controller.dart';
import 'package:poli_admin/base/backend/pdf_api.dart';
import 'package:poli_admin/base/global_widgets/btrb_text.dart';
import 'package:poli_admin/base/global_widgets/confirm_alert.dart';
import 'package:poli_admin/base/global_widgets/grey_divider.dart';
import 'package:poli_admin/base/global_widgets/loading_alert.dart';
import 'package:poli_admin/base/global_widgets/sucfail_alert.dart';
import 'package:poli_admin/base/global_widgets/the_button.dart';
import 'package:poli_admin/base/utils/app_styles.dart';
import 'package:printing/printing.dart';

class DetailRiwayat extends StatefulWidget {
  final String id;
  const DetailRiwayat({
    super.key,
    required this.id,
  });

  @override
  State<DetailRiwayat> createState() => _DetailRiwayatState();
}

class _DetailRiwayatState extends State<DetailRiwayat> {
  int rowsPerPage = 10;
  DetailTransaksi? detail;
  List<Obat> listObat = [];
  List<Tindakan> listTindakan = [];
  bool isLoading = true;
  var total = 0;
  double satuanObat = 0;
  String? namaAdmin;

  final DataController dataController = DataController();

  @override
  void initState() {
    super.initState();
    urutan();
  }

  Future<void> urutan() async {
    detail = await dataController.fetchDetailTransaksi(widget.id);
    namaAdmin = dataController.nama;

    if (detail != null) {
      setState(() {
        listObat = List.from(detail!.obat);
        listTindakan = List.from(detail!.tindakan);
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          width: 1000,
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: SelectionArea(
              child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Rincian Transaksi',
                    style: AppStyles.subheadingText
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(
                        Icons.close,
                        color: Colors.black,
                      ))
                ],
              ),
              GreyDivider(),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    btrbText(
                                        topText: 'Nama Pasien',
                                        botText: detail?.namaPasien ?? ''),
                                    SizedBox(
                                      width: 32,
                                    ),
                                    btrbText(
                                        topText: 'Tujuan Poliklinik',
                                        botText: detail?.namaPoli ?? ''),
                                  ],
                                ),
                                SizedBox(
                                  height: 16,
                                ),
                                btrbText(
                                    topText: 'Nomor RM',
                                    botText: detail?.idRm ?? '')
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                btrbText(
                                    topText: 'Nama Dokter',
                                    botText: detail?.namaDokter ?? ''),
                                SizedBox(
                                  height: 16,
                                ),
                                btrbText(
                                    topText: 'Biaya Jasa Dokter',
                                    botText:
                                        detail?.biayaDokter.toString() ?? ''),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  detail?.waktuDibayar?.substring(0, 10) ?? '',
                                  style: AppStyles.contentText,
                                ),
                                Text(
                                  'Admin: $namaAdmin',
                                  style: AppStyles.contentText,
                                ),
                                // Text(
                                // 'Admin: ${detail?.namaAdministrasi ?? ''}',
                                // style: AppStyles.contentText,
                                // ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      GreyDivider(),
                      SizedBox(
                        height: 550,
                        child: ListView(
                          children: [
                            Text(
                              'Daftar Obat',
                              style: AppStyles.sidebarText
                                  .copyWith(fontWeight: FontWeight.bold),
                            ),
                            listObat.isEmpty
                                ? Center(
                                    child: Text(
                                    'Tidak ada ada',
                                    style: AppStyles.statusText
                                        .copyWith(fontWeight: FontWeight.bold),
                                  ))
                                : ConstrainedBox(
                                    constraints: BoxConstraints(maxHeight: 300),
                                    child: DataTable2(
                                      // style
                                      headingTextStyle: AppStyles.sidebarText
                                          .copyWith(
                                              fontWeight: FontWeight.w600,
                                              color: AppStyles.textColor),
                                      headingRowColor:
                                          WidgetStateProperty.resolveWith(
                                        (states) => Colors.white,
                                      ),
                                      headingRowDecoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(6),
                                              topRight: Radius.circular(6))),
                                      dataTextStyle: AppStyles.contentText
                                          .copyWith(color: AppStyles.textColor),
                                      minWidth: 768,
                                      dividerThickness: 1,
                                      horizontalMargin: 12,
                                      dataRowHeight: 50,
                                      columnSpacing: 12,

                                      columns: [
                                        DataColumn(
                                          label: Text('No.'),
                                        ),
                                        DataColumn(label: Text('Nama Obat')),
                                        DataColumn(label: Text('Keterangan')),
                                        DataColumn(label: Text('Jumlah')),
                                        DataColumn(label: Text('Satuan')),
                                        DataColumn(label: Text('Harga Satuan')),
                                        DataColumn(label: Text('Total')),
                                      ],
                                      rows: List.generate(listObat.length,
                                          (index) {
                                        var data = listObat[index];
                                        total += listObat[index].hargaTotal;
                                        satuanObat =
                                            listObat[index].hargaTotal /
                                                listObat[index].jumlah;
                                        // print(listObat[index]);
                                        return DataRow(cells: [
                                          DataCell(
                                              Text((index + 1).toString())),
                                          DataCell(Text(
                                              data.namaObat?.isNotEmpty == true
                                                  ? data.namaObat!
                                                  : (data.namaRacikan ?? ''))),
                                          DataCell(Text(data.keterangan)),
                                          DataCell(
                                              Text(data.jumlah.toString())),
                                          DataCell(Text(data.satuan ?? '')),
                                          DataCell(Text(data.hargaSatuan
                                                      .toString() ==
                                                  'null'
                                              ? satuanObat.toString()
                                              : data.hargaSatuan.toString())),
                                          DataCell(
                                              Text(data.hargaTotal.toString())),
                                        ]);
                                      }),
                                    ),
                                  ),
                            GreyDivider(),
                            Text(
                              'Daftar Tindakan',
                              style: AppStyles.sidebarText
                                  .copyWith(fontWeight: FontWeight.bold),
                            ),
                            listTindakan.isEmpty
                                ? Center(
                                    child: Text(
                                    'Tidak ada data',
                                    style: AppStyles.statusText
                                        .copyWith(fontWeight: FontWeight.bold),
                                  ))
                                : ConstrainedBox(
                                    constraints: BoxConstraints(maxHeight: 300),
                                    child: DataTable2(
                                      // style
                                      headingTextStyle: AppStyles.sidebarText
                                          .copyWith(
                                              fontWeight: FontWeight.w600,
                                              color: AppStyles.textColor),
                                      headingRowColor:
                                          WidgetStateProperty.resolveWith(
                                        (states) => Colors.white,
                                      ),
                                      headingRowDecoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(6),
                                              topRight: Radius.circular(6))),
                                      dataTextStyle: AppStyles.contentText
                                          .copyWith(color: AppStyles.textColor),
                                      minWidth: 768,
                                      dividerThickness: 1,
                                      horizontalMargin: 12,
                                      dataRowHeight: 50,
                                      columnSpacing: 12,
                                      // empty: Center(
                                      //   child: Text(
                                      //     'Tidak ada Data',
                                      //     style: AppStyles.subheadingText.copyWith(fontWeight: FontWeight.bold),
                                      //   ),
                                      // ),
                                      columns: [
                                        DataColumn(
                                          label: Text('No.'),
                                        ),
                                        DataColumn(
                                            label: Text('Nama Tindakan')),
                                        DataColumn(label: Text('Jumlah')),
                                        DataColumn(
                                            label: Text('Harga Tindakan')),
                                        DataColumn(label: Text('Harga Total')),
                                      ],
                                      rows: List.generate(listTindakan.length,
                                          (index) {
                                        var data = listTindakan[index];
                                        total += listTindakan[index]
                                            .totalHargaTindakan;
                                        // print(listTindakan[index]);
                                        return DataRow(cells: [
                                          DataCell(
                                              Text((index + 1).toString())),
                                          DataCell(Text(data.namaTindakan)),
                                          DataCell(
                                              Text(data.jumlah.toString())),
                                          DataCell(Text(
                                              data.hargaTindakan.toString())),
                                          DataCell(Text(data.totalHargaTindakan
                                              .toString())),
                                        ]);
                                      }),
                                    ),
                                  ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              GreyDivider(),
              Padding(
                padding: EdgeInsets.only(right: 64.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'TOTAL JUMLAH BAYAR: \tRp${total.toString()},00',
                          style: AppStyles.contentText
                              .copyWith(fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 6,
              ),
              Padding(
                padding: EdgeInsets.only(right: 16.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (context) => ConfirmAlert(
                                      icon: FluentIcons.print_16_filled,
                                      boldText: 'Cetak Tagihan?',
                                      yesText: 'cetak',
                                      yesFunc: () async {
                                        Navigator.pop(context);
                                        showDialog(
                                            context: context,
                                            builder: (context) =>
                                                LoadingAlert(),
                                            barrierDismissible: false);

                                        try {
                                          final pdfData =
                                              await PdfApi.cetakTagihan(
                                                  detail!, total, satuanObat);
                                          if (!context.mounted) return;
                                          Navigator.pop(context);
                                          await Printing.layoutPdf(
                                                  onLayout: (format) => pdfData)
                                              .catchError((error) {
                                            throw Exception(
                                                "Failed to print: $error");
                                          });
                                        } catch (e) {
                                          if (!context.mounted) return;
                                          Navigator.pop(context);
                                          showDialog(
                                              context: context,
                                              builder: (context) => SucfailAlert(
                                                  isSuccess: false,
                                                  boldText: "Gagal",
                                                  italicText:
                                                      "Gagal membuat data: $e"));
                                        }
                                      },
                                    ));
                          },
                          child: TheButton(
                            text: 'Cetak Tagihan',
                            color: AppStyles.accentColor,
                            iconColor: AppStyles.accentColor,
                            textColor: AppStyles.accentColor,
                            border: true,
                            isIcon: true,
                            icon: Icons.print,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          )),
        ));
  }
}
