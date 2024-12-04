import 'package:pdf/widgets.dart' as pw;
import 'package:standby_capstone/pages/documents/_report/pdf_report_model.dart';

class PdfIncubatorDetails {
  static pw.Widget buildIncubatorDetails(Report report, pw.Font font) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          'No. Lab: ${report.incubatorDetail.labNumber}',
          style: pw.TextStyle(font: font, fontSize: 10),
        ),
        pw.Text(
          'Nama Produk: ${report.incubatorDetail.productName}',
          style: pw.TextStyle(font: font, fontSize: 10),
        ),
        pw.Text(
          'Model: ${report.incubatorDetail.model}',
          style: pw.TextStyle(font: font, fontSize: 10),
        ),
        pw.Text(
          'No. Seri: ${report.incubatorDetail.serialNumber}',
          style: pw.TextStyle(font: font, fontSize: 10),
        ),
        pw.Text(
          'Referensi: SNI IEC 60601-1:2014',
          style: pw.TextStyle(font: font, fontSize: 10),
        ),
        pw.Text(
          'Peralatan Uji: Sesuai PO',
          style: pw.TextStyle(font: font, fontSize: 10),
        ),
      ],
    );
  }
}
