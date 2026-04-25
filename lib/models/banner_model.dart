class BannerAd {
  final int id;
  final String image;
  final String headline;
  final String subheadline;
  final String startDate;
  final String endDate;
  final String status;
  final String createdAt;
  final String updatedAt;

  BannerAd({
    required this.id,
    required this.image,
    required this.headline,
    required this.subheadline,
    required this.startDate,
    required this.endDate,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory BannerAd.fromJson(Map<String, dynamic> json) {
    return BannerAd(
      id: json['id'] ?? 0,
      image: json['image'] ?? '',
      headline: json['headline'] ?? '',
      subheadline: json['subheadline'] ?? '',
      startDate: json['start_date'] ?? '',
      endDate: json['end_date'] ?? '',
      status: json['status'] ?? '',
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'image': image,
      'headline': headline,
      'subheadline': subheadline,
      'start_date': startDate,
      'end_date': endDate,
      'status': status,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
