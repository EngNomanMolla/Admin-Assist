import 'package:flutter/material.dart';
import 'package:flutter_widgets/controller/banner_ads_controller.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AddBannerScreen extends StatelessWidget {
  const AddBannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BannerController>(
      builder: (controller) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Handle bar
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                
                Obx(() => Text(
                  controller.isEditing.value ? "Update Banner" : "Add New Banner",
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    fontFamily: 'Inter',
                  ),
                )),
                const SizedBox(height: 4),
                Obx(() => Text(
                  controller.isEditing.value ? "Modify your ad details" : "Create a beautiful ad for your app",
                  style: const TextStyle(
                    fontSize: 13,
                    color: Colors.grey,
                    fontFamily: 'Inter',
                  ),
                )),
                
                const SizedBox(height: 24),
                
                const Text(
                  "Banner Image",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    fontFamily: 'Inter',
                  ),
                ),
                const SizedBox(height: 12),
                
                // Toggle Tab
                Obx(() => Container(
                  height: 45,
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF3F4F6),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () => controller.toggleMode(true),
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: controller.isUploadMode.value ? const Color(0xFF6A11CB) : Colors.transparent,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              "Upload Gallery",
                              style: TextStyle(
                                color: controller.isUploadMode.value ? Colors.white : Colors.black54,
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                                fontFamily: 'Inter',
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () => controller.toggleMode(false),
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: !controller.isUploadMode.value ? const Color(0xFF6A11CB) : Colors.transparent,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              "Image Link",
                              style: TextStyle(
                                color: !controller.isUploadMode.value ? Colors.white : Colors.black54,
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                                fontFamily: 'Inter',
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
                
                const SizedBox(height: 16),

                // Conditional Input Area
                Obx(() {
                  if (controller.isUploadMode.value) {
                    return GestureDetector(
                      onTap: () => controller.pickImage(),
                      child: Container(
                        height: 140,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: const Color(0xFFF3F4F6),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: const Color(0xFF6A11CB).withOpacity(0.1)),
                          image: controller.selectedImage.value != null 
                            ? DecorationImage(image: FileImage(controller.selectedImage.value!), fit: BoxFit.cover)
                            : null,
                        ),
                        child: controller.selectedImage.value == null 
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.add_photo_alternate_rounded, color: const Color(0xFF6A11CB).withOpacity(0.5), size: 40),
                                const SizedBox(height: 8),
                                const Text("Tap to select image", style: TextStyle(color: Colors.grey, fontSize: 12, fontFamily: 'Inter')),
                              ],
                            )
                          : Container(
                              alignment: Alignment.bottomRight,
                              padding: const EdgeInsets.all(8),
                              child: CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 14,
                                child: Icon(Icons.edit_rounded, size: 14, color: const Color(0xFF6A11CB)),
                              ),
                            ),
                      ),
                    );
                  } else {
                    return _buildInputField(controller.urlController, "Enter direct image link", Icons.link_rounded);
                  }
                }),
                
                const SizedBox(height: 24),
                
                _buildLabel("Headline"),
                _buildInputField(controller.headlineController, "e.g. Career Growth", Icons.title_rounded),
                
                const SizedBox(height: 16),
                
                _buildLabel("Content"),
                _buildInputField(controller.subheadlineController, "e.g. Continuous Improvement", Icons.subtitles_rounded),
                
                const SizedBox(height: 16),

                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildLabel("Start Date"),
                          _buildDateSelector(context, controller, true),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildLabel("End Date"),
                          _buildDateSelector(context, controller, false),
                        ],
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: 32),

                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: () => controller.saveBanner(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF6A11CB),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      elevation: 0,
                    ),
                    child: Obx(() => Text(
                      controller.isEditing.value ? "Update Banner" : "Publish Banner",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontFamily: 'Inter',
                      ),
                    )),
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8, left: 4),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w700,
          color: Colors.black87,
          fontFamily: 'Inter',
        ),
      ),
    );
  }

  Widget _buildInputField(TextEditingController ctrl, String hint, IconData icon) {
    return TextField(
      controller: ctrl,
      style: const TextStyle(fontFamily: 'Inter', fontSize: 14),
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: Icon(icon, size: 20, color: const Color(0xFF6A11CB).withOpacity(0.6)),
        filled: true,
        fillColor: const Color(0xFFF3F4F6),
        hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      ),
    );
  }

  Widget _buildDateSelector(BuildContext context, BannerController controller, bool isStart) {
    String value = isStart ? controller.startDate : controller.endDate;
    return InkWell(
      onTap: () => controller.selectDate(context, isStart),
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          color: const Color(0xFFF3F4F6),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              value.isEmpty ? "DD MMM YY" : DateFormat('dd MMM yy').format(DateTime.parse(value)),
              style: TextStyle(
                color: value.isEmpty ? Colors.grey : Colors.black87,
                fontSize: 13,
                fontFamily: 'Inter',
                fontWeight: value.isEmpty ? FontWeight.normal : FontWeight.w600,
              ),
            ),
            Icon(Icons.calendar_month_rounded, size: 18, color: const Color(0xFF6A11CB).withOpacity(0.6)),
          ],
        ),
      ),
    );
  }
}
