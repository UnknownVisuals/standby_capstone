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
  void _addListenersToControllers(PowerInputModel power) {
    power.powerController.addListener(() {
      setState(() {});
    });
    power.currentController.addListener(() {
      setState(() {});
    });
    power.powerFactorController.addListener(() {
      setState(() {});
    });
  }

  double _calculateMean(List<TextEditingController> controllers) {
    double sum = 0.0;
    int count = 0;
    for (var controller in controllers) {
      final value = double.tryParse(controller.text);
      if (value != null) {
        sum += value;
        count++;
      }
    }
    return count > 0 ? sum / count : 0.0;
  }

  @override
  void initState() {
    super.initState();
    for (var power in widget.powerInput) {
      _addListenersToControllers(power);
    }
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
                  'Catatan',
                  textAlign: TextAlign.center,
                  style: kTextHeading_Black,
                ),
              ),
            ],
            rows: [
              ...widget.powerInput.map((powerInput) {
                return _customDataRow(powerInput);
              }),
              _averageRow(),
            ],
          ),
        ),
      ],
    );
  }

  DataRow _customDataRow(PowerInputModel powerInput) {
    return DataRow(
      cells: [
        DataCell(Text(powerInput.voltageController)),
        DataCell(
          TextFormField(
            controller: powerInput.powerController,
            keyboardType: TextInputType.number,
          ),
        ),
        DataCell(
          TextFormField(
            controller: powerInput.currentController,
            keyboardType: TextInputType.number,
          ),
        ),
        DataCell(
          TextFormField(
            controller: powerInput.powerFactorController,
            keyboardType: TextInputType.number,
          ),
        ),
        DataCell(Text(powerInput.notesController)),
      ],
    );
  }

  DataRow _averageRow() {
    return DataRow(
      cells: [
        DataCell(
          Center(
            child: Text('Rata-rata', style: kTextHeading_Black),
          ),
        ),
        DataCell(
          Center(
            child: Text(
              _calculateMean(
                widget.powerInput.map((e) => e.powerController).toList(),
              ).toStringAsFixed(2),
            ),
          ),
        ),
        DataCell(
          Center(
            child: Text(
              _calculateMean(
                widget.powerInput.map((e) => e.currentController).toList(),
              ).toStringAsFixed(2),
            ),
          ),
        ),
        DataCell(
          Center(
            child: Text(
              _calculateMean(
                widget.powerInput.map((e) => e.powerFactorController).toList(),
              ).toStringAsFixed(2),
            ),
          ),
        ),
        const DataCell(Center(child: Text(''))),
      ],
    );
  }
}
