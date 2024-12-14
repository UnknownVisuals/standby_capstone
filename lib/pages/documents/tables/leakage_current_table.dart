import 'package:flutter/material.dart';
import 'package:standby_capstone/constants.dart';
import 'package:standby_capstone/pages/documents/models/leakage_current_model.dart';

class LekageCurrentTable extends StatelessWidget {
  final List<LeakageCurrentModel> leakageCurrent;

  const LekageCurrentTable({
    super.key,
    required this.leakageCurrent,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            columnSpacing: 16.0,
            columns: [
              DataColumn(
                label: Text(
                  'Jenis arus bocor',
                  textAlign: TextAlign.center,
                  style: kTextHeading_Black,
                ),
              ),
              DataColumn(
                label: Text(
                  '1 (µA)',
                  textAlign: TextAlign.center,
                  style: kTextHeading_Black,
                ),
              ),
              DataColumn(
                label: Text(
                  'Maks 1 (mA)',
                  textAlign: TextAlign.center,
                  style: kTextHeading_Black,
                ),
              ),
              DataColumn(
                label: Text(
                  'Hasil',
                  textAlign: TextAlign.center,
                  style: kTextHeading_Black,
                ),
              ),
            ],
            rows: leakageCurrent.asMap().entries.map((entry) {
              LeakageCurrentModel leakages = entry.value;
              return customDataRow(
                leakageCurrentType: leakages.leakageCurrentType,
                microAmpereController: leakages.microAmpere,
                maxMiliAmp: leakages.maxMiliAmp,
                resultController: leakages.result,
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  DataRow customDataRow({
    required String leakageCurrentType,
    required TextEditingController microAmpereController,
    required String maxMiliAmp,
    required TextEditingController resultController,
  }) {
    return DataRow(
      cells: [
        DataCell(Text(leakageCurrentType)),
        DataCell(TextFormField(controller: microAmpereController)),
        DataCell(Text(maxMiliAmp)),
        DataCell(TextFormField(controller: resultController)),
      ],
    );
  }
}
