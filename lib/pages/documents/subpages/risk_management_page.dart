import 'package:flutter/material.dart';
import 'package:standby_capstone/constants.dart';
import 'package:standby_capstone/pages/documents/models/risk_management_model.dart';
import 'package:standby_capstone/pages/documents/tables/risk_management_table.dart';

class RiskManagementPage extends StatefulWidget {
  final List<RiskManagementModel> clauses;

  const RiskManagementPage({super.key, required this.clauses});

  @override
  State<RiskManagementPage> createState() => _RiskManagementPageState();
}

class _RiskManagementPageState extends State<RiskManagementPage> {
  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: SizedBox(
        width: double.infinity,
        child: Text(
            '4.2.2. TABEL. Hasil manajemen resiko. Persyaratan umum manajemen resiko.',
            style: kTextHeading_Red),
      ),
      children: [
        const SizedBox(height: 8),
        RiskManagementTable(
          clauses: widget.clauses,
          onClauseChange: (int index) {
            setState(() {
              widget.clauses[index].isRisk = !widget.clauses[index].isRisk;
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
            style: kTextNormal_Black.copyWith(fontSize: 12),
          ),
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}
