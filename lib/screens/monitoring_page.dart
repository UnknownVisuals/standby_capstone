import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:standby_capstone/components/card_info.dart';
import 'package:standby_capstone/constants.dart';

class MonitoringPage extends StatefulWidget {
  const MonitoringPage({super.key});

  @override
  State<MonitoringPage> createState() => _MonitoringPageState();
}

class _MonitoringPageState extends State<MonitoringPage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kGray,
        leading: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Image.asset('assets/images/logo_appbar.png'),
        ),
        title: Text(
          'Monitoring',
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
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          color: kGray,
          child: const Padding(
            padding: EdgeInsets.all(24),
            child: Column(
              children: [
                InfoCard(
                  icon: Icons.device_thermostat,
                  title: '33°C',
                  subtitle: 'Suhu\nInkubator Bayi',
                ),
                SizedBox(height: 24),
                InfoCard(
                  icon: Icons.water_drop,
                  title: '96%',
                  subtitle: 'Kelembaban\nInkubator Bayi',
                ),
                SizedBox(height: 24),
                InfoCard(
                  icon: Icons.child_care,
                  title: '36°C',
                  subtitle: 'Suhu\nKulit Bayi',
                ),
                SizedBox(height: 24),
                InfoCard(
                  icon: Icons.heat_pump,
                  title: 'OFF',
                  subtitle: 'Kipas\nPendingin',
                ),
              ],
            ),
          ),
        ),
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
