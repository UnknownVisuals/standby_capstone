import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:standby_capstone/pages/documents/_report/pdf_report_model.dart';
import 'package:standby_capstone/pages/documents/_report/pdf_report_utils.dart';

class PdfPerformanceMatters {
  static Future<pw.Widget> buildPerformanceMatters(Report report) async {
    final font =
        await PdfReportUtils.loadFont('assets/fonts/Roboto-Regular.ttf');
    final fontBold =
        await PdfReportUtils.loadFont('assets/fonts/Roboto-Bold.ttf');

    final headers = [
      'Daftar fungsi kinerja penting',
      'Referensi nomor dokumen produsen atau referensi\ndari standard ini atau standard tertentu',
      'Catatan',
    ];

    final data = report.performanceMattersItem
        .map((item) => [
              item.performanceMatters,
              item.docsReference,
              item.notes,
            ])
        .toList();

    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          '4.3. TABEL. Kinerja penting.',
          style: pw.TextStyle(font: fontBold, fontSize: 12),
        ),
        pw.SizedBox(height: 4),
        pw.TableHelper.fromTextArray(
          headers: headers,
          data: data,
          columnWidths: {
            0: const pw.FlexColumnWidth(30),
            1: const pw.FlexColumnWidth(40),
            2: const pw.FlexColumnWidth(30),
          },
          headerStyle: pw.TextStyle(
            font: fontBold,
            fontSize: 10,
          ),
          headerDecoration: const pw.BoxDecoration(
            color: PdfColors.grey300,
          ),
          cellStyle: pw.TextStyle(font: font, fontSize: 10),
          cellAlignment: pw.Alignment.centerLeft,
          headerAlignment: pw.Alignment.center,
        ),
        pw.SizedBox(height: 4),
        pw.Text(
          'Informasi tambahan:',
          style: pw.TextStyle(font: fontBold, fontSize: 10),
        ),
        pw.Text(
          'Kinerja esensial adalah kinerja yang tidak ada atau penurunannya akan menghasilkan resiko yang tidak dapat diterima.',
          style: pw.TextStyle(font: font, fontSize: 10),
        ),
      ],
    );
  }
}
