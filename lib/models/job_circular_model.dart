class JobCircular {
  final int id;
  final String organizationName;
  final String postTitle;
  final String requiredEducation;
  final int vacancy;
  final String deadline;
  final String jobDescription;
  final String? applicationLink;
  final String status;
  final String createdAt;
  final String updatedAt;

  JobCircular({
    required this.id,
    required this.organizationName,
    required this.postTitle,
    required this.requiredEducation,
    required this.vacancy,
    required this.deadline,
    required this.jobDescription,
    this.applicationLink,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory JobCircular.fromJson(Map<String, dynamic> json) {
    return JobCircular(
      id: json['id'],
      organizationName: json['organization_name'],
      postTitle: json['post_title'],
      requiredEducation: json['required_education'],
      vacancy: json['vacancy'],
      deadline: json['deadline'],
      jobDescription: json['job_description'],
      applicationLink: json['application_link'],
      status: json['status'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'organization_name': organizationName,
      'post_title': postTitle,
      'required_education': requiredEducation,
      'vacancy': vacancy,
      'deadline': deadline,
      'job_description': jobDescription,
      'application_link': applicationLink,
      'status': status,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
