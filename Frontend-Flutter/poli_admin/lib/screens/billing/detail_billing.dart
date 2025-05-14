import 'package:data_table_2/data_table_2.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:poli_admin/base/backend/class/detail_transaksi.dart';
import 'package:poli_admin/base/backend/data_controller.dart';
import 'package:poli_admin/base/global_widgets/confirm_alert.dart';
import 'package:poli_admin/base/global_widgets/global_top_bar.dart';
import 'package:poli_admin/base/global_widgets/grey_divider.dart';
import 'package:poli_admin/base/global_widgets/label_required.dart';
import 'package:poli_admin/base/global_widgets/the_button.dart';
import 'package:poli_admin/base/utils/app_styles.dart';

class DetailBilling extends StatefulWidget {
  final VoidCallback? toggleSidebar;
  final bool isExpand;
  final Function(int) navigateToPage;
  final String id;
  const DetailBilling({
    super.key,
    this.toggleSidebar,
    required this.isExpand,
    required this.navigateToPage,
    required this.id,
  });

  @override
  State<DetailBilling> createState() => _DetailBillingState();
}

class _DetailBillingState extends State<DetailBilling> {
  final List<String> listBayar = ["Debit", "Cash", "Credit"];
  String? selectedValue;
  var selectedDate = DateTime.now();
  var parsedDate = DateTime.now();
  var tanggalcontroller = TextEditingController();

  int rowsPerPage = 10;
  DetailTransaksi? detail;
  List<Obat> listObat = [];
  List<Tindakan> listTindakan = [];
  bool isLoading = true;

  final DataController dataController = DataController();

  @override
  void initState() {
    super.initState();
    urutan();
  }

  Future<void> urutan() async {
    await fetchData();
    listObat = List.from(detail!.obat);
    listTindakan = List.from(detail!.tindakan);
  }

