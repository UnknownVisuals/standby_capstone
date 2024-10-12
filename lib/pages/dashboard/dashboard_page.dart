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

              final double currentDHT22Temp =
                  (latestSensorData?['dht22_temp'] ?? 0.0).toDouble();
              final double currentDHT22Humi =
                  (latestSensorData?['dht22_humi'] ?? 0.0).toDouble();
              final double currentDS18B20Temp1 =
                  (latestSensorData?['ds18b20_temp1'] ?? 0.0).toDouble();
              final double currentDS18B20Temp2 =
                  (latestSensorData?['ds18b20_temp2'] ?? 0.0).toDouble();
              final double currentDS18B20Temp3 =
                  (latestSensorData?['ds18b20_temp3'] ?? 0.0).toDouble();
              final double currentDS18B20Temp4 =
                  (latestSensorData?['ds18b20_temp4'] ?? 0.0).toDouble();
              final double currentFlowRate =
                  (latestSensorData?['flow_rate'] ?? 0.0).toDouble();
              final String currentFanStatus =
                  latestSensorData?['fan_status'] ?? 'Unknown';
              final String currentSoundStatus =
                  latestSensorData?['sound_detected'] ?? 'Unknown';

              return Column(
                children: [
                  Text('Date retrieved:', style: kTextHeading_Black),
                  Text(formattedDate, style: kTextHeading_Red),
                  const SizedBox(height: 24),
                  InfoCard(
                    icon: Icons.thermostat_rounded,
                    title: '$currentDHT22Temp°C',
                    subtitle: 'DHT22\nTemperature',
                  ),
                  const SizedBox(height: 24),
                  InfoCard(
                    icon: Icons.water_drop_rounded,
                    title: '$currentDHT22Humi%',
                    subtitle: 'DHT22\nHumidity',
                  ),
                  const SizedBox(height: 24),
                  InfoCard(
                    icon: Icons.thermostat_rounded,
                    title: '$currentDS18B20Temp1°C',
                    subtitle: 'DS18B20 - 1\nTemperature',
                  ),
                  const SizedBox(height: 24),
                  InfoCard(
                    icon: Icons.thermostat_rounded,
                    title: '$currentDS18B20Temp2°C',
                    subtitle: 'DS18B20 - 2\nTemperature',
                  ),
                  const SizedBox(height: 24),
                  InfoCard(
                    icon: Icons.thermostat_rounded,
                    title: '$currentDS18B20Temp3°C',
                    subtitle: 'DS18B20 - 3\nTemperature',
                  ),
                  const SizedBox(height: 24),
                  InfoCard(
                    icon: Icons.thermostat_rounded,
                    title: '$currentDS18B20Temp4°C',
                    subtitle: 'DS18B20 - 4\nTemperature',
                  ),
                  const SizedBox(height: 24),
                  InfoCard(
                    icon: Icons.heat_pump_rounded,
                    title: currentFanStatus,
                    subtitle: 'Fan Status',
                  ),
                  const SizedBox(height: 24),
                  InfoCard(
                    icon: Icons.air_rounded,
                    title: '$currentFlowRate',
                    subtitle: 'Flow Rate',
                  ),
                  const SizedBox(height: 24),
                  InfoCard(
                    icon: Icons.volume_up_rounded,
                    title: currentSoundStatus,
                    subtitle: 'Sound Status',
                  ),
                  const SizedBox(height: 24 * 3),
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
          Icons.timeline_rounded,
          color: kWhite,
        ),
      ),
    );
  }
}
