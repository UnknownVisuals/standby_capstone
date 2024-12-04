import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:standby_capstone/pages/documents/_report/pdf_report_model.dart';
import 'package:standby_capstone/pages/documents/_report/pdf_report_utils.dart';

class PdfRiskManagement {
  static Future<pw.Widget> buildRiskManagement(Report report) async {
    final font =
        await PdfReportUtils.loadFont('assets/fonts/Roboto-Regular.ttf');
    final fontBold =
        await PdfReportUtils.loadFont('assets/fonts/Roboto-Bold.ttf');

    final headers = [
      'Klausul',
      'Judul Klausul',
      'Dok Ref FMR (Dok No./ hal)',
      'Ada/tidak ada dalam file manajemen resiko',
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

    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          '4.2.2. TABEL: Hasil manajemen resiko; Persyaratan umum manajemen resiko.',
          style: pw.TextStyle(font: fontBold, fontSize: 10),
        ),
        pw.SizedBox(height: 4),
        pw.TableHelper.fromTextArray(
          headers: headers,
          data: data,
          columnWidths: {
            0: const pw.FixedColumnWidth(10),
            1: const pw.FixedColumnWidth(45),
            2: const pw.FixedColumnWidth(15),
            3: const pw.FixedColumnWidth(15),
            4: const pw.FixedColumnWidth(15),
          },
          headerStyle: pw.TextStyle(font: fontBold, fontSize: 10),
          headerDecoration: const pw.BoxDecoration(color: PdfColors.grey300),
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
          'Dokumen ref harus berkaitan dengan kebijakan/prosedur dokumen dan dokumen yang berisi output perangkat tertentu.',
          style: pw.TextStyle(font: font, fontSize: 10),
        ),
      ],
    );
  }
}
