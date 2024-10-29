import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:standby_capstone/main.dart';
import 'package:standby_capstone/constants.dart';
import 'package:standby_capstone/pages/deep_menu_navigation.dart';

class SensorsData extends StatefulWidget {
  const SensorsData({super.key});

  @override
  State<SensorsData> createState() => _SensorsDataState();
}

class _SensorsDataState extends State<SensorsData> {
  Future<List<dynamic>>? _sensorDataFuture;
  List<dynamic> _allData = [];
  int _currentPage = 1;
  int _itemsPerPage = 50;
  int _totalPages = 1;
  final TextEditingController _pageController = TextEditingController();
  final List<int> _itemsPerPageOptions = [25, 50, 100];

  @override
  void initState() {
    super.initState();
    _initializeData();
    _pageController.text = _currentPage.toString();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _initializeData() async {
    try {
      final data = await _fetchSensorsData();
      setState(() {
        _allData = data;
        _updateTotalPages();
        _sensorDataFuture = Future.value(_getPaginatedData());
      });
    } catch (e) {
      print('Error initializing data: $e');
    }
  }

  Future<List<dynamic>> _fetchSensorsData() async {
    final response = await supabase.from('esp32_1').select();
    response.sort((a, b) {
      DateTime dateA = DateTime.parse(a['created_at']).toLocal();
      DateTime dateB = DateTime.parse(b['created_at']).toLocal();
      return dateB.compareTo(dateA);
    });
    return response;
  }

  List<dynamic> _getPaginatedData() {
    final startIndex = (_currentPage - 1) * _itemsPerPage;
    final endIndex = startIndex + _itemsPerPage;
    return _allData.sublist(
      startIndex,
      endIndex > _allData.length ? _allData.length : endIndex,
    );
  }

  void _updateTotalPages() {
    _totalPages = (_allData.length / _itemsPerPage).ceil();
    if (_currentPage > _totalPages && _totalPages > 0) {
      _currentPage = _totalPages;
      _pageController.text = _currentPage.toString();
    }
  }

  void _changePage(int page) {
    if (page >= 1 && page <= _totalPages) {
      setState(() {
        _currentPage = page;
        _sensorDataFuture = Future.value(_getPaginatedData());
      });
    }
  }

  void _handlePageSubmit() {
    final newPage = int.tryParse(_pageController.text);
    if (newPage != null) {
      _changePage(newPage);
    }
  }

  void _changeItemsPerPage(int? newValue) {
    if (newValue != null) {
      setState(() {
        _itemsPerPage = newValue;
        _currentPage = 1;
        _updateTotalPages();
        _sensorDataFuture = Future.value(_getPaginatedData());
      });
    }
  }

  String _formatTimestamp(String timestamptz) {
    try {
      DateTime parsedDate = DateTime.parse(timestamptz).toLocal();
      return DateFormat('yyyy/MM/dd - kk:mm:ss a').format(parsedDate);
    } catch (e) {
      return 'Invalid timestamp';
    }
  }

  Widget _buildPaginationControls() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: const Icon(Icons.first_page),
          onPressed: _currentPage > 1 ? () => _changePage(1) : null,
        ),
        IconButton(
          icon: const Icon(Icons.chevron_left),
          onPressed:
              _currentPage > 1 ? () => _changePage(_currentPage - 1) : null,
        ),
        Container(
          width: 50,
          margin: const EdgeInsets.symmetric(horizontal: 8),
          child: TextField(
            controller: _pageController,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            onSubmitted: (_) => _handlePageSubmit(),
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(horizontal: 8),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),
        Text(' of $_totalPages'),
        IconButton(
          icon: const Icon(Icons.chevron_right),
          onPressed: _currentPage < _totalPages
              ? () => _changePage(_currentPage + 1)
              : null,
        ),
        IconButton(
          icon: const Icon(Icons.last_page),
          onPressed: _currentPage < _totalPages
              ? () => _changePage(_totalPages)
              : null,
        ),
        const SizedBox(width: 16),
        DropdownButton<int>(
          value: _itemsPerPage,
          items: _itemsPerPageOptions.map((int value) {
            return DropdownMenuItem<int>(
              value: value,
              child: Text('$value items'),
            );
          }).toList(),
          onChanged: _changeItemsPerPage,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DeepMenuAppbar(title: 'Sensors Data'),
      backgroundColor: kGray,
      body: Column(
        children: [
          _buildPaginationControls(),
          Expanded(
            child: FutureBuilder<List<dynamic>>(
              future: _sensorDataFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(
                      child: Text('No sensors data available.'));
                }

                final sensorsData = snapshot.data!;
                return SingleChildScrollView(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      columns: [
                        DataColumn(
                            label: Text('Timestamp', style: kTextHeading_Red)),
                        DataColumn(
                            label:
                                Text('DHT22\nTemp', style: kTextHeading_Red)),
                        DataColumn(
                            label:
                                Text('DHT22\nHumi', style: kTextHeading_Red)),
                        DataColumn(
                            label: Text('DS18B20\nTemp - 1',
                                style: kTextHeading_Red)),
                        DataColumn(
                            label: Text('DS18B20\nTemp - 2',
                                style: kTextHeading_Red)),
                        DataColumn(
                            label: Text('DS18B20\nTemp - 3',
                                style: kTextHeading_Red)),
                        DataColumn(
                            label: Text('DS18B20\nTemp - 4',
                                style: kTextHeading_Red)),
                        DataColumn(
                            label:
                                Text('Fan\nStatus', style: kTextHeading_Red)),
                        DataColumn(
                            label: Text('Flow\nRate', style: kTextHeading_Red)),
                        DataColumn(
                            label:
                                Text('Sound\nStatus', style: kTextHeading_Red)),
                      ],
                      rows: sensorsData.map((sensor) {
                        final timestamp = sensor['created_at'] ?? 'N/A';
                        final dht22Temp = sensor['dht22_temp'] ?? 'N/A';
                        final dht22Humi = sensor['dht22_humi'] ?? 'N/A';
                        final ds18b20Temp1 = sensor['ds18b20_temp1'] ?? 'N/A';
                        final ds18b20Temp2 = sensor['ds18b20_temp2'] ?? 'N/A';
                        final ds18b20Temp3 = sensor['ds18b20_temp3'] ?? 'N/A';
                        final ds18b20Temp4 = sensor['ds18b20_temp4'] ?? 'N/A';
                        final fanStatus = sensor['fan_status'] ?? 'N/A';
                        final flowRate = sensor['flow_rate'] ?? 'N/A';
                        final soundDetected = sensor['sound_detected'] ?? 'N/A';

                        return DataRow(cells: [
                          DataCell(
                              Text(_formatTimestamp(timestamp.toString()))),
                          DataCell(Text(dht22Temp.toString())),
                          DataCell(Text(dht22Humi.toString())),
                          DataCell(Text(ds18b20Temp1.toString())),
                          DataCell(Text(ds18b20Temp2.toString())),
                          DataCell(Text(ds18b20Temp3.toString())),
                          DataCell(Text(ds18b20Temp4.toString())),
                          DataCell(Text(fanStatus.toString())),
                          DataCell(Text(flowRate.toString())),
                          DataCell(Text(soundDetected.toString())),
                        ]);
                      }).toList(),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
