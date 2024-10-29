import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:standby_capstone/pages/documents/_report/pdf_report_model.dart';
import 'package:standby_capstone/pages/documents/_report/pdf_report_utils.dart';

class PdfLeakageCurrent {
  static Future<pw.Widget> buildLeakageCurrent(Report report) async {
    final font =
        await PdfReportUtils.loadFont('assets/fonts/Roboto-Regular.ttf');
    final fontBold =
        await PdfReportUtils.loadFont('assets/fonts/Roboto-Bold.ttf');

    final headers = [
      'Jenis arus bocor',
      '1 (µA)',
      'Maks 1 (mA)',
      'Hasil',
    ];

    final data = report.leakageCurrentItem
        .map((item) => [
              item.leakageCurrentType,
              item.microAmpere,
              item.maxMiliAmp,
              item.result
            ])
        .toList();

    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          '8.7. TABEL. Arus bocor.',
          style: pw.TextStyle(font: fontBold, fontSize: 10),
        ),
        pw.SizedBox(height: 4),
        pw.TableHelper.fromTextArray(
          headers: headers,
          data: data,
          columnWidths: {
            0: const pw.FixedColumnWidth(40),
            1: const pw.FixedColumnWidth(10),
            2: const pw.FixedColumnWidth(40),
            3: const pw.FixedColumnWidth(10),
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
          'Catatan 1: Untuk kebocoran arus pembumian lihat 8.7.3 d) dan 8.7 45;',
          style: pw.TextStyle(font: font, fontSize: 10),
        ),
        pw.Text(
          'Catatan 2: Untuk arus sentuh lihat 8.7.3 c) dan 8 7 4.6;',
          style: pw.TextStyle(font: font, fontSize: 10),
        ),
        pw.Text(
          'Catatan 3: Untuk arus pelengkap pasien lihat 8.7.3 b) dan 8.7 4.7;',
          style: pw.TextStyle(font: font, fontSize: 10),
        ),
        pw.Text(
          'Catatan 4: Nila total arus bocor pasien hanya relatif terhadap peralatan dengan multipel bagian yang diaplikasikan dari tipe yang sama. Lihat 8.7.4.7 h). Bagian yang diaplikasikan individu sesuai dengan nilai arus pelengkap pasien.',
          style: pw.TextStyle(font: font, fontSize: 10),
        ),
        pw.Text(
          'Catatan 5: Selain kondisi yang ditunjukkan dalam TABEL, pengujian dilakukan pada suhu operasi dan setelah kondisi kelembaban awal 5.7. peralatan diberi energi dalam kondisi stanby dan beroperasi penuh, frekuensi suplai pengenal maks, pada 110% dari pengenal tegangan utama, dan setelah pengujian yang relevan dari Klausul 11.6 (yaitu, luapan, tumpahan, kebocoran, masuknya air dan materi partikulat, pembersihan & desinfeksi, & sterilisasi).',
          style: pw.TextStyle(font: font, fontSize: 10),
        ),
      ],
    );
  }
}
