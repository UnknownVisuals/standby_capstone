import 'package:flutter/material.dart';
import 'package:standby_capstone/constants.dart';

class PerformanceMattersTable extends StatefulWidget {
  const PerformanceMattersTable({super.key});

  @override
  State<PerformanceMattersTable> createState() =>
      _PerformanceMattersTableState();
}

class _PerformanceMattersTableState extends State<PerformanceMattersTable> {
  final List<DataRow> _rows = [
    DataRow(
      cells: [
        DataCell(TextFormField()),
        DataCell(TextFormField()),
        DataCell(TextFormField()),
      ],
    ),
    DataRow(
      cells: [
        DataCell(TextFormField()),
        DataCell(TextFormField()),
        DataCell(TextFormField()),
      ],
    ),
    DataRow(
      cells: [
        DataCell(TextFormField()),
        DataCell(TextFormField()),
        DataCell(TextFormField()),
      ],
    ),
  ];

  void _addRow() {
    setState(() {
      _rows.add(
        DataRow(
          cells: [
            DataCell(TextFormField()),
            DataCell(TextFormField()),
            DataCell(TextFormField()),
          ],
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            columns: [
              DataColumn(
                label: Text(
                  'Daftar fungsi kinerja penting',
                  style: kTextHeading_Black,
                ),
              ),
              DataColumn(
                label: Text(
                  'Referensi nomor dokumen produsen atau referensi\ndari standard ini atau standard tetentu',
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
            rows: _rows,
          ),
        ),
        IconButton(
          icon: const Icon(Icons.add, color: kPrimary),
          onPressed: _addRow,
        ),
      ],
    );
  }
}
