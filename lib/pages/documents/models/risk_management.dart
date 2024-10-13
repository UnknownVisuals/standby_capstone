import 'package:flutter/material.dart';

class RiskManagement {
  final String clause;
  final String title;
  final TextEditingController refController = TextEditingController();
  final TextEditingController decisionController = TextEditingController();
  bool isRisk;

  RiskManagement({
    required this.clause,
    required this.title,
    this.isRisk = false,
  });

  static List<RiskManagement> defaultClauses() {
    return [
      RiskManagement(
        clause: '3.1',
        title: 'Proses manajemen risiko',
      ),
      RiskManagement(
        clause: '3.2',
        title: 'Tanggung jawab manajemen',
      ),
      RiskManagement(
        clause: '3.3',
        title: 'Kualifikasi Personil',
      ),
      RiskManagement(
        clause: '3.4',
        title: 'Rencana Manajemen Resiko',
      ),
      RiskManagement(
        clause: '3.5',
        title: 'Berkas Manajemen Resiko',
      ),
      RiskManagement(
        clause: '4.1',
        title: 'Proses Analisa Resiko',
      ),
      RiskManagement(
        clause: '4.2',
        title:
            'Maksud penggunaan dan identifikasi karakteristik terkait dengan keamanan alat kesehatan',
      ),
      RiskManagement(
        clause: '4.3',
        title: 'Identifikasi bahaya',
      ),
      RiskManagement(
        clause: '4.4',
        title: 'Estimasi resiko untuk setiap yang membahayakan',
      ),
      RiskManagement(
        clause: '5',
        title: 'Evaluasi resiko',
      ),
      RiskManagement(
        clause: '6',
        title: 'Kendali resiko',
      ),
      RiskManagement(
        clause: '7',
        title: 'Evaluasi keberterimaan seluruh residu resiko',
      ),
      RiskManagement(
        clause: '8',
        title: 'Laporan manajemen resiko',
      ),
    ];
  }
}
