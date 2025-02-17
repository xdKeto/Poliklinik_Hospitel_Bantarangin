import 'package:data_table_2/data_table_2.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:poli_admin/base/global_widgets/global_top_bar.dart';
import 'package:poli_admin/screens/list_pasien/widgets/status_box.dart';
import 'package:poli_admin/base/global_widgets/the_button.dart';
import 'package:poli_admin/base/utils/app_styles.dart';
import 'package:poli_admin/dummy/data.dart';
import 'package:poli_admin/screens/list_pasien/widgets/icon_dropdown.dart';

class ListPasienScreen extends StatefulWidget {
<<<<<<< HEAD
  const ListPasienScreen(
      {super.key});
=======
  final VoidCallback onMenuPressed;
  final bool isExpand;
  final Function(int) navigateToChild;
  const ListPasienScreen(
      {super.key,
      required this.onMenuPressed,
      required this.isExpand,
      required this.navigateToChild});
>>>>>>> f56544f7a71d942398a3e7b997fc6a4d2ea549d5

  @override
  State<ListPasienScreen> createState() => _ListPasienScreenState();
}

class _ListPasienScreenState extends State<ListPasienScreen> {
  final List<String> listStatus = [
    '-- Semua Status --',
    'Menunggu',
    'Konsultasi',
    'Selesai'
  ];

  String? selectedStatus;

  bool sortAscending = true;
  int sortColumnIndex = 0;
  int rowsPerPage = 10;
  List<Map<String, dynamic>> filteredList = [];
  final TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredList = List.from(pasienList);
  }

  void applyFilters() {
    setState(() {
      filteredList = pasienList.where((pasien) {
        bool statusMatch = selectedStatus == "-- Semua Status --" ||
            selectedStatus == null ||
            pasien['status'] == selectedStatus;
        return statusMatch;
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

  void onSearch(String query) {
    setState(() {
      filteredList = pasienList.where((pasien) {
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
<<<<<<< HEAD
    return Scaffold(
      backgroundColor: AppStyles.backgroundColor,
      appBar: GlobalTopBar(
        title: 'List Pasien',
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
                  TheButton(
                    text: "Registrasi",
                    color: AppStyles.accentColor,
                    isIcon: true,
                    icon: FluentIcons.clipboard_edit_20_regular,
                    onTapFunc: () {
                      
                    },
                    horiPadding: 16,
                    vertPadding: 9,
                    border: true,
                    iconColor: AppStyles.accentColor,
                    textColor: AppStyles.accentColor,
                    borderRad: 10,
                  ),

                  SizedBox(
                    width: screenWidth * 0.01,
                  ),
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
                          filteredList = List.from(pasienList);
                        });
                      },
                      icon: Icon(Icons.refresh)),
                ],
=======
    return SelectionArea(
      child: Scaffold(
        backgroundColor: AppStyles.backgroundColor,
        appBar: GlobalTopBar(
          onMenuPressed: widget.onMenuPressed,
          title: 'List Pasien',
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
                    InkWell(
                      onTap: () {
                        widget.navigateToChild(1);
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
                      ),
                    ),
                    SizedBox(
                      width: screenWidth * 0.01,
                    ),
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
                    SizedBox(
                      width: 300,
                      child: DropdownButtonFormField2<String>(
                        // isExpanded: true,
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
                    IconButton(
                        onPressed: () {
                          setState(() {
                            controller.clear();
                            filteredList = List.from(pasienList);
                          });
                        },
                        icon: Icon(Icons.refresh)),
                  ],
                ),
>>>>>>> f56544f7a71d942398a3e7b997fc6a4d2ea549d5
              ),
              SizedBox(height: 12),
              Expanded(
                child: PaginatedDataTable2(
                  sortColumnIndex: sortColumnIndex,
                  sortAscending: sortAscending,

                  // style
                  headingTextStyle: AppStyles.sidebarText.copyWith(
                      fontWeight: FontWeight.w600, color: AppStyles.textColor),
                  headingRowColor: WidgetStateProperty.resolveWith(
                      (states) => AppStyles.greyColor),
                  headingRowDecoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(12))),
                  dataTextStyle: AppStyles.contentText
                      .copyWith(color: AppStyles.textColor),
                  minWidth: 768,
                  empty: Center(
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
                    DataColumn(label: Text('No. Antrian'), onSort: onSort),
                    DataColumn(label: Text('No. Rekam Medis')),
                    DataColumn(label: Text('Nama Pasien'), onSort: onSort),
                    DataColumn(label: Text('Poli Tujuan')),
                    DataColumn(label: Center(child: Text('Status'))),
                    DataColumn(label: Center(child: Text('Aksi'))),
                  ],
                  source: RowSource(
                      myData: filteredList, count: filteredList.length),
                ),
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
          DataCell(Text(data['no_antrian'].toString())),
          DataCell(Text(data['no_rekam_medis'])),
          DataCell(Text(data['nama_pasien'])),
          DataCell(Text(data['poli_tujuan'])),
          DataCell(Center(child: StatusBox(status: data['status']))),
          DataCell(Center(child: IconDropdown())),
        ]);
  }

  @override
  bool get isRowCountApproximate => false;
  @override
  int get rowCount => count;
  @override
  int get selectedRowCount => 0;
}
