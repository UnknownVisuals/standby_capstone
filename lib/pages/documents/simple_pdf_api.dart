import 'dart:io';
import 'package:flutter/services.dart';
import 'package:pdf/widgets.dart';
import 'package:standby_capstone/pages/documents/pdf_utils.dart';

class SimplePdfApi {
  static Future<File> generateSimpleTextPdf(String title, String desc) async {
    final pdf = Document();

    final fontData = await rootBundle.load('assets/fonts/Roboto-Regular.ttf');
    final fontRegular = Font.ttf(fontData);

    final boldFontData = await rootBundle.load('assets/fonts/Roboto-Bold.ttf');
    final fontBold = Font.ttf(boldFontData);

    pdf.addPage(
      Page(
        build: (context) => Center(
          child: Column(
            children: [
              Text(title, style: TextStyle(font: fontBold, fontSize: 24)),
              Text(desc, style: TextStyle(font: fontRegular, fontSize: 20)),
            ],
          ),
        ),
      ),
    );

    return PdfUtils.savePdf(name: 'simple_text.pdf', pdf: pdf);
  }
}
