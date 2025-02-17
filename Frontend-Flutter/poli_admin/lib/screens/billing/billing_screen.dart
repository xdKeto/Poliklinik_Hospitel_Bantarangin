import 'package:data_table_2/data_table_2.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:poli_admin/base/global_widgets/global_top_bar.dart';
import 'package:poli_admin/screens/billing/widgets/status_box.dart';
import 'package:poli_admin/base/global_widgets/the_button.dart';
import 'package:poli_admin/base/utils/app_styles.dart';
import 'package:poli_admin/dummy/data.dart';

class BillingScreen extends StatefulWidget {
<<<<<<< HEAD
  const BillingScreen(
      {super.key,});
=======
  final VoidCallback onMenuPressed;
  final bool isExpand;
  final Function(int) navigateToChild;
  const BillingScreen(
      {super.key,
      required this.onMenuPressed,
      required this.isExpand,
      required this.navigateToChild});
>>>>>>> f56544f7a71d942398a3e7b997fc6a4d2ea549d5

  @override
  State<BillingScreen> createState() => _BillingScreenState();
}

class _BillingScreenState extends State<BillingScreen> {
  final List<String> listPoli = [
    "-- Semua Poli --",
    "Poli Gigi",
    "Poli Anak",
    "Poli Umum",
    "Poli Saraf",
    "Poli Mata",
    "Poli Kulit",
  ];

  final List<String> listStatus = ['-- Semua Status --', 'Belum', 'Sudah'];

  String? selectedPoli;
  String? selectedStatus;
  String searchQuery = "";

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

  void onSearch(String query) {
    setState(() {
      filteredList = billingList.where((pasien) {
        String namaPasien = pasien['nama_pasien'];
        String noRekamMedis = pasien['no_rekam_medis'];
        String searchQuery = query.toLowerCase();

        return namaPasien.toLowerCase().contains(searchQuery) ||
            noRekamMedis.toLowerCase().contains(searchQuery);
      }).toList();
    });
  }

  void applyFilters() {
    setState(() {
      filteredList = billingList.where((pasien) {
        bool poliMatch = selectedPoli == "-- Semua Poli --" ||
            selectedPoli == null ||
            pasien['poli_tujuan'] == selectedPoli;
        bool statusMatch = selectedStatus == "-- Semua Status --" ||
            selectedStatus == null ||
            pasien['status'] == selectedStatus;
        return poliMatch && statusMatch;
      }).toList();
    });
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

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
<<<<<<< HEAD
    return Scaffold(
      backgroundColor: AppStyles.backgroundColor,
      appBar: GlobalTopBar(
        title: 'Billing',
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                left: 5,
                right: 8.0,
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: 400,
                    // flex: widget.isExpanded ? 3 : 4,
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
                  IconButton(
                      onPressed: () {
                        setState(() {
                          controller.clear();
                          filteredList = List.from(billingList);
                        });
                      },
                      icon: Icon(Icons.refresh)),
                  Spacer(),
                ],
              ),
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
                      // border: Border.all(),
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
                    DataColumn(label: Text('No.'), onSort: onSort),
                    DataColumn(label: Text('No. Rekam Medis')),
                    DataColumn(label: Text('Nama Pasien'), onSort: onSort),
                    DataColumn(label: Text('Poli Tujuan')),
                    DataColumn(label: Center(child: Text('Status'))),
                    DataColumn(label: Center(child: Text('Rincian'))),
                  ],
                  source: RowSource(myData: filteredList, count: filteredList.length)),
            ),
          ],
=======
    return SelectionArea(
      child: Scaffold(
        backgroundColor: AppStyles.backgroundColor,
        appBar: GlobalTopBar(
          onMenuPressed: widget.onMenuPressed,
          title: 'Billing',
          isExpanded: widget.isExpand,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  left: 5,
                  right: 8.0,
                ),
                child: Row(
                  children: [
                    // search
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
                        // isExpanded: true,
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
                    SizedBox(
                      width: screenWidth * 0.01,
                    ),
                    // filter by status
                    SizedBox(
                      width: 300,
                      child: DropdownButtonFormField2<String>(
                        isExpanded: true,
                        decoration: AppStyles.formBox,
                        hint: Text('-- Pilih Status --'),
                        items: listStatus
                            .map((item) => DropdownMenuItem<String>(
                                value: item, child: Text(item)))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedStatus = value;
                          });
                          applyFilters();
                        },
                      ),
                    ),
                    Spacer(),
                  ],
                ),
              ),
              SizedBox(height: 12),
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
                      DataColumn(label: Text('No. Rekam Medis')),
                      DataColumn(label: Text('Nama Pasien'), onSort: onSort),
                      DataColumn(label: Text('Poli Tujuan')),
                      DataColumn(label: Center(child: Text('Status'))),
                      DataColumn(label: Center(child: Text('Rincian'))),
                    ],
                    source: RowSource(widget.navigateToChild,
                        myData: filteredList, count: filteredList.length)),
              ),
            ],
          ),
>>>>>>> f56544f7a71d942398a3e7b997fc6a4d2ea549d5
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
<<<<<<< HEAD
    return DataRow(cells: [
      DataCell(Text((index + 1).toString())),
      DataCell(Text(data['no_rekam_medis'])),
      DataCell(Text(data['nama_pasien'])),
      DataCell(Text(data['poli_tujuan'])),
      DataCell(Center(child: StatusBox(status: data['status']))),
      DataCell(Center(
          child: TheButton(
        text: "Lihat Rincian",
        color: AppStyles.secondaryColor,
        isIcon: true,
        icon: Icons.menu_open_rounded,
        onTapFunc: () {
        },
        border: true,
        textColor: AppStyles.secondaryColor,
        iconColor: AppStyles.secondaryColor,
      ))),
    ]);
=======
    return DataRow(
        color: WidgetStateProperty.resolveWith<Color?>(
          (Set<WidgetState> states) {
            return Colors.white;
          },
        ),
        cells: [
          DataCell(Text((index + 1).toString())),
          DataCell(Text(data['no_rekam_medis'])),
          DataCell(Text(data['nama_pasien'])),
          DataCell(Text(data['poli_tujuan'])),
          DataCell(Center(child: StatusBox(status: data['status']))),
          DataCell(Center(
              child: InkWell(
            onTap: () {
              navigateToChild(1);
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
>>>>>>> f56544f7a71d942398a3e7b997fc6a4d2ea549d5
  }

  @override
  bool get isRowCountApproximate => false;
  @override
  int get rowCount => count;
  @override
  int get selectedRowCount => 0;
}
