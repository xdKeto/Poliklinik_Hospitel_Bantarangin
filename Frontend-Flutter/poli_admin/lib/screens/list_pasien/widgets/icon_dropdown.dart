import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:poli_admin/base/backend/data_controller.dart';
import 'package:poli_admin/base/utils/app_styles.dart';

class IconDropdown extends StatefulWidget {
  final String status;
  const IconDropdown({super.key, required this.status});

  @override
  State<IconDropdown> createState() => _IconDropdownState();
}

class _IconDropdownState extends State<IconDropdown> {
  bool privData = false;
  bool privLabel = false;
  bool privGelang = false;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    listPriv();
  }

  void listPriv() async {
    var temp1 = await DataController().cekPriv(3);
    var temp2 = await DataController().cekPriv(4);
    var temp3 = await DataController().cekPriv(5);

    setState(() {
      privData = temp1;
      privLabel = temp2;
      privGelang = temp3;
      loading = false;
    });
  }

  List<MenuItem> privItems() {
    List<MenuItem> items = [];

    if (privData) {
      items.add(MenuItems.dataPasien);
    }

    if (privLabel) {
      items.add(MenuItems.labelPasien);
    }

    if (privGelang) {
      items.add(MenuItems.gelangPasien);
    }

    return items;
  }

  List<MenuItem> dropdownItems() {
    List<MenuItem> items = privItems();
    if (widget.status.toLowerCase() == 'selesai' ||
        widget.status.toLowerCase() == 'konsultasi' ||
        widget.status.toLowerCase() == 'screening') {
      return items;
    } else if (widget.status.toLowerCase() == 'menunggu') {
      return [...items, MenuItems.tundaPasien, MenuItems.batalAntrian];
    } else {
      return [MenuItems.masukAntrian, MenuItems.batalAntrian];
    }
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return LoadingAnimationWidget.horizontalRotatingDots(
          color: Colors.black, size: 20);
    }

    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        customButton: Icon(Icons.more_horiz),
        items: dropdownItems()
            .map((item) =>
                DropdownMenuItem(value: item, child: MenuItems.buildItem(item)))
            .toList(),
        onChanged: (value) {
          MenuItems.onChanged(context, value as MenuItem);
        },
        dropdownStyleData: DropdownStyleData(
            width: 180,
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
  static const batalAntrian =
      MenuItem(text: "Batalkan Antrian", icon: Icons.close);

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

  static void onChanged(BuildContext context, MenuItem item) async {
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
      case MenuItems.batalAntrian:
        print('antrian batal');
        break;
    }
  }
}
