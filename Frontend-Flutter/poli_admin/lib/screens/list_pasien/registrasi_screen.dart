import 'dart:async';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:elegant_notification/elegant_notification.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:poli_admin/base/backend/class/pasien.dart';
import 'package:poli_admin/base/backend/data_controller.dart';
import 'package:poli_admin/base/global_widgets/confirm_alert.dart';
import 'package:poli_admin/base/global_widgets/global_top_bar.dart';
import 'package:poli_admin/base/global_widgets/label_required.dart';
import 'package:poli_admin/base/global_widgets/loading_alert.dart';
import 'package:poli_admin/base/global_widgets/sucfail_alert.dart';
import 'package:poli_admin/base/global_widgets/the_button.dart';
import 'package:poli_admin/base/utils/app_routes.dart';
import 'package:poli_admin/base/utils/app_styles.dart';
import 'package:poli_admin/base/utils/config.dart';
import 'package:poli_admin/base/backend/pdf_api.dart';
import 'package:printing/printing.dart';

class RegistrasiScreen extends StatefulWidget {
  final VoidCallback? toggleSidebar;
  final bool isExpand;
  final Function(int) navigateToPage;
  const RegistrasiScreen({
    super.key,
    this.toggleSidebar,
    required this.isExpand,
    required this.navigateToPage,
  });

  @override
  State<RegistrasiScreen> createState() => _RegistrasiScreenState();
}

class _RegistrasiScreenState extends State<RegistrasiScreen> {
  String? nama = "";
  String? jenisKelamin = "";
  String? tempatLahir = "";
  String? tanggalLahir = "";
  String? nik = "";
  String? noTelp = "";
  String? alamat = "";
  String? kelurahan = "";
  String? kecamatan = "";
  String? tempatTinggal = "";
  int? idPoli = 0;
  String? keluhanUtama = "";
  bool isPost = true;

  final List<String> listPoli = [];
  final List<String> listGender = ["Laki-Laki", "Perempuan"];

  String? selectedValue;
  var selectedDate = DateTime.now();
  var parsedDate = DateTime.now();
  var tanggalcontroller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  DataController dataController = DataController();
  Timer? debouncer;

  var namaController = TextEditingController();
  var jenisKelaminController = TextEditingController();
  var tempatLahirController = TextEditingController();
  var nikController = TextEditingController();
  var noTelpController = TextEditingController();
  var alamatController = TextEditingController();
  var kelurahanController = TextEditingController();
  var kecamatanController = TextEditingController();
  var tempatTinggalController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      await dataController.fetchPoliAktif();

