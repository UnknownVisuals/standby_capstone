import 'package:flutter/material.dart';
import 'package:standby_capstone/components/input_text.dart';
import 'package:standby_capstone/constants.dart';

class InputPage extends StatefulWidget {
  const InputPage({super.key});

  @override
  State<InputPage> createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  final List<bool> _checkboxValues = List.generate(20, (index) => false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: kGray,
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Container(
              decoration: kEmbossDecoration,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columns: [
                    DataColumn(
                      label: Text('Klausal', style: kTextTableTitleRed),
                    ),
                    DataColumn(
                      label: Text('Judul Klausal', style: kTextTableTitleRed),
                    ),
                    DataColumn(
                      label: Text('Dok Ref', style: kTextTableTitleRed),
                    ),
                    DataColumn(
                      label: Text('Ada/tidak', style: kTextTableTitleRed),
                    ),
                    DataColumn(
                      label: Text('Keputusan', style: kTextTableTitleRed),
                    ),
                  ],
                  rows: List.generate(20, (index) {
                    return DataRow(
                      cells: [
                        DataCell(
                          Text('${index + 1000}', style: kTextTableBodyBlack),
                        ),
                        DataCell(Text('Judul Klausal ${index + 1}',
                            style: kTextTableBodyBlack)),
                        const DataCell(
                          InputText(hintText: 'referensi'),
                        ),
                        DataCell(Checkbox(
                          value: _checkboxValues[index],
                          activeColor: kPrimary,
                          onChanged: (newValue) {
                            setState(() {
                              _checkboxValues[index] = newValue!;
                            });
                          },
                        )),
                        DataCell(
                          Text('LULUS ${index + 1}',
                              style: kTextTableBodyBlack),
                        ),
                      ],
                    );
                  }),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
