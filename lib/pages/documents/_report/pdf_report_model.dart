class Report {
  final IncubatorDetail incubatorDetail;
  final TestingCondition testingCondition;
  final List<RiskManagementItem> riskManagementItem;
  final List<PerformanceMattersItem> performanceMattersItem;
  final List<PowerInputItem> powerInputItem0,
      powerInputItem1,
      powerInputItem2,
      powerInputItem3,
      powerInputItem4,
      powerInputItem5;
  final List<LeakageCurrentItem> leakageCurrentItem;
  final List<DielectricStrengthItem> dielectricStrengthItem;

  Report({
    required this.incubatorDetail,
    required this.testingCondition,
    required this.riskManagementItem,
    required this.performanceMattersItem,
    required this.powerInputItem0,
    required this.powerInputItem1,
    required this.powerInputItem2,
    required this.powerInputItem3,
    required this.powerInputItem4,
    required this.powerInputItem5,
    required this.leakageCurrentItem,
    required this.dielectricStrengthItem,
  });
}

class IncubatorDetail {
  final String labNumber;
  final String productName;
  final String model;
  final String serialNumber;

  IncubatorDetail({
    required this.labNumber,
    required this.productName,
    required this.model,
    required this.serialNumber,
  });
}

class TestingCondition {
  final String date;
  final String temperature;
  final String humidity;

  TestingCondition({
    required this.date,
    required this.temperature,
    required this.humidity,
  });
}

class RiskManagementItem {
  final String clause;
  final String clauseTitle;
  final String docsReference;
  final String riskManagement;
  final String result;

  RiskManagementItem({
    required this.clause,
    required this.clauseTitle,
    required this.docsReference,
    required this.riskManagement,
    required this.result,
  });
}

class PerformanceMattersItem {
  final String performanceMatters;
  final String docsReference;
  final String notes;

  PerformanceMattersItem({
    required this.performanceMatters,
    required this.docsReference,
    required this.notes,
  });
}

class PowerInputItem {
  final String voltage;
  final double power;
  final double current;
  final double powerFactor;
  final String notes;
  final double meanPower;
  final double meanCurrent;
  final double meanPowerFactor;

  PowerInputItem({
    required this.voltage,
    required this.power,
    required this.current,
    required this.powerFactor,
    required this.notes,
    required this.meanPower,
    required this.meanCurrent,
    required this.meanPowerFactor,
  });
}

class LeakageCurrentItem {
  final String leakageCurrentType;
  final String microAmpere;
  final String maxMiliAmp;
  final String result;

  LeakageCurrentItem({
    required this.leakageCurrentType,
    required this.microAmpere,
    required this.maxMiliAmp,
    required this.result,
  });
}

class DielectricStrengthItem {
  final String sampleIsolationController;
  final String insulationTypeController;
  final double voltagePeakController;
  final double voltagePeakDCController;
  final double voltageTestController;
  final String dielectricDamageController;

  DielectricStrengthItem({
    required this.sampleIsolationController,
    required this.insulationTypeController,
    required this.voltagePeakController,
    required this.voltagePeakDCController,
    required this.voltageTestController,
    required this.dielectricDamageController,
  });
}
