import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_widgets/controller/product/product_controller.dart';
import 'package:get/get.dart';

class AddProductScreen extends StatelessWidget {
  const AddProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FD),
      body: GetBuilder<ProductController>(
        builder: (controller) {
          // Filter out "All" for the creation form
          final dropdownCategories = controller.categories.where((c) => c != "All").toList();
          
          return Column(
            children: [
              // Premium Header with Gradient
              Container(
                width: double.infinity,
                padding: const EdgeInsets.only(top: 60, bottom: 30, left: 20, right: 20),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF8E2DE2), Color(0xFF4A00E0)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(32),
                    bottomRight: Radius.circular(32),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x444A00E0),
                      blurRadius: 20,
                      offset: Offset(0, 10),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () => Get.back(),
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 18),
                          ),
                        ),
                        Text(
                          controller.isEdit ? "Update Product" : "Add Product",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                            fontFamily: 'Inter',
                          ),
                        ),
                        const SizedBox(width: 40), // Balance
                      ],
                    ),
                  ],
                ),
              ),

              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildSectionTitle("General Information"),
                      const SizedBox(height: 16),
                      
                      _buildLabel("Product Name"),
                      _buildTextField(
                        controller.productNameController,
                        hint: "e.g. Premium Cotton Shirt",
                        icon: Icons.shopping_bag_outlined,
                      ),
                      
                      const SizedBox(height: 20),
                      
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildLabel("Category"),
                                _buildDropdown(
                                  value: controller.formSelectedCategory.isEmpty ? null : controller.formSelectedCategory,
                                  items: dropdownCategories,
                                  onChanged: (v) => controller.updateFormCategory(v!),
                                  hint: "Select",
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildLabel("Size"),
                                _buildDropdown(
                                  value: controller.selectedSize,
                                  items: controller.availableSizes,
                                  onChanged: (v) => controller.updateSize(v!),
                                  hint: "Select",
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 24),
                      _buildSectionTitle("Specifications"),
                      const SizedBox(height: 16),
                      
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildLabel("Material"),
                                _buildTextField(
                                  controller.materialController,
                                  hint: "e.g. Cotton",
                                  icon: Icons.texture_rounded,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildLabel("Color"),
                                _buildTextField(
                                  controller.colorController,
                                  hint: "e.g. Blue",
                                  icon: Icons.palette_outlined,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      
                      const SizedBox(height: 20),
                      
                      _buildLabel("Quality Level"),
                      _buildDropdown(
                        value: controller.selectedQuality,
                        items: ["Premium", "Standard", "Economy"],
                        onChanged: (v) => controller.updateQuality(v!),
                      ),

                      const SizedBox(height: 24),
                      _buildSectionTitle("Media & Description"),
                      const SizedBox(height: 16),
                      
                      _buildLabel("Product Image"),
                      GestureDetector(
                        onTap: () => controller.pickProductImage(),
                        child: Container(
                          height: 180,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: const Color(0xFFF1F3F5), width: 1.5),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.02),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              controller.pickedImage != null
                                  ? ClipRRect(
                                      borderRadius: BorderRadius.circular(18),
                                      child: Image.file(
                                        File(controller.pickedImage!.path),
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                  : controller.existingImageUrl != null
                                      ? ClipRRect(
                                          borderRadius: BorderRadius.circular(18),
                                          child: Image.network(
                                            controller.existingImageUrl!,
                                            fit: BoxFit.cover,
                                          ),
                                        )
                                      : Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              padding: const EdgeInsets.all(12),
                                              decoration: BoxDecoration(
                                                color: const Color(0xFFF3EFFF),
                                                shape: BoxShape.circle,
                                              ),
                                              child: const Icon(Icons.add_photo_alternate_rounded, color: Color(0xFF4A00E0), size: 28),
                                            ),
                                            const SizedBox(height: 12),
                                            const Text(
                                              "Tap to select from gallery",
                                              style: TextStyle(color: Colors.grey, fontSize: 13, fontWeight: FontWeight.w600),
                                            ),
                                          ],
                                        ),
                              if (controller.pickedImage != null || controller.existingImageUrl != null)
                                Positioned(
                                  top: 10,
                                  right: 10,
                                  child: GestureDetector(
                                    onTap: () => controller.clearImage(),
                                    child: Container(
                                      padding: const EdgeInsets.all(6),
                                      decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(0.9),
                                        shape: BoxShape.circle,
                                        boxShadow: [
                                          BoxShadow(color: Colors.black12, blurRadius: 4, offset: const Offset(0, 2))
                                        ],
                                      ),
                                      child: const Icon(Icons.close_rounded, color: Colors.redAccent, size: 20),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                      
                      const SizedBox(height: 24),
                      
                      _buildLabel("Description"),
                      _buildTextField(
                        controller.productDescriptionController,
                        hint: "Tell us more about the product...",
                        maxLines: 4,
                      ),

                      const SizedBox(height: 40),
                      
                      // Action Buttons
                      Row(
                        children: [
                          Expanded(
                            child: _buildButton(
                              "Cancel",
                              Colors.white,
                              const Color(0xFF495057),
                              () => Get.back(),
                              isBordered: true,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: _buildButton(
                              controller.isSaving 
                                  ? "Saving..." 
                                  : (controller.isEdit ? "Update Product" : "Save Product"),
                              const Color(0xFF4A00E0),
                              Colors.white,
                              controller.isSaving ? () {} : () => controller.saveProduct(),
                              isLoading: controller.isSaving,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title.toUpperCase(),
      style: TextStyle(
        color: Colors.grey.shade500,
        fontSize: 11,
        fontWeight: FontWeight.w900,
        letterSpacing: 1.2,
      ),
    );
  }

  Widget _buildLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 8),
      child: Text(
        label,
        style: const TextStyle(
          color: Color(0xFF1F2937),
          fontSize: 14,
          fontWeight: FontWeight.w700,
          fontFamily: 'Inter',
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, {required String hint, IconData? icon, int maxLines = 1}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFF1F3F5), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF343A40)),
        decoration: InputDecoration(
          hintText: hint,
          prefixIcon: icon != null ? Icon(icon, size: 18, color: const Color(0xFF4A00E0)) : null,
          hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 13, fontWeight: FontWeight.w500),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.all(18),
        ),
      ),
    );
  }

  Widget _buildDropdown({String? value, required List<String> items, required Function(String?) onChanged, String? hint}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFF1F3F5), width: 1.5),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          hint: hint != null ? Text(hint, style: TextStyle(color: Colors.grey.shade400, fontSize: 13)) : null,
          icon: const Icon(Icons.keyboard_arrow_down_rounded, color: Color(0xFF4A00E0)),
          items: items.map((String item) {
            return DropdownMenuItem(
              value: item,
              child: Text(item, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF343A40))),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }

  Widget _buildButton(String text, Color bgColor, Color textColor, VoidCallback onTap, {bool isBordered = false, bool isLoading = false}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 56,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(16),
          border: isBordered ? Border.all(color: const Color(0xFFCED4DA)) : null,
          boxShadow: bgColor != Colors.white ? [
            BoxShadow(
              color: bgColor.withOpacity(0.3),
              blurRadius: 12,
              offset: const Offset(0, 6),
            )
          ] : [],
        ),
        child: isLoading
            ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
              )
            : Text(
                text,
                style: TextStyle(
                  color: textColor,
                  fontSize: 15,
                  fontWeight: FontWeight.w800,
                  fontFamily: 'Inter',
                ),
              ),
      ),
    );
  }
}
