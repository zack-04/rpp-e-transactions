class TransactionStatsModel {
  final String status;
  final String message;
  final TransactionStats data;

  const TransactionStatsModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory TransactionStatsModel.fromJson(Map<String, dynamic> json) {
    return TransactionStatsModel(
      status: json['status'] as String? ?? '',
      message: json['message'] as String? ?? '',
      data: TransactionStats.fromJson(
        json['data'] as Map<String, dynamic>? ?? {},
      ),
    );
  }
}

class TransactionStats {
  final int total;
  final int totalThisYear;
  final int totalThisMonth;
  final int totalToday;

  final String totalAmount;
  final String totalThisYearAmount;
  final String totalThisMonthAmount;
  final String totalTodayAmount;

  const TransactionStats({
    required this.total,
    required this.totalThisYear,
    required this.totalThisMonth,
    required this.totalToday,
    required this.totalAmount,
    required this.totalThisYearAmount,
    required this.totalThisMonthAmount,
    required this.totalTodayAmount,
  });

  factory TransactionStats.fromJson(Map<String, dynamic> json) {
    return TransactionStats(
      total: int.tryParse(json['total']?.toString() ?? '') ?? 0,
      totalThisYear: int.tryParse(json['totalThisYear']?.toString() ?? '') ?? 0,
      totalThisMonth:
          int.tryParse(json['totalThisMonth']?.toString() ?? '') ?? 0,
      totalToday: int.tryParse(json['totalToday']?.toString() ?? '') ?? 0,
      totalAmount: json['totalAmount']?.toString() ?? '',
      totalThisYearAmount: json['totalThisYearAmount']?.toString() ?? '',
      totalThisMonthAmount: json['totalThisMonthAmount']?.toString() ?? '',
      totalTodayAmount: json['totalTodayAmount']?.toString() ?? '',
    );
  }
}
