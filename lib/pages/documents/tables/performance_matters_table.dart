import 'package:flutter/material.dart';
import 'package:standby_capstone/constants.dart';
import 'package:standby_capstone/pages/documents/models/performance_matters_model.dart';

class PerformanceMattersTable extends StatelessWidget {
  final List<PerformanceMattersModel> performanceMatters;

  const PerformanceMattersTable({
    super.key,
    required this.performanceMatters,
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
                  'Daftar fungsi kinerja penting',
                  style: kTextHeading_Black,
                ),
              ),
              DataColumn(
                label: Text(
                  'Referensi nomor dokumen produsen atau referensi\ndari standard ini atau standard tertentu',
                  style: kTextHeading_Black,
                ),
              ),
              DataColumn(
                label: Text(
                  'Catatan',
                  style: kTextHeading_Black,
                ),
              ),
            ],
            rows: performanceMatters.asMap().entries.map((entry) {
              PerformanceMattersModel matters = entry.value;
              return customDataRow(
                mattersController: matters.perfMattersController,
                refController: matters.docsReferenceController,
                notesController: matters.notesController,
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  DataRow customDataRow({
    required TextEditingController mattersController,
    required TextEditingController refController,
    required TextEditingController notesController,
  }) {
    return DataRow(
      cells: [
        DataCell(
          TextFormField(controller: mattersController),
        ),
        DataCell(
          TextFormField(controller: refController),
        ),
        DataCell(
          TextFormField(controller: notesController),
        ),
      ],
    );
  }
}
