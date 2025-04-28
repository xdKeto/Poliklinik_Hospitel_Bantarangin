import 'dart:typed_data';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

String calculateAge(int hari) {
  if (hari < 0) {
    return "invalid";
  }

  if (hari < 365) {
    int bulan = (hari / 30).floor();
    return "$bulan bulan";
  } else {
    int tahun = (hari / 365).floor();

    return "$tahun tahun";
  }
}

class PdfApi {
  static Future<Uint8List> cetakAntrian(
      int noAntrian,
      String nama,
      String jenisKelamin,
      DateTime tanggalLahir,
      String tanggal,
      String jam,
      String poli) async {
    final pdf = pw.Document();

    String antrianStr = "000";

    if (noAntrian == 0) {
      antrianStr = "000";
    } else if (noAntrian < 10) {
      antrianStr = "00$noAntrian";
    } else if (noAntrian < 100) {
      antrianStr = "0$noAntrian";
    } else {
      antrianStr = "$noAntrian";
    }

    String ageDisplay = "";
    final now = DateTime.now();
    final years = now.year - tanggalLahir.year;
    final months =
        now.month - tanggalLahir.month + (now.year - tanggalLahir.year) * 12;

    if (years < 1) {
      ageDisplay = "$months bulan";
    } else {
      ageDisplay = "$years tahun";
    }

    pdf.addPage(pw.Page(
        pageFormat:
            PdfPageFormat(100 * PdfPageFormat.mm, 100 * PdfPageFormat.mm),
        build: (_) {
          return pw.Container(
            decoration: pw.BoxDecoration(
              border: pw.Border.all(color: PdfColor.fromInt(0xFF000000)),
            ),
            child: pw.Column(
              children: [
                pw.Container(
                    padding: pw.EdgeInsets.all(6),
                    decoration: pw.BoxDecoration(
                        border: pw.Border(
                            bottom: pw.BorderSide(
                                color: PdfColor.fromInt(0xFF000000)))),
                    child: pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.center,
                        children: [
                          pw.Text("Hospitel Bantarangin",
                              style: pw.TextStyle(
                                fontSize: 14,
                                fontWeight: pw.FontWeight.bold,
                              )),
                          pw.SizedBox(height: 8),
                          pw.Text(
                              "Jl. Ponorogo - Wonogiri, Tengah, Kauman, Kec. Kauman, Kabupaten Ponorogo, Jawa Timur 63541",
                              style: pw.TextStyle(fontSize: 10),
                              textAlign: pw.TextAlign.center),
                        ])),
                pw.SizedBox(height: 6),
                pw.Container(
                    padding: pw.EdgeInsets.all(6),
                    decoration: pw.BoxDecoration(
                        border: pw.Border(
                            bottom: pw.BorderSide(
                                color: PdfColor.fromInt(0xFF000000)),
                            top: pw.BorderSide(
                                color: PdfColor.fromInt(0xFF000000)))),
                    child: pw.Center(
                      child: pw.Text(poli.toUpperCase(),
                          style: pw.TextStyle(
                              fontSize: 14, fontWeight: pw.FontWeight.bold)),
                    )),
                pw.Container(
                    width: double.infinity,
                    padding: pw.EdgeInsets.all(8),
                    decoration: pw.BoxDecoration(
                        border: pw.Border(
                            bottom: pw.BorderSide(
                                color: PdfColor.fromInt(0xFF000000)))),
                    child: pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.center,
                        children: [
                          pw.Text("NOMOR ANTRIAN",
                              style: pw.TextStyle(
                                  fontSize: 12,
                                  fontWeight: pw.FontWeight.bold)),
                          pw.SizedBox(height: 4),
                          pw.Text(antrianStr,
                              style: pw.TextStyle(
                                  fontSize: 65,
                                  fontWeight: pw.FontWeight.bold)),
                        ])),
                pw.SizedBox(height: 6),
                pw.Container(
                    width: double.infinity,
                    padding: pw.EdgeInsets.all(4),
                    decoration: pw.BoxDecoration(
                        border: pw.Border(
                            top: pw.BorderSide(
                                color: PdfColor.fromInt(0xFF000000)))),
                    child: pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.center,
                        children: [
                          pw.Text(nama, style: pw.TextStyle(fontSize: 10)),
                          pw.Text(jenisKelamin,
                              style: pw.TextStyle(fontSize: 10)),
                          pw.Text("Umur: $ageDisplay",
                              style: pw.TextStyle(fontSize: 10)),
                          pw.Text(tanggal, style: pw.TextStyle(fontSize: 10)),
                          pw.Text(jam, style: pw.TextStyle(fontSize: 10)),
                        ])),
              ],
            ),
          );
        }));

    return pdf.save();
  }

  static Future<Uint8List> cetakLabel(
      String namaDokter,
      String nama,
      String jenisKelamin,
      String tanggalLahir,
      String tanggal,
      String jam,
      int umur) async {
    final pdf = pw.Document();

    String ageDisplay = calculateAge(umur);

    pdf.addPage(pw.Page(
        pageFormat: PdfPageFormat(
          65 * PdfPageFormat.mm,
          40 * PdfPageFormat.mm,
        ),
        build: (_) {
          return pw.Container(
              decoration: pw.BoxDecoration(
                  border: pw.Border.all(color: PdfColor.fromInt(0xFF000000))),
              child: pw.Column(children: [
                pw.SizedBox(height: 4),
                pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.center,
                    children: [
                      pw.Column(children: [
                        pw.Text("Hospitel Bantarangin",
                            style: pw.TextStyle(
                              fontSize: 10,
                              fontWeight: pw.FontWeight.bold,
                            )),
                        pw.SizedBox(height: 4),
                        pw.Text("Jl. Ponorogo - Wonogiri, Tengah, Kauman",
                            style: pw.TextStyle(fontSize: 9),
                            textAlign: pw.TextAlign.center),
                      ])
                    ]),
                // pw.SizedBox(height: 4),
                pw.Divider(thickness: 1),
                // pw.SizedBox(height: 4),
                pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text("Nama Dokter: $namaDokter",
                          style: pw.TextStyle(fontSize: 8)),
                      pw.SizedBox(height: 2),
                      pw.Text("Nama Pasien: $nama",
                          style: pw.TextStyle(fontSize: 8)),
                      pw.SizedBox(height: 2),
                      pw.Text("Tgl. Lahir: $tanggalLahir ($ageDisplay)",
                          style: pw.TextStyle(fontSize: 8)),
                      pw.SizedBox(height: 2),
                      pw.Text("Jenis Kelamin: $jenisKelamin",
                          style: pw.TextStyle(fontSize: 8)),
                    ]),
                pw.SizedBox(height: 10),
                pw.Row(mainAxisAlignment: pw.MainAxisAlignment.end, children: [
                  pw.Text("$tanggal - $jam", style: pw.TextStyle(fontSize: 6)),
                  pw.SizedBox(width: 8),
                ])
              ]));
        }));

    return pdf.save();
  }

  static Future<Uint8List> cetakGelang(String nama, String dokter,
      String tanggalLahir, String tanggal, String jam) async {
    final pdf = pw.Document();

    pdf.addPage(pw.Page(
        pageFormat:
            PdfPageFormat(270 * PdfPageFormat.mm, 25 * PdfPageFormat.mm),
        build: (_) {
          return pw.Container(
              decoration: pw.BoxDecoration(
                  border: pw.Border.all(color: PdfColor.fromInt(0xFF000000))),
              child: pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.center,
                  children: [
                    pw.Center(
                        child: pw.Row(children: [
                      pw.VerticalDivider(thickness: 2),
                      pw.Row(children: [
                        pw.Column(
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [
                              pw.SizedBox(height: 4),
                              pw.Text("Hospitel Bantarangin",
                                  style: pw.TextStyle(
                                    fontSize: 10,
                                    fontWeight: pw.FontWeight.bold,
                                  )),
                              pw.SizedBox(height: 4),
                              pw.Text("Nama Pasien: $nama",
                                  style: pw.TextStyle(fontSize: 8)),
                              pw.SizedBox(height: 2),
                              pw.Text("DOB: $tanggalLahir",
                                  style: pw.TextStyle(fontSize: 8)),
                              pw.SizedBox(height: 2),
                              pw.Text("Nama Dokter: $dokter",
                                  style: pw.TextStyle(fontSize: 8)),
                            ]),
                        pw.Column(
                            crossAxisAlignment: pw.CrossAxisAlignment.end,
                            mainAxisAlignment: pw.MainAxisAlignment.end,
                            children: [
                              pw.Text("$tanggal - $jam",
                                  style: pw.TextStyle(fontSize: 6)),
                              pw.SizedBox(height: 4)
                            ]),
                      ]),
                      pw.VerticalDivider(thickness: 2),
                    ]))
                  ]));
        }));

    return pdf.save();
  }
}
