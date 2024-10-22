import 'package:flutter/material.dart';

class MergedTable extends StatelessWidget {
  const MergedTable({super.key});

  @override
  Widget build(BuildContext context) {
    return Table(
      border: TableBorder.all(),
      columnWidths: const {
        0: FixedColumnWidth(100),
        1: FlexColumnWidth(),
      },
      children: [
        // Row with two cells, second one contains a nested table with a simulated merged column
        TableRow(children: [
          const Text('No.'),
          Table(
            border: TableBorder.all(),
            children: const [
              TableRow(
                children: [
                  // Using a Row to simulate the merging of columns
                  Row(
                    children: [
                      Expanded(
                        child: Center(
                          child: Text('Merged Data'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              TableRow(
                children: [
                  Text('data 1'),
                  Text('data 2'),
                ],
              ),
            ],
          ),
        ]),
        // Row with irregular column count, using Row for flexibility
        TableRow(children: [
          const Text('170 Volt'),
          Table(
            border: TableBorder.all(),
            children: [
              TableRow(children: [
                TextFormField(),
                TextFormField(),
              ]),
              TableRow(children: [
                // Simulating a merged row by wrapping with Row and Expanded
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(),
                    ),
                  ],
                ),
              ]),
            ],
          ),
        ]),
      ],
    );
  }
}
