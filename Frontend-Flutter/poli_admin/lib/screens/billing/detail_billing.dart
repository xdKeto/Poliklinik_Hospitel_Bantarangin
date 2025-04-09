import 'package:data_table_2/data_table_2.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:poli_admin/base/global_widgets/confirm_alert.dart';
import 'package:poli_admin/base/global_widgets/global_top_bar.dart';
import 'package:poli_admin/base/global_widgets/grey_divider.dart';
import 'package:poli_admin/base/global_widgets/label_required.dart';
import 'package:poli_admin/base/global_widgets/the_button.dart';
import 'package:poli_admin/base/utils/app_styles.dart';
import 'package:poli_admin/dummy/data.dart';

class DetailBilling extends StatefulWidget {
  final VoidCallback? toggleSidebar;
  final bool isExpand;
  final Function(int) navigateToPage;
  const DetailBilling({
    super.key,
    this.toggleSidebar,
    required this.isExpand,
    required this.navigateToPage,
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
  List<Map<String, dynamic>> filteredList = [];

  @override
  void initState() {
    super.initState();
    filteredList = List.from(listobat);
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
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Nama: Andi Pratama',
                                style: AppStyles.contentText,
                              ),
                              Text(
                                'Nomor Rekam Medis: RM2024001',
                                style: AppStyles.contentText,
                              ),
                              Text(
                                'Poli Tujuan: Poli Gigi',
                                style: AppStyles.contentText,
                              ),
                            ],
                          ),
                          SizedBox(
                            width: screenWidth * 0.15,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Dokter: dr. [nama dokter]',
                                style: AppStyles.contentText,
                              ),
                              Text(
                                'Biaya Dokter: Rp500.000  ',
                                style: AppStyles.contentText,
                              ),
                              Text(
                                'Yang Ditugaskan: [nama tenkes]',
                                style: AppStyles.contentText,
                              ),
                            ],
                          ),
                          SizedBox(
                            width: screenWidth * 0.15,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Nama administrasi: [nama admin]',
                                style: AppStyles.contentText,
                              ),
                              Text(
                                '',
                                style: AppStyles.contentText,
                              ),
                              // Spacer()
                            ],
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
                      ConstrainedBox(
                          constraints: BoxConstraints(maxHeight: 325),
                          child: PaginatedDataTable2(
                              // style
                              headingTextStyle: AppStyles.sidebarText.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: AppStyles.textColor),
                              headingRowColor: WidgetStateProperty.resolveWith(
                                  (states) => AppStyles.greyColor),
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
                              hidePaginator: true,
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
                              source: RowSource(
                                  myData: filteredList,
                                  count: filteredList.length))),
                      SizedBox(
                        height: 6,
                      ),
                      GreyDivider(),
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
                      onTap: () {
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

class RowSource extends DataTableSource {
  final List<Map<String, dynamic>> myData;
  final int count;

  RowSource({required this.myData, required this.count});

  @override
  DataRow? getRow(int index) {
    if (index >= myData.length) return null;
    var data = myData[index];
    return DataRow(
        color: WidgetStateProperty.resolveWith<Color?>(
          (Set<WidgetState> states) {
            return Colors.white;
          },
        ),
        cells: [
          DataCell(Text((index + 1).toString())),
          DataCell(Text(data['nama'])),
          DataCell(Text(data['keterangan'])),
          DataCell(Text(data['jumlah'].toString())),
          DataCell(Text(data['jenis'])),
          DataCell(Text(data['harga_satuan'].toString())),
          DataCell(Text(data['total_harga'].toString())),
        ]);
  }

  @override
  bool get isRowCountApproximate => false;
  @override
  int get rowCount => count;
  @override
  int get selectedRowCount => 0;
}
