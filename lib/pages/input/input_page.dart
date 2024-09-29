import 'package:flutter/material.dart';
import 'package:standby_capstone/constants.dart';

class InputPage extends StatefulWidget {
  const InputPage({super.key});

  @override
  State<InputPage> createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  bool _isRisk = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kGray,
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: SingleChildScrollView(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columns: [
                DataColumn(
                  label: Text('Klausul', style: kTextHeading_Red),
                ),
                DataColumn(
                  label: Text('Judul Klausul', style: kTextHeading_Red),
                ),
                DataColumn(
                  label: Text('Dok Ref FMR (Dok No./hal)',
                      style: kTextHeading_Red),
                ),
                DataColumn(
                  label: Text('Ada/tidak ada dalam file manajemen risiko',
                      style: kTextHeading_Red),
                ),
                DataColumn(
                  label: Text('Keputusan', style: kTextHeading_Red),
                ),
              ],
              rows: [
                DataRow(
                  cells: [
                    const DataCell(Text('3.1')),
                    const DataCell(Text('Proses manajemen risiko')),
                    DataCell(TextFormField()),
                    DataCell(
                      Row(
                        children: [
                          Expanded(
                            child: RadioListTile<bool>(
                              title: Text('Ada', style: kTextHeading_Black),
                              activeColor: kPrimary,
                              value: true,
                              groupValue: _isRisk,
                              onChanged: (bool? value) {
                                setState(() {
                                  _isRisk = value ?? false;
                                });
                              },
                            ),
                          ),
                          Expanded(
                            child: RadioListTile<bool>(
                              title:
                                  Text('Tidak ada', style: kTextHeading_Black),
                              activeColor: kPrimary,
                              value: false,
                              groupValue: _isRisk,
                              onChanged: (bool? value) {
                                setState(() {
                                  _isRisk = value ?? false;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    DataCell(TextFormField()),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
