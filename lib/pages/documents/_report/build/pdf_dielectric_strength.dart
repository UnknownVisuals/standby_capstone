import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:standby_capstone/pages/documents/_report/pdf_report_model.dart';
import 'package:standby_capstone/pages/documents/_report/pdf_report_utils.dart';

class PdfDielectricStrengthModel {
  static Future<pw.Widget> buildDielectricStrength(Report report) async {
    final font =
        await PdfReportUtils.loadFont('assets/fonts/Roboto-Regular.ttf');
    final fontBold =
        await PdfReportUtils.loadFont('assets/fonts/Roboto-Bold.ttf');

    final headers = [
      'Isolasi sample yang diuji (area dari diagram isolasi)',
      'Tipe insulasi (1 or 2 SPO/SPP)',
      'Tegangan Kerja Puncak Vpeak',
      'Tegangan Kerja Puncak V d.c.',
      'AC tegangan uji pada V r.m.s',
      'Kerusakan dielektrik setelah 1 menit (Ya / Tidak)',
    ];

    final data = report.dielectricStrengthItem
        .map((item) => [
              item.sampleIsolationController,
              item.insulationTypeController,
              item.voltagePeakController,
              item.voltagePeakDCController,
              item.voltageTestController,
              item.dielectricDamageController,
            ])
        .toList();

    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          '8.8.3. TABEL: Uji kekuatan dielektrik bahan insulasi padat dengan fungsi kemanan - Sarana perlingdungan operator (SPO) / Sarana perlindungan pasien (SPP).',
          style: pw.TextStyle(font: fontBold, fontSize: 10),
        ),
        pw.SizedBox(height: 4),
        pw.TableHelper.fromTextArray(
          headers: headers,
          data: data,
          columnWidths: {
            0: const pw.FixedColumnWidth(2),
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
        pw.Text(
          'Informasi tambahan:',
          style: pw.TextStyle(font: fontBold, fontSize: 10),
        ),
        pw.Text(
          'Alternatifnya, sesuai TABEL (is., dc), a dc tegangan uji sama dengan nilai puncak a c. tegangan uji digunakan. 2A) Segera setelah perlakuan kelembaban 5.7, Peralatan elektromedik dihilangkan energi, B) setelah prosedur sterilisasi diperlukan, peralatan elektromedik dihilangkan energi, C) setelah mencapai suhu operasi steady state seperti selama uji pemanasan 11.1.1, dan D) setelah pengujian yang relevan dan 11.6 (yaitu, luapan, tumpahan. kebocoran, masuknya air pembersihan, desinfeksi, dan sterilisasi)',
          style: pw.TextStyle(font: font, fontSize: 10),
        ),
      ],
    );
  }
}
