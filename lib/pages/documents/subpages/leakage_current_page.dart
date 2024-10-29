import 'package:flutter/material.dart';
import 'package:standby_capstone/constants.dart';
import 'package:standby_capstone/pages/documents/models/leakage_current_model.dart';
import 'package:standby_capstone/pages/documents/tables/leakage_current_table.dart';

class LeakageCurrentPage extends StatefulWidget {
  final List<LeakageCurrentModel> leakages;

  const LeakageCurrentPage({super.key, required this.leakages});

  @override
  State<LeakageCurrentPage> createState() => _LeakageCurrentPageState();
}

class _LeakageCurrentPageState extends State<LeakageCurrentPage> {
  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: SizedBox(
        width: double.infinity,
        child: Text('8.7. TABEL. Arus bocor.', style: kTextHeading_Red),
      ),
      children: [
        LekageCurrentTable(leakageCurrent: widget.leakages),
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
            'Catatan 1: Untuk kebocoran arus pembumian lihat 8.7.3 d) dan 8.7 45;',
            style: kTextNormal_Black.copyWith(fontSize: 12),
          ),
        ),
        SizedBox(
          width: double.infinity,
          child: Text(
            'Catatan 2: Untuk arus sentuh lihat 8.7.3 c) dan 8 7 4.6;',
            style: kTextNormal_Black.copyWith(fontSize: 12),
          ),
        ),
        SizedBox(
          width: double.infinity,
          child: Text(
            'Catatan 3: Untuk arus pelengkap pasien lihat 8.7.3 b) dan 8.7 4.7;',
            style: kTextNormal_Black.copyWith(fontSize: 12),
          ),
        ),
        SizedBox(
          width: double.infinity,
          child: Text(
            'Catatan 4: Nila total arus bocor pasien hanya relatif terhadap peralatan dengan multipel bagian yang diaplikasikan dari tipe yang sama. Lihat 8.7.4.7 h). Bagian yang diaplikasikan individu sesuai dengan nilai arus pelengkap pasien.',
            style: kTextNormal_Black.copyWith(fontSize: 12),
          ),
        ),
        SizedBox(
          width: double.infinity,
          child: Text(
            'Catatan 5: Selain kondisi yang ditunjukkan dalam TABEL, pengujian dilakukan pada suhu operasi dan setelah kondisi kelembaban awal 5.7. peralatan diberi energi dalam kondisi stanby dan beroperasi penuh, frekuensi suplai pengenal maks, pada 110% dari pengenal tegangan utama, dan setelah pengujian yang relevan dari Klausul 11.6 (yaitu, luapan, tumpahan, kebocoran, masuknya air dan materi partikulat, pembersihan & desinfeksi, & sterilisasi).',
            style: kTextNormal_Black.copyWith(fontSize: 12),
          ),
        ),
      ],
    );
  }
}
