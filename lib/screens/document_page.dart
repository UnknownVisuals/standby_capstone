import 'package:flutter/material.dart';
import 'package:standby_capstone/constants.dart';

class DocumentPage extends StatefulWidget {
  const DocumentPage({super.key});

  @override
  State<DocumentPage> createState() => _DocumentPageState();
}

class _DocumentPageState extends State<DocumentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: kGray,
        child: const Center(
          child: Text("Document Page"),
        ),
      ),
    );
  }
}
