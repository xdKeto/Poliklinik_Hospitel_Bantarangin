import 'package:data_table_2/data_table_2.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:poli_admin/base/global_widgets/global_top_bar.dart';
import 'package:poli_admin/base/global_widgets/the_button.dart';
import 'package:poli_admin/base/utils/app_styles.dart';
import 'package:poli_admin/dummy/data.dart';
import 'package:poli_admin/screens/riwayat_pembayaran/detail_riwayat.dart';

class RiwayatScreen extends StatefulWidget {
  final VoidCallback onMenuPressed;
  final bool isExpanded;
  final Function(int) navigateToChild;
  const RiwayatScreen(
      {super.key,
      required this.onMenuPressed,
      required this.isExpanded,
      required this.navigateToChild});

  @override
  State<RiwayatScreen> createState() => _RiwayatScreenState();
}

class _RiwayatScreenState extends State<RiwayatScreen> {
  final List<String> listPoli = [
    "-- Semua Poli --",
    "Poli Gigi",
    "Poli Anak",
    "Poli Umum",
    "Poli Saraf",
    "Poli Mata",
    "Poli Kulit",
  ];

  String? selectedPoli;

  bool sortAscending = true;
  int sortColumnIndex = 0;
  int rowsPerPage = 10;
  List<Map<String, dynamic>> filteredList = [];
  final TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredList = List.from(riwayat);
  }

  void onSort(int columnIndex, bool ascending) {
    setState(() {
      sortColumnIndex = columnIndex;
      sortAscending = ascending;

      filteredList.sort((a, b) {
        var valueA, valueB;

        switch (columnIndex) {
          case 0:
            valueA = filteredList.indexOf(a);
            valueB = filteredList.indexOf(b);
            break;
          case 1:
            valueA = a['nama'];
            valueB = b['nama'];
            break;
          case 2:
            valueA = DateTime.parse(a['tanggal']);
            valueB = DateTime.parse(b['tanggal']);
            break;
          case 3:
            valueA = a['poli'];
            valueB = b['poli'];
            break;
          default:
            return 0;
        }

        return ascending ? valueA.compareTo(valueB) : valueB.compareTo(valueA);
      });
    });
  }

  void applyFilters() {
    setState(() {
      filteredList = riwayat.where((pasien) {
        bool poliMatch = selectedPoli == "-- Semua Poli --" ||
            selectedPoli == null ||
            pasien['poli'] == selectedPoli;
        return poliMatch;
      }).toList();
    });
  }

  void onSearch(String query) {
    setState(() {
      filteredList = riwayat.where((pasien) {
        String namaPasien = pasien['nama'].toLowerCase();
        String searchQuery = query.toLowerCase();

        return namaPasien.toString().contains(searchQuery);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return SelectionArea(
      child: Scaffold(
        backgroundColor: AppStyles.backgroundColor,
        appBar: GlobalTopBar(
            onMenuPressed: widget.onMenuPressed,
            title: 'Riwayat Pembayaran',
            isExpanded: widget.isExpanded),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 5, right: 8),
                child: Row(
                  children: [
                    SizedBox(
                      width: 400,
                      child: TextFormField(
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
                    // filter by poliklinik
                    SizedBox(
                      width: 300,
                      child: DropdownButtonFormField2<String>(
                        isExpanded: true,
                        decoration: AppStyles.formBox,
                        hint: Text('-- Pilih Poliklinik --'),
                        items: listPoli
                            .map((item) => DropdownMenuItem<String>(
                                value: item, child: Text(item)))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedPoli = value;
                          });
                          applyFilters();
                        },
                      ),
                    ),
                    Spacer()
                  ],
                ),
              ),
              SizedBox(
                height: 12,
              ),
              Expanded(
                child: PaginatedDataTable2(
                    sortColumnIndex: sortColumnIndex,
                    sortAscending: sortAscending,

                    // style
                    headingTextStyle: AppStyles.sidebarText.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppStyles.textColor),
                    headingRowColor: WidgetStateProperty.resolveWith(
                        (states) => AppStyles.greyColor),
                    headingRowDecoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(12),
                            topRight: Radius.circular(12))),
                    dataTextStyle: AppStyles.contentText
                        .copyWith(color: AppStyles.textColor),
                    minWidth: 768,
                    dividerThickness: 0,
                    horizontalMargin: 12,
                    dataRowHeight: 56,
                    columnSpacing: 12,

                    // pagination
                    showFirstLastButtons: true,
                    renderEmptyRowsInTheEnd: false,
                    rowsPerPage: rowsPerPage,
                    availableRowsPerPage: [10, 25, 50, 100],
                    onRowsPerPageChanged: (value) {
                      if (value != null && [10, 25, 50, 100].contains(value)) {
                        setState(() {
                          rowsPerPage = value;
                        });
                      }
                    },

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
                      DataColumn(label: Text('No.')),
                      DataColumn(label: Text('Nama Pasien'), onSort: onSort),
                      DataColumn(label: Text('Tanggal Pembayaran')),
                      DataColumn(label: Text('Poli Tujuan')),
                      DataColumn(label: Center(child: Text('Rincian'))),
                    ],
                    source: RowSource(
                        widget.navigateToChild,
                        myData: filteredList,
                        count: filteredList.length,
                        context)),
              ),
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
  final Function(int) navigateToChild;
  final BuildContext context;

  RowSource(this.navigateToChild, this.context,
      {required this.myData, required this.count});

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
          DataCell(Text(data['tanggal'])),
          DataCell(Text(data['poli'])),
          DataCell(Center(
              child: InkWell(
            onTap: () {
              showDialog(
                  context: context, builder: (context) => DetailRiwayat());
            },
            child: TheButton(
              text: "Lihat Rincian",
              color: AppStyles.secondaryColor,
              isIcon: true,
              icon: Icons.menu_open_rounded,
              border: true,
              textColor: AppStyles.secondaryColor,
              iconColor: AppStyles.secondaryColor,
              horiPadding: 8.5,
              vertPadding: 4,
            ),
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
