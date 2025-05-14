import 'dart:async';

import 'package:data_table_2/data_table_2.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:poli_admin/base/backend/class/billing.dart';
import 'package:poli_admin/base/backend/data_controller.dart';
import 'package:poli_admin/base/global_widgets/global_top_bar.dart';
import 'package:poli_admin/base/global_widgets/loading_alert.dart';
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
  final List<String> listStatus = [
    '-- Semua Status --',
    'Belum',
    'Selesai',
    'Dibatalkan',
  ];

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
  bool firstLoad = true;

  @override
  void initState() {
    super.initState();
    urutan();
  }

  Future<void> urutan() async {
    await fetchData();
    await applyFilters();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
//
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> fetchData() async {
    if (!mounted) return;
    setState(() {
      isLoading = true;
    });

    try {
      if (dataController.poliAktif.isEmpty) {
        await dataController.fetchPoliAktif();
      }

      if (firstLoad) {
        await dataController.fetchBilling();
        firstLoad = false;
      }

      if (!mounted) return;
      setState(() {
        listPoli = ['-- Semua Poliklinik --'];
        for (var poli in dataController.poliAktif) {
          listPoli.add(poli.namaPoli);
        }

        isLoading = false;
      });
    } catch (e) {
      print('error fetching billing data: $e');
      if (!mounted) return;
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> applyFilters() async {
    if (!mounted) return;
    setState(() {
      List<Billing> baseList = List.from(dataController.billing);

      if (selectedPoli != null && selectedPoli != '-- Semua Poliklinik --') {
        baseList = baseList.where((billing) => billing.namaPoli == selectedPoli).toList();
      }

      if (selectedStatus != null && selectedStatus != '-- Semua Status --') {
        baseList = baseList.where((billing) => billing.status == selectedStatus).toList();
      }

      if (controller.text.isNotEmpty) {
        onSearch(controller.text);
      }

      filteredList = baseList;
    });
  }

  void onSearch(String query) {
    if (!mounted) return;
    setState(() {
      List<Billing> baseList;
      if (selectedStatus == "-- Semua Status --" || selectedStatus == null) {
        baseList = List.from(dataController.billing);
      } else {
        baseList =
            dataController.billing.where((billing) => billing.status == selectedStatus).toList();
      }

      String searchQuery = query.toLowerCase();
      filteredList = baseList.where((billing) {
        String namaPasien = billing.namaPasien.toLowerCase();
        String idRm = billing.idRm.toString().toLowerCase();

        return namaPasien.contains(searchQuery) || idRm.contains(searchQuery);
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
                      width: 350,
                      child: DropdownButtonFormField2<String>(
                        // isExpanded: true,
                        decoration: AppStyles.formBox,
                        hint: Text('-- Pilih Poliklinik --'),
                        items: listPoli
                            .map((item) => DropdownMenuItem<String>(value: item, child: Text(item)))
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
                            .map((item) => DropdownMenuItem<String>(value: item, child: Text(item)))
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
                  child: StreamBuilder<List<Billing>>(
                stream: dataController.billingStream,
                initialData: filteredList,
                builder: (context, snapshot) {
                  return PaginatedDataTable2(
                      sortColumnIndex: sortColumnIndex,
                      sortAscending: sortAscending,

                      // style
                      headingTextStyle: AppStyles.sidebarText
                          .copyWith(fontWeight: FontWeight.w600, color: AppStyles.textColor),
                      headingRowColor:
                          WidgetStateProperty.resolveWith((states) => AppStyles.greyColor),
                      headingRowDecoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(12), topRight: Radius.circular(12))),
                      dataTextStyle: AppStyles.contentText.copyWith(color: AppStyles.textColor),
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
                      empty: (isLoading && dataController.billing.isEmpty)
                          ? Center(
                              child: CircularProgressIndicator(
                              color: AppStyles.primaryColor,
                            ))
                          : Center(
                              child: Text(
                                'Tidak ada Data',
                                style:
                                    AppStyles.subheadingText.copyWith(fontWeight: FontWeight.bold),
                              ),
                            ),
                      columns: [
                        DataColumn(label: Text('No.')),
                        DataColumn(label: Text('No. Rekam Medis')),
                        DataColumn(
                          label: Text('Nama Pasien'),
                        ),
                        DataColumn(label: Text('Poli Tujuan')),
                        DataColumn(label: Center(child: Text('Status'))),
                        DataColumn(label: Center(child: Text('Rincian'))),
                      ],
                      source: RowSource(widget.navigateToPage,
                          myData: filteredList, count: filteredList.length, context: context));
                },
              )),
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
  final BuildContext context;

  RowSource(this.navigateToPage,
      {required this.myData, required this.count, required this.context});

  @override
  DataRow? getRow(int index) {
    if (index >= myData.length) return null;
    var data = myData[index];

    DataController dataController = DataController();
    return DataRow(
        color: WidgetStateProperty.resolveWith<Color?>(
          (Set<WidgetState> states) {
            return Colors.white;
          },
        ),
        cells: [
          DataCell(Text((index + 1).toString())),
          DataCell(Text(data.idRm)),
          DataCell(Text(data.namaPasien)),
          DataCell(Text(data.namaPoli)),
          DataCell(Center(child: StatusBox(status: data.status))),
          DataCell(Center(
              child: InkWell(
            onTap: () async {
              showDialog(
                  context: context,
                  builder: (context) => LoadingAlert(),
                  barrierDismissible: false);

              try {
                final detail =
                    await dataController.fetchDetailTransaksi(data.idKunjungan.toString());
                if (detail != null) {
                  dataController.detailTransaksi = detail; 
                  if (!context.mounted) return;
                  Navigator.pop(context);
                  navigateToPage(4);
                } else {
                  if (!context.mounted) return;
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Failed to load billing details')),
                  );
                }
              } catch (e) {
                if (!context.mounted) return;
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Error: $e')),
                );
              }
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
