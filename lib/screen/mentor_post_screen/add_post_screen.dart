import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_widgets/controller/mentor_post_controller.dart';

class AddPostDialog extends StatelessWidget {
  const AddPostDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<MentorPostController>();

    return Dialog(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      elevation: 5,
      insetPadding: const EdgeInsets.symmetric(horizontal: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(width: 32),
                  const Text(
                    "Add Mentor Post",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1A1A1A),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.close,
                        size: 18,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              _buildLabel("Post Title"),
              const SizedBox(height: 10),
              _buildTextField(controller.titleController, "Enter Post Title"),
              const SizedBox(height: 24),

              _buildLabel("Post Type"),
              const SizedBox(height: 12),
              GetBuilder<MentorPostController>(
                builder: (ctrl) {
                  return Column(
                    children: [
                      Row(
                        children: [
                          _buildTypeCard(
                            ctrl,
                            "Text Post",
                            Icons.article_outlined,
                            'Text',
                          ),
                          const SizedBox(width: 10),
                          _buildTypeCard(
                            ctrl,
                            "Image Post",
                            Icons.image_outlined,
                            'Image',
                          ),
                          const SizedBox(width: 10),
                          _buildTypeCard(
                            ctrl,
                            "Video Post",
                            Icons.videocam_outlined,
                            'Video',
                          ),
                        ],
                      ),

                      if (ctrl.selectedPostType != 'Text') ...[
                        const SizedBox(height: 24),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: _buildLabel("Upload ${ctrl.selectedPostType}"),
                        ),
                        const SizedBox(height: 10),
                        GestureDetector(
                          onTap: () => ctrl.pickImage(),
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(vertical: 30),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFBFBFB),
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: Colors.grey.shade200,
                                width: 1.5,
                              ),
                            ),
                            child: Column(
                              children: [
                                Icon(
                                  Icons.cloud_upload_outlined,
                                  color: Colors.grey[400],
                                  size: 35,
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  ctrl.uploadedImageName ??
                                      "Click to upload ${ctrl.selectedPostType.toLowerCase()}",
                                  style: TextStyle(
                                    color: Colors.grey[500],
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ],
                  );
                },
              ),
              const SizedBox(height: 24),

              _buildLabel("Description"),
              const SizedBox(height: 10),
              _buildTextField(
                controller.contentController,
                "Write your post content",
                maxLines: 4,
              ),
              const SizedBox(height: 32),

              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Get.back(),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        shape: const StadiumBorder(),
                        side: BorderSide(color: Colors.grey.shade200),
                      ),
                      child: const Text(
                        "Cancel",
                        style: TextStyle(color: Colors.black87),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => controller.publishPost(),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        backgroundColor: const Color(0xFF7B39FD),
                        shape: const StadiumBorder(),
                        elevation: 0,
                      ),
                      child: const Text(
                        "Publish Post",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) => Text(
    text,
    style: const TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 14,
      color: Color(0xFF333333),
    ),
  );

  Widget _buildTextField(
    TextEditingController ctrl,
    String hint, {
    int maxLines = 1,
  }) {
    return TextField(
      controller: ctrl,
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: Colors.grey[400], fontSize: 13),
        filled: true,
        fillColor: const Color(0xFFF7F7F7),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _buildTypeCard(
    MentorPostController controller,
    String label,
    IconData icon,
    String type,
  ) {
    bool isSelected = controller.selectedPostType == type;
    return Expanded(
      child: GestureDetector(
        onTap: () => controller.changePostType(type),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            color: isSelected
                ? const Color(0xFF7B39FD).withOpacity(0.05)
                : Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isSelected
                  ? const Color(0xFF7B39FD)
                  : Colors.grey.shade200,
              width: 1.5,
            ),
          ),
          child: Column(
            children: [
              Icon(
                icon,
                color: isSelected ? const Color(0xFF7B39FD) : Colors.grey[500],
                size: 24,
              ),
              const SizedBox(height: 6),
              Text(
                label,
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                  color: isSelected
                      ? const Color(0xFF7B39FD)
                      : Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
