class Report {
  final IncubatorDetail incubatorDetail;
  final TestingCondition testingCondition;
  final List<RiskManagementItem> riskManagementItem;

  Report({
    required this.incubatorDetail,
    required this.testingCondition,
    required this.riskManagementItem,
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
