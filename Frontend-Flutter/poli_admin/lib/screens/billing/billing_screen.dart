import 'package:data_table_2/data_table_2.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:poli_admin/base/global_widgets/global_top_bar.dart';
import 'package:poli_admin/screens/billing/detail_billing.dart';
import 'package:poli_admin/screens/billing/widgets/status_box.dart';
import 'package:poli_admin/base/global_widgets/the_button.dart';
import 'package:poli_admin/base/utils/app_styles.dart';
import 'package:poli_admin/dummy/data.dart';

class BillingScreen extends StatefulWidget {
  final VoidCallback onMenuPressed;
  final bool isExpanded;
  const BillingScreen(
      {super.key, required this.onMenuPressed, required this.isExpanded});

  @override
  State<BillingScreen> createState() => _BillingScreenState();
}

class _BillingScreenState extends State<BillingScreen> {
  bool sortAscending = true;
  int sortColumnIndex = 0;
  int rowsPerPage = 10;
  List<Map<String, dynamic>> filteredList = [];
  final TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredList = List.from(billingList);
  }

  void onSort(int columnIndex, bool ascending) {
    setState(() {
      sortColumnIndex = columnIndex;
      sortAscending = ascending;
      filteredList.sort((a, b) {
        var valueA = a[sortColumnIndex == 0
            ? 'no_antrian'
            : sortColumnIndex == 1
                ? 'no_rekam_medis'
                : 'nama_pasien'];
        var valueB = b[sortColumnIndex == 0
            ? 'no_antrian'
            : sortColumnIndex == 1
                ? 'no_rekam_medis'
                : 'nama_pasien'];
        return ascending ? valueA.compareTo(valueB) : valueB.compareTo(valueA);
      });
    });
  }

  void onSearch(String query) {
    setState(() {
      filteredList = billingList.where((pasien) {
        String namaPasien = pasien['nama_pasien'].toLowerCase();
        String noRekamMedis = pasien['no_rekam_medis'].toLowerCase();
        String searchQuery = query.toLowerCase();

        return namaPasien.toString().contains(searchQuery) ||
            noRekamMedis.toString().contains(searchQuery);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppStyles.backgroundColor,
      appBar: GlobalTopBar(
        onMenuPressed: widget.onMenuPressed,
        title: 'Billing',
        isExpanded: widget.isExpanded,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    onChanged: onSearch,
                    decoration: AppStyles.formBox.copyWith(
                      hintText: 'Search',
                      prefixIcon: Icon(Icons.search),
                    ),
                  ),
                ),
                SizedBox(
                  width: screenWidth * 0.01,
                ),
                IconButton(
                    onPressed: () {
                      setState(() {
                        controller.clear();
                        filteredList = List.from(billingList);
                      });
                    },
                    icon: Icon(Icons.refresh)),
                SizedBox(
                  width: screenWidth * 0.08,
                ),
                Text('Entries:  ',
                    style: AppStyles.contentText.copyWith(
                        color: AppStyles.primaryColor,
                        fontWeight: FontWeight.bold)),
                Expanded(
                  child: DropdownButtonFormField<int>(
                    decoration: AppStyles.formBox,
                    value: rowsPerPage,
                    items: [10, 25, 50, 100]
                        .map((e) =>
                            DropdownMenuItem(value: e, child: Text('$e Rows')))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        rowsPerPage = value!;
                      });
                    },
                  ),
                ),
                SizedBox(
                  width: screenWidth * 0.02,
                ),
              ],
            ),
            SizedBox(height: 12),
            Expanded(
              child: PaginatedDataTable2(
                sortColumnIndex: sortColumnIndex,
                sortAscending: sortAscending,

                // style
                headingTextStyle: AppStyles.sidebarText.copyWith(
                    fontWeight: FontWeight.w600, color: AppStyles.textColor),
                // headingTextStyle: Theme.of(context).textTheme.titleMedium,
                headingRowColor: WidgetStateProperty.resolveWith(
                    (states) => AppStyles.greyColor),
                headingRowDecoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12))),
                dataTextStyle:
                    AppStyles.contentText.copyWith(color: AppStyles.textColor),
                minWidth: 768,
                dividerThickness: 0,
                horizontalMargin: 12,
                dataRowHeight: 56,
                rowsPerPage: 10,
                columnSpacing: 12,
                availableRowsPerPage: [10, 25, 50, 100],
                isHorizontalScrollBarVisible: true,

                // pagination
                showFirstLastButtons: true,
                renderEmptyRowsInTheEnd: false,

                // sorting
                sortArrowAlwaysVisible: true,
                sortArrowBuilder: (bool ascending, bool sorted) {
                  if (sorted) {
                    return Icon(
                      ascending
                          ? FluentIcons.arrow_sort_up_16_regular
                          : FluentIcons.arrow_sort_down_16_regular,
                      size: 12,
                    );
                  } else {
                    return Icon(
                      FluentIcons.arrow_sort_16_regular,
                      size: 12,
                    );
                  }
                },

                columns: [
                  DataColumn(label: Text('No.'), onSort: onSort),
                  DataColumn(label: Text('No. Rekam Medis')),
                  DataColumn(label: Text('Nama Pasien'), onSort: onSort),
                  DataColumn(label: Text('Poli Tujuan')),
                  DataColumn(label: Center(child: Text('Status'))),
                  DataColumn(label: Center(child: Text('Rincian'))),
                ],
                source:
                    RowSource(myData: filteredList, count: filteredList.length),
              ),
            ),
          ],
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
    return DataRow(cells: [
      DataCell(Text((index + 1).toString())),
      DataCell(Text(data['no_rekam_medis'])),
      DataCell(Text(data['nama_pasien'])),
      DataCell(Text(data['poli_tujuan'])),
      DataCell(Center(child: StatusBox(status: data['status']))),
      DataCell(Center(
          child: TheButton(
        text: "View Details",
        color: AppStyles.accentColor,
        isIcon: true,
        icon: Icons.menu_open_rounded,
      ))),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;
  @override
  int get rowCount => count;
  @override
  int get selectedRowCount => 0;
}
