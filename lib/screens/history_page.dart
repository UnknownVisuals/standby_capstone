import 'package:flutter/material.dart';
import 'package:standby_capstone/constants.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: kGray,
        child: const Center(
          child: Text("History Page"),
        ),
      ),
    );
  }
}
