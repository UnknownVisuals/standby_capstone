import 'dart:io';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:standby_capstone/pages/documents/models/report.dart';
import 'package:standby_capstone/pages/documents/pdf_utils.dart';

class PdfReport {
  static Future<File> generatePdfReport(Report report) async {
    final pdf = pw.Document();

    final logo = await loadAsset('assets/logo/logo.png');
    final font = await loadFont('assets/fonts/Roboto-Regular.ttf');
    final fontBold = await loadFont('assets/fonts/Roboto-Bold.ttf');

    final headers = [
      'Klausul',
      'Judul Klausul',
      'Dok Ref FMR',
      'Ada/tidak ada',
      'Keputusan'
    ];

    final data = report.riskManagementItem
        .map((item) => [
              item.clause,
              item.clauseTitle,
              item.docsReference,
              item.riskManagement,
              item.result
            ])
        .toList();

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(32),
        header: (context) => buildPageHeader(context, logo, fontBold),
        footer: (context) => buildPageNumber(context, font),
        build: (context) => [
          pw.SizedBox(height: 16),
          pw.Row(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              buildIncubatorDetail(report, font),
              pw.Spacer(),
              buildTestingCondition(report, font),
            ],
          ),
          pw.SizedBox(height: 16),
          pw.Text(
            'TABEL : Hasil manajemen resiko : Persyaratan umum manajemen resiko',
            style: pw.TextStyle(font: fontBold, fontSize: 12),
          ),
          pw.SizedBox(height: 4),
          pw.TableHelper.fromTextArray(headers: headers, data: data),
        ],
      ),
    );

    return PdfUtils.savePdf(name: 'simple_text.pdf', pdf: pdf);
  }

  static pw.Widget buildIncubatorDetail(Report report, pw.Font font) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          'No. Lab : ${report.incubatorDetail.labNumber}',
          style: pw.TextStyle(font: font),
        ),
        pw.Text('Nama Produk : ${report.incubatorDetail.productName}',
            style: pw.TextStyle(font: font)),
        pw.Text(
          'Model : ${report.incubatorDetail.model}',
          style: pw.TextStyle(font: font),
        ),
        pw.Text(
          'No. Seri : ${report.incubatorDetail.serialNumber}',
          style: pw.TextStyle(font: font),
        ),
        pw.Text(
          'Referensi : SNI IEC 60601-1:2014',
          style: pw.TextStyle(font: font),
        ),
        pw.Text(
          'Peralatan Uji : Sesuai PO',
          style: pw.TextStyle(font: font),
        ),
      ],
    );
  }

  static pw.Widget buildTestingCondition(Report report, pw.Font font) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          'Tanggal Uji : ${report.testingCondition.date}',
          style: pw.TextStyle(font: font),
        ),
        pw.Text(
          'Suhu Ruang : ${report.testingCondition.temperature}',
          style: pw.TextStyle(font: font),
        ),
        pw.Text(
          'Kelembaban Ruang : ${report.testingCondition.humidity}',
          style: pw.TextStyle(font: font),
        ),
      ],
    );
  }

  static pw.Widget buildPageHeader(
    pw.Context context,
    Uint8List logo,
    pw.Font fontBold,
  ) {
    return pw.Column(
      children: [
        pw.Row(
          children: [
            pw.Text(
              'Test Report - StandBy',
              style: pw.TextStyle(font: fontBold, fontSize: 12),
            ),
            pw.Spacer(),
            pw.Image(pw.MemoryImage(logo), width: 64),
          ],
        ),
        pw.Divider(thickness: 1, color: const PdfColor(0.8, 0.8, 0.8)),
      ],
    );
  }

  static pw.Widget buildPageNumber(pw.Context context, pw.Font font) {
    return pw.Center(
      child: pw.Text(
        '${context.pageNumber}',
        style: pw.TextStyle(font: font, fontSize: 12),
      ),
    );
  }

  static Future<Uint8List> loadAsset(String path) async {
    final ByteData data = await rootBundle.load(path);
    return data.buffer.asUint8List();
  }

  static Future<pw.Font> loadFont(String path) async {
    final ByteData fontData = await rootBundle.load(path);
    return pw.Font.ttf(fontData);
  }
}
