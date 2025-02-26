import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:poli_admin/base/utils/app_styles.dart';

class IconDropdown extends StatefulWidget {
  final String status;
  const IconDropdown({super.key, required this.status});

  @override
  State<IconDropdown> createState() => _IconDropdownState();
}

class _IconDropdownState extends State<IconDropdown> {
  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        customButton: Icon(Icons.more_horiz),
        items: (widget.status.toLowerCase() == 'selesai' ||
                widget.status.toLowerCase() == 'konsultasi')
            ? MenuItems.items
                .map((item) => DropdownMenuItem<MenuItem>(
                    value: item, child: MenuItems.buildItem(item)))
                .toList()
            : (widget.status.toLowerCase() == 'menunggu')
                ? MenuItems.items2
                    .map((item) => DropdownMenuItem<MenuItem>(
                        value: item, child: MenuItems.buildItem(item)))
                    .toList()
                : MenuItems.items3
                    .map((item) => DropdownMenuItem<MenuItem>(
                        value: item, child: MenuItems.buildItem(item)))
                    .toList(),
        onChanged: (value) {
          MenuItems.onChanged(context, value as MenuItem);
        },
        dropdownStyleData: DropdownStyleData(
            width: 160,
            padding: const EdgeInsets.symmetric(vertical: 6),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              // color: Colors.redAccent,
            ),
            offset: Offset(8, 0),
            direction: DropdownDirection.left),
      ),
    );
  }
}

class MenuItem {
  const MenuItem({required this.text, required this.icon});

  final String text;
  final IconData icon;
}

class MenuItems {
  static const dataPasien = MenuItem(
      text: 'Cetak Data', icon: FluentIcons.document_one_page_16_regular);
  static const gelangPasien =
      MenuItem(text: 'Cetak Gelang', icon: FluentIcons.patient_20_regular);
  static const labelPasien =
      MenuItem(text: 'Cetak Label', icon: FluentIcons.bookmark_16_regular);
  static const tundaPasien =
      MenuItem(text: 'Tunda Antrian', icon: FluentIcons.previous_16_regular);
  static const masukAntrian = MenuItem(
      text: 'Masuk Antrian', icon: FluentIcons.people_queue_20_regular);

  // kalo selesai || konsultasi
  static const List<MenuItem> items = [dataPasien, gelangPasien, labelPasien];

  // kalo menunggu
  static const List<MenuItem> items2 = [
    dataPasien,
    gelangPasien,
    labelPasien,
    tundaPasien
  ];

  // kalo ditunda
  static const List<MenuItem> items3 = [masukAntrian];

  static Widget buildItem(MenuItem item) {
    return Row(
      children: [
        Icon(
          item.icon,
          size: 20,
        ),
        SizedBox(
          width: 4,
        ),
        Expanded(
          child: Text(
            item.text,
            style: AppStyles.contentText.copyWith(color: AppStyles.textColor),
          ),
        )
      ],
    );
  }

  static void onChanged(BuildContext context, MenuItem item) {
    switch (item) {
      case MenuItems.dataPasien:
        print('print data');
        break;
      case MenuItems.gelangPasien:
        print('print gelang');
        break;
      case MenuItems.labelPasien:
        print('print label');
        break;
      case MenuItems.tundaPasien:
        print('tunda pasien');
        break;
      case MenuItems.masukAntrian:
        print('masuk antrian');
        break;
    }
  }
}
