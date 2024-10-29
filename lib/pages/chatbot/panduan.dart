import 'package:flutter/material.dart';
import 'package:standby_capstone/pages/chatbot/chat_bot_page.dart';
import 'package:standby_capstone/pages/chatbot/sni_iec_60601.dart';
import 'package:standby_capstone/constants.dart';

class PanduanPage extends StatefulWidget {
  const PanduanPage({super.key});

  @override
  State<PanduanPage> createState() => _PanduanPageState();
}

class _PanduanPageState extends State<PanduanPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kGray,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: sections.map((section) {
              return Container(
                margin: const EdgeInsets.only(bottom: 24),
                decoration: kEmbossDecoration,
                child: Theme(
                  data: Theme.of(context).copyWith(
                    dividerColor: Colors.transparent,
                  ),
                  child: ExpansionTile(
                    iconColor: kPrimary,
                    collapsedIconColor: kPrimary,
                    title: Text(
                      section['mainTitle'] as String,
                      style: kTextHeading_Black,
                    ),
                    children: (section['subSections'] as List)
                        .map<Widget>((subSection) {
                      return ExpansionTile(
                        iconColor: kPrimary,
                        collapsedIconColor: kPrimary,
                        title: Text(
                          subSection['subTitle'] as String,
                          style: kTextHeading_Black,
                        ),
                        children: [
                          ListTile(
                            dense: true,
                            title: Text(
                              subSection['content'] as String,
                              style: kTextNormal_Black,
                            ),
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ChatBotPage()),
          );
        },
        backgroundColor: kPrimary,
        shape: const CircleBorder(),
        child: const Icon(
          Icons.chat_rounded,
          color: kWhite,
        ),
      ),
    );
  }
}
