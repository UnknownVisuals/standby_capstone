import 'package:flutter/material.dart';
import 'package:standby_capstone/components/card_info.dart';
import 'package:standby_capstone/constants.dart';

class MonitoringPage extends StatefulWidget {
  const MonitoringPage({super.key});

  @override
  State<MonitoringPage> createState() => _MonitoringPageState();
}

class _MonitoringPageState extends State<MonitoringPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Monitoring'),
      ),
      body: Container(
        color: kGray,
        child: const Padding(
          padding: EdgeInsets.fromLTRB(24, 24, 24, 0),
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
                title: '33°C',
                subtitle: 'Suhu\nKulit Bayi',
              ),
              SizedBox(height: 24),
              InfoCard(
                icon: Icons.heat_pump,
                title: 'OFF',
                subtitle: 'Suhu\nKulit Bayi',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
