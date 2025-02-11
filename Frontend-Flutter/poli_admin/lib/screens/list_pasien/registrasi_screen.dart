import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:poli_admin/base/global_widgets/global_top_bar.dart';
import 'package:poli_admin/base/global_widgets/label_required.dart';
import 'package:poli_admin/base/global_widgets/the_button.dart';
import 'package:poli_admin/base/utils/app_routes.dart';
import 'package:poli_admin/base/utils/app_styles.dart';

class RegistrasiScreen extends StatefulWidget {
  final VoidCallback onMenuPressed;
  final bool isExpanded;
  const RegistrasiScreen(
      {super.key, required this.onMenuPressed, required this.isExpanded});

  @override
  State<RegistrasiScreen> createState() => _RegistrasiScreenState();
}

class _RegistrasiScreenState extends State<RegistrasiScreen> {
  final List<String> listPoli = [
    "Poli Gigi",
    "Poli Anak",
    "Poli Umum",
    "Poli Obgyn "
  ];

  final List<String> listGender = ["Laki-Laki", "Perempuan"];

  String? selectedValue;

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyles.backgroundColor,
      appBar: GlobalTopBar(
          onMenuPressed: widget.onMenuPressed,
          title: 'Registrasi',
          isExpanded: widget.isExpanded),
      body: Form(
        key: _formKey,
        child: Center(
          child: ListView(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 22, horizontal: 27),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                  decoration: AppStyles.whiteBox,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      LabelRequired(
                          text: 'Pilih Poliklinik',
                          style: AppStyles.contentText
                              .copyWith(fontWeight: FontWeight.bold)),
                      SizedBox(
                        height: 12,
                      ),
                      SizedBox(
                        width: 650,
                        child: DropdownButtonFormField2<String>(
                          isExpanded: true,
                          decoration: AppStyles.formBox,
                          hint: Text('-- Pilih Poliklinik --'),
                          items: listPoli
                              .map((item) => DropdownMenuItem<String>(
                                  value: item, child: Text(item)))
                              .toList(),
                          validator: (value) {
                            if (value == null) {
                              return 'Pilih Poliklinik';
                            }
                            return null;
                          },
                          onChanged: (value) {},
                          onSaved: (newValue) {
                            selectedValue = newValue.toString();
                          },
                          buttonStyleData: ButtonStyleData(
                              padding: EdgeInsets.only(right: 8)),
                          iconStyleData: const IconStyleData(
                            icon: Icon(
                              Icons.arrow_drop_down,
                              color: Colors.black45,
                            ),
                            iconSize: 24,
                          ),
                          dropdownStyleData: DropdownStyleData(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          menuItemStyleData: const MenuItemStyleData(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.only(left: 27, right: 27, top: 8, bottom: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Data Pasien',
                      style: AppStyles.tambahanText
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                      decoration: AppStyles.whiteBox,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    LabelRequired(
                                        text: 'Nama Lengkap',
                                        style: AppStyles.contentText.copyWith(
                                            fontWeight: FontWeight.bold)),
                                    TextFormField(
                                      cursorColor: Colors.black,
                                      decoration: AppStyles.formBox.copyWith(
                                          hintText: 'Nama Lengkap',
                                          hintStyle: TextStyle(
                                              color: AppStyles.greyColor2)),
                                      onChanged: (value) {},
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 16,
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    LabelRequired(
                                        text: 'Jenis Kelamin',
                                        style: AppStyles.contentText.copyWith(
                                            fontWeight: FontWeight.bold)),
                                    DropdownButtonFormField2<String>(
                                      isExpanded: true,
                                      decoration: AppStyles.formBox.copyWith(
                                          contentPadding: EdgeInsets.zero),
                                      hint: Text('-- Pilih jenis kelamin --'),
                                      items: listGender
                                          .map((item) =>
                                              DropdownMenuItem<String>(
                                                  value: item,
                                                  child: Text(item)))
                                          .toList(),
                                      validator: (value) {
                                        if (value == null) {
                                          return 'Pilih jenis kelamin';
                                        }
                                        return null;
                                      },
                                      onChanged: (value) {},
                                      onSaved: (newValue) {
                                        selectedValue = newValue.toString();
                                      },
                                      buttonStyleData: ButtonStyleData(
                                          padding: EdgeInsets.only(right: 8)),
                                      iconStyleData: const IconStyleData(
                                        icon: Icon(
                                          Icons.arrow_drop_down,
                                          color: Colors.black45,
                                        ),
                                        iconSize: 24,
                                      ),
                                      dropdownStyleData: DropdownStyleData(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                      ),
                                      menuItemStyleData:
                                          const MenuItemStyleData(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 16),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    LabelRequired(
                                        text: 'Tempat Lahir',
                                        style: AppStyles.contentText.copyWith(
                                            fontWeight: FontWeight.bold)),
                                    TextFormField(
                                      cursorColor: Colors.black,
                                      decoration: AppStyles.formBox.copyWith(
                                          hintText: 'e.g: Surabaya',
                                          hintStyle: TextStyle(
                                              color: AppStyles.greyColor2)),
                                      onChanged: (value) {},
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 16,
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    LabelRequired(
                                        text: 'Tanggal Lahir',
                                        style: AppStyles.contentText.copyWith(
                                            fontWeight: FontWeight.bold)),
                                    TextFormField(
                                      readOnly: true,
                                      cursorColor: Colors.black,
                                      decoration: AppStyles.formBox.copyWith(
                                        hintText: 'DD/MM/YY',
                                        hintStyle: TextStyle(
                                            color: AppStyles.greyColor2),
                                        suffixIcon: Icon(Icons.date_range),
                                      ),
                                      onChanged: (value) {},
                                      onTap: () async {
                                        DateTime? pickedDate =
                                            await showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime(2000),
                                          lastDate: DateTime(2100),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    LabelRequired(
                                        text: 'Nomor NIK / KTP',
                                        style: AppStyles.contentText.copyWith(
                                            fontWeight: FontWeight.bold)),
                                    TextFormField(
                                      cursorColor: Colors.black,
                                      decoration: AppStyles.formBox.copyWith(
                                          hintText: 'Nomor NIK / KTP',
                                          hintStyle: TextStyle(
                                              color: AppStyles.greyColor2)),
                                      onChanged: (value) {},
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 16,
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    LabelRequired(
                                        text: 'Nomor HP',
                                        style: AppStyles.contentText.copyWith(
                                            fontWeight: FontWeight.bold)),
                                    TextFormField(
                                      cursorColor: Colors.black,
                                      decoration: AppStyles.formBox.copyWith(
                                          hintText: 'Nomor HP',
                                          hintStyle: TextStyle(
                                              color: AppStyles.greyColor2)),
                                      onChanged: (value) {},
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    LabelRequired(
                                        text: 'Alamat Rumah',
                                        style: AppStyles.contentText.copyWith(
                                            fontWeight: FontWeight.bold)),
                                    TextFormField(
                                      maxLines: 2,
                                      cursorColor: Colors.black,
                                      decoration: AppStyles.formBox.copyWith(
                                          hintText: 'Alamat Rumah',
                                          hintStyle: TextStyle(
                                              color: AppStyles.greyColor2)),
                                      onChanged: (value) {},
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    LabelRequired(
                                        text: 'Kelurahan',
                                        style: AppStyles.contentText.copyWith(
                                            fontWeight: FontWeight.bold)),
                                    TextFormField(
                                      cursorColor: Colors.black,
                                      decoration: AppStyles.formBox.copyWith(
                                          hintText: 'Keluarahan',
                                          hintStyle: TextStyle(
                                              color: AppStyles.greyColor2)),
                                      onChanged: (value) {},
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 16,
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    LabelRequired(
                                        text: 'Kecamatan',
                                        style: AppStyles.contentText.copyWith(
                                            fontWeight: FontWeight.bold)),
                                    TextFormField(
                                      cursorColor: Colors.black,
                                      decoration: AppStyles.formBox.copyWith(
                                          hintText: 'Kecamatan',
                                          hintStyle: TextStyle(
                                              color: AppStyles.greyColor2)),
                                      onChanged: (value) {},
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TheButton(
                                text: 'Kembali',
                                color: AppStyles.greyBtnColor,
                                iconColor: AppStyles.greyBtnColor,
                                textColor: AppStyles.greyBtnColor,
                                border: true,
                                isIcon: true,
                                icon: Icons.arrow_back,
                                onTapFunc: () {
                                  Navigator.pushReplacementNamed(
                                      context, AppRoutes.homeScreen);
                                },
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              TheButton(
                                text: 'Cetak Antrian',
                                color: AppStyles.accentColor,
                                iconColor: AppStyles.accentColor,
                                textColor: AppStyles.accentColor,
                                border: true,
                                isIcon: true,
                                icon: Icons.print,
                                onTapFunc: () {},
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 8,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
