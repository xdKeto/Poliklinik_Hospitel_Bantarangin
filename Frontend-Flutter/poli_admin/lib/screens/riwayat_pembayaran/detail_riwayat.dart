import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:poli_admin/base/global_widgets/btrb_text.dart';
import 'package:poli_admin/base/global_widgets/grey_divider.dart';
import 'package:poli_admin/base/utils/app_styles.dart';
import 'package:poli_admin/dummy/data.dart';

class DetailRiwayat extends StatefulWidget {
  const DetailRiwayat({
    super.key,
  });

  @override
  State<DetailRiwayat> createState() => _DetailRiwayatState();
}

class _DetailRiwayatState extends State<DetailRiwayat> {
  int rowsPerPage = 10;
  List<Map<String, dynamic>> filteredList = [];

  @override
  void initState() {
    super.initState();
    filteredList = List.from(listobat);
  }

  @override
  Widget build(BuildContext context) {
    return SelectionArea(
      child: Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            width: 1000,
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
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
                SizedBox(
                  height: 6,
                ),
                GreyDivider(),
                SizedBox(
                  height: 8,
                ),
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
                                  topText: 'Nama Pasien', botText: 'John Doe'),
                              SizedBox(
                                width: 32,
                              ),
                              btrbText(
                                  topText: 'Tujuan Poliklinik',
                                  botText: 'Poli Umum'),
                            ],
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          btrbText(topText: 'Nomor RM', botText: 'RM2024001')
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          btrbText(
                              topText: 'Nama Dokter', botText: '[nama dokter]'),
                          SizedBox(
                            height: 16,
                          ),
                          btrbText(
                              topText: 'Biaya Jasa Dokter',
                              botText: 'Rp. 500.000'),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            '01/01/2025 - 13:30',
                            style: AppStyles.contentText,
                          ),
                          Text(
                            'Admin: Lala',
                            style: AppStyles.contentText,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                ConstrainedBox(
                    constraints: BoxConstraints(maxHeight: 400),
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
                            myData: filteredList, count: filteredList.length))),
                SizedBox(
                  height: 12,
                ),
                Padding(
                  padding: EdgeInsets.only(right: 64.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'TOTAL JUMLAH BAYAR: \tRp524.000,00',
                        style: AppStyles.contentText
                            .copyWith(fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                )
              ],
            ),
          )),
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
