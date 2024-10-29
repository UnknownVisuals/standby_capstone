class Report {
  final IncubatorDetail incubatorDetail;
  final TestingCondition testingCondition;
  final List<RiskManagementItem> riskManagementItem;
  final List<PerformanceMattersItem> performanceMattersItem;
  final List<PowerInputItem> powerInputItem0, powerInputItem1, powerInputItem2;
  final List<LeakageCurrentItem> leakageCurrentItem;

  Report({
    required this.incubatorDetail,
    required this.testingCondition,
    required this.riskManagementItem,
    required this.performanceMattersItem,
    required this.powerInputItem0,
    required this.powerInputItem1,
    required this.powerInputItem2,
    required this.leakageCurrentItem,
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
  final DateTime date;
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
  final String result;
  final String notes;

  PowerInputItem({
    required this.voltage,
    required this.power,
    required this.current,
    required this.powerFactor,
    required this.result,
    required this.notes,
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
