import 'package:flutter/material.dart';
import 'package:standby_capstone/constants.dart';
import 'package:standby_capstone/pages/documents/models/performance_matters_model.dart';
import 'package:standby_capstone/pages/documents/tables/performance_matters_table.dart';

class PerformanceMattersPage extends StatefulWidget {
  final List<PerformanceMattersModel> matters;

  const PerformanceMattersPage({super.key, required this.matters});

  @override
  State<PerformanceMattersPage> createState() => _PerformanceMattersPageState();
}

class _PerformanceMattersPageState extends State<PerformanceMattersPage> {
  @override
  void initState() {
    super.initState();
    if (widget.matters.length < 3) {
      widget.matters.addAll(
        List.generate(
          3 - widget.matters.length,
          (_) => PerformanceMattersModel(),
        ),
      );
    }
  }

  void _addRow() {
    setState(() {
      widget.matters.add(PerformanceMattersModel());
    });
  }

  void _removeRow() {
    setState(() {
      widget.matters.removeLast();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: SizedBox(
        width: double.infinity,
        child: Text('4.3. TABEL: Kinerja penting.', style: kTextHeading_Red),
      ),
      children: [
        PerformanceMattersTable(performanceMatters: widget.matters),
        const SizedBox(height: 8),
        Container(
          width: 128,
          decoration: const BoxDecoration(
            color: kPrimary,
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                icon: const Icon(Icons.remove, color: kWhite),
                onPressed: _removeRow,
              ),
              Container(width: 1, height: 24, color: kWhite),
              IconButton(
                icon: const Icon(Icons.add, color: kWhite),
                onPressed: _addRow,
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          width: double.infinity,
          child: Text(
            'Informasi tambahan:',
            style: kTextHeading_Black.copyWith(fontSize: 12),
          ),
        ),
        SizedBox(
          width: double.infinity,
          child: Text(
            'Kinerja esensial adalah kinerja yang tidak ada atau penurunannya akan menghasilkan resiko yang tidak dapat diterima.',
            style: kTextNormal_Black.copyWith(fontSize: 12),
          ),
        ),
      ],
    );
  }
}
