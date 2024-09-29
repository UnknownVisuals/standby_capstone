import 'package:flutter/material.dart';
import 'package:standby_capstone/constants.dart';

class PanduanPage extends StatefulWidget {
  const PanduanPage({super.key});

  @override
  State<PanduanPage> createState() => _PanduanPageState();
}

class _PanduanPageState extends State<PanduanPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kGray,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: _generateExpansionTiles(),
          ),
        ),
      ),
    );
  }

  List<Widget> _generateExpansionTiles() {
    final sections = [
      {
        'mainTitle': '201.1 Ruang Lingkup, Tujuan dan Standar Terkait',
        'subSections': [
          {
            'subTitle': '201.1.1 Ruang Lingkup',
            'content': '''
Standar ini berlaku untuk keselamatan dasar dan kinerja esensial inkubator infant, sebagaimana didefinisikan pada 201.3.209, serta peralatan elektromedik. 

Jika pasal atau sub pasal hanya berlaku untuk peralatan elektromedik atau sistem elektromedik, ini akan dinyatakan dalam judul dan isi pasal. 

Standar ini tidak berlaku untuk gawai yang menyalurkan panas melalui selimut, alas, atau matras dalam penggunaan medis, penghangat infant (IEC 60601-2-21), inkubator transpor infant (IEC 60601-2-20), atau peralatan fototerapi infant (IEC 60601-2-50).

CATATAN Lihat juga 4.2 standar umum.

Standar khusus ini menetapkan persyaratan keselamatan untuk inkubator infant tetapi merubah metoda kesesuaian dengan pasal tertentu dengan cara menunjukkan keselamatan yang setara tidak akan dijustifikasi sebagai tidak sesuai jika pabrikan dapat menunjukkan dalam s bahwa risiko yang ditimbulkan karena bahaya telah diketahui sebagai tingkat yang dapat diterima pada saat ditimbang dengan manfaat perawatan dari gawai tersebut.

Standar khusus ini tidak berlaku untuk:
- gawai yang menyalurkan panas melalui selimut, alas atau matras dalam penggunaan medis, untuk informasi lihat IEC 80601-2-35 [3]2)
- peralatan penghangat infant, untuk informasi lihat IEC 60601-2-21 [2];
- inkubator transpor infant, untuk informasi lihat IEC 60601-2-20 [1];
- peralatan fototerapi infant, untuk informasi lihat IEC 60601-2-50 [4].
            '''
          },
          {
            'subTitle': '201.1.2 Tujuan',
            'content': '''
Tujuan standar khusus ini adalah untuk menetapkan persyaratan khusus keselamatan dasar dan kinerja esensial untuk inkubator infant sebagaimana didefinisikan pada 201.3.208, yangmampu meminimalkan bahaya bagi pasien dan operator, dan menentukan pengujian yang kesesuaiannya terhadap persyaratan dapat diverifikasi.
            '''
          },
          {
            'subTitle': '201.1.3 Standar Kolateral',
            'content': '''
Tambahan:

Standar khusus ini mengacu pada semua standar kolateral yang dapat ciaplikasikan sebagaimana tertulis pada pasal 2 standar umum dan pasal 2 standar khusus.

IEC 60601-1-2 dan IEC 60601-1-10 diberlakukan sebagaimana modifikasi yang dilakukan dalam pasal 202 dan 210 secara berurutan.

IEC 60601-1-3 tidak diberlakukan. Semua standar kolateral lain yang telah dipublikasikan dalam seri IEC 60601-1 diberlakukan pada saat dipublikasikan.

            '''
          },
          {
            'subTitle': '201.1.4 Standar Khusus',
            'content': '''
Penggantian:

Dalam seri IEC 60601, standar khusus dapat memodifkasi, mengganti atau menghapus persyaratan yang ada dalam standar umum dan standar kolateral untuk peralatan elektromedik yang sedang dipertimbangkan, dapat menambah persyaratan keselamatan dasar dan persyaratan kinerja esensial lainnya.

Persyaratan standar khusus mendapat prioritas dalam standar umum.

Singkatnya, IEC 60601-1 diacu dalam standar khusus ini sebagai standar umum. Standar kolateral diacu dalam nomor dokumennya.

Penomoran pasal dan sub pasal standar khusus ini sama dengan penomoran pada standar umum dengan awalan “201❞ (misalnya 201.1 dalam standar ini menyampaikan isi dari Pasal 1 standar umum) atau standar kolateral yang dapat diaplikasikan dengan awalan “20x" dimana x adalah digit akhir dari nomor dokumen standar kolateral (misalnya 202.4 dalam standar khusus ini menyampaikan isi Pasal 4 dari standar kolateral 60601-1-2. 203.4 dalam standar kolateral ini menyampaikan isi dari Pasal 4 standar kolateral 60601-1-3 dan seterusnya). Perubahan pada teks standar umum ditentukan dengan penggunaan kata sebagai berikut:

"Penggantian❞ berarti pasal atau sub pasal standar umum atau standar kolateral yang dapat diaplikasikan diganti semuanya dengan teks standar khusus ini.

"Tambahan" berarti teks standar khusus ini sebagai tambahan bagi persyaratan standar umum atau standar kolateral yang dapat diaplikasikan.

"Amandemen" berarti bahwa pasal atau sub pasal standar umum atau stancar kolateral yang dapat diaplikasikan diamandemen sebagaimana ditunjukkan pada teks dari standar khusus ini.

Sub pasal, gambar atau tabel sebagai tambahan bagi semua standar umum ciberi nomor mulai dari 201.101. Oleh karena itu, mengingat kenyataan bahwa definisi dalam standar umum diberi nomor mulai dari 3.1 sampai dengan 3.139, definisi tambahan dalam standar ini diberi nomor mulai dari 201.3.201. Lampiran tambahan diberi huruf AA, BB, dst.nya dan item tambahan aa), bb) dan seterusnya

Sub pasal atau gambar yang merupakan tambahan bagi semua standar kolateral diberi nomor mulai dari 20x, dimana "x' adalah nomor dari standar kolateral, misalnya 202 untuk IEC 60601-1-2, 203 untuk IEC 60601-1-3, dan seterusnya

Istilah “standar ini" digunakan untuk acuan bagi standar umum, setiap standar kolateral yang dapat diaplikasikan dan standar khusus ini menjadi satu.

Jika tidak ada pasal atau sub pasal dalam standar khusus ini, pasal atau sub pasal dari standar umum atau standar kolateral yang dapat diaplikasikan, meskipun mungkin tidak relevan, diaplikasikan tanpa modifikasi, dimana dimaksudkan setiap bagian dari standar umum atau standar kolateral, meskipun relevan, tidak diaplikasikan, pernyataan terhadap dampaknya diberikan dalam standar khusus ini.
            '''
          },
        ]
      }
    ];

    return sections.map((section) {
      return Container(
        margin: const EdgeInsets.only(bottom: 24),
        decoration: kEmbossDecoration,
        child: Theme(
          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
          child: ExpansionTile(
            iconColor: kPrimary,
            collapsedIconColor: kPrimary,
            title:
                Text(section['mainTitle'] as String, style: kTextHeading_Black),
            children:
                (section['subSections'] as List).map<Widget>((subSection) {
              return ExpansionTile(
                iconColor: kPrimary,
                collapsedIconColor: kPrimary,
                title: Text(subSection['subTitle']!, style: kTextHeading_Black),
                children: [
                  ListTile(
                    dense: true,
                    title:
                        Text(subSection['content']!, style: kTextNormal_Black),
                  ),
                ],
              );
            }).toList(),
          ),
        ),
      );
    }).toList();
  }
}
