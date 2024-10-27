import 'package:flutter/material.dart';
import 'package:standby_capstone/constants.dart';
import 'package:standby_capstone/pages/documents/_report/pdf_report_document.dart';
import 'package:standby_capstone/pages/documents/_report/pdf_report_model.dart';
import 'package:standby_capstone/pages/documents/_report/pdf_utils.dart';
import 'package:standby_capstone/pages/documents/models/performance_matters_model.dart';
import 'package:standby_capstone/pages/documents/models/power_input_model.dart';
import 'package:standby_capstone/pages/documents/models/risk_management_model.dart';
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

  final List<RiskManagementModel> clauses =
      RiskManagementModel.defaultClauses();
  final List<PerformanceMattersModel> matters = [];
  final List<PowerInputModel> powers0 = PowerInputModel.defaultPowers('100');
  final List<PowerInputModel> powers1 = PowerInputModel.defaultPowers('170');
  final List<PowerInputModel> powers2 = PowerInputModel.defaultPowers('200');

  @override
  void dispose() {
    super.dispose();
    _labNumberController.dispose();
    _productNameController.dispose();
    _modelController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kGray,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text('Enter Incubator Details', style: kTextHeading_Red),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Expanded(
                    flex: 1,
                    child: Text('No. Lab'),
                  ),
                  Expanded(
                    flex: 2,
                    child: TextFormField(controller: _labNumberController),
                  ),
                ],
              ),
              Row(
                children: [
                  const Expanded(
                    flex: 1,
                    child: Text('Nama Produk'),
                  ),
                  Expanded(
                    flex: 2,
                    child: TextFormField(controller: _productNameController),
                  ),
                ],
              ),
              Row(
                children: [
                  const Expanded(
                    flex: 1,
                    child: Text('Model'),
                  ),
                  Expanded(
                    flex: 2,
                    child: TextFormField(controller: _modelController),
                  ),
                ],
              ),
              Row(
                children: [
                  const Expanded(
                    flex: 1,
                    child: Text('No. Serial'),
                  ),
                  Expanded(
                    flex: 2,
                    child: TextFormField(controller: _serialNumberController),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              RiskManagementPage(clauses: clauses),
              PerformanceMattersPage(matters: matters),
              PowerInputPage(powers: powers0),
              PowerInputPage(powers: powers1),
              PowerInputPage(powers: powers2),
              const SizedBox(height: 24 * 3),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final report = Report(
            incubatorDetail: IncubatorDetail(
              labNumber: _labNumberController.text,
              productName: _productNameController.text,
              model: _modelController.text,
              serialNumber: _serialNumberController.text,
            ),
            testingCondition: TestingCondition(
              date: DateTime.now(),
              temperature: 'temperature',
              humidity: 'humidity',
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
            powerInputItem0: powers0.map((powers) {
              return PowerInputItem(
                voltage: powers.voltageController,
                power: double.tryParse(powers.powerController.text) ?? 0.0,
                current: double.tryParse(powers.currentController.text) ?? 0.0,
                powerFactor:
                    double.tryParse(powers.powerFactorController.text) ?? 1.0,
                result: powers.resultController.text,
                notes: powers.notesController,
              );
            }).toList(),
            powerInputItem1: powers1.map((powers) {
              return PowerInputItem(
                voltage: powers.voltageController,
                power: double.tryParse(powers.powerController.text) ?? 0.0,
                current: double.tryParse(powers.currentController.text) ?? 0.0,
                powerFactor:
                    double.tryParse(powers.powerFactorController.text) ?? 1.0,
                result: powers.resultController.text,
                notes: powers.notesController,
              );
            }).toList(),
            powerInputItem2: powers2.map((powers) {
              return PowerInputItem(
                voltage: powers.voltageController,
                power: double.tryParse(powers.powerController.text) ?? 0.0,
                current: double.tryParse(powers.currentController.text) ?? 0.0,
                powerFactor:
                    double.tryParse(powers.powerFactorController.text) ?? 1.0,
                result: powers.resultController.text,
                notes: powers.notesController,
              );
            }).toList(),
          );

          final finalReport = await PdfReport.generatePdfReport(report);
          PdfUtils.openPdf(finalReport);
        },
        backgroundColor: kPrimary,
        shape: const CircleBorder(),
        child: const Icon(
          Icons.print_rounded,
          color: kWhite,
        ),
      ),
    );
  }
}
