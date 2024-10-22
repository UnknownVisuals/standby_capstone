import 'package:flutter/material.dart';
import 'package:standby_capstone/constants.dart';
import 'package:standby_capstone/pages/documents/models/report.dart';
import 'package:standby_capstone/pages/documents/models/risk_management.dart';
import 'package:standby_capstone/pages/documents/pdf_report.dart';
import 'package:standby_capstone/pages/documents/pdf_utils.dart';
import 'package:standby_capstone/pages/documents/tables/performance_matters.dart';
import 'package:standby_capstone/pages/documents/tables/power_input.dart';
import 'package:standby_capstone/pages/documents/tables/risk_management.dart';
import 'package:standby_capstone/pages/documents/tables/test_table.dart';

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

  final List<RiskManagement> _clauses = RiskManagement.defaultClauses();

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
              const SizedBox(height: 48),
              SizedBox(
                width: double.infinity,
                child: Text(
                    '4.2.2. TABEL. Hasil manajemen resiko. Persyaratan umum manajemen resiko.',
                    style: kTextHeading_Red),
              ),
              const SizedBox(height: 8),
              RiskManagementTable(
                clauses: _clauses,
                onClauseChange: (int index) {
                  setState(() {
                    _clauses[index].isRisk = !_clauses[index].isRisk;
                  });
                },
              ),
              const SizedBox(height: 8),
              SizedBox(
                width: double.infinity,
                child: Text(
                  'Informasi tambahan:',
                  style: kTextHeading_Black.copyWith(fontSize: 12),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: Text(
                    'Dokumen ref harus berkaitan dengan kebijakan/prosedur dokumen dan dokumen yang berisi output perangkat tertentu.',
                    style: kTextNormal_Black.copyWith(fontSize: 12)),
              ),
              const SizedBox(height: 48),
              SizedBox(
                width: double.infinity,
                child: Text('4.3. TABEL. Kinerja penting.',
                    style: kTextHeading_Red),
              ),
              const SizedBox(height: 8),
              const PerformanceMattersTable(),
              const SizedBox(height: 8),
              SizedBox(
                width: double.infinity,
                child: Text(
                  'Informasi tambahan:',
                  style: kTextHeading_Black.copyWith(fontSize: 12),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: Text(
                    'Kinerja esensial adalah kinerja yang tidak ada atau penurunannya akan menghasilkan resiko yang tidak dapat diterima.',
                    style: kTextNormal_Black.copyWith(fontSize: 12)),
              ),
              const SizedBox(height: 48),
              SizedBox(
                width: double.infinity,
                child:
                    Text('4.11. TABEL. Input daya.', style: kTextHeading_Red),
              ),
              const SizedBox(height: 8),
              const PowerInputTable(),
              const MergedTable(),
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
            riskManagementItem: _clauses.map((clause) {
              return RiskManagementItem(
                clause: clause.clause,
                clauseTitle: clause.title,
                docsReference: clause.refController.text,
                riskManagement: clause.isRisk ? 'Ada' : 'Tidak ada',
                result: clause.decisionController.text,
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
