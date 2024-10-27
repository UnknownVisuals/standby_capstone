import 'package:flutter/material.dart';
import 'package:standby_capstone/constants.dart';
import 'package:standby_capstone/pages/documents/models/power_input_model.dart';

class PowerInputTable extends StatefulWidget {
  final List<PowerInputModel> powerInput;

  const PowerInputTable({super.key, required this.powerInput});

  @override
  State<PowerInputTable> createState() => _PowerInputTableState();
}

class _PowerInputTableState extends State<PowerInputTable> {
  final ValueNotifier<String> resultValue = ValueNotifier<String>('');

  @override
  void dispose() {
    resultValue.dispose();
    super.dispose();
  }

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
                  'Kondisi operasi dan\nDaya pengenal\n(W, A, VA)',
                  style: kTextHeading_Black,
                ),
              ),
              DataColumn(
                label: Text(
                  'Daya (W/VA)\nTerukur',
                  style: kTextHeading_Black,
                ),
              ),
              DataColumn(
                label: Text(
                  'Arus (A)\nTerukur',
                  style: kTextHeading_Black,
                ),
              ),
              DataColumn(
                label: Text(
                  'Power faktor\n(cos theta)\nTerukur',
                  style: kTextHeading_Black,
                ),
              ),
              DataColumn(
                label: Text(
                  'Hasil\n(W/ VA)',
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
            rows: widget.powerInput.map((powerInput) {
              return customDataRow(
                voltageController: powerInput.voltageController,
                powerController: powerInput.powerController,
                currentController: powerInput.currentController,
                powerFactorController: powerInput.powerFactorController,
                resultController: powerInput.resultController,
                notesController: powerInput.notesController,
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  DataRow customDataRow({
    required String voltageController,
    required TextEditingController powerController,
    required TextEditingController currentController,
    required TextEditingController powerFactorController,
    required TextEditingController resultController,
    required String notesController,
  }) {
    return DataRow(
      cells: [
        DataCell(Text(voltageController)),
        DataCell(
          TextFormField(controller: powerController),
        ),
        DataCell(
          TextFormField(controller: currentController),
        ),
        DataCell(
          TextFormField(controller: powerFactorController),
        ),
        DataCell(
          ValueListenableBuilder(
            valueListenable: resultValue,
            builder: (context, value, child) {
              return TextFormField(
                controller: resultController..text = value,
                onChanged: (newValue) => resultValue.value = newValue,
              );
            },
          ),
        ),
        DataCell(Text(notesController)),
      ],
    );
  }
}
