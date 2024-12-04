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
                  'Kondisi operasi dan Daya pengenal\n(W, A, VA)',
                  textAlign: TextAlign.center,
                  style: kTextHeading_Black,
                ),
              ),
              DataColumn(
                label: Text(
                  'Daya\n(W/VA)',
                  textAlign: TextAlign.center,
                  style: kTextHeading_Black,
                ),
              ),
              DataColumn(
                label: Text(
                  'Arus\n(A)',
                  textAlign: TextAlign.center,
                  style: kTextHeading_Black,
                ),
              ),
              DataColumn(
                label: Text(
                  'Power faktor\n(cos φ)',
                  textAlign: TextAlign.center,
                  style: kTextHeading_Black,
                ),
              ),
              DataColumn(
                label: Text(
                  'Hasil\n(W/VA)',
                  textAlign: TextAlign.center,
                  style: kTextHeading_Black,
                ),
              ),
              DataColumn(
                label: Text(
                  'Catatan',
                  textAlign: TextAlign.center,
                  style: kTextHeading_Black,
                ),
              ),
            ],
            rows: widget.powerInput.map((powerInput) {
              return customDataRow(powerInput);
            }).toList(),
          ),
        ),
      ],
    );
  }

  DataRow customDataRow(PowerInputModel powerInput) {
    return DataRow(
      cells: [
        DataCell(Text(powerInput.voltageController)),
        DataCell(TextFormField(controller: powerInput.powerController)),
        DataCell(TextFormField(controller: powerInput.currentController)),
        DataCell(TextFormField(controller: powerInput.powerFactorController)),
        DataCell(
          ValueListenableBuilder(
            valueListenable: resultValue,
            builder: (context, value, child) {
              return TextFormField(
                controller: powerInput.resultController..text = value,
                onChanged: (newValue) => resultValue.value = newValue,
              );
            },
          ),
        ),
        DataCell(Text(powerInput.notesController)),
      ],
    );
  }
}
