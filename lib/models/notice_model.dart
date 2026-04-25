class Notice {
  final int id;
  final String noticeText;
  final String startDate;
  final String endDate;
  final String status;
  final String createdAt;
  final String updatedAt;

  Notice({
    required this.id,
    required this.noticeText,
    required this.startDate,
    required this.endDate,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Notice.fromJson(Map<String, dynamic> json) {
    return Notice(
      id: json['id'] ?? 0,
      noticeText: json['notice_text'] ?? '',
      startDate: json['start_date'] ?? '',
      endDate: json['end_date'] ?? '',
      status: json['status'] ?? 'active',
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
    );
  }

  String get formattedStartDate {
    return _formatDateString(startDate);
  }

  String get formattedEndDate {
    return _formatDateString(endDate);
  }

  static String _formatDateString(String dateStr) {
    try {
      DateTime date = DateTime.parse(dateStr);
      const months = [
        'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
        'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
      ];
      String day = date.day.toString().padLeft(2, '0');
      String month = months[date.month - 1];
      String year = date.year.toString().substring(2);
      return '$day $month $year';
    } catch (e) {
      return dateStr;
    }
  }
}
