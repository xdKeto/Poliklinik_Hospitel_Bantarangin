import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:poli_admin/base/utils/app_styles.dart';

class IconDropdown extends StatefulWidget {
  const IconDropdown({super.key});

  @override
  State<IconDropdown> createState() => _IconDropdownState();
}

class _IconDropdownState extends State<IconDropdown> {
  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        customButton: Icon(Icons.more_horiz),
        items: MenuItems.items
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
  const MenuItem({
    required this.text,
  });

  final String text;
}

class MenuItems {
  static const List<MenuItem> items = [dataPasien, gelangPasien, labelPasien];

  static const dataPasien = MenuItem(text: 'Cetak Data Pasien');
  static const gelangPasien = MenuItem(text: 'Cetak Gelang Pasien');
  static const labelPasien = MenuItem(text: 'Cetak Label Pasien');

  static Widget buildItem(MenuItem item) {
    return Row(
      children: [
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
        break;
      case MenuItems.gelangPasien:
        break;
      case MenuItems.labelPasien:
        break;
    }
  }
}
