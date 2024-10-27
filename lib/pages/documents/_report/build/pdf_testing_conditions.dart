import 'package:pdf/widgets.dart' as pw;
import 'package:standby_capstone/pages/documents/_report/pdf_report_model.dart';

class PdfTestingConditions {
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
}
