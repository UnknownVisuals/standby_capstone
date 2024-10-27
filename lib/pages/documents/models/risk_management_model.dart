import 'package:flutter/material.dart';

class RiskManagementModel {
  final String clause;
  final String title;
  final TextEditingController refController = TextEditingController();
  final TextEditingController decisionController = TextEditingController();
  bool isRisk;

  RiskManagementModel({
    required this.clause,
    required this.title,
    this.isRisk = false,
  });

  static List<RiskManagementModel> defaultClauses() {
    return [
      RiskManagementModel(
        clause: '3.1',
        title: 'Proses manajemen risiko',
      ),
      RiskManagementModel(
        clause: '3.2',
        title: 'Tanggung jawab manajemen',
      ),
      RiskManagementModel(
        clause: '3.3',
        title: 'Kualifikasi Personil',
      ),
      RiskManagementModel(
        clause: '3.4',
        title: 'Rencana Manajemen Resiko',
      ),
      RiskManagementModel(
        clause: '3.5',
        title: 'Berkas Manajemen Resiko',
      ),
      RiskManagementModel(
        clause: '4.1',
        title: 'Proses Analisa Resiko',
      ),
      RiskManagementModel(
        clause: '4.2',
        title:
            'Maksud penggunaan dan identifikasi karakteristik\nterkait dengan keamanan alat kesehatan',
      ),
      RiskManagementModel(
        clause: '4.3',
        title: 'Identifikasi bahaya',
      ),
      RiskManagementModel(
        clause: '4.4',
        title: 'Estimasi resiko untuk setiap yang membahayakan',
      ),
      RiskManagementModel(
        clause: '5',
        title: 'Evaluasi resiko',
      ),
      RiskManagementModel(
        clause: '6',
        title: 'Kendali resiko',
      ),
      RiskManagementModel(
        clause: '7',
        title: 'Evaluasi keberterimaan seluruh residu resiko',
      ),
      RiskManagementModel(
        clause: '8',
        title: 'Laporan manajemen resiko',
      ),
    ];
  }
}
