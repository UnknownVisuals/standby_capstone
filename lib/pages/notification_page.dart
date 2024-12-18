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
  bool _isLoading = true;

  Future<void> _fetchNotifications() async {
    try {
      final response = await supabase
          .from('notifications')
          .select('id, created_at, temp, anomaly, anomaly_score')
          .order('created_at', ascending: false);

      setState(() {
        _notifications = List<Map<String, dynamic>>.from(response);
        _isLoading = false;
      });
    } catch (error) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DeepMenuAppbar(title: 'Notifications'),
      body: Container(
        color: kGray,
        height: double.infinity,
        child: _isLoading
            ? const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(kPrimary),
                ),
              )
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: _generateExpansionTiles(),
                  ),
                ),
              ),
      ),
    );
  }

  List<Widget> _generateExpansionTiles() {
    if (_notifications.isEmpty) {
      return [
        Center(
          child: Text('No notifications available.', style: kTextHeading_Red),
        )
      ];
    }

    return _notifications.map((data) {
      final temp = data['temp'];
      final anomaly = data['anomaly'];
      final anomalyScore = data['anomaly_score'];
      final date = DateFormat('dd/MM/yyyy - kk:mm:ss').format(
        DateTime.parse(data['created_at']).toLocal(),
      );

      String title;
      String content;

      if (temp != null) {
        title = 'Temperature Warning';
        content =
            '${temp.toStringAsFixed(2)}°C is outside suitable range for Incubator';
      } else if (anomaly != null) {
        title = 'Anomaly Warning';
        content =
            'Check your hardware device! Anomaly score: ${anomalyScore?.toStringAsFixed(2)}';
      } else {
        title = 'Unknown Notification';
        content = 'No details available.';
      }

      return Container(
        margin: const EdgeInsets.only(bottom: 24),
        decoration: kEmbossDecoration,
        child: Theme(
          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
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
                title: Text(content, style: kTextNormal_Black),
              ),
            ],
          ),
        ),
      );
    }).toList();
  }
}
