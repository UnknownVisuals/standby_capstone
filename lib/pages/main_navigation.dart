import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:standby_capstone/constants.dart';
import 'package:standby_capstone/main.dart';
import 'package:standby_capstone/pages/dashboard/dashboard_page.dart';
import 'package:standby_capstone/pages/documents/documents_page.dart';
import 'package:standby_capstone/pages/notification_page.dart';
import 'package:standby_capstone/pages/chatbot/chat_bot_page.dart';
import 'package:standby_capstone/pages/profile/profile_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => MainNavigationState();
}

class MainNavigationState extends State<MainNavigation> {
  int _currentIndex = 0;
  final List<String> _appBarTitles = const [
    'Dashboard',
    'Documents',
    'Chat Bot',
    'Profile',
  ];
  final List<Widget> _screenList = const [
    DashboardPage(),
    DocumentsPage(),
    ChatBotPage(),
    ProfilePage(),
  ];

  @override
  void initState() {
    super.initState();
    supabase.auth.onAuthStateChange.listen((event) async {
      if (event.event == AuthChangeEvent.signedIn) {
        await FirebaseMessaging.instance.requestPermission();
        await FirebaseMessaging.instance.getAPNSToken();

        final fcmToken = await FirebaseMessaging.instance.getToken();

        if (fcmToken != null) {
          await _setFcmToken(fcmToken);
        }
      }
    });

    FirebaseMessaging.instance.onTokenRefresh.listen((fcmToken) async {
      await _setFcmToken(fcmToken);
    });

    FirebaseMessaging.onMessage.listen((payload) {
      final notification = payload.notification;
      if (!mounted) return;
      if (notification != null) {
        showTopSnackBar(
          Overlay.of(context),
          CustomSnackBar.error(
            message: '${notification.title} ${notification.body}',
          ),
        );
      }
    });
  }

  Future<void> _setFcmToken(String fcmToken) async {
    await supabase.from('profiles').update({
      'fcm_token': fcmToken,
    }).eq('id', supabase.auth.currentUser!.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kGray,
        surfaceTintColor: kGray,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Image.asset('assets/logo/logo_icon.png'),
        ),
        title: Text(
          _appBarTitles[_currentIndex],
          style: kAppbarTitle,
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
            icon: const Icon(Icons.notifications, color: kDarkGray),
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
            Icons.dashboard_rounded,
            size: 32,
            color: _currentIndex == 0 ? kPrimary : kDarkGray,
          ),
          Icon(
            Icons.edit_document,
            size: 32,
            color: _currentIndex == 1 ? kPrimary : kDarkGray,
          ),
          Icon(
            Icons.chat_rounded,
            size: 32,
            color: _currentIndex == 2 ? kPrimary : kDarkGray,
          ),
          Icon(
            Icons.manage_accounts_rounded,
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
