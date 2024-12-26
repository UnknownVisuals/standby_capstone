import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:standby_capstone/main.dart';
import 'package:standby_capstone/pages/deep_menu_navigation.dart';
import 'package:standby_capstone/constants.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  List<Map<String, dynamic>> _notifications = [];
  bool _isFetchingMore = false;
  bool _isLoading = true;
  int _filter = 0;
  int _currentOffset = 0;
  final int _limit = 25;
  final ScrollController _scrollController = ScrollController();

  Future<void> _fetchNotifications({bool loadMore = false}) async {
    if (loadMore) {
      setState(() => _isFetchingMore = true);
    } else {
      setState(() {
        _isLoading = true;
        _notifications = [];
        _currentOffset = 0;
      });
    }

    try {
      List<Map<String, dynamic>> response;

      if (_filter == 0) {
        response = await supabase
            .from('notifications')
            .select('id, created_at, temp, anomaly, anomaly_score')
            .order('created_at', ascending: false)
            .range(_currentOffset, _currentOffset + _limit - 1);
      } else if (_filter == 1) {
        response = await supabase
            .from('notifications')
            .select('id, created_at, temp, anomaly, anomaly_score')
            .eq('temp', 85.0)
            .order('created_at', ascending: false)
            .range(_currentOffset, _currentOffset + _limit - 1);
      } else if (_filter == 2) {
        response = await supabase
            .from('notifications')
            .select('id, created_at, temp, anomaly, anomaly_score')
            .neq('temp', 85.0)
            .order('created_at', ascending: false)
            .range(_currentOffset, _currentOffset + _limit - 1);
      } else if (_filter == 3) {
        response = await supabase
            .from('notifications')
            .select('id, created_at, temp, anomaly, anomaly_score')
            .not('anomaly', 'is', null)
            .order('created_at', ascending: false)
            .range(_currentOffset, _currentOffset + _limit - 1);
      } else {
        throw Exception('Invalid filter selected');
      }

      setState(() {
        _notifications.addAll(List<Map<String, dynamic>>.from(response));
        _isLoading = false;
        _isFetchingMore = false;
        _currentOffset += _limit;
      });
    } catch (error) {
      setState(() {
        _isLoading = false;
        _isFetchingMore = false;
      });
    }
  }

  void _changeFilter(int? filter) {
    setState(() {
      _filter = filter!;
    });
    _fetchNotifications();
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent &&
        !_isFetchingMore) {
      _fetchNotifications(loadMore: true);
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchNotifications();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kGray,
      appBar: const DeepMenuAppbar(title: 'Notifications'),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Filter: ', style: kTextHeading_Black),
              const SizedBox(width: 12),
              DropdownButton<int>(
                dropdownColor: kGray,
                borderRadius: const BorderRadius.all(Radius.circular(12)),
                alignment: AlignmentDirectional.center,
                elevation: 4,
                value: _filter,
                items: [
                  DropdownMenuItem(
                    value: 0,
                    child: Center(
                      child: Text('All Notifications', style: kTextHeading_Red),
                    ),
                  ),
                  DropdownMenuItem(
                    value: 1,
                    child: Center(
                      child: Text('Device On 🟢', style: kTextHeading_Red),
                    ),
                  ),
                  DropdownMenuItem(
                    value: 2,
                    child: Center(
                      child: Text('Temperature Warning ⚠️',
                          style: kTextHeading_Red),
                    ),
                  ),
                  DropdownMenuItem(
                    value: 3,
                    child: Center(
                      child:
                          Text('Anomaly Detected ⚠️', style: kTextHeading_Red),
                    ),
                  ),
                ],
                onChanged: _changeFilter,
              ),
            ],
          ),
          Expanded(
            child: _isLoading
                ? const Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(kPrimary),
                    ),
                  )
                : ListView.builder(
                    controller: _scrollController,
                    itemCount:
                        _notifications.length + (_isFetchingMore ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index == _notifications.length && _isFetchingMore) {
                        return const Center(
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation(kPrimary),
                          ),
                        );
                      }

                      final data = _notifications[index];

                      final date = DateFormat('dd/MM/yyyy - kk:mm:ss').format(
                        DateTime.parse(data['created_at']).toLocal(),
                      );

                      final temp = data['temp'];
                      final anomaly = data['anomaly'];
                      final anomalyScore = data['anomaly_score'];

                      String title;
                      String content;

                      if (temp != null && temp == 85.0) {
                        title = 'Device On 🟢';
                        content =
                            'Device is on and ready for real-time monitoring!';
                      } else if (temp != null) {
                        title = 'Temperature Warning ⚠️';
                        content =
                            '${temp.toStringAsFixed(2)}°C is outside the suitable range for the incubator.';
                      } else if (anomaly != null) {
                        title = 'Anomaly Detected ⚠️';
                        content =
                            'Check your hardware device! Anomaly score: ${anomalyScore?.toStringAsFixed(2)}';
                      } else {
                        title = 'Unknown Notification';
                        content = 'No details available.';
                      }

                      return Container(
                        padding: const EdgeInsets.all(12),
                        child: Theme(
                          data: Theme.of(context).copyWith(
                            dividerColor: Colors.transparent,
                          ),
                          child: ExpansionTile(
                            iconColor: kPrimary,
                            collapsedIconColor: kPrimary,
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(title, style: kTextHeading_Red),
                                Text(date, style: kTextNormal_Black),
                              ],
                            ),
                            children: [
                              ListTile(
                                dense: true,
                                title: Text(
                                  content,
                                  style: kTextNormal_Black,
                                ),
                              ),
                            ],
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
