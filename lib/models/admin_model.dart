class Admin {
  final int id;
  final String name;
  final String email;
  final String status;
  final String createdAt;
  final String updatedAt;

  Admin({
    required this.id,
    required this.name,
    required this.email,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Admin.fromJson(Map<String, dynamic> json) {
    return Admin(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      status: json['status'] ?? '',
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'status': status,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
