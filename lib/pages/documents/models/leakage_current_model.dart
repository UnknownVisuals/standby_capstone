import 'package:flutter/material.dart';

class LeakageCurrentModel {
  final String leakageCurrentType;
  final TextEditingController microAmpere = TextEditingController();
  final String maxMiliAmp;
  final TextEditingController result = TextEditingController();

  LeakageCurrentModel({
    required this.leakageCurrentType,
    required this.maxMiliAmp,
  });

  static List<LeakageCurrentModel> defaultLeakageCurrent() {
    return [
      LeakageCurrentModel(
        leakageCurrentType: 'Kebocoran pembumian',
        maxMiliAmp: '5mA kondisi normal, 10mA kondisi kegagalan tunggal',
      ),
      LeakageCurrentModel(
        leakageCurrentType: 'Arus sentuh',
        maxMiliAmp: '100µA kondisi normal, 500µA kondisi kegagalan tunggal',
      ),
      LeakageCurrentModel(
        leakageCurrentType: 'Arus bocor pasien',
        maxMiliAmp:
            'Tipe B atau BF 10µA kondisi normal, 50µA kondisi kegagalan tunggal (dc); 100µA kondisi normal, 500µA kondisi kegagalan tunggal (ac); Tipe CF 10µA kondisi normal; 50µA kondisi kegagalan tunggal (dc atau ac)',
      ),
      LeakageCurrentModel(
        leakageCurrentType:
            'Arus bocor pasien dengan tegangan luar pada bagian sinyal input/output',
        maxMiliAmp:
            'Tipe B atau BF 10µA kondisi normal, 50µA kondisi kegagalan tunggal (dc); 100µA kondisi normal, 500µA kondisi kegagalan tunggal (ac); Tipe CF 10µA kondisi normal; 50µA kondisi kegagalan tunggal (dc atau ac)',
      ),
      LeakageCurrentModel(
        leakageCurrentType:
            'Arus bocor pasien dengan tegangan luar pada bagian metal yang dapat diakses yang tidak dibumikan',
        maxMiliAmp: 'Tipe B atau BF: 500µA',
      ),
      LeakageCurrentModel(
        leakageCurrentType: 'Arus pelengkap pasien',
        maxMiliAmp:
            'Tipe B atau BF 10µA kondisi normal, 50µA kondisi kegagalan tunggal (dc); 100µA kondisi normal, 500µA kondisi kegagalan tunggal (ac); Tipe CF 10µA kondisi normal; 50µA kondisi kegagalan tunggal (dc atau ac)',
      ),
      LeakageCurrentModel(
        leakageCurrentType:
            'Total arus bocor pasien dengan semua sampel dari tipe yang sama koneksi bersama',
        maxMiliAmp:
            'Tipe B atau BF 10µA kondisi normal, 50µA kondisi kegagalan tunggal (dc); 100µA kondisi normal, 500µA kondisi kegagalan tunggal (ac); Tipe CF 10µA kondisi normal; 50µA kondisi kegagalan tunggal (dc atau ac)',
      ),
      LeakageCurrentModel(
        leakageCurrentType:
            'Total arus bocor pasien dengan semua sampel dari tipe yang sama koneksi bersama dengan tegangan luar pada SIP/SOP',
        maxMiliAmp:
            'Tipe B atau BF 10µA kondisi normal, 50µA kondisi kegagalan tunggal (dc); 100µA kondisi normal, 500µA kondisi kegagalan tunggal (ac); Tipe CF 10µA kondisi normal; 50µA kondisi kegagalan tunggal (dc atau ac)',
      ),
      LeakageCurrentModel(
        leakageCurrentType:
            'Total arus bocor pasien dengan semua sampel dari tipe yang sama koneksi bersama dengan tegangan luar pada tipe F',
        maxMiliAmp: 'Tipe BF: 500µA, Tipe CF: 100µA',
      ),
      LeakageCurrentModel(
        leakageCurrentType:
            'Total arus bocor pasien dengan semua sampel dari tipe yang sama koneksi bersama dengan tegangan luar pada bagian metal yang dapat diakses yang tidak dibumikan',
        maxMiliAmp: 'Tipe B & BF: 500µA',
      ),
    ];
  }
}