      setState(() {
        if (dataController.poliAktif.isNotEmpty) {
          listPoli.clear();
          for (var poli in dataController.poliAktif) {
            listPoli.add(poli.namaPoli);
          }
        }
      });
    } catch (e) {
      print("error fetching data: $e");
    }
  }

  @override
  void dispose() {
    namaController.dispose();
    jenisKelaminController.dispose();
    tempatLahirController.dispose();
    tanggalcontroller.dispose();
    nikController.dispose();
    noTelpController.dispose();
    alamatController.dispose();
    kelurahanController.dispose();
    kecamatanController.dispose();
    tempatTinggalController.dispose();
    debouncer?.cancel();
    super.dispose();
  }

  void autoFillDataPasien(Pasien pasien) {
    setState(() {
      isPost = false;
      tempatLahirController.text = pasien.tempatLahir;
      tanggalcontroller.text =
          DateFormat('yyyy-MM-dd').format(pasien.tanggalLahir);
      nikController.text = pasien.nik;
      noTelpController.text = pasien.noTelp;
      alamatController.text = pasien.alamat;
      kelurahanController.text = pasien.kelurahan;
      kecamatanController.text = pasien.kecamatan;
      tempatTinggalController.text = pasien.kotaTinggal;

      nama = pasien.nama;
      jenisKelamin = pasien.jenisKelamin;
      tanggalLahir = DateFormat('yyyy-MM-dd').format(pasien.tanggalLahir);
      nik = pasien.nik;
      noTelp = pasien.noTelp;
      tempatLahir = pasien.tempatLahir;
      alamat = pasien.alamat;
      kelurahan = pasien.kelurahan;
      kecamatan = pasien.kecamatan;
      tempatTinggal = pasien.kotaTinggal;
    });
  }

  void clearForm() {
    setState(() {
      namaController.text = "";
      tempatLahirController.text = "";
      tanggalcontroller.text = "";
      nikController.text = "";
      noTelpController.text = "";
      alamatController.text = "";
      kelurahanController.text = "";
      kecamatanController.text = "";
      tempatTinggalController.text = "";

      nama = "";
      jenisKelamin = "";
      tempatLahir = "";
      tanggalLahir = "";
      nik = "";
      noTelp = "";
      alamat = "";
      kelurahan = "";
      kecamatan = "";
      tempatTinggal = "";
      idPoli = 0;
      keluhanUtama = "";

      isPost = true;
    });
  }

  void doRegistrasi() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final context2 = context;

      Navigator.pop(context);
      showDialog(
          context: context,
          builder: (context) => LoadingAlert(),
          barrierDismissible: false);

      DataController dataController = DataController();
      ResponseRequestAPI response;

      try {
        if (isPost) {
          response = await dataController
              .apiConnector(Config.apiEndpoints['registerPasien']!(), "post", {
            "nama": nama,
            "jenis_kelamin": jenisKelamin,
            "tempat_lahir": tempatLahir,
            "tanggal_lahir": tanggalLahir,
            "nik": nik,
            "no_telp": noTelp,
            "alamat": alamat,
            "kelurahan": kelurahan,
            "kecamatan": kecamatan,
            "kota_tempat_tinggal": tempatTinggal,
            "id_poli": idPoli,
            "keluhan_utama": keluhanUtama
          });
        } else {
          // print('ini put pasien');
          // print(idPoli);
          // print(nama);
          // print(jenisKelamin);
          // print(tempatLahir);
          // print(tanggalLahir);
          // print(nik);
          // print(noTelp);
          // print(alamat);
          // print(kelurahan);
          // print(kecamatan);
          response = await dataController
              .apiConnector(Config.apiEndpoints['putPasien']!(), "put", {
            "id_poli": idPoli,
            "nama": nama,
            "jenis_kelamin": jenisKelamin,
            "tempat_lahir": tempatLahir,
            "tanggal_lahir": tanggalLahir,
            "nik": nik,
            "no_telp": noTelp,
            "alamat": alamat,
            "kelurahan": kelurahan,
            "kecamatan": kecamatan,
          });

          // cek error msg
          if (response.status != 200 &&
              response.message.contains("pasien with NIK") &&
              response.message.contains("not found")) {
            // cobak POST lagi
            setState(() {
              isPost = true;
            });

            if (!context.mounted) return;
            Navigator.pop(context2);

            showDialog(
                context: context2,
                builder: (context) => LoadingAlert(),
                barrierDismissible: false);

            // POST
            response = await dataController.apiConnector(
                Config.apiEndpoints['registerPasien']!(), "post", {
              "nama": nama,
              "jenis_kelamin": jenisKelamin,
              "tempat_lahir": tempatLahir,
              "tanggal_lahir": tanggalLahir,
              "nik": nik,
              "no_telp": noTelp,
              "alamat": alamat,
              "kelurahan": kelurahan,
              "kecamatan": kecamatan,
              "kota_tempat_tinggal": tempatTinggal,
              "id_poli": idPoli,
              "keluhan_utama": keluhanUtama
            });
          }
        }
      } on Exception catch (e) {
        throw Exception("failed to register pasien: $e");
      }

      if (!context.mounted) return;
      Navigator.pop(context2); // pop loading
      if (response.status == 200) {
        final responseData = response.data;
        final int noAntrian = responseData['nomor_antrian'] ?? 0;

        final now = DateTime.now();
        final String tanggal = DateFormat('dd MMMM yyyy').format(now);
        final String jam = DateFormat('HH:mm').format(now);

        final poli = dataController.poliAktif
            .firstWhere((poli) => poli.idPoli == idPoli);

        // generate  pdf
        final pdfData = await PdfApi.cetakAntrian(
            noAntrian,
            nama!,
            jenisKelamin!,
            DateTime.parse(tanggalLahir!),
            tanggal,
            jam,
            poli.namaPoli);

        // pop up buat print
        await Printing.layoutPdf(
          onLayout: (format) => pdfData,
        );

        if (!context.mounted) return;
        showDialog(
            context: context2,
            builder: (context) {
              Future.delayed(Duration(seconds: 1), () {
                if (context.mounted) Navigator.pop(context);
              });

              return SucfailAlert(
                  isSuccess: true,
                  boldText: "Registrasi Sukses",
                  italicText: "pasien berhasil registrasi");
            }).then((_) async {
          if (context.mounted) {
            Navigator.pushReplacementNamed(context2, AppRoutes.dashboard);
          }
        });
      } else {
        showDialog(
          context: context2,
          builder: (context) => SucfailAlert(
            isSuccess: false,
            boldText: "Registrasi Gagal",
            italicText: response.message,
          ),
        );
      }
    } else {
      Navigator.pop(context);
      ElegantNotification.error(
        title: Text(
          'Form Error',
          style: AppStyles.sidebarText.copyWith(fontWeight: FontWeight.bold),
        ),
        description: Text(
          'Pastikan semua field telah terisi',
          style: AppStyles.contentText,
        ),
        icon: Icon(
          FluentIcons.error_circle_16_regular,
          color: AppStyles.redColor,
          size: 48,
        ),
        width: 400,
        height: 75,
        toastDuration: Duration(seconds: 5),
      ).show(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SelectionArea(
      child: Scaffold(
        backgroundColor: AppStyles.backgroundColor,
        appBar: GlobalTopBar(
          toggleSidebar: widget.toggleSidebar,
          isExpand: widget.isExpand,
          title: 'Registrasi',
        ),
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
                            decoration: AppStyles.formBox
                                .copyWith(contentPadding: EdgeInsets.zero),
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
                            onChanged: (value) {
                              // idPoli = 1;
                              try {
                                final poli =
                                    dataController.poliAktif.firstWhere(
                                  (poli) => poli.namaPoli == value,
                                );
                                setState(() {
                                  idPoli = poli.idPoli;
                                });
                              } catch (e) {
                                print("Error setting idPoli: $e");
                              }
                            },
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Data Pasien',
                            style: AppStyles.tambahanText
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                          InkWell(
                            onTap: () {
                              clearForm();
                            },
                            child: TheButton(
                              text: 'Clear Form',
                              color: AppStyles.primaryColor,
                              iconColor: AppStyles.primaryColor,
                              textColor: AppStyles.primaryColor,
                              border: true,
                              isIcon: false,
                            ),
                          ),
                        ],
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
                                      TypeAheadField<Pasien>(
                                        builder:
                                            (context, controller, focusNode) {
                                          namaController = controller;
                                          return TextField(
                                            controller: controller,
                                            focusNode: focusNode,
                                            cursorColor: Colors.black,
                                            decoration: AppStyles.formBox
                                                .copyWith(
                                                    hintText: 'Nama Lengkap',
                                                    hintStyle: TextStyle(
                                                        color: AppStyles
                                                            .greyColor2)),
                                            onChanged: (value) {
                                              nama = value;
                                            },
                                          );
                                        },
                                        itemBuilder:
                                            (context, Pasien suggestions) {
                                          return ListTile(
                                            title: Text(
                                              suggestions.nama,
                                              overflow: TextOverflow.ellipsis,
                                              style: AppStyles.sidebarText
                                                  .copyWith(
                                                      fontWeight:
                                                          FontWeight.bold),
                                            ),
                                            subtitle: Text(
                                                "NIK - ${suggestions.nik}"),
                                          );
                                        },
                                        onSelected: (value) {
                                          namaController.text = value.nama;
                                          autoFillDataPasien(value);
                                        },
                                        suggestionsCallback: (search) async {
                                          if (search.length < 2) return [];

                                          try {
                                            return await dataController
                                                .fetchAllPasien(search, "1");
                                          } catch (e) {
                                            print('error fetching query: $e');
                                            return [];
                                          }
                                        },
                                        loadingBuilder: (context) => Padding(
                                          padding: EdgeInsets.all(8),
                                          child: Center(
                                              child: LoadingAnimationWidget
                                                  .waveDots(
                                                      color: Colors.black,
                                                      size: 48)),
                                        ),
                                        errorBuilder: (context, error) =>
                                            Padding(
                                          padding: EdgeInsets.all(8),
                                          child: Center(child: Text('Error!')),
                                        ),
                                        emptyBuilder: (context) => Padding(
                                          padding: EdgeInsets.all(8),
                                          child: Text('No Data'),
                                        ),
                                        constraints:
                                            BoxConstraints(maxHeight: 350),
                                        decorationBuilder: (context, child) {
                                          return Container(
                                            decoration: AppStyles.whiteBox
                                                .copyWith(
                                                    border:
                                                        Border.all(
                                                            color: Colors.black,
                                                            width: 1),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                            child: child,
                                          );
                                        },
                                      )
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
                                        value: jenisKelamin != null &&
                                                jenisKelamin!.isNotEmpty
                                            ? jenisKelamin
                                            : null,
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
                                        onChanged: (value) {
                                          jenisKelamin = value;
                                        },
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
                                        controller: tempatLahirController,
                                        cursorColor: Colors.black,
                                        decoration: AppStyles.formBox.copyWith(
                                            hintText: 'e.g: Surabaya',
                                            hintStyle: TextStyle(
                                                color: AppStyles.greyColor2)),
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return "Field tempat lahir pasien harus terisi";
                                          }

                                          return null;
                                        },
                                        onChanged: (value) {
                                          tempatLahir = value;
                                        },
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
                                        controller: tanggalcontroller,
                                        readOnly: true,
                                        cursorColor: Colors.black,
                                        decoration: AppStyles.formBox.copyWith(
                                          hintText: 'DD/MM/YY',
                                          hintStyle: TextStyle(
                                              color: AppStyles.greyColor2),
                                          suffixIcon: Icon(Icons.date_range),
                                        ),
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return "Field tanggal lahir pasien harus terisi";
                                          }

                                          return null;
                                        },
                                        onChanged: (value) {
                                          tanggalLahir = value;
                                        },
                                        onTap: () async {
                                          DateTime? pickedDate =
                                              await showDatePicker(
                                            builder: (context, child) {
                                              return Theme(
                                                data:
                                                    Theme.of(context).copyWith(
                                                  colorScheme:
                                                      ColorScheme.light(
                                                          primary: AppStyles
                                                              .primaryColor,
                                                          onPrimary:
                                                              Colors.white,
                                                          onSurface: AppStyles
                                                              .primaryColor),
                                                  textButtonTheme:
                                                      TextButtonThemeData(
                                                    style: TextButton.styleFrom(
                                                        foregroundColor:
                                                            AppStyles
                                                                .primaryColor),
                                                  ),
                                                ),
                                                child: child!,
                                              );
                                            },
                                            context: context,
                                            initialDate: DateTime.now(),
                                            firstDate: DateTime(2000),
                                            lastDate: DateTime(2100),
                                          );

                                          if (pickedDate != null &&
                                              pickedDate != selectedDate) {
                                            setState(() {
                                              selectedDate = pickedDate;

                                              tanggalcontroller.text =
                                                  DateFormat('yyyy-MM-dd')
                                                      .format(selectedDate);
                                              tanggalLahir =
                                                  tanggalcontroller.text;
                                            });
                                          }
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
                                        controller: nikController,
                                        cursorColor: Colors.black,
                                        decoration: AppStyles.formBox.copyWith(
                                            hintText: 'Nomor NIK / KTP',
                                            hintStyle: TextStyle(
                                                color: AppStyles.greyColor2)),
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return "Field NIK pasien harus terisi";
                                          }

                                          return null;
                                        },
                                        onChanged: (value) {
                                          nik = value;
                                        },
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
                                        controller: noTelpController,
                                        cursorColor: Colors.black,
                                        decoration: AppStyles.formBox.copyWith(
                                            hintText: 'Nomor HP',
                                            hintStyle: TextStyle(
                                                color: AppStyles.greyColor2)),
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return "Field no. HP pasien harus terisi";
                                          }

                                          return null;
                                        },
                                        onChanged: (value) {
                                          noTelp = value;
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
                                          text: 'Alamat Rumah',
                                          style: AppStyles.contentText.copyWith(
                                              fontWeight: FontWeight.bold)),
                                      TextFormField(
                                        controller: alamatController,
                                        cursorColor: Colors.black,
                                        decoration: AppStyles.formBox.copyWith(
                                            hintText: 'Alamat Rumah',
                                            hintStyle: TextStyle(
                                                color: AppStyles.greyColor2)),
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return "Field alamat pasien harus terisi";
                                          }

                                          return null;
                                        },
                                        onChanged: (value) {
                                          alamat = value;
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
                                          text: 'Kelurahan',
                                          style: AppStyles.contentText.copyWith(
                                              fontWeight: FontWeight.bold)),
                                      TextFormField(
                                        controller: kelurahanController,
                                        cursorColor: Colors.black,
                                        decoration: AppStyles.formBox.copyWith(
                                            hintText: 'Keluarahan',
                                            hintStyle: TextStyle(
                                                color: AppStyles.greyColor2)),
                                        onChanged: (value) {
                                          kelurahan = value;
                                        },
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return "Field kelurahan pasien harus terisi";
                                          }

                                          return null;
                                        },
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
                                        controller: kecamatanController,
                                        cursorColor: Colors.black,
                                        decoration: AppStyles.formBox.copyWith(
                                            hintText: 'Kecamatan',
                                            hintStyle: TextStyle(
                                                color: AppStyles.greyColor2)),
                                        onChanged: (value) {
                                          kecamatan = value;
                                        },
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return "Field kecamatan pasien harus terisi";
                                          }

                                          return null;
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
                                          text: 'Kota Tempat Tinggal',
                                          style: AppStyles.contentText.copyWith(
                                              fontWeight: FontWeight.bold)),
                                      TextFormField(
                                        controller: tempatTinggalController,
                                        cursorColor: Colors.black,
                                        decoration: AppStyles.formBox.copyWith(
                                            hintText: 'Kota Tempat Tinggal',
                                            hintStyle: TextStyle(
                                                color: AppStyles.greyColor2)),
                                        onChanged: (value) {
                                          tempatTinggal = value;
                                        },
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return "Field tempat tinggal pasien harus terisi";
                                          }

                                          return null;
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
                                          text: 'Keluhan Utama',
                                          style: AppStyles.contentText.copyWith(
                                              fontWeight: FontWeight.bold)),
                                      TextFormField(
                                        // maxLines: 2,
                                        cursorColor: Colors.black,
                                        decoration: AppStyles.formBox.copyWith(
                                            hintText: 'Keluhan Utama',
                                            hintStyle: TextStyle(
                                                color: AppStyles.greyColor2)),
                                        onChanged: (value) {
                                          keluhanUtama = value;
                                        },
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return "Field keluhan utama pasien harus terisi";
                                          }

                                          return null;
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
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                InkWell(
                                  onTap: () {
                                    widget.navigateToPage(0);
                                  },
                                  child: TheButton(
                                    text: 'Kembali',
                                    color: AppStyles.greyBtnColor,
                                    iconColor: AppStyles.greyBtnColor,
                                    textColor: AppStyles.greyBtnColor,
                                    border: true,
                                    isIcon: true,
                                    icon: Icons.arrow_back,
                                  ),
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                InkWell(
                                  onTap: () {
                                    showDialog(
                                        context: context,
                                        builder: (context) => ConfirmAlert(
                                              icon: FluentIcons.print_16_filled,
                                              boldText: 'Cetak Antrian?',
                                              yesText: 'cetak',
                                              yesFunc: () {
                                                doRegistrasi();
                                              },
                                            ));
                                  },
                                  child: TheButton(
                                    text: 'Cetak Antrian',
                                    color: AppStyles.accentColor,
                                    iconColor: AppStyles.accentColor,
                                    textColor: AppStyles.accentColor,
                                    border: true,
                                    isIcon: true,
                                    icon: Icons.print,
                                  ),
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
      ),
    );
  }
}
