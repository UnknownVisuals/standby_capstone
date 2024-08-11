import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:standby_capstone/constants.dart';
import 'package:standby_capstone/screens/monitoring_page.dart';
import 'package:standby_capstone/screens/document_page.dart';
import 'package:standby_capstone/screens/history_page.dart';
import 'package:standby_capstone/screens/profile_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => MainPageState();
}

class MainPageState extends State<MainPage> {
  int _currentIndex = 0;
  final List<String> _appBarTitles = const [
    'Monitoring',
    'Document',
    'History',
    'Profile',
  ];
  final List<Widget> _screenList = const [
    MonitoringPage(),
    DocumentPage(),
    HistoryPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kGray,
        leading: Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Image.asset('assets/logo/logo_icon.png')),
        title: Text(
          _appBarTitles[_currentIndex],
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications),
          )
        ],
        centerTitle: true,
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: _screenList,
      ),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: kGray,
        color: kWhite,
        animationDuration: const Duration(milliseconds: 300),
        items: <Widget>[
          Icon(
            Icons.home,
            size: 32,
            color: _currentIndex == 0 ? kPrimary : kDarkGray,
          ),
          Icon(
            Icons.document_scanner,
            size: 32,
            color: _currentIndex == 1 ? kPrimary : kDarkGray,
          ),
          Icon(
            Icons.bar_chart_rounded,
            size: 32,
            color: _currentIndex == 2 ? kPrimary : kDarkGray,
          ),
          Icon(
            Icons.person,
            size: 32,
            color: _currentIndex == 3 ? kPrimary : kDarkGray,
          ),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
