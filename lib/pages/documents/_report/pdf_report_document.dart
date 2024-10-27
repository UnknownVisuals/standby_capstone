import 'dart:io';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:standby_capstone/pages/documents/_report/build/pdf_incubator_details.dart';
import 'package:standby_capstone/pages/documents/_report/build/pdf_performance_matters.dart';
import 'package:standby_capstone/pages/documents/_report/build/pdf_risk_management.dart';
import 'package:standby_capstone/pages/documents/_report/build/pdf_testing_conditions.dart';
import 'package:standby_capstone/pages/documents/_report/pdf_report_model.dart';
import 'package:standby_capstone/pages/documents/_report/pdf_report_utils.dart';
import 'package:standby_capstone/pages/documents/_report/pdf_utils.dart';

class PdfReport {
  static Future<File> generatePdfReport(Report report) async {
    final pdf = pw.Document();

    final logo = await PdfReportUtils.loadAsset('assets/logo/logo.png');
    final font =
        await PdfReportUtils.loadFont('assets/fonts/Roboto-Regular.ttf');
    final fontBold =
        await PdfReportUtils.loadFont('assets/fonts/Roboto-Bold.ttf');

    final riskManagementWidget =
        await PdfRiskManagement.buildRiskManagement(report);
    final performanceMattersWidget =
        await PdfPerformanceMatters.buildPerformanceMatters(report);

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(32),
        header: (context) => PdfReportUtils.buildPageHeader(
          context,
          logo,
          fontBold,
        ),
        footer: (context) => PdfReportUtils.buildPageNumber(
          context,
          font,
        ),
        build: (context) => [
          pw.SizedBox(height: 16),
          pw.Row(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              PdfIncubatorDetails.buildIncubatorDetails(report, font),
              pw.Spacer(),
              PdfTestingConditions.buildTestingCondition(report, font),
            ],
          ),
          pw.SizedBox(height: 16),
          riskManagementWidget,
        ],
      ),
    );

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(32),
        header: (context) => PdfReportUtils.buildPageHeader(
          context,
          logo,
          fontBold,
        ),
        footer: (context) => PdfReportUtils.buildPageNumber(
          context,
          font,
        ),
        build: (context) => [
          pw.SizedBox(height: 32),
          performanceMattersWidget,
          pw.SizedBox(height: 16),
        ],
      ),
    );

    return PdfUtils.savePdf(name: 'simple_text.pdf', pdf: pdf);
  }
}
