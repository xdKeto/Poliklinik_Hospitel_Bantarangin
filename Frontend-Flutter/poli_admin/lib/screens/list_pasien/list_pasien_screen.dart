import 'package:data_table_2/data_table_2.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:poli_admin/base/global_widgets/global_top_bar.dart';
import 'package:poli_admin/base/global_widgets/the_button.dart';
import 'package:poli_admin/base/utils/app_styles.dart';
import 'package:poli_admin/dummy/data.dart';

class ListPasienScreen extends StatefulWidget {
  final VoidCallback onMenuPressed;
  const ListPasienScreen({super.key, required this.onMenuPressed});

  @override
  State<ListPasienScreen> createState() => _ListPasienScreenState();
}

class _ListPasienScreenState extends State<ListPasienScreen> {
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
      filteredList = pasienList
          .where((pasien) =>
              pasien['nama_pasien'].toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppStyles.backgroundColor,
      appBar: GlobalTopBar(
          onMenuPressed: widget.onMenuPressed, title: 'List Pasien'),
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
                        filteredList = List.from(pasienList);
                      });
                    },
                    icon: Icon(Icons.refresh)),
                SizedBox(
                  width: screenWidth * 0.5,
                ),
                TheButton(
                  text: "Registrasi",
                  color: AppStyles.accentColor,
                  isIcon: true,
                  icon: FluentIcons.clipboard_edit_20_regular,
                )
              ],
            ),
            SizedBox(height: 12),
            DropdownButton<int>(
              value: rowsPerPage,
              items: [10, 25, 50, 100]
                  .map(
                      (e) => DropdownMenuItem(value: e, child: Text('$e Rows')))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  rowsPerPage = value!;
                });
              },
            ),
            Expanded(
              child: PaginatedDataTable2(
                sortColumnIndex: sortColumnIndex,
                sortAscending: sortAscending,
                rowsPerPage: 10,
                columnSpacing: 12,
                availableRowsPerPage: [10, 25, 50, 100],
                columns: [
                  DataColumn(label: Text('No. Antrian'), onSort: onSort),
                  DataColumn(label: Text('No. Rekam Medis'), onSort: onSort),
                  DataColumn(label: Text('Nama Pasien'), onSort: onSort),
                  DataColumn(label: Text('Poli Tujuan')),
                  DataColumn(label: Text('Status')),
                  DataColumn(label: Text('Aksi')),
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
      DataCell(Text(data['no_antrian'].toString())),
      DataCell(Text(data['no_rekam_medis'])),
      DataCell(Text(data['nama_pasien'])),
      DataCell(Text(data['poli_tujuan'])),
      DataCell(Text(data['status'])),
      DataCell(IconButton(icon: Icon(Icons.menu), onPressed: () {})),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;
  @override
  int get rowCount => count;
  @override
  int get selectedRowCount => 0;
}
