class Report {
  final IncubatorDetail incubatorDetail;
  final TestingCondition testingCondition;
  final List<RiskManagementItem> riskManagementItem;
  final List<PerformanceMattersItem> performanceMattersItem;

  Report({
    required this.incubatorDetail,
    required this.testingCondition,
    required this.riskManagementItem,
    required this.performanceMattersItem,
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
