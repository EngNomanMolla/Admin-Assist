class User {
  final int id;
  final String name;
  final String email;
  final String phone;
  final String? emailVerifiedAt;
  final String status;
  final String? firebaseNotificationToken;
  final bool notificationEnabled;
  final String? firebaseTokenUpdatedAt;
  final String createdAt;
  final String updatedAt;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    this.emailVerifiedAt,
    required this.status,
    this.firebaseNotificationToken,
    required this.notificationEnabled,
    this.firebaseTokenUpdatedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      emailVerifiedAt: json['email_verified_at'],
      status: json['status'] ?? 'active',
      firebaseNotificationToken: json['firebase_notification_token'],
      notificationEnabled: json['notification_enabled'] ?? true,
      firebaseTokenUpdatedAt: json['firebase_token_updated_at'],
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'email_verified_at': emailVerifiedAt,
      'status': status,
      'firebase_notification_token': firebaseNotificationToken,
      'notification_enabled': notificationEnabled,
      'firebase_token_updated_at': firebaseTokenUpdatedAt,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
