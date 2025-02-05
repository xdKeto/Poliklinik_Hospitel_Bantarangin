import 'package:data_table_2/data_table_2.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:poli_admin/base/global_widgets/global_top_bar.dart';
import 'package:poli_admin/base/utils/app_styles.dart';
// import 'package:poli_admin/base/utils/app_styles.dart';

class ListPasienScreen extends StatefulWidget {
  final VoidCallback onMenuPressed;
  const ListPasienScreen({super.key, required this.onMenuPressed});

  @override
  State<ListPasienScreen> createState() => _ListPasienScreenState();
}

class _ListPasienScreenState extends State<ListPasienScreen> {
  @override
  Widget build(BuildContext context) {
    final DashboardController controller = Get.put(DashboardController());
    return Scaffold(
      backgroundColor: AppStyles.backgroundColor,
      appBar: GlobalTopBar(
          onMenuPressed: widget.onMenuPressed, title: 'List Pasien'),
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                  controller: controller.searchtextController,
                  onChanged: (value) {
                    controller.searchQuery(value);
                  },
                  cursorColor: AppStyles.textColor,
                  decoration: AppStyles.formBox.copyWith(
                      hintText: 'Search', prefixIcon: Icon(Icons.search))),
              SizedBox(
                height: 12,
              ),
              Expanded(
                child: Obx(
                  () {
                    Visibility(
                      visible: false,
                      child:
                          Text(controller.filteredDatalist.length.toString()),
                    );

                    return Theme(
                      data: Theme.of(context).copyWith(
                        cardTheme: CardTheme(
                          color: Colors.white,
                          elevation: 0,
                        ),
                      ),
                      child: PaginatedDataTable2(
                        columnSpacing: 12,
                        minWidth: 786,
                        dividerThickness: 0,
                        horizontalMargin: 12,
                        dataRowHeight: 56,
                        rowsPerPage: 10,
                        availableRowsPerPage: [
                          10,
                          25,
                          50,
                          100,
                        ],
                        headingTextStyle:
                            Theme.of(context).textTheme.titleMedium,
                        headingRowColor: WidgetStateProperty.resolveWith(
                            (states) => AppStyles.greyColor),
                        headingRowDecoration: BoxDecoration(
                            border: Border.all(),
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(12),
                                topRight: Radius.circular(12))),
                        showCheckboxColumn: true,

                        // pagination
                        showFirstLastButtons: true,
                        onPageChanged: (value) {},
                        renderEmptyRowsInTheEnd: false,
                        onRowsPerPageChanged: (rows) {},

                        // sorting
                        sortAscending: controller.sortAscending.value,
                        sortArrowAlwaysVisible: true,
                        sortArrowIcon: Icons.line_axis,
                        sortColumnIndex: controller.sortColumnIndex.value,
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
                              label: Text('Nama Pasien'),
                              onSort: (columnIndex, ascending) =>
                                  controller.sortById(columnIndex, ascending)),
                          DataColumn(label: Text('No. Rekam Medis')),
                          DataColumn(label: Text('Poli Tujuan')),
                          DataColumn(
                              label: Text('No. Antrian'),
                              onSort: (columnIndex, ascending) =>
                                  controller.sortById(columnIndex, ascending)),
                          DataColumn(label: Text('Status')),
                          DataColumn(label: Text('Aksi')),
                        ],
                        source: MyData(),
                      ),
                    );
                  },
                ),
              ),
            ],
          )),
    );
  }
}

class MyData extends DataTableSource {
  final DashboardController controller = Get.put(DashboardController());

  @override
  DataRow? getRow(int index) {
    final data = controller.datalist[index];

    return DataRow2(
        onTap: () {},
        selected: controller.selectedRows[index],
        onSelectChanged: (value) =>
            controller.selectedRows[index] = value ?? false,
        cells: [
          DataCell(Text(data['Column1'] ?? '')),
          DataCell(Text(data['Column2'] ?? '')),
          DataCell(Text(data['Column3'] ?? '')),
          DataCell(Text(data['Column4'] ?? '')),
          DataCell(Text(data['Column5'] ?? '')),
          DataCell(Text(data['Column6'] ?? '')),
        ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => controller.datalist.length;

  @override
  int get selectedRowCount => 0;
}

class DashboardController extends GetxController {
  var datalist = <Map<String, String>>[].obs;
  var filteredDatalist = <Map<String, String>>[].obs;
  RxList<bool> selectedRows = <bool>[].obs;

  RxInt sortColumnIndex = 1.obs;
  RxBool sortAscending = true.obs;

  final searchtextController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    fetchDummyData();
  }

  void sortById(int sortColumnIndex, bool ascending) {
    sortAscending.value = ascending;
    datalist.sort((a, b) {
      if (ascending) {
        return datalist[0]['Column1']
            .toString()
            .toLowerCase()
            .compareTo(datalist[0]['Column1'].toString().toLowerCase());
      } else {
        return datalist[0]['Column1']
            .toString()
            .toLowerCase()
            .compareTo(datalist[0]['Column1'].toString().toLowerCase());
      }
    });

    this.sortColumnIndex.value = sortColumnIndex;
  }

  void searchQuery(String query) {
    filteredDatalist.assignAll(datalist
        .where((item) => item['Column1']!.contains(query.toLowerCase())));
  }

  void fetchDummyData() {
    selectedRows.assignAll(List.generate(36, (index) => false));

    datalist.addAll(List.generate(
        36,
        (index) => {
              'Column1': 'Data ${index + 1} - 1',
              'Column2': 'Data ${index + 1} - 2',
              'Column3': 'Data ${index + 1} - 3',
              'Column4': 'Data ${index + 1} - 4',
              'Column5': 'Data ${index + 1} - 5',
              'Column6': 'Data ${index + 1} - 6',
            }));

    filteredDatalist.addAll(List.generate(
        36,
        (index) => {
              'Column1': 'Data ${index + 1} - 1',
              'Column2': 'Data ${index + 1} - 2',
              'Column3': 'Data ${index + 1} - 3',
              'Column4': 'Data ${index + 1} - 4',
              'Column5': 'Data ${index + 1} - 5',
              'Column6': 'Data ${index + 1} - 6',
            }));
  }
}
