import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

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

    pdf.addPage(pw.Page(build: (_) {
      return pw.Container(
        width: 100 * PdfPageFormat.mm,
        height: 100 * PdfPageFormat.mm,
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
                        bottom:
                            pw.BorderSide(color: PdfColor.fromInt(0xFF000000)),
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
                              fontSize: 12, fontWeight: pw.FontWeight.bold)),
                      pw.SizedBox(height: 4),
                      pw.Text(antrianStr,
                          style: pw.TextStyle(
                              fontSize: 65, fontWeight: pw.FontWeight.bold)),
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
                      pw.Text(jenisKelamin, style: pw.TextStyle(fontSize: 10)),
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
}
