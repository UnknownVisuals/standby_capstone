import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:standby_capstone/constants.dart';
import 'package:standby_capstone/components/card_info.dart';
import 'package:standby_capstone/main.dart';
import 'package:standby_capstone/pages/dashboard/sensors_data.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final _sensorStream = supabase.from('esp32').stream(primaryKey: ['id']);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kGray,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: StreamBuilder(
            stream: _sensorStream,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(kPrimary),
                  ),
                );
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text('No sensors data available.'));
              }

              final latestSensorData = snapshot.data?.last;

              final formattedDate = (latestSensorData?['created_at'] != null)
                  ? DateFormat.yMMMMEEEEd().add_jms().format(
                      DateTime.parse(latestSensorData!['created_at']).toLocal())
                  : 'Invalid timestamp';

              final double currentIncubatorTemp =
                  (latestSensorData?['dht22_temp'] ?? 0.0).toDouble();
              final double currentIncubatorHumi =
                  (latestSensorData?['dht22_humi'] ?? 0.0).toDouble();
              final double currentSkinTemp =
                  (latestSensorData?['ds18b20_temp'] ?? 0.0).toDouble();
              final String currentFanStatus =
                  latestSensorData?['fan_status'] ?? 'Unknown';

              return Column(
                children: [
                  Text('Date retrieved:', style: kTextHeading_Black),
                  Text(formattedDate, style: kTextHeading_Red),
                  const SizedBox(height: 24),
                  InfoCard(
                    icon: Icons.device_thermostat,
                    title: '$currentIncubatorTemp°C',
                    subtitle: 'Suhu\nInkubator Bayi',
                  ),
                  const SizedBox(height: 24),
                  InfoCard(
                    icon: Icons.water_drop,
                    title: '$currentIncubatorHumi%',
                    subtitle: 'Kelembaban\nInkubator Bayi',
                  ),
                  const SizedBox(height: 24),
                  InfoCard(
                    icon: Icons.child_care,
                    title: '$currentSkinTemp°C',
                    subtitle: 'Suhu\nKulit Bayi',
                  ),
                  const SizedBox(height: 24),
                  InfoCard(
                    icon: Icons.heat_pump,
                    title: currentFanStatus,
                    subtitle: 'Kipas\nPendingin',
                  ),
                  const SizedBox(height: 64),
                ],
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const SensorsData(),
            ),
          );
        },
        backgroundColor: kPrimary,
        shape: const CircleBorder(),
        child: const Icon(
          Icons.ssid_chart_rounded,
          color: kWhite,
        ),
      ),
    );
  }
}
