import 'package:flutter/material.dart';

class PowerInputModel {
  final String voltageController;
  final TextEditingController powerController = TextEditingController();
  final TextEditingController currentController = TextEditingController();
  final TextEditingController powerFactorController = TextEditingController();
  final TextEditingController resultController = TextEditingController();
  final String notesController;

  PowerInputModel({
    required this.voltageController,
    required this.notesController,
  });

  static List<PowerInputModel> defaultPowers(String voltage) {
    return List.generate(
      5,
      (_) => PowerInputModel(
        voltageController: voltage,
        notesController: '+ 10%',
      ),
    );
  }
}
