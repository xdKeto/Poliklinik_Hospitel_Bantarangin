import 'dart:async';

import 'package:data_table_2/data_table_2.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:poli_admin/base/backend/class/billing.dart';
import 'package:poli_admin/base/backend/data_controller.dart';
import 'package:poli_admin/base/global_widgets/global_top_bar.dart';
import 'package:poli_admin/screens/billing/widgets/status_box.dart';
import 'package:poli_admin/base/global_widgets/the_button.dart';
import 'package:poli_admin/base/utils/app_styles.dart';

class BillingScreen extends StatefulWidget {
  final VoidCallback? toggleSidebar;
  final bool isExpand;
  final Function(int) navigateToPage;
  const BillingScreen({
    super.key,
    this.toggleSidebar,
    required this.isExpand,
    required this.navigateToPage,
  });

  @override
  State<BillingScreen> createState() => _BillingScreenState();
}

class _BillingScreenState extends State<BillingScreen> {
  late List<String> listPoli = [];
  final List<String> listStatus = ['-- Semua Status --', 'Belum', 'Sudah'];

  String? selectedPoli;
  String? selectedStatus;
  String searchQuery = "";

  bool sortAscending = true;
  int sortColumnIndex = 0;
  int rowsPerPage = 10;

  List<Billing> filteredList = [];
  final TextEditingController controller = TextEditingController();
  DataController dataController = DataController();
  bool isLoading = true;
  Timer? refreshData;

  @override
  void initState() {
    super.initState();
    fetchData();

    refreshData = Timer.periodic(Duration(seconds: 10), (timer) => fetchData());
  }

  Future<void> fetchData() async {
    try {
      await dataController.fetchPoliAktif();
      await dataController.fetchBilling();

      if (mounted) {
        setState(() {
          isLoading = true;
        });
        setState(() {
          if (dataController.poliAktif.isNotEmpty) {
            listPoli.clear();
            listPoli = ["-- Semua Poliklinik --"];
            for (var poli in dataController.poliAktif) {
              listPoli.add(poli.namaPoli);
            }
          }

          filteredList = List.from(dataController.billing);
          isLoading = false;
        });
      }
    } catch (e) {
      print('error fetching billing data: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  void onSearch(String query) {
    setState(() {});
  }

  void applyFilters() {
    setState(() {});
  }

  void onSort(int columnIndex, bool ascending) {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return SelectionArea(
      child: Scaffold(
        backgroundColor: AppStyles.backgroundColor,
        appBar: GlobalTopBar(
          isExpand: widget.isExpand,
          title: 'Billing',
          toggleSidebar: widget.toggleSidebar,
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
                    SizedBox(
                      width: screenWidth * 0.01,
                    ),
                    Spacer(),
                    InkWell(
                      onTap: () {
                        setState(() {
                          controller.clear();
                          selectedStatus = '-- Semua Status --';
                          selectedPoli = '-- Semua Poliklinik --';
                          fetchData();
                        });
                      },
                      child: TheButton(
                        text: 'Refresh',
                        color: AppStyles.greyBtnColor,
                        iconColor: AppStyles.greyBtnColor,
                        textColor: AppStyles.greyBtnColor,
                        border: true,
                        isIcon: true,
                        horiPadding: 13,
                        vertPadding: 7,
                        icon: Icons.refresh,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 12),
              Expanded(
                child: (isLoading)
                    ? Center(
                        child: CircularProgressIndicator(
                        color: AppStyles.primaryColor,
                      ))
                    : PaginatedDataTable2(
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
                          if (value != null &&
                              [10, 25, 50, 100].contains(value)) {
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
                        empty: Center(
                          child: Text(
                            'Tidak ada Data',
                            style: AppStyles.subheadingText
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                        columns: [
                          DataColumn(label: Text('No.')),
                          DataColumn(label: Text('No. Rekam Medis')),
                          DataColumn(
                              label: Text('Nama Pasien'), onSort: onSort),
                          DataColumn(label: Text('Poli Tujuan')),
                          DataColumn(label: Center(child: Text('Status'))),
                          DataColumn(label: Center(child: Text('Rincian'))),
                        ],
                        source: RowSource(widget.navigateToPage,
                            myData: filteredList, count: filteredList.length)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RowSource extends DataTableSource {
  final List<Billing> myData;
  final int count;
  final Function(int) navigateToPage;

  RowSource(this.navigateToPage, {required this.myData, required this.count});

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
          DataCell(Text(data.idRm.toString())),
          DataCell(Text(data.namaPasien)),
          DataCell(Text(data.namaPoli)),
          DataCell(Center(child: StatusBox(status: data.status))),
          DataCell(Center(
              child: InkWell(
            onTap: () {
              navigateToPage(4);
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
