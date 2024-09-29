import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Import intl for date formatting
import 'package:standby_capstone/main.dart';
import 'package:standby_capstone/constants.dart';
import 'package:standby_capstone/pages/deep_menu_navigation.dart';

class SensorsData extends StatefulWidget {
  const SensorsData({super.key});

  @override
  State<SensorsData> createState() => _SensorsDataState();
}

class _SensorsDataState extends State<SensorsData> {
  Future<List<dynamic>> _fetchSensorsData() async {
    final response = await supabase.from('esp32').select();
    response.sort((a, b) {
      DateTime dateA = DateTime.parse(a['created_at']).toLocal();
      DateTime dateB = DateTime.parse(b['created_at']).toLocal();
      return dateB.compareTo(dateA);
    });
    return response;
  }

  String _formatTimestamp(String timestamptz) {
    try {
      DateTime parsedDate = DateTime.parse(timestamptz).toLocal();
      return DateFormat('yyyy-MM-dd - kk:mm a').format(parsedDate);
    } catch (e) {
      return 'Invalid timestamp';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DeepMenuAppbar(title: 'Sensors Data'),
      backgroundColor: kGray,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              FutureBuilder<List<dynamic>>(
                future: _fetchSensorsData(),
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
                    return const Center(
                        child: Text('No sensors data available.'));
                  }
                  final sensorsData = snapshot.data!;

                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      columns: [
                        DataColumn(
                          label: Text('Timestamp', style: kTextHeading_Red),
                        ),
                        DataColumn(
                          label: Text('DHT22\nTemp', style: kTextHeading_Red),
                        ),
                        DataColumn(
                          label: Text('DHT22\nHumi', style: kTextHeading_Red),
                        ),
                        DataColumn(
                          label: Text('DS18B20\nTemp', style: kTextHeading_Red),
                        ),
                        DataColumn(
                          label: Text('Fan\nStatus', style: kTextHeading_Red),
                        ),
                      ],
                      rows: sensorsData.map((sensor) {
                        final timestamp = sensor['created_at'] ?? 'N/A';
                        final dht22Temp = sensor['dht22_temp'] ?? 'N/A';
                        final dht22Humi = sensor['dht22_humi'] ?? 'N/A';
                        final ds18b20Temp = sensor['ds18b20_temp'] ?? 'N/A';
                        final fanStatus = sensor['fan_status'] ?? 'N/A';

                        return DataRow(cells: [
                          DataCell(
                              Text(_formatTimestamp(timestamp.toString()))),
                          DataCell(Text(dht22Temp.toString())),
                          DataCell(Text(dht22Humi.toString())),
                          DataCell(Text(ds18b20Temp.toString())),
                          DataCell(Text(fanStatus.toString())),
                        ]);
                      }).toList(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}