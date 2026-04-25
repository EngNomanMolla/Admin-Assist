import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_widgets/controller/live_notice_controller.dart'; 

class AddLiveNoticeScreen extends StatelessWidget {
  const AddLiveNoticeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<LiveNoticeController>();

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
      child: SingleChildScrollView(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Drag handle
            Center(
              child: Container(
                width: 40,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  controller.editingNoticeId != null ? "Edit Notice" : "Add Live Notice",
                  style: const TextStyle(
                    fontSize: 20, 
                    fontWeight: FontWeight.w800,
                    fontFamily: 'Inter',
                    color: Colors.black87,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    onPressed: () => Get.back(),
                    icon: const Icon(Icons.close_rounded, size: 20, color: Colors.black54),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            const Text(
              "Notice Text",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.black87,
                fontFamily: 'Inter',
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: controller.noticeController,
              maxLines: 3,
              style: const TextStyle(fontFamily: 'Inter', fontSize: 14),
              decoration: InputDecoration(
                hintText: "Enter the details of the notice...",
                hintStyle: TextStyle(color: Colors.grey.shade400, fontFamily: 'Inter'),
                filled: true,
                fillColor: const Color(0xFFF9FAFB),
                contentPadding: const EdgeInsets.all(16),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(color: Colors.grey.shade200),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(color: Color(0xFF7B61FF), width: 1.5),
                ),
              ),
            ),
            const SizedBox(height: 24),

            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Start Date",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                          fontFamily: 'Inter',
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 8),
                      GetBuilder<LiveNoticeController>(
                        builder: (c) {
                          return _buildDatePicker(
                            context,
                            c.startDate.isEmpty ? "Select date" : c.startDate,
                            () => c.selectDate(context, true),
                            c.startDate.isNotEmpty,
                          );
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "End Date",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                          fontFamily: 'Inter',
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 8),
                      GetBuilder<LiveNoticeController>(
                        builder: (c) {
                          return _buildDatePicker(
                            context,
                            c.endDate.isEmpty ? "Select date" : c.endDate,
                            () => c.selectDate(context, false),
                            c.endDate.isNotEmpty,
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),

            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Get.back(),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      side: BorderSide(color: Colors.grey.shade300),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: const Text(
                      "Cancel",
                      style: TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Inter',
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Obx(() => ElevatedButton(
                    onPressed: controller.isLoading.value ? null : () => controller.saveNotice(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF7B61FF),
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: controller.isLoading.value 
                      ? const SizedBox(
                          height: 20, width: 20,
                          child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                        )
                      : Text(
                          controller.editingNoticeId != null ? "Update Notice" : "Save Notice",
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Inter',
                            fontSize: 15,
                          ),
                        ),
                  )),
                ),
              ],
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Widget _buildDatePicker(
    BuildContext context,
    String hint,
    VoidCallback onTap,
    bool isSelected,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF7B61FF).withOpacity(0.05) : const Color(0xFFF9FAFB),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? const Color(0xFF7B61FF).withOpacity(0.3) : Colors.grey.shade200, 
            width: 1
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              hint,
              style: TextStyle(
                color: isSelected ? const Color(0xFF7B61FF) : Colors.grey.shade500, 
                fontSize: 13,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                fontFamily: 'Inter',
              ),
            ),
            Icon(
              Icons.calendar_today_rounded,
              size: 16,
              color: isSelected ? const Color(0xFF7B61FF) : Colors.grey.shade400,
            ),
          ],
        ),
      ),
    );
  }
}
