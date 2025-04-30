import 'dart:async';

import 'package:data_table_2/data_table_2.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:poli_admin/base/backend/class/antrian_pasien.dart';
import 'package:poli_admin/base/backend/data_controller.dart';
import 'package:poli_admin/base/global_widgets/global_top_bar.dart';
import 'package:poli_admin/screens/list_pasien/widgets/status_box.dart';
import 'package:poli_admin/base/global_widgets/the_button.dart';
import 'package:poli_admin/base/utils/app_styles.dart';
import 'package:poli_admin/screens/list_pasien/widgets/icon_dropdown.dart';

class ListPasienScreen extends StatefulWidget {
  final VoidCallback? toggleSidebar;
  final bool isExpand;
  final Function(int) navigateToPage;
  const ListPasienScreen({
    super.key,
    this.toggleSidebar,
    required this.isExpand,
    required this.navigateToPage,
    
  });

  @override
  State<ListPasienScreen> createState() => _ListPasienScreenState();
}

class _ListPasienScreenState extends State<ListPasienScreen> {
  late bool priv = false;
  String? selectedStatus;
  bool sortAscending = true;
  int sortColumnIndex = 0;
  int rowsPerPage = 10;
  Timer? refreshData;

  late List<String> listStatus = [];
  List<AntrianPasien> filteredList = [];
  final TextEditingController controller = TextEditingController();
  final DataController dataController = DataController();
  bool isLoading = true;
  bool firstLoad = true;

  @override
  void initState() {
    super.initState();
    listPriv();

    urutan();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // if (firstLoad) {
    //   refreshData =
    //       Timer.periodic(Duration(seconds: 5), (timer) => fetchData());
    // }
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> urutan() async {
    await fetchData();
    await applyFilters();
  }

  Future<void> fetchData() async {
    setState(() {
      isLoading = true;
    });

    try {
      if (dataController.statusAntrian.isEmpty) {
        await dataController.fetchListStatus();
      }

      if (firstLoad) {
        await dataController.fetchAntrianToday();
        firstLoad = false;
      }

      setState(() {
        listStatus = ['-- Semua Status --'];
        for (var status in dataController.statusAntrian) {
          listStatus.add(status.status);
        }

        isLoading = false;
      });
    } catch (e) {
      print('error di fetching data: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  void listPriv() async {
    var temp = await DataController().cekPriv(1);
    setState(() {
      priv = temp;
    });
  }

  Future<void> applyFilters() async {
    setState(() {
      if (selectedStatus == "-- Semua Status --" || selectedStatus == null) {
        filteredList = List.from(dataController.antrianToday);
      } else {
        filteredList = dataController.antrianToday
            .where((antrian) => antrian.status == selectedStatus)
            .toList();
      }

      filteredList.sort((a, b) => a.priorityOrder.compareTo(b.priorityOrder));
      // print(filteredList);
      if (controller.text.isNotEmpty) {
        onSearch(controller.text);
      }
    });
  }

  void onSearch(String query) {
    setState(() {
      List<AntrianPasien> baseList;
      if (selectedStatus == "-- Semua Status --" || selectedStatus == null) {
        baseList = List.from(dataController.antrianToday);
      } else {
        baseList = dataController.antrianToday
            .where((antrian) => antrian.status == selectedStatus)
            .toList();
      }

      String searchQuery = query.toLowerCase();
      filteredList = baseList.where((antrian) {
        String namaPasien = antrian.nama.toLowerCase();
        String idRm = antrian.idRm.toString().toLowerCase();

        return namaPasien.contains(searchQuery) || idRm.contains(searchQuery);
      }).toList();

      filteredList.sort((a, b) => a.priorityOrder.compareTo(b.priorityOrder));
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return SelectionArea(
      child: Scaffold(
        backgroundColor: AppStyles.backgroundColor,
        appBar: GlobalTopBar(
          title: 'List Pasien',
          toggleSidebar: widget.toggleSidebar,
          isExpand: widget.isExpand,
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
                    priv
                        ? Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  widget.navigateToPage(3);
                                },
                                child: TheButton(
                                  text: "Registrasi",
                                  color: AppStyles.accentColor,
                                  isIcon: true,
                                  icon: FluentIcons.clipboard_edit_20_regular,
                                  horiPadding: 13,
                                  vertPadding: 7,
                                  border: true,
                                  iconColor: AppStyles.accentColor,
                                  textColor: AppStyles.accentColor,
                                  borderRad: 10,
                                  hoverIcon:
                                      FluentIcons.clipboard_edit_20_filled,
                                ),
                              ),
                              SizedBox(
                                width: screenWidth * 0.01,
                              ),
                            ],
                          )
                        : SizedBox.shrink(),
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
                    SizedBox(
                      width: 300,
                      child: DropdownButtonFormField2<String>(
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
                  child: StreamBuilder<List<AntrianPasien>>(
                stream: dataController.antrianStream,
                initialData: dataController.antrianToday,
                builder: (context, snapshot) {
                  return PaginatedDataTable2(
                    sortColumnIndex: sortColumnIndex,
                    sortAscending: sortAscending,
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
                    empty: (isLoading && dataController.antrianToday.isEmpty)
                        ? Center(
                            child: CircularProgressIndicator(
                            color: AppStyles.primaryColor,
                          ))
                        : Center(
                            child: Text(
                              'Tidak ada Data',
                              style: AppStyles.subheadingText
                                  .copyWith(fontWeight: FontWeight.bold),
                            ),
                          ),
                    dividerThickness: 0,
                    horizontalMargin: 12,
                    dataRowHeight: 56,
                    columnSpacing: 12,
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
                      DataColumn(
                        label: Text('Poli Tujuan'),
                      ),
                      DataColumn(
                        label: Text('No. Antrian'),
                      ),
                      DataColumn(
                        label: Text('No. Rekam Medis'),
                      ),
                      DataColumn(
                        label: Text('Nama Pasien'),
                      ),
                      DataColumn(label: Center(child: Text('Status'))),
                      DataColumn(label: Center(child: Text('Aksi'))),
                    ],
                    source: AntrianRowSource(
                        antrianData: filteredList, count: filteredList.length),
                  );
                },
              )),
            ],
          ),
        ),
      ),
    );
  }
}

class AntrianRowSource extends DataTableSource {
  final List<AntrianPasien> antrianData;
  final int count;

  AntrianRowSource({required this.antrianData, required this.count});

  @override
  DataRow? getRow(int index) {
    if (index >= antrianData.length) return null;
    final data = antrianData[index];
    return DataRow(
        color: WidgetStateProperty.resolveWith<Color?>(
          (Set<WidgetState> states) {
            return Colors.white;
          },
        ),
        cells: [
          DataCell(Text(data.namaPoli)),
          DataCell(Text(data.nomorAntrian.toString())),
          DataCell(Text(data.idRm)),
          DataCell(Text(data.nama)),
          DataCell(Center(child: StatusBox(status: data.status))),
          DataCell(Center(
              child: IconDropdown(status: data.status, id: data.idAntrian))),
        ]);
  }

  @override
  bool get isRowCountApproximate => false;
  @override
  int get rowCount => count;
  @override
  int get selectedRowCount => 0;
}
