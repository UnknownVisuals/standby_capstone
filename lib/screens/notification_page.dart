import 'package:flutter/material.dart';
import 'package:lorem_ipsum/lorem_ipsum.dart';
import 'package:standby_capstone/constants.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  final _loremIpsumFull = loremIpsum(words: 24, initWithLorem: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kGray,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Image.asset('assets/logo/logo_icon.png'),
        ),
        title: Text('Notification', style: kTextAppbar),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.close),
          )
        ],
        centerTitle: true,
      ),
      body: Container(
        color: kGray,
        height: double.infinity,
        child: SingleChildScrollView(
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
    final titles = [
      {'title': 'Fan menyala', 'date': '2022-01-01'},
      {'title': 'Suhu melebihi batas', 'date': '2022-01-02'},
      {'title': 'Fan menyala', 'date': '2022-01-03'},
      {'title': 'Suhu melebihi batas', 'date': '2022-01-04'},
      {'title': 'Fan menyala', 'date': '2022-01-05'},
      {'title': 'Suhu melebihi batas', 'date': '2022-01-06'},
      {'title': 'Fan menyala', 'date': '2022-01-07'},
    ];

    return titles.map((data) {
      return Container(
        margin: const EdgeInsets.only(bottom: 24),
        decoration: kEmbossDecoration,
        child: Theme(
          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
          child: ExpansionTile(
            iconColor: kPrimary,
            collapsedIconColor: kPrimary,
            title: Row(
              children: [
                Text(data['title']!, style: kTextHeadingRed),
                const Spacer(),
                Text(data['date']!, style: kTextNormal),
              ],
            ),
            children: [
              ListTile(
                dense: true,
                title: Text(_loremIpsumFull, style: kTextNormal),
              ),
            ],
          ),
        ),
      );
    }).toList();
  }
}
