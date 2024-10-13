import 'package:flutter/material.dart';
import 'package:standby_capstone/constants.dart';
import 'package:standby_capstone/pages/documents/pdf_utils.dart';
import 'package:standby_capstone/pages/documents/simple_pdf_api.dart';

class DocumentClause {
  final String clause;
  final String title;
  final TextEditingController refController = TextEditingController();
  final TextEditingController decisionController = TextEditingController();
  bool isRisk;

  DocumentClause({
    required this.clause,
    required this.title,
    this.isRisk = false,
  });
}

class DocumentsPage extends StatefulWidget {
  const DocumentsPage({super.key});

  @override
  State<DocumentsPage> createState() => _DocumentsPageState();
}

class _DocumentsPageState extends State<DocumentsPage> {
  final List<DocumentClause> _clauses = [
    DocumentClause(clause: '3.1', title: 'Proses manajemen risiko'),
    DocumentClause(clause: '3.2', title: 'Tanggung jawab manajemen'),
    DocumentClause(clause: '3.3', title: 'Kualifikasi Personil'),
    DocumentClause(clause: '3.4', title: 'Rencana Manajemen Resiko'),
    DocumentClause(clause: '3.5', title: 'Berkas Manajemen Resiko'),
    DocumentClause(clause: '4.1', title: 'Proses Analisa Resiko'),
    DocumentClause(
        clause: '4.2',
        title:
            'Maksud penggunaan dan identifikasi karakteristik terkait dengan keamanan alat kesehatan'),
    DocumentClause(clause: '4.3', title: 'Identifikasi bahaya'),
    DocumentClause(
        clause: '4.4', title: 'Estimasi resiko untuk setiap yang membahayakan'),
    DocumentClause(clause: '5', title: 'Evaluasi resiko'),
    DocumentClause(clause: '6', title: 'Kendali resiko'),
    DocumentClause(
        clause: '7', title: 'Evaluasi keberterimaan seluruh residu resiko'),
    DocumentClause(clause: '8', title: 'Laporan manajemen resiko'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kGray,
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: SingleChildScrollView(
            child: DataTable(
              border: TableBorder.all(color: kDarkGray),
              columns: [
                DataColumn(
                  label: Text('Klausul', style: kTextHeading_Red),
                ),
                DataColumn(
                  label: Text('Judul Klausul', style: kTextHeading_Red),
                ),
                DataColumn(
                  label: Text('Dok Ref FMR (Dok No./hal)',
                      style: kTextHeading_Red),
                ),
                DataColumn(
                  label: Text('Ada/tidak ada dalam file manajemen risiko',
                      style: kTextHeading_Red),
                ),
                DataColumn(
                  label: Text('Keputusan', style: kTextHeading_Red),
                ),
              ],
              rows: _clauses.map((clause) {
                return customDataRow(
                  clause: clause.clause,
                  title: clause.title,
                  refController: clause.refController,
                  decisionController: clause.decisionController,
                  isRisk: clause.isRisk,
                  onRiskChanged: (bool value) {
                    setState(() {
                      clause.isRisk = value;
                    });
                  },
                );
              }).toList(),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final simpleTextPDF = await SimplePdfApi.generateSimpleTextPdf(
            'Judul Dokumen PDF',
            'Deskripsi blablablab ablablaba balbalb',
          );

          PdfUtils.openPdf(simpleTextPDF);
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

DataRow customDataRow({
  required String clause,
  required String title,
  required TextEditingController refController,
  required TextEditingController decisionController,
  required bool isRisk,
  required ValueChanged<bool> onRiskChanged,
}) {
  return DataRow(
    cells: [
      DataCell(Text(clause)),
      DataCell(
        IntrinsicHeight(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title),
            ],
          ),
        ),
      ),
      DataCell(
        IntrinsicHeight(
          child: TextFormField(
            controller: refController,
            decoration: const InputDecoration(
              hintText: 'Dok Ref FMR',
              border: OutlineInputBorder(),
            ),
          ),
        ),
      ),
      DataCell(
        IntrinsicHeight(
          child: Row(
            children: [
              Expanded(
                child: RadioListTile<bool>(
                  title: Tooltip(
                    message: 'Ada di manajemen risiko',
                    child: Text('Ada', style: kTextHeading_Black),
                  ),
                  activeColor: kPrimary,
                  value: true,
                  groupValue: isRisk,
                  onChanged: (bool? value) {
                    onRiskChanged(value ?? false);
                  },
                ),
              ),
              Expanded(
                child: RadioListTile<bool>(
                  title: Tooltip(
                    message: 'Tidak ada di manajemen risiko',
                    child: Text('Tidak ada', style: kTextHeading_Black),
                  ),
                  activeColor: kPrimary,
                  value: false,
                  groupValue: isRisk,
                  onChanged: (bool? value) {
                    onRiskChanged(value ?? false);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      DataCell(
        IntrinsicHeight(
          child: TextFormField(
            controller: decisionController,
            decoration: const InputDecoration(
              hintText: 'Keputusan',
              border: OutlineInputBorder(),
            ),
          ),
        ),
      ),
    ],
  );
}
