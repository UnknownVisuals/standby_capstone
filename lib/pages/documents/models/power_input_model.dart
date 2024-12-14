import 'package:flutter/material.dart';

class PowerInputModel {
  final String voltageController;
  final TextEditingController powerController = TextEditingController();
  final TextEditingController currentController = TextEditingController();
  final TextEditingController powerFactorController = TextEditingController();
  final double meanPowerController;
  final double meanCurrentController;
  final double meanPowerFactorController;
  final String notesController;

  PowerInputModel({
    required this.voltageController,
    required this.notesController,
    required this.meanPowerController,
    required this.meanCurrentController,
    required this.meanPowerFactorController,
  });

  static List<PowerInputModel> defaultPowers(
    String voltage,
  ) {
    return List.generate(
      5,
      (_) => PowerInputModel(
        voltageController: voltage,
        notesController: '+ 10%',
        meanPowerController: 0.0,
        meanCurrentController: 0.0,
        meanPowerFactorController: 0.0,
      ),
    );
  }
}
