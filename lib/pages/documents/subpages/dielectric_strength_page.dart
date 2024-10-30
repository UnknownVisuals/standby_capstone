import 'package:flutter/material.dart';
import 'package:standby_capstone/constants.dart';
import 'package:standby_capstone/pages/documents/models/dielectric_strength_model.dart';
import 'package:standby_capstone/pages/documents/tables/dielectric_strength_table.dart';

class DielectrictStrengthPage extends StatefulWidget {
  final List<DielectricStrengthModel> dielectrics;

  const DielectrictStrengthPage({super.key, required this.dielectrics});

  @override
  State<DielectrictStrengthPage> createState() =>
      _DielectrictStrengthPageState();
}

class _DielectrictStrengthPageState extends State<DielectrictStrengthPage> {
  @override
  void initState() {
    super.initState();
    if (widget.dielectrics.length < 3) {
      widget.dielectrics.addAll(
        List.generate(
          3 - widget.dielectrics.length,
          (_) => DielectricStrengthModel(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: SizedBox(
        width: double.infinity,
        child: Text(
            '8.8.3. TABEL. Uji kekuatan dielektrik bahan insulasi padat dengan fungsi kemanan - Sarana perlingdungan operator (SPO) / Sarana perlindungan pasien (SPP).',
            style: kTextHeading_Red),
      ),
      children: [
        DielectricStrengthTable(dielectricStrength: widget.dielectrics),
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
            'Alternatifnya, sesuai TABEL (is., dc), a dc tegangan uji sama dengan nilai puncak a c. tegangan uji digunakan. 2A) Segera setelah perlakuan kelembaban 5.7, Peralatan elektromedik dihilangkan energi, B) setelah prosedur sterilisasi diperlukan, peralatan elektromedik dihilangkan energi, C) setelah mencapai suhu operasi steady state seperti selama uji pemanasan 11.1.1, dan D) setelah pengujian yang relevan dan 11.6 (yaitu, luapan, tumpahan. kebocoran, masuknya air pembersihan, desinfeksi, dan sterilisasi)',
            style: kTextNormal_Black.copyWith(fontSize: 12),
          ),
        ),
      ],
    );
  }
}
