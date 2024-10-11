import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ChatBot extends StatefulWidget {
  const ChatBot({super.key});

  @override
  State<ChatBot> createState() => _ChatBotState();
}

class _ChatBotState extends State<ChatBot> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(
          'https://cdn.botpress.cloud/webchat/v2.1/shareable.html?botId=abf73d59-de68-4f12-993a-aafd25b94f9a'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: const DeepMenuAppbar(title: 'StandBy Chat Bot'),
      body: WebViewWidget(controller: _controller),
    );
  }
}
