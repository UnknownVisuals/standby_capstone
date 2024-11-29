import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rxdart/rxdart.dart';
import 'package:standby_capstone/components/card_info.dart';
import 'package:standby_capstone/constants.dart';
import 'package:standby_capstone/main.dart';
import 'package:standby_capstone/pages/dashboard/sensors_data_page.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final _sensorStream1 = supabase.from('esp32_1').stream(primaryKey: ['id']);
  final _sensorStream2 = supabase.from('esp32_2').stream(primaryKey: ['id']);

  late final stream = Rx.combineLatest2(
    _sensorStream1,
    _sensorStream2,
    (data1, data2) => {'esp32_1': data1, 'esp32_2': data2},
  );

  Future<void> _refreshData() async {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kGray,
      body: RefreshIndicator(
        onRefresh: _refreshData,
        backgroundColor: kPrimary,
        color: kWhite,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: StreamBuilder<Map<String, dynamic>>(
              stream: stream,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(kPrimary),
                    ),
                  );
                }

                // else if (snapshot.hasError) {
                //   return Center(child: Text('Error: ${snapshot.error}'));
                // } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                //   return const Center(child: Text('No sensor data available.'));
                // }

                final esp32_1 = snapshot.data?['esp32_1']?.last;
                final esp32_2 = snapshot.data?['esp32_2']?.last;

                final formattedDate = (esp32_1?['created_at'] != null)
                    ? DateFormat('EEEE, d MMMM y - kk:mm:ss a').format(
                        DateTime.parse(esp32_1!['created_at']).toLocal(),
                      )
                    : 'Invalid timestamp';

                final double currentDHT22Temp =
                    (esp32_1?['dht22_temp'] ?? 0.0).toDouble();
                final double currentDHT22Humi =
                    (esp32_1?['dht22_humi'] ?? 0.0).toDouble();
                final double currentDS18B20Temp1 =
                    (esp32_1?['ds18b20_temp1'] ?? 0.0).toDouble();
                final double currentDS18B20Temp2 =
                    (esp32_1?['ds18b20_temp2'] ?? 0.0).toDouble();
                final double currentDS18B20Temp3 =
                    (esp32_1?['ds18b20_temp3'] ?? 0.0).toDouble();
                final double currentDS18B20Temp4 =
                    (esp32_1?['ds18b20_temp4'] ?? 0.0).toDouble();
                final double currentFlowRate =
                    (esp32_1?['flow_rate'] ?? 0.0).toDouble();
                final String currentFanStatus =
                    esp32_1?['fan_status'] ?? 'Unknown';
                final String currentSoundStatus =
                    esp32_1?['sound_detected'] ?? 'Unknown';

                final double currentSoundLevel =
                    (esp32_2?['sound_level'] ?? 0.0).toDouble();
                final double currentLightLux =
                    (esp32_2?['light_lux'] ?? 0.0).toDouble();
                final double currentMq135ppm =
                    (esp32_2?['mq135_ppm'] ?? 0.0).toDouble();
                final double currentOtherTemp =
                    (esp32_2?['temperature'] ?? 0.0).toDouble();
                final String currentRelayStatus =
                    esp32_2?['relay_status'] ?? 'Unknown';
                final double currentBPM = (esp32_2?['bpm'] ?? 0.0).toDouble();
                final double currentSPO2 = (esp32_2?['spo2'] ?? 0.0).toDouble();

                return Column(
                  children: [
                    Text('Date retrieved:', style: kTextHeading_Black),
                    Text(formattedDate, style: kTextHeading_Red),
                    const SizedBox(height: 24),
                    InfoCard(
                      icon: Icons.thermostat_rounded,
                      value: '$currentDHT22Temp',
                      unit: '°C',
                      description: 'DHT22\nTemperature',
                    ),
                    const SizedBox(height: 24),
                    InfoCard(
                      icon: Icons.water_drop_rounded,
                      value: '$currentDHT22Humi',
                      unit: '%',
                      description: 'DHT22\nHumidity',
                    ),
                    const SizedBox(height: 24),
                    InfoCard(
                      icon: Icons.thermostat_rounded,
                      value: '$currentDS18B20Temp1',
                      unit: '°C',
                      description: 'DS18B20 - 1\nTemperature',
                    ),
                    const SizedBox(height: 24),
                    InfoCard(
                      icon: Icons.thermostat_rounded,
                      value: '$currentDS18B20Temp2',
                      unit: '°C',
                      description: 'DS18B20 - 2\nTemperature',
                    ),
                    const SizedBox(height: 24),
                    InfoCard(
                      icon: Icons.thermostat_rounded,
                      value: '$currentDS18B20Temp3',
                      unit: '°C',
                      description: 'DS18B20 - 3\nTemperature',
                    ),
                    const SizedBox(height: 24),
                    InfoCard(
                      icon: Icons.thermostat_rounded,
                      value: '$currentDS18B20Temp4',
                      unit: '°C',
                      description: 'DS18B20 - 4\nTemperature',
                    ),
                    const SizedBox(height: 24),
                    InfoCard(
                      icon: Icons.heat_pump_rounded,
                      value: currentFanStatus,
                      unit: '',
                      description: 'Fan Status',
                    ),
                    const SizedBox(height: 24),
                    InfoCard(
                      icon: Icons.air_rounded,
                      value: '$currentFlowRate',
                      unit: 'L/min',
                      description: 'Flow Rate',
                    ),
                    const SizedBox(height: 24),
                    InfoCard(
                      icon: Icons.volume_up_rounded,
                      value: currentSoundStatus,
                      unit: '',
                      description: 'Sound Status',
                    ),
                    const SizedBox(height: 24),
                    InfoCard(
                      icon: Icons.volume_up_rounded,
                      value: '$currentSoundLevel',
                      unit: 'dB',
                      description: 'Sound Level',
                    ),
                    const SizedBox(height: 24),
                    InfoCard(
                      icon: Icons.lightbulb_circle_rounded,
                      value: '$currentLightLux',
                      unit: 'Lux',
                      description: 'Light\nIntensity',
                    ),
                    const SizedBox(height: 24),
                    InfoCard(
                      icon: Icons.gas_meter_rounded,
                      value: '$currentMq135ppm',
                      unit: 'ppm',
                      description: 'Air Quality',
                    ),
                    const SizedBox(height: 24),
                    InfoCard(
                      icon: Icons.thermostat_rounded,
                      value: '$currentOtherTemp',
                      unit: '°C',
                      description: 'Device\nTemperature',
                    ),
                    const SizedBox(height: 24),
                    InfoCard(
                      icon: Icons.toggle_off_rounded,
                      value: currentRelayStatus,
                      unit: '',
                      description: 'Relay Status',
                    ),
                    const SizedBox(height: 24),
                    InfoCard(
                      icon: Icons.monitor_heart_rounded,
                      value: '$currentBPM',
                      unit: 'bpm',
                      description: 'Heart Rate',
                    ),
                    const SizedBox(height: 24),
                    InfoCard(
                      icon: Icons.air_rounded,
                      value: '$currentSPO2',
                      unit: '%',
                      description: 'Oxygen\nSaturation',
                    ),
                    const SizedBox(height: 24 * 3),
                  ],
                );
              },
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const SensorsDataPage(),
            ),
          );
        },
        backgroundColor: kPrimary,
        shape: const CircleBorder(),
        child: const Icon(Icons.history_rounded, color: kWhite),
      ),
    );
  }
}
