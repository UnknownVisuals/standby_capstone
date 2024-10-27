import 'package:flutter/material.dart';
import 'package:standby_capstone/constants.dart';
import 'package:standby_capstone/pages/documents/models/power_input_model.dart';
import 'package:standby_capstone/pages/documents/tables/power_input_table.dart';

class PowerInputPage extends StatefulWidget {
  const PowerInputPage({super.key, required List<PowerInputModel> powers});

  @override
  State<PowerInputPage> createState() => _PowerInputPageState();
}

class _PowerInputPageState extends State<PowerInputPage> {
  final List<PowerInputModel> model0 = PowerInputModel.defaultPowers('100 V');
  final List<PowerInputModel> model1 = PowerInputModel.defaultPowers('170 V');
  final List<PowerInputModel> model2 = PowerInputModel.defaultPowers('200 V');

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: SizedBox(
        width: double.infinity,
        child: Text('4.11. TABEL. Input daya', style: kTextHeading_Red),
      ),
      children: [
        const SizedBox(height: 8),
        PowerInputTable(powerInput: model0),
        PowerInputTable(powerInput: model1),
        PowerInputTable(powerInput: model2),
        const SizedBox(height: 8),
      ],
    );
  }
}
