import 'dart:typed_data';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';


class PdfApi {
  static Future<Uint8List> cetakAntrian(
      int noAntrian,
      String nama,
      String jenisKelamin,
      DateTime tanggalLahir,
      String tanggal,
      String jam) async {
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
        pageFormat: PdfPageFormat(PdfPageFormat.cm * 10, PdfPageFormat.cm * 10),
        build: (_) {
          return pw.Container(
            decoration: pw.BoxDecoration(
              border: pw.Border.all(color: PdfColor.fromInt(0xFF000000)),
            ),
            margin: pw.EdgeInsets.all(16),
            child: pw.Column(
              children: [
                pw.Text(antrianStr,
                    style: pw.TextStyle(
                        fontSize: 40, fontWeight: pw.FontWeight.bold)),
                pw.SizedBox(height: 10),
                pw.Text(nama, style: pw.TextStyle(fontSize: 16)),
                pw.Text(jenisKelamin, style: pw.TextStyle(fontSize: 14)),
                pw.Text("Umur: $ageDisplay", style: pw.TextStyle(fontSize: 14)),
                pw.Text(tanggal, style: pw.TextStyle(fontSize: 14)),
                pw.Text(jam, style: pw.TextStyle(fontSize: 14)),
              ],
            ),
          );
        }));

    return pdf.save();
  }

 
}
