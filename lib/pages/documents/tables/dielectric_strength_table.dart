import 'package:flutter/material.dart';
import 'package:standby_capstone/constants.dart';
import 'package:standby_capstone/pages/documents/models/dielectric_strength_model.dart';

class DielectricStrengthTable extends StatelessWidget {
  final List<DielectricStrengthModel> dielectricStrength;

  const DielectricStrengthTable({
    super.key,
    required this.dielectricStrength,
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
                  'Isolasi sample yang diuji\n(area dari diagram isolasi)',
                  textAlign: TextAlign.center,
                  style: kTextHeading_Black,
                ),
              ),
              DataColumn(
                label: Text(
                  'Tipe insulasi\n(1 or 2 SPO/SPP)',
                  textAlign: TextAlign.center,
                  style: kTextHeading_Black,
                ),
              ),
              DataColumn(
                label: Text(
                  'Tegangan Kerja Puncak\nVpeak',
                  textAlign: TextAlign.center,
                  style: kTextHeading_Black,
                ),
              ),
              DataColumn(
                label: Text(
                  'Tegangan Kerja Puncak\nV d.c.',
                  textAlign: TextAlign.center,
                  style: kTextHeading_Black,
                ),
              ),
              DataColumn(
                label: Text(
                  'AC tegangan uji pada\nV r.m.s',
                  textAlign: TextAlign.center,
                  style: kTextHeading_Black,
                ),
              ),
              DataColumn(
                label: Text(
                  'Kerusakan dielektrik setelah\n1 menit (Ya / Tidak)',
                  textAlign: TextAlign.center,
                  style: kTextHeading_Black,
                ),
              ),
            ],
            rows: dielectricStrength.asMap().entries.map((entry) {
              DielectricStrengthModel dielectric = entry.value;
              return customDataRow(
                sampleIsolationController: dielectric.sampleIsolationController,
                insulationTypeController: dielectric.insulationTypeController,
                voltagePeakController: dielectric.voltagePeakController,
                voltagePeakDCController: dielectric.voltagePeakDCController,
                voltageTestController: dielectric.voltageTestController,
                dielectricDamageController:
                    dielectric.dielectricDamageController,
              );
            }).toList(),
          ),
        )
      ],
    );
  }

  DataRow customDataRow({
    required TextEditingController sampleIsolationController,
    required TextEditingController insulationTypeController,
    required TextEditingController voltagePeakController,
    required TextEditingController voltagePeakDCController,
    required TextEditingController voltageTestController,
    required TextEditingController dielectricDamageController,
  }) {
    return DataRow(
      cells: [
        DataCell(TextFormField(controller: sampleIsolationController)),
        DataCell(TextFormField(controller: insulationTypeController)),
        DataCell(TextFormField(controller: voltagePeakController)),
        DataCell(TextFormField(controller: voltagePeakDCController)),
        DataCell(TextFormField(controller: voltageTestController)),
        DataCell(TextFormField(controller: dielectricDamageController)),
      ],
    );
  }
}
