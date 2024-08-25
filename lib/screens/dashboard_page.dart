import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:standby_capstone/constants.dart';
import 'package:standby_capstone/components/card_info.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  String _currentIncubatorTemp = '0';
  String _currentIncubatorHumi = '0';
  String _currentSkinTemp = '0';
  String _currentFanStatus = 'OFF';

  final _database = FirebaseDatabase.instance.ref();

  @override
  void initState() {
    super.initState();
    _readData();
  }

  void _readData() {
    _database.child('sensor_data').onValue.listen((event) {
      final data = event.snapshot.value as Map<dynamic, dynamic>;
      setState(() {
        _currentIncubatorTemp =
            data['DHT22']?['temperature']?.toString() ?? '0';
        _currentIncubatorHumi = data['DHT22']?['humidity']?.toString() ?? '0';
        _currentSkinTemp = data['DS18B20']?['temperature']?.toString() ?? '0';
        _currentFanStatus = data['fan_status']?.toString() ?? 'OFF';
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          color: kGray,
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                InfoCard(
                  icon: Icons.device_thermostat,
                  title: '$_currentIncubatorTemp°C',
                  subtitle: 'Suhu\nInkubator Bayi',
                ),
                const SizedBox(height: 24),
                InfoCard(
                  icon: Icons.water_drop,
                  title: '$_currentIncubatorHumi%',
                  subtitle: 'Kelembaban\nInkubator Bayi',
                ),
                const SizedBox(height: 24),
                InfoCard(
                  icon: Icons.child_care,
                  title: '$_currentSkinTemp°C',
                  subtitle: 'Suhu\nKulit Bayi',
                ),
                const SizedBox(height: 24),
                InfoCard(
                  icon: Icons.heat_pump,
                  title: _currentFanStatus,
                  subtitle: 'Kipas\nPendingin',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
