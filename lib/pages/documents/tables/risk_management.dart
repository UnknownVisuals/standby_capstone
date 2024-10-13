import 'package:flutter/material.dart';
import 'package:standby_capstone/constants.dart';
import 'package:standby_capstone/pages/documents/models/risk_management.dart';

class RiskManagementTable extends StatelessWidget {
  final List<RiskManagement> clauses;
  final ValueChanged<int> onClauseChange;

  const RiskManagementTable({
    super.key,
    required this.clauses,
    required this.onClauseChange,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columns: [
          DataColumn(label: Text('Klausul', style: kTextHeading_Black)),
          DataColumn(label: Text('Judul Klausul', style: kTextHeading_Black)),
          DataColumn(
              label: Text('Dok Ref FMR (Dok No./ hal)',
                  style: kTextHeading_Black)),
          DataColumn(
              label: Text('Ada/tidak ada dalam file manajemen resiko',
                  style: kTextHeading_Black)),
          DataColumn(label: Text('Keputusan', style: kTextHeading_Black)),
        ],
        rows: clauses.asMap().entries.map((entry) {
          int index = entry.key;
          RiskManagement clause = entry.value;
          return customDataRow(
            clause: clause.clause,
            title: clause.title,
            refController: clause.refController,
            decisionController: clause.decisionController,
            isRisk: clause.isRisk,
            onRiskChanged: (bool value) => onClauseChange(index),
          );
        }).toList(),
      ),
    );
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
        DataCell(Text(title)),
        DataCell(
          TextFormField(controller: refController),
        ),
        DataCell(
          Row(
            children: [
              Expanded(
                child: RadioListTile<bool>(
                  title: const Text('Ada'),
                  activeColor: kPrimary,
                  value: true,
                  groupValue: isRisk,
                  onChanged: (bool? value) => onRiskChanged(value ?? false),
                ),
              ),
              Expanded(
                child: RadioListTile<bool>(
                  title: const Text('Tidak ada'),
                  activeColor: kPrimary,
                  value: false,
                  groupValue: isRisk,
                  onChanged: (bool? value) => onRiskChanged(value ?? false),
                ),
              ),
            ],
          ),
        ),
        DataCell(
          TextFormField(controller: decisionController),
        ),
      ],
    );
  }
}
