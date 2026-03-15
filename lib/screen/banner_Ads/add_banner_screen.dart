import 'package:flutter/material.dart';
import 'package:flutter_widgets/controller/banner_ads_controller.dart';
import 'package:get/get.dart';

class AddBannerScreen extends StatelessWidget {
  const AddBannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<BannerController>();

    return GetBuilder<BannerController>(
      builder: (controller) {
        return Container(
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildHeader(),
                const SizedBox(height: 20),
                const Text(
                  "Banner Image",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                _buildUploadBox(),
                const SizedBox(height: 12),

                _buildInputField(
                  controller.urlController,
                  "Enter Image URL (e.g. assets/...)",
                ),
                const SizedBox(height: 16),

                const Text(
                  "Headline",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                _buildInputField(
                  controller.headlineController,
                  "Career Growth",
                ),
                const SizedBox(height: 16),

                const Text(
                  "Subheadline",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                _buildInputField(
                  controller.subheadlineController,
                  "Continuous Improvement",
                ),
                const SizedBox(height: 16),

                Row(
                  children: [
                    Expanded(
                      child: _buildDateDisplay(
                        context,
                        "Start Date",
                        controller.startDate,
                        true,
                        controller,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildDateDisplay(
                        context,
                        "End Date",
                        controller.endDate,
                        false,
                        controller,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),

                _buildActionButtons(controller),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back),
        ),
        const Text(
          "Add Banner Ad",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        IconButton(onPressed: () => Get.back(), icon: const Icon(Icons.close)),
      ],
    );
  }

  Widget _buildUploadBox() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 30),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        children: [
          Icon(Icons.image_outlined, color: Colors.grey.shade400, size: 40),
          const Text(
            "Click to upload image",
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  Widget _buildInputField(TextEditingController ctrl, String hint) {
    return TextField(
      controller: ctrl,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: Colors.grey.shade50,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _buildDateDisplay(
    BuildContext context,
    String label,
    String value,
    bool isStart,
    BannerController controller,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        InkWell(
          onTap: () => controller.selectDate(context, isStart),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  value.isEmpty ? "mm/dd/yyyy" : value,
                  style: TextStyle(
                    color: value.isEmpty ? Colors.grey : Colors.black,
                  ),
                ),
                const Icon(Icons.calendar_month, size: 18, color: Colors.grey),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons(BannerController controller) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: () => Get.back(),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            child: const Text("Cancel"),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: ElevatedButton(
            onPressed: () => controller.saveBanner(),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF7B39FD),
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            child: const Text("Save", style: TextStyle(color: Colors.white)),
          ),
        ),
      ],
    );
  }
}