  Future<void> fetchData() async {
    setState(() {
      isLoading = true;
      detail = dataController.detailTransaksi;
    });
  }
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return SelectionArea(
      child: Scaffold(
        backgroundColor: AppStyles.backgroundColor,
        appBar: GlobalTopBar(
          toggleSidebar: widget.toggleSidebar,
          isExpand: widget.isExpand,
          title: 'Detail Billing',
        ),
        body: Center(
          child: ListView(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 22, horizontal: 27),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                  decoration: AppStyles.whiteBox,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hospitel Bantarangin',
                        style: AppStyles.subheadingText
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Jl. Ponorogo - Wonogiri, Tengah, Kauman',
                        style: AppStyles.contentText,
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      GreyDivider(),
                      SizedBox(
                        height: 6,
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Wrap(
                              spacing: 32,
                              runSpacing: 8,
                              children: [
                                Text(
                                  'Nama: ${detail!.namaPasien}',
                                  style: AppStyles.contentText,
                                ),
                                Text(
                                  'Nomor Rekam Medis: ${detail!.idRm}',
                                  style: AppStyles.contentText,
                                ),
                                Text(
                                  'Poli Tujuan: ${detail!.namaPoli}',
                                  style: AppStyles.contentText,
                                ),
                                Text(
                                  'Dokter: ${detail!.namaDokter}',
                                  style: AppStyles.contentText,
                                ),
                                Text(
                                  'Biaya Dokter: Rp ${detail!.biayaDokter}',
                                  style: AppStyles.contentText,
                                ),
                                Text(
                                  'Nama administrasi: ${detail!.namaAdministrasi}',
                                  style: AppStyles.contentText,
                                ),
                                Text(
                                  'Yang Ditugaskan: ${detail!.namaDokter}',
                                  style: AppStyles.contentText,
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      GreyDivider(),
                      SizedBox(
                        height: 6,
                      ),
                      DataTable2(
                        // style
                        headingTextStyle: AppStyles.sidebarText.copyWith(
                            fontWeight: FontWeight.w600,
                            color: AppStyles.textColor),
                        headingRowColor: WidgetStateProperty.resolveWith(
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
                        dataRowHeight: 40,
                        columnSpacing: 12,
                        empty: Center(
                          child: Text(
                            'Tidak ada Data',
                            style: AppStyles.subheadingText
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
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
                        rows: List.generate(listObat.length, (index) {
                          var data = listObat[index];
                          return DataRow(cells: [
                            DataCell(Text((index + 1).toString())),
                            DataCell(Text(data.namaObat)),
                            DataCell(Text(data.keterangan)),
                            DataCell(Text(data.jumlah.toString())),
                            DataCell(Text(data.satuan)),
                            DataCell(Text(data.hargaSatuan.toString())),
                            DataCell(Text(data.hargaTotal.toString())),
                          ]);
                        }),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      GreyDivider(),
                      SizedBox(
                        height: 6,
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'TOTAL JUMLAH BAYAR',
                            style: AppStyles.contentText
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: screenWidth * 0.1,
                          ),
                          Text(
                            '0,00',
                            style: AppStyles.contentText,
                          )
                        ],
                      ),
                      SizedBox(
                        height: 6,
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 27, right: 27, bottom: 22),
                child: Container(
                  padding:
                      EdgeInsets.only(left: 20, right: 20, top: 12, bottom: 24),
                  decoration: AppStyles.whiteBox,
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            LabelRequired(
                                text: 'Pilih Pembayaran',
                                style: AppStyles.contentText
                                    .copyWith(fontWeight: FontWeight.bold)),
                            SizedBox(
                              height: 12,
                            ),
                            DropdownButtonFormField2<String>(
                              isExpanded: true,
                              decoration: AppStyles.formBox
                                  .copyWith(contentPadding: EdgeInsets.zero),
                              hint: Text('-- Pilih jenis pembayaran --'),
                              items: listBayar
                                  .map((item) => DropdownMenuItem<String>(
                                      value: item, child: Text(item)))
                                  .toList(),
                              validator: (value) {
                                if (value == null) {
                                  return 'Pilih jenis pembayaran';
                                }
                                return null;
                              },
                              onChanged: (value) {},
                              onSaved: (newValue) {
                                selectedValue = newValue.toString();
                              },
                              buttonStyleData: ButtonStyleData(
                                  padding: EdgeInsets.only(right: 8)),
                              iconStyleData: const IconStyleData(
                                icon: Icon(
                                  Icons.arrow_drop_down,
                                  color: Colors.black45,
                                ),
                                iconSize: 24,
                              ),
                              dropdownStyleData: DropdownStyleData(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                              menuItemStyleData: const MenuItemStyleData(
                                padding: EdgeInsets.symmetric(horizontal: 16),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            LabelRequired(
                                text: 'Tanggal Pembayaran',
                                style: AppStyles.contentText
                                    .copyWith(fontWeight: FontWeight.bold)),
                            SizedBox(
                              height: 12,
                            ),
                            TextFormField(
                              controller: tanggalcontroller,
                              readOnly: true,
                              cursorColor: Colors.black,
                              decoration: AppStyles.formBox.copyWith(
                                hintText: 'DD/MM/YY',
                                hintStyle:
                                    TextStyle(color: AppStyles.greyColor2),
                                suffixIcon: Icon(Icons.date_range),
                              ),
                              onChanged: (value) {},
                              onTap: () async {
                                DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2000),
                                  lastDate: DateTime(2100),
                                );

                                if (pickedDate != null &&
                                    pickedDate != selectedDate) {
                                  setState(() {
                                    selectedDate = pickedDate;

                                    tanggalcontroller.text =
                                        DateFormat('yyyy-MM-dd')
                                            .format(selectedDate);
                                  });
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 27, right: 27, bottom: 22),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () async {
                        widget.navigateToPage(1);
                      },
                      child: TheButton(
                        text: 'Kembali',
                        color: AppStyles.greyBtnColor,
                        iconColor: AppStyles.greyBtnColor,
                        textColor: AppStyles.greyBtnColor,
                        border: true,
                        isIcon: true,
                        icon: Icons.arrow_back,
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    InkWell(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) => ConfirmAlert(
                                  icon: FluentIcons.info_12_regular,
                                  boldText: 'Assign Pembayaran?',
                                  italicText:
                                      'Tagihan akan dicatat lunas oleh sistem',
                                  yesText: 'assign',
                                  yesFunc: () {},
                                ));
                      },
                      child: TheButton(
                        text: 'Assign Pembayaran',
                        color: AppStyles.primaryColor,
                        textColor: AppStyles.primaryColor,
                        border: true,
                        // horiPadding: 16,
                        vertPadding: 10,
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    InkWell(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) => ConfirmAlert(
                                  icon: FluentIcons.print_16_filled,
                                  boldText: 'Cetak Tagihan?',
                                  yesText: 'cetak',
                                  yesFunc: () {},
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
