import 'package:flutter/material.dart';
import 'package:standby_capstone/constants.dart';
import 'package:standby_capstone/pages/documents/models/power_input_model.dart';
import 'package:standby_capstone/pages/documents/tables/power_input_table.dart';

class PowerInputPage extends StatefulWidget {
  final String voltage;
  final List<PowerInputModel> powers;

  const PowerInputPage({
    super.key,
    required this.powers,
    required this.voltage,
  });

  @override
  State<PowerInputPage> createState() => _PowerInputPageState();
}

class _PowerInputPageState extends State<PowerInputPage> {
  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: SizedBox(
        width: double.infinity,
        child: Text(
          '4.11. TABEL. Input daya ${widget.voltage}',
          style: kTextHeading_Red,
        ),
      ),
      children: [PowerInputTable(powerInput: widget.powers)],
    );
  }
}
