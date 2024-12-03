import 'package:flutter/material.dart';
import 'package:standby_capstone/pages/deep_menu_navigation.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WifiManagerPage extends StatefulWidget {
  const WifiManagerPage({super.key});

  @override
  State<WifiManagerPage> createState() => _WifiManagerPageState();
}

class _WifiManagerPageState extends State<WifiManagerPage> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse('http://192.168.4.1/'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DeepMenuAppbar(title: 'WiFi Manager'),
      body: WebViewWidget(controller: _controller),
    );
  }
}
