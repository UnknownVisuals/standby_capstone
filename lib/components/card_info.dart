import 'package:flutter/material.dart';
import 'package:standby_capstone/constants.dart';

class InfoCard extends StatelessWidget {
  final IconData icon;
  final String value;
  final String unit;
  final String description;

  const InfoCard({
    super.key,
    required this.icon,
    required this.value,
    required this.unit,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      height: 128,
      decoration: kEmbossDecoration,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  alignment: Alignment.topLeft,
                  child: Icon(
                    icon,
                    size: 48,
                    color: kDarkGray,
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.topRight,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(value, style: kMonitor),
                      Text(unit, style: kMonitor),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: Container(
              alignment: Alignment.bottomRight,
              child: Text(
                description,
                textAlign: TextAlign.right,
                style: kMonitorDescription,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
