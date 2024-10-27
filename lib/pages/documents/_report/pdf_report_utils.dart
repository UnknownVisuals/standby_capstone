import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class PdfReportUtils {
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
