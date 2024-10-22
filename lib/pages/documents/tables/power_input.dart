import 'package:flutter/material.dart';

class PowerInputTable extends StatelessWidget {
  const PowerInputTable({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columns: const [
          DataColumn(
            label: Text('Kondisi operasi dan Daya pengenal\n(W, A, VA)'),
          ),
          DataColumn(
            label: Text('Terukur'),
          ),
          DataColumn(
            label: Text('Hasil\n(W/ VA)'),
          ),
          DataColumn(
            label: Text('Catatan'),
          ),
        ],
        rows: [
          DataRow(
            cells: [
              DataCell(TextFormField()),
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
              DataCell(TextFormField()),
            ],
          ),
          DataRow(
            cells: [
              DataCell(TextFormField()),
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
              DataCell(TextFormField()),
            ],
          ),
          DataRow(
            cells: [
              DataCell(TextFormField()),
              DataCell(TextFormField()),
              DataCell(TextFormField()),
              DataCell(TextFormField()),
            ],
          ),
        ],
      ),
    );
  }
}
