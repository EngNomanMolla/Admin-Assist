import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CareerController extends GetxController {
  List<Map<String, String>> circulars = [
    {
      "company": "Tech Solutions Ltd.",
      "role": "Senior Software Engineer",
      "positions": "3 Positions",
      "deadline": "2026-02-15",
    },
    {
      "company": "Digital Marketing Agency",
      "role": "Content Writer",
      "positions": "3 Positions",
      "deadline": "2026-02-15",
    },
    {
      "company": "Finance Corp",
      "role": "Accountant",
      "positions": "3 Positions",
      "deadline": "2026-02-15",
    },
    {
      "company": "Tech Solutions Ltd.",
      "role": "Senior Software Engineer",
      "positions": "3 Positions",
      "deadline": "2026-02-15",
    },
  ];

  final organizationNameController = TextEditingController();
  final postTitleController = TextEditingController();
  final requiredEducationController = TextEditingController();
  final vacancyController = TextEditingController();
  final deadlineController = TextEditingController();
  final jobDescriptionController = TextEditingController();
  final applicationLinkController = TextEditingController();

  void deleteCircular(int index) {
    circulars.removeAt(index);
    update();
  }

  Future<void> chooseDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
    );

    if (pickedDate != null) {
      deadlineController.text =
          "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";
      update();
    }
  }

  void saveJobCircular() {
    if (organizationNameController.text.isEmpty ||
        postTitleController.text.isEmpty) {
      Get.snackbar(
        "Error",
        "Organization and Post title are required",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
      return;
    }

    Map<String, String> newJob = {
      "company": organizationNameController.text,
      "role": postTitleController.text,
      "positions": "${vacancyController.text} Positions",
      "deadline": deadlineController.text.isEmpty
          ? "No Deadline"
          : deadlineController.text,
    };

    circulars.insert(0, newJob);

    clearFields();

    update();

    Get.snackbar(
      "Success",
      "Job Circular Added Successfully!",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );

    Future.delayed(const Duration(seconds: 1), () => Get.back());
  }

  void clearFields() {
    organizationNameController.clear();
    postTitleController.clear();
    requiredEducationController.clear();
    vacancyController.clear();
    deadlineController.clear();
    jobDescriptionController.clear();
    applicationLinkController.clear();
  }

  @override
  void onClose() {
    organizationNameController.dispose();
    postTitleController.dispose();
    requiredEducationController.dispose();
    vacancyController.dispose();
    deadlineController.dispose();
    jobDescriptionController.dispose();
    applicationLinkController.dispose();
    super.onClose();
  }
}
