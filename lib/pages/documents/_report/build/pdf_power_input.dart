import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:standby_capstone/pages/documents/_report/pdf_report_model.dart';
import 'package:standby_capstone/pages/documents/_report/pdf_report_utils.dart';

class PdfPowerInputModel {
  static Future<pw.Widget> buildPowerInput(
      Report report, List<PowerInputItem> dataItems) async {
    final font =
        await PdfReportUtils.loadFont('assets/fonts/Roboto-Regular.ttf');
    final fontBold =
        await PdfReportUtils.loadFont('assets/fonts/Roboto-Bold.ttf');

    final headers = [
      'Kondisi operasi dan Daya pengenal (W, A, VA)',
      'Daya (W/VA) Terukur',
      'Arus (A)\nTerukur',
      'Power faktor (cos theta) Terukur',
      'Hasil (W/ VA)',
      'Catatan',
    ];

    final data = dataItems
        .map((item) => [
              item.voltage,
              item.power,
              item.current,
              item.powerFactor,
              item.result,
              item.notes,
            ])
        .toList();

    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          '4.11. TABEL: Input daya.',
          style: pw.TextStyle(font: fontBold, fontSize: 10),
        ),
        pw.SizedBox(height: 4),
        pw.TableHelper.fromTextArray(
          headers: headers,
          data: data,
          columnWidths: {
            0: const pw.FixedColumnWidth(1),
            1: const pw.FixedColumnWidth(1),
            2: const pw.FixedColumnWidth(1),
            3: const pw.FixedColumnWidth(1),
            4: const pw.FixedColumnWidth(1),
            5: const pw.FixedColumnWidth(1),
          },
          headerStyle: pw.TextStyle(font: fontBold, fontSize: 10),
          headerDecoration: const pw.BoxDecoration(color: PdfColors.grey300),
          cellStyle: pw.TextStyle(font: font, fontSize: 10),
          cellAlignment: pw.Alignment.centerLeft,
          headerAlignment: pw.Alignment.center,
        ),
        pw.SizedBox(height: 4),
      ],
    );
  }
}
