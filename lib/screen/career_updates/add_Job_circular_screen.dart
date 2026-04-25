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
      body: Column(
        children: [
          // Vibrant Gradient Header
          Container(
            padding: const EdgeInsets.only(top: 50, bottom: 25, left: 16, right: 16),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF8E2DE2), Color(0xFF4A00E0)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
              boxShadow: [
                BoxShadow(
                  color: Color(0x334A00E0),
                  blurRadius: 15,
                  offset: Offset(0, 8),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 18),
                    onPressed: () {
                      controller.clearFields();
                      Get.back();
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Obx(() => Text(
                    controller.isEditing.value ? "Update Job Posting" : "Create Job Posting",
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      fontSize: 22,
                      fontFamily: 'Inter',
                    ),
                  )),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.post_add_rounded, color: Colors.white, size: 20),
                ),
              ],
            ),
          ),

          // Form Fields
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionHeader(Icons.business_center_rounded, "Job Details"),
                  _buildLabel("Organization Name"),
                  _buildTextField(
                    controller.organizationNameController,
                    "e.g., Tech Solutions Inc.",
                    Icons.business_rounded,
                  ),

                  _buildLabel("Post Title"),
                  _buildTextField(
                    controller.postTitleController,
                    "e.g., Senior Software Engineer",
                    Icons.badge_rounded,
                  ),

                  _buildLabel("Required Education"),
                  _buildTextField(
                    controller.requiredEducationController,
                    "e.g., Bachelor's Degree in CSE",
                    Icons.school_rounded,
                  ),

                  const SizedBox(height: 20),
                  _buildSectionHeader(Icons.event_note_rounded, "Logistics"),
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
                              Icons.groups_rounded,
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
                                  "YYYY-MM-DD",
                                  Icons.calendar_today_rounded,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),
                  _buildSectionHeader(Icons.description_rounded, "Additional Info"),
                  _buildLabel("Job Description"),
                  _buildTextField(
                    controller.jobDescriptionController,
                    "Write details about the role...",
                    Icons.text_snippet_rounded,
                    maxLines: 5,
                  ),

                  _buildLabel("Application Link (Optional)"),
                  _buildTextField(
                    controller.applicationLinkController,
                    "https://company.com/careers",
                    Icons.link_rounded,
                  ),

                  const SizedBox(height: 40),

                  // Action Buttons
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            controller.clearFields();
                            Get.back();
                          },
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            side: BorderSide(color: Colors.grey.shade300),
                          ),
                          child: const Text(
                            "Cancel",
                            style: TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'Inter',
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Obx(() => ElevatedButton(
                          onPressed: controller.isLoading.value ? null : () => controller.saveJobCircular(),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF6A11CB),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            elevation: 8,
                            shadowColor: const Color(0xFF6A11CB).withOpacity(0.4),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          child: controller.isLoading.value
                              ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                              : Text(
                                  controller.isEditing.value ? "Update Now" : "Post Circular",
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w800,
                                    fontSize: 16,
                                    fontFamily: 'Inter',
                                  ),
                                ),
                        )),
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(IconData icon, String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12, top: 10),
      child: Row(
        children: [
          Icon(icon, size: 20, color: const Color(0xFF4A00E0)),
          const SizedBox(width: 10),
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w800,
              fontFamily: 'Inter',
              color: Color(0xFF4A00E0),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(child: Divider(color: Colors.grey.shade200, thickness: 1)),
        ],
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8, top: 16),
      child: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 13,
          fontFamily: 'Inter',
          color: Colors.black54,
        ),
      ),
    );
  }

  Widget _buildTextField(
    TextEditingController textController,
    String hint,
    IconData icon, {
    int maxLines = 1,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9FA),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFF1F3F5), width: 1.5),
      ),
      child: TextField(
        controller: textController,
        maxLines: maxLines,
        keyboardType: keyboardType,
        style: const TextStyle(fontFamily: 'Inter', fontSize: 14, fontWeight: FontWeight.w600),
        decoration: InputDecoration(
          prefixIcon: Icon(icon, size: 18, color: Colors.grey.shade400),
          hintText: hint,
          hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 13, fontWeight: FontWeight.w500),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          border: InputBorder.none,
        ),
      ),
    );
  }
  }

