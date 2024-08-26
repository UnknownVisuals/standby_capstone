import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:standby_capstone/constants.dart';
import 'package:standby_capstone/screens/dashboard_page.dart';
import 'package:standby_capstone/screens/input_page.dart';
import 'package:standby_capstone/screens/notification_page.dart';
import 'package:standby_capstone/screens/panduan_page.dart';
import 'package:standby_capstone/screens/profile_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => MainPageState();
}

class MainPageState extends State<MainPage> {
  int _currentIndex = 0;
  final List<String> _appBarTitles = const [
    'Dashboard',
    'Input',
    'Panduan',
    'Profile',
  ];
  final List<Widget> _screenList = const [
    DashboardPage(),
    InputPage(),
    PanduanPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kGray,
        surfaceTintColor: kGray,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Image.asset('assets/logo/logo_icon.png'),
        ),
        title: Text(
          _appBarTitles[_currentIndex],
          style: kTextAppbar,
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const NotificationPage(),
                ),
              );
            },
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
            Icons.dashboard,
            size: 32,
            color: _currentIndex == 0 ? kPrimary : kDarkGray,
          ),
          Icon(
            Icons.edit_document,
            size: 32,
            color: _currentIndex == 1 ? kPrimary : kDarkGray,
          ),
          Icon(
            Icons.description,
            size: 32,
            color: _currentIndex == 2 ? kPrimary : kDarkGray,
          ),
          Icon(
            Icons.manage_accounts,
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
