import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:standby_capstone/constants.dart';
import 'package:standby_capstone/main.dart';
import 'package:standby_capstone/pages/deep_menu_navigation.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class SensorsDataPage extends StatefulWidget {
  const SensorsDataPage({super.key});

  @override
  State<SensorsDataPage> createState() => _SensorsDataPageState();
}

class _SensorsDataPageState extends State<SensorsDataPage> {
  final TextEditingController _pageController = TextEditingController();
  final List<int> _itemsPerPageOptions = [25, 50, 100];
  Future<List<dynamic>>? _sensorDataFuture;
  List<dynamic> _allData = [];
  int _itemsPerPage = 50;
  int _currentPage = 1;
  int _totalPages = 1;

  Future<void> _initializeData() async {
    try {
      final data = await _fetchSensorsData();
      setState(() {
        _allData = data;
        _updateTotalPages();
        _sensorDataFuture = Future.value(_getPaginatedData());
      });
    } catch (e) {
      if (!mounted) return;
      showTopSnackBar(
        Overlay.of(context),
        CustomSnackBar.error(message: 'Error initializing data: $e'),
      );
    }
  }

  Future<List<dynamic>> _fetchSensorsData() async {
    try {
      final response = await supabase.from('esp32_1').select();
      response.sort((a, b) {
        DateTime dateA = DateTime.parse(a['created_at']).toLocal();
        DateTime dateB = DateTime.parse(b['created_at']).toLocal();
        return dateB.compareTo(dateA);
      });
      return response;
    } catch (e) {
      if (mounted) {
        showTopSnackBar(
          Overlay.of(context),
          CustomSnackBar.error(message: 'Error fetching sensor data: $e'),
        );
      }
      rethrow;
    }
  }

  List<dynamic> _getPaginatedData() {
    if (_allData.isEmpty) return [];

    final startIndex = (_currentPage - 1) * _itemsPerPage;
    final endIndex = startIndex + _itemsPerPage;

    if (startIndex >= _allData.length) {
      _currentPage = 1;
      _pageController.text = '1';
      return _allData.take(_itemsPerPage).toList();
    }

    return _allData.sublist(
      startIndex,
      endIndex > _allData.length ? _allData.length : endIndex,
    );
  }

  void _updateTotalPages() {
    setState(() {
      _totalPages = (_allData.length / _itemsPerPage).ceil();

      if (_currentPage > _totalPages && _totalPages > 0) {
        _currentPage = _totalPages;
        _pageController.text = _currentPage.toString();
      }
    });
  }

  Future<void> _refreshData() async {
    try {
      final newData = await _fetchSensorsData();
      setState(() {
        _allData = newData;
        _updateTotalPages();
        _sensorDataFuture = Future.value(_getPaginatedData());
      });
    } catch (e) {
      if (mounted) {
        showTopSnackBar(
          Overlay.of(context),
          CustomSnackBar.error(message: 'Error refreshing data: $e'),
        );
      }
    }
  }

  void _changePage(int page) {
    if (page >= 1 && page <= _totalPages) {
      setState(() {
        _currentPage = page;
        _pageController.text = page.toString();
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
        _currentPage = 1; // Reset to first page
        _pageController.text = '1';
        _updateTotalPages();
        _sensorDataFuture = Future.value(_getPaginatedData());
      });
    }
  }

  String _formatTimestamp(String timestamptz) {
    DateTime parsedDate = DateTime.parse(timestamptz).toLocal();
    return DateFormat('dd/MM/yyyy - kk:mm:ss').format(parsedDate);
  }

  Widget _buildPaginationControls() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            icon: const Icon(Icons.first_page),
            onPressed: _currentPage > 1 ? () => _changePage(1) : null,
            color: kBlack,
          ),
          IconButton(
            icon: const Icon(Icons.chevron_left),
            onPressed:
                _currentPage > 1 ? () => _changePage(_currentPage - 1) : null,
            color: kBlack,
          ),
          Container(
            width: 50,
            margin: const EdgeInsets.symmetric(horizontal: 8),
            child: TextField(
              controller: _pageController,
              style: kTextNormal_Black,
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
          Text(' of $_totalPages', style: kTextNormal_Black),
          IconButton(
            icon: const Icon(Icons.chevron_right),
            onPressed: _currentPage < _totalPages
                ? () => _changePage(_currentPage + 1)
                : null,
            color: kBlack,
          ),
          IconButton(
            icon: const Icon(Icons.last_page),
            onPressed: _currentPage < _totalPages
                ? () => _changePage(_totalPages)
                : null,
            color: kBlack,
          ),
          DropdownButton<int>(
            dropdownColor: kGray,
            borderRadius: const BorderRadius.all(Radius.circular(12)),
            elevation: 4,
            value: _itemsPerPage,
            items: _itemsPerPageOptions.map((int value) {
              return DropdownMenuItem<int>(
                value: value,
                child: Text('$value items', style: kTextNormal_Black),
              );
            }).toList(),
            onChanged: _changeItemsPerPage,
          ),
        ],
      ),
    );
  }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DeepMenuAppbar(title: 'Sensors Data'),
      backgroundColor: kGray,
      body: Column(
        children: [
          _buildPaginationControls(),
          Expanded(
            child: RefreshIndicator(
              onRefresh: _refreshData,
              backgroundColor: kPrimary,
              color: kWhite,
              child: FutureBuilder<List<dynamic>>(
                future: _sensorDataFuture,
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
                  //   return const Center(
                  //       child: Text('No sensors data available.'));
                  // }

                  final sensorsData = snapshot.data!;

                  return SingleChildScrollView(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        columnSpacing: 32,
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
                            label: Text('DS18B20\nTemp - 1',
                                style: kTextHeading_Red),
                          ),
                          DataColumn(
                            label: Text('DS18B20\nTemp - 2',
                                style: kTextHeading_Red),
                          ),
                          DataColumn(
                            label: Text('DS18B20\nTemp - 3',
                                style: kTextHeading_Red),
                          ),
                          DataColumn(
                            label: Text('DS18B20\nTemp - 4',
                                style: kTextHeading_Red),
                          ),
                          DataColumn(
                            label: Text('Fan\nStatus', style: kTextHeading_Red),
                          ),
                          DataColumn(
                            label: Text('Flow\nRate', style: kTextHeading_Red),
                          ),
                          DataColumn(
                            label:
                                Text('Sound\nStatus', style: kTextHeading_Red),
                          ),
                        ],
                        rows: sensorsData.map((sensor) {
                          return DataRow(cells: [
                            DataCell(Text(_formatTimestamp(
                                sensor['created_at'] ?? 'N/A'))),
                            DataCell(Text(
                                sensor['dht22_temp']?.toString() ?? 'N/A')),
                            DataCell(Text(
                                sensor['dht22_humi']?.toString() ?? 'N/A')),
                            DataCell(Text(
                                sensor['ds18b20_temp1']?.toString() ?? 'N/A')),
                            DataCell(Text(
                                sensor['ds18b20_temp2']?.toString() ?? 'N/A')),
                            DataCell(Text(
                                sensor['ds18b20_temp3']?.toString() ?? 'N/A')),
                            DataCell(Text(
                                sensor['ds18b20_temp4']?.toString() ?? 'N/A')),
                            DataCell(Text(
                                sensor['fan_status']?.toString() ?? 'N/A')),
                            DataCell(
                                Text(sensor['flow_rate']?.toString() ?? 'N/A')),
                            DataCell(Text(
                                sensor['sound_detected']?.toString() ?? 'N/A')),
                          ]);
                        }).toList(),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
