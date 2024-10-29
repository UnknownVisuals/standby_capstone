import 'package:flutter/material.dart';
import 'package:standby_capstone/constants.dart';
import 'package:standby_capstone/main.dart';
import 'package:standby_capstone/pages/documents/_report/pdf_report_document.dart';
import 'package:standby_capstone/pages/documents/_report/pdf_report_model.dart';
import 'package:standby_capstone/pages/documents/_report/pdf_utils.dart';
import 'package:standby_capstone/pages/documents/models/leakage_current_model.dart';
import 'package:standby_capstone/pages/documents/models/performance_matters_model.dart';
import 'package:standby_capstone/pages/documents/models/power_input_model.dart';
import 'package:standby_capstone/pages/documents/models/risk_management_model.dart';
import 'package:standby_capstone/pages/documents/subpages/leakage_current_page.dart';
import 'package:standby_capstone/pages/documents/subpages/performance_matters_page.dart';
import 'package:standby_capstone/pages/documents/subpages/power_input_page.dart';
import 'package:standby_capstone/pages/documents/subpages/risk_management_page.dart';

class DocumentsPage extends StatefulWidget {
  const DocumentsPage({super.key});

  @override
  State<DocumentsPage> createState() => _DocumentsPageState();
}

class _DocumentsPageState extends State<DocumentsPage> {
  final _labNumberController = TextEditingController();
  final _productNameController = TextEditingController();
  final _modelController = TextEditingController();
  final _serialNumberController = TextEditingController();

  final _sensorStream = supabase.from('esp32_1').stream(primaryKey: ['id']);
  double currentTemp = 0.0;
  double currentHumi = 0.0;

  final List<RiskManagementModel> clauses =
      RiskManagementModel.defaultClauses();
  final List<PerformanceMattersModel> matters = [];
  final List<PowerInputModel> powers0 = PowerInputModel.defaultPowers('100 V');
  final List<PowerInputModel> powers1 = PowerInputModel.defaultPowers('170 V');
  final List<PowerInputModel> powers2 = PowerInputModel.defaultPowers('200 V');
  final List<LeakageCurrentModel> leakages =
      LeakageCurrentModel.defaultLeakageCurrent();

  Widget _buildTextRow(String label, TextEditingController controller) {
    return Row(
      children: [
        Expanded(flex: 1, child: Text(label)),
        Expanded(flex: 2, child: TextFormField(controller: controller)),
      ],
    );
  }

  Future<void> _generateReport() async {
    final report = Report(
      incubatorDetail: IncubatorDetail(
        labNumber: _labNumberController.text,
        productName: _productNameController.text,
        model: _modelController.text,
        serialNumber: _serialNumberController.text,
      ),
      testingCondition: TestingCondition(
        date: DateTime.now(),
        temperature: '$currentTemp °C',
        humidity: '$currentHumi %RH',
      ),
      riskManagementItem: clauses.map((clause) {
        return RiskManagementItem(
          clause: clause.clause,
          clauseTitle: clause.title,
          docsReference: clause.refController.text,
          riskManagement: clause.isRisk ? 'Ada' : 'Tidak ada',
          result: clause.decisionController.text,
        );
      }).toList(),
      performanceMattersItem: matters.map((matters) {
        return PerformanceMattersItem(
          performanceMatters: matters.perfMattersController.text,
          docsReference: matters.docsReferenceController.text,
          notes: matters.notesController.text,
        );
      }).toList(),
      powerInputItem0: _convertToPowerInputItems(powers0),
      powerInputItem1: _convertToPowerInputItems(powers1),
      powerInputItem2: _convertToPowerInputItems(powers2),
      leakageCurrentItem: leakages.map((leakages) {
        return LeakageCurrentItem(
          leakageCurrentType: leakages.leakageCurrentType,
          microAmpere: leakages.microAmpere.text,
          maxMiliAmp: leakages.maxMiliAmp,
          result: leakages.result.text,
        );
      }).toList(),
    );

    final finalReport = await PdfReport.generatePdfReport(report);

    if (!mounted) return;

    PdfUtils.openPdf(finalReport);
    // PdfUtils.uploadPdf(finalReport, context);
  }

  List<PowerInputItem> _convertToPowerInputItems(List<PowerInputModel> powers) {
    return powers.map((powers) {
      return PowerInputItem(
        voltage: powers.voltageController,
        power: double.tryParse(powers.powerController.text) ?? 0.0,
        current: double.tryParse(powers.currentController.text) ?? 0.0,
        powerFactor: double.tryParse(powers.powerFactorController.text) ?? 1.0,
        result: powers.resultController.text,
        notes: powers.notesController,
      );
    }).toList();
  }

  @override
  void dispose() {
    super.dispose();
    _labNumberController.dispose();
    _productNameController.dispose();
    _modelController.dispose();
    _serialNumberController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kGray,
      body: StreamBuilder(
        stream: _sensorStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(kPrimary),
              ),
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No sensors data available.'));
          }

          final latestSensorData = snapshot.data?.last;

          currentTemp =
              ((latestSensorData?['ds18b20_temp1'] ?? 0.0).toDouble() +
                      (latestSensorData?['ds18b20_temp2'] ?? 0.0).toDouble() +
                      (latestSensorData?['ds18b20_temp3'] ?? 0.0).toDouble() +
                      (latestSensorData?['ds18b20_temp4'] ?? 0.0).toDouble()) /
                  4;
          currentHumi = (latestSensorData?['dht22_humi'] ?? 0.0).toDouble();

          return Padding(
            padding: const EdgeInsets.all(16),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text('Enter Incubator Details', style: kTextHeading_Red),
                  const SizedBox(height: 8),
                  _buildTextRow('No. Lab', _labNumberController),
                  _buildTextRow('Nama Produk', _productNameController),
                  _buildTextRow('Model', _modelController),
                  _buildTextRow('No. Serial', _serialNumberController),
                  const SizedBox(height: 24),
                  RiskManagementPage(clauses: clauses),
                  PerformanceMattersPage(matters: matters),
                  PowerInputPage(powers: powers0),
                  PowerInputPage(powers: powers1),
                  PowerInputPage(powers: powers2),
                  LeakageCurrentPage(leakages: leakages),
                  const SizedBox(height: 24 * 3),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _generateReport,
        backgroundColor: kPrimary,
        shape: const CircleBorder(),
        child: const Icon(Icons.print_rounded, color: kWhite),
      ),
    );
  }
}
