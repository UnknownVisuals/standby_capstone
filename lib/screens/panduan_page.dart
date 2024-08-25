import 'package:flutter/material.dart';
import 'package:lorem_ipsum/lorem_ipsum.dart';
import 'package:standby_capstone/constants.dart';

class PanduanPage extends StatefulWidget {
  const PanduanPage({super.key});

  @override
  State<PanduanPage> createState() => _PanduanPageState();
}

class _PanduanPageState extends State<PanduanPage> {
  final _loremIpsumText =
      loremIpsum(words: 100, paragraphs: 2, initWithLorem: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: kGray,
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: _generateExpansionTiles(),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _generateExpansionTiles() {
    final titles = [
      '01. Ruang lingkup, tujuan dan standar terkait',
      '02. Acuan dan normatif',
      '03. Istilah dan definisi',
      '04. Persyaratan umum',
      '05. Persyaratan umum untuk pengujian alat elektromedik',
      '06. Klasifikasi peralatan elektromedik dan sistem elektromedik',
      '07. Identifikasi peralatan elektromedik, penandaan dan dokumen',
      '08. Proteksi terhadap bahaya listrik dari peraltan elektromedik',
      '09. Proteksi terhadap bahaya mekanis dari peraltan elektromedik dan sistem elektromedik',
      '10. Proteksi terhadap bahaya radiasi yang tidak diinginkan dan radiasi yang berlebihan',
      '11. Proteksi terhadap temperature yang belebihan dan bahaya lainnya',
      '12. Akurasi pengontrol dan instrumen dan proteksi terhadap keluaran yang berpotensi bahaya',
      '13. Situasi yang berpotensi bahaya dan kondisi kegagalan',
      '14. Sistem elektromedik terprogram/programmable electrical medical system (PEMS)',
      '15. Konstruksi peralatan elektromedik',
      '16. Sistem elektromedik',
      '17. Kompatibilitas elektromagnetik peralatan elektromedik dan sistem elektromedik'
    ];

    return titles.map((title) {
      return Container(
        margin: const EdgeInsets.only(bottom: 24),
        decoration: kEmbossDecoration,
        child: ExpansionTile(
          iconColor: kPrimary,
          collapsedIconColor: kPrimary,
          title: Text(title, style: kTextPanduanTitleBlack),
          children: [
            ListTile(
              dense: true,
              title: Text(_loremIpsumText, style: kTextPanduanBodyBlack),
            ),
          ],
        ),
      );
    }).toList();
  }
}
