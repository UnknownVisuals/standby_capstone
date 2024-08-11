import 'package:flutter/material.dart';
import 'package:standby_capstone/constants.dart';
import 'package:standby_capstone/components/card_info.dart';

class MonitoringPage extends StatefulWidget {
  const MonitoringPage({super.key});

  @override
  State<MonitoringPage> createState() => _MonitoringPageState();
}

class _MonitoringPageState extends State<MonitoringPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          color: kGray,
          child: const Padding(
            padding: EdgeInsets.all(24),
            child: Column(
              children: [
                InfoCard(
                  icon: Icons.device_thermostat,
                  title: '33°C',
                  subtitle: 'Suhu\nInkubator Bayi',
                ),
                SizedBox(height: 24),
                InfoCard(
                  icon: Icons.water_drop,
                  title: '96%',
                  subtitle: 'Kelembaban\nInkubator Bayi',
                ),
                SizedBox(height: 24),
                InfoCard(
                  icon: Icons.child_care,
                  title: '36°C',
                  subtitle: 'Suhu\nKulit Bayi',
                ),
                SizedBox(height: 24),
                InfoCard(
                  icon: Icons.heat_pump,
                  title: 'OFF',
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
