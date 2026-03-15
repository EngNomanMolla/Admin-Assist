import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_widgets/controller/career_controller.dart'; // আপনার সঠিক পাথ দিন

class AddJobCircularScreen extends StatelessWidget {
  const AddJobCircularScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final CareerController controller = Get.find<CareerController>();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            controller.clearFields();
            Get.back();
          },
        ),
        title: const Text(
          "Add Job Circular",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildLabel("Organization Name"),
            _buildTextField(
              controller.organizationNameController,
              "Enter organization name",
            ),

            _buildLabel("Post title"),
            _buildTextField(
              controller.postTitleController,
              "e.g., Senior Software Engineer",
            ),

            _buildLabel("Required Education"),
            _buildTextField(
              controller.requiredEducationController,
              "e.g., Bachelor's in Computer Science",
            ),

            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildLabel("Vacancy"),
                      _buildTextField(
                        controller.vacancyController,
                        "1",
                        keyboardType: TextInputType.number,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildLabel("Deadline"),
                      GestureDetector(
                        onTap: () => controller.chooseDate(context),
                        child: AbsorbPointer(
                          child: _buildTextField(
                            controller.deadlineController,
                            "yyyy-mm-dd",
                            suffixIcon: Icons.calendar_today_outlined,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            _buildLabel("Job Description"),
            _buildTextField(
              controller.jobDescriptionController,
              "Enter detailed job description...",
              maxLines: 4,
            ),

            _buildLabel("Application Link (Optional)"),
            _buildTextField(
              controller.applicationLinkController,
              "https://example.com/apply",
            ),

            const SizedBox(height: 30),

            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      controller.clearFields();
                      Get.back();
                    },
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      side: const BorderSide(color: Color(0xFFE5E7EB)),
                    ),
                    child: const Text(
                      "Cancel",
                      style: TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => controller.saveJobCircular(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF7B4DFF),
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text(
                      "Save Product",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8, top: 12),
      child: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 14,
          color: Colors.black87,
        ),
      ),
    );
  }

  Widget _buildTextField(
    TextEditingController textController,
    String hint, {
    int maxLines = 1,
    IconData? suffixIcon,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextField(
      controller: textController,
      maxLines: maxLines,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.grey, fontSize: 13),
        filled: true,
        fillColor: const Color(0xFFF9FAFB),
        suffixIcon: suffixIcon != null
            ? Icon(suffixIcon, size: 18, color: Colors.grey)
            : null,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFF3F4F6), width: 1),
        ),
      ),
    );
  }
}
