import 'package:flutter/material.dart';
import 'package:flutter_widgets/controller/product/product_controller.dart';
import 'package:get/get.dart';

class AddProductScreen extends StatelessWidget {
  const AddProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProductController>();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black54),
          onPressed: () => Get.back(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.close, color: Colors.black54),
            onPressed: () => Get.back(),
          ),
        ],
        centerTitle: true,
      ),
      body: GetBuilder<ProductController>(
        builder: (controller) {
          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Basic Information",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 20),

                _buildFieldLabel("Product Name"),
                _buildTextField(
                  "Enter product name",
                  controller.productNameController,
                ),
                const SizedBox(height: 15),

                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildFieldLabel("Category"),
                          _buildDropdownField(
                            controller.formSelectedCategory,
                            ["Men's", "Women's", "Kids"],
                            (v) => controller.updateFormCategory(v!),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildFieldLabel("Size"),

                          _buildTextField(controller.selectedProductSize, null),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),

                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildFieldLabel("Material"),
                          _buildTextField(
                            "Cotton, Denim",
                            controller.materialController,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildFieldLabel("Size"),

                          _buildTextField(controller.selectedColorSize, null),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),

                _buildFieldLabel("Quality"),
                _buildDropdownField(controller.selectedQuality, [
                  "Premium",
                  "Standard",
                ], (v) => controller.updateQuality(v!)),
                const SizedBox(height: 25),

                const Text(
                  "Media",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 10),
                _buildImageUploadBox("Upload product image"),
                const SizedBox(height: 20),

                _buildFieldLabel("Details"),
                _buildTextField(
                  "Or enter thumbnail URL",
                  controller.thumbnailURLController,
                ),
                const SizedBox(height: 15),

                _buildFieldLabel("Description"),
                _buildTextField(
                  "Product description",
                  controller.productDescriptionController,
                  maxLines: 3,
                ),

                const SizedBox(height: 40),

                Row(
                  children: [
                    Expanded(
                      child: _buildActionButton(
                        "Cancel",
                        Colors.white,
                        Colors.black,
                        () => Get.back(),
                      ),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: _buildActionButton(
                        "Save Product",
                        const Color(0xFF7B4DFF),
                        Colors.white,
                        () => controller.saveProduct(),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildFieldLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6.0),
      child: Text(
        label,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 13,
          color: Colors.grey[700],
        ),
      ),
    );
  }

  Widget _buildTextField(
    String hint,
    TextEditingController? ctrl, {
    int maxLines = 1,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFFBFBFB),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFF1F1F1)),
      ),
      child: TextField(
        controller: ctrl,
        maxLines: maxLines,
        style: const TextStyle(fontSize: 14, color: Colors.black87),
        decoration: InputDecoration(
          hintText: hint,

          hintStyle: const TextStyle(
            color: Colors.black26,
            fontSize: 13,
            fontWeight: FontWeight.w400,
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget _buildDropdownField(
    String value,
    List<String> items,
    Function(String?) onChange,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFFBFBFB),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFF1F1F1)),
      ),
      child: DropdownButtonFormField<String>(
        value: value,
        icon: Icon(
          Icons.keyboard_arrow_down,
          color: Colors.grey[600],
          size: 20,
        ),
        items: items
            .map(
              (e) => DropdownMenuItem(
                value: e,
                child: Text(e, style: const TextStyle(fontSize: 14)),
              ),
            )
            .toList(),
        onChanged: onChange,
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 16),
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget _buildImageUploadBox(String text) {
    return Container(
      height: 140,
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFFFAFAFA),
        border: Border.all(color: Colors.black.withOpacity(0.06)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.drive_folder_upload_outlined,
            color: Colors.grey[500],
            size: 28,
          ),
          const SizedBox(height: 8),
          Text(
            text,
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(
    String text,
    Color bg,
    Color textCol,
    VoidCallback onTap,
  ) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: bg,
        foregroundColor: textCol,
        elevation: 0,
        side: bg == Colors.white
            ? const BorderSide(color: Colors.black12)
            : null,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        padding: const EdgeInsets.symmetric(vertical: 16),
      ),
      onPressed: onTap,
      child: Text(
        text,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
      ),
    );
  }
}
