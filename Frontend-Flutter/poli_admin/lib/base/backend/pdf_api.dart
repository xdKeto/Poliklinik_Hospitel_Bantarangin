import 'dart:typed_data';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:universal_html/html.dart' as html;

class PdfApi {
  // Check if the current environment supports all PDF features

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

  static Future<void> saveAndLaunchPdf(
      Uint8List pdfBytes, String fileName) async {
    final blob = html.Blob([pdfBytes], 'application/pdf');

    final url = html.Url.createObjectUrlFromBlob(blob);

    final anchor = html.AnchorElement(href: url)
      ..setAttribute('download', fileName)
      ..style.display = 'none';

    html.document.body?.children.add(anchor);

    anchor.click();

    html.document.body?.children.remove(anchor);
    html.Url.revokeObjectUrl(url);
  }

  static Future<void> openPdfInNewTab(Uint8List pdfBytes) async {
    final blob = html.Blob([pdfBytes], 'application/pdf');
    final url = html.Url.createObjectUrlFromBlob(blob);

    html.window.open(url, '_blank');
  }

  static Future<void> printPdf(Uint8List pdfBytes) async {
    await Printing.layoutPdf(
      onLayout: (format) => pdfBytes,
      name: 'Nomor Antrian',
    );
  }
}
