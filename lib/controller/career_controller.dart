import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/job_circular_model.dart';
import '../provider/career_provider.dart';

class CareerController extends GetxController {
  final CareerProvider _careerProvider = CareerProvider();
  
  var circulars = <JobCircular>[].obs;
  var isLoading = false.obs;
  var isDetailLoading = false.obs;
  var isEditing = false.obs;
  var editingId = 0.obs;
  var selectedCircular = Rxn<JobCircular>();

  final organizationNameController = TextEditingController();
  final postTitleController = TextEditingController();
  final requiredEducationController = TextEditingController();
  final vacancyController = TextEditingController();
  final deadlineController = TextEditingController();
  final jobDescriptionController = TextEditingController();
  final applicationLinkController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    fetchJobCirculars();
  }

  void openEditMode(JobCircular circular) {
    isEditing(true);
    editingId(circular.id);
    organizationNameController.text = circular.organizationName;
    postTitleController.text = circular.postTitle;
    requiredEducationController.text = circular.requiredEducation;
    vacancyController.text = circular.vacancy.toString();
    deadlineController.text = circular.deadline.split('T')[0];
    jobDescriptionController.text = circular.jobDescription;
    applicationLinkController.text = circular.applicationLink ?? "";
  }

  Future<void> fetchJobCirculars() async {
    try {
      isLoading(true);
      final response = await _careerProvider.fetchJobCirculars();
      final List<dynamic> data = response['job_circulars'];
      circulars.assignAll(data.map((e) => JobCircular.fromJson(e)).toList());
    } catch (e) {
      Get.snackbar("Error", "Failed to fetch circulars: ${e.toString()}",
          backgroundColor: Colors.redAccent, colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM, margin: const EdgeInsets.all(16));
    } finally {
      isLoading(false);
    }
  }

  Future<void> fetchDetails(int id) async {
    try {
      isDetailLoading(true);
      final data = await _careerProvider.fetchJobCircularDetails(id);
      selectedCircular.value = JobCircular.fromJson(data);
    } catch (e) {
      Get.snackbar("Error", "Failed to fetch details: ${e.toString()}",
          backgroundColor: Colors.redAccent, colorText: Colors.white);
    } finally {
      isDetailLoading(false);
    }
  }

  Future<void> deleteCircular(int id) async {
    try {
      isLoading(true);
      await _careerProvider.deleteJobCircular(id);
      circulars.removeWhere((c) => c.id == id);
      Get.snackbar("Success", "Job circular deleted successfully",
          backgroundColor: Colors.green, colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM, margin: const EdgeInsets.all(16));
    } catch (e) {
      Get.snackbar("Error", "Failed to delete circular: ${e.toString()}",
          backgroundColor: Colors.redAccent, colorText: Colors.white);
    } finally {
      isLoading(false);
    }
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
    }
  }

  Future<void> saveJobCircular() async {
    if (organizationNameController.text.isEmpty || postTitleController.text.isEmpty) {
      Get.snackbar("Error", "Please fill required fields", backgroundColor: Colors.orange);
      return;
    }

    final data = {
      "organization_name": organizationNameController.text,
      "post_title": postTitleController.text,
      "required_education": requiredEducationController.text,
      "vacancy": int.tryParse(vacancyController.text) ?? 1,
      "deadline": deadlineController.text,
      "job_description": jobDescriptionController.text,
      "application_link": applicationLinkController.text,
      "status": "active",
    };

    try {
      isLoading(true);
      String message = "";
      if (isEditing.value) {
        await _careerProvider.updateJobCircular(editingId.value, data);
        message = "Job circular updated successfully";
      } else {
        await _careerProvider.createJobCircular(data);
        message = "Job circular posted successfully";
      }
      
      // Navigate back first for a smooth transition
      Get.back();
      
      // Refresh the list
      await fetchJobCirculars();
      
      // Show success message on the list screen
      Get.snackbar(
        "Success", 
        message, 
        backgroundColor: Colors.green, 
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(16),
      );
      
      clearFields();
    } catch (e) {
      Get.snackbar(
        "Error", 
        "Action failed: ${e.toString()}", 
        backgroundColor: Colors.redAccent, 
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(16),
      );
    } finally {
      isLoading(false);
    }
  }

  void clearFields() {
    isEditing(false);
    editingId(0);
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
