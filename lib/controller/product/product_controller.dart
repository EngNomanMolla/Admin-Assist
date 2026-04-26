import 'dart:io';
import 'package:flutter_widgets/screen/product_screen/add_product_screen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_widgets/provider/category_provider.dart';
import 'package:flutter_widgets/provider/product_provider.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

class ProductController extends GetxController {
  final CategoryProvider _categoryProvider = CategoryProvider();
  final ProductProvider _productProvider = ProductProvider();
  final ImagePicker _picker = ImagePicker();
  
  String selectedCategory = "All";
  int? selectedCategoryId;
  List<String> categories = ["All"];
  List<dynamic> categoriesData = [];
  
  bool isLoadingCategories = false;
  bool isLoadingProducts = false;
  
  List<dynamic> fetchedProducts = [];
  XFile? pickedImage;

  @override
  void onInit() {
    super.onInit();
    fetchCategories();
    fetchProducts();
  }

  Future<void> fetchCategories() async {
    try {
      isLoadingCategories = true;
      update();
      final data = await _categoryProvider.fetchCategories();
      categoriesData = data;
      
      categories = ["All"];
      for (var item in data) {
        if (item['name'] != null) {
          categories.add(item['name']);
        }
      }
      
      if (formSelectedCategory.isEmpty && categories.length > 1) {
        formSelectedCategory = categories[1]; // First item after "All"
      }
    } catch (e) {
      debugPrint("Category Fetch Error: $e");
    } finally {
      isLoadingCategories = false;
      update();
    }
  }

  Future<void> fetchProducts({int? categoryId}) async {
    try {
      isLoadingProducts = true;
      update();
      final data = await _productProvider.fetchProducts(categoryId: categoryId);
      fetchedProducts = data;
    } catch (e) {
      debugPrint("Product Fetch Error: $e");
    } finally {
      isLoadingProducts = false;
      update();
    }
  }

  void changeCategory(String category) {
    selectedCategory = category;
    
    if (category == "All") {
      selectedCategoryId = null;
    } else {
      final catObj = categoriesData.firstWhere(
        (element) => element['name'] == category,
        orElse: () => null,
      );
      selectedCategoryId = catObj != null ? catObj['id'] : null;
    }
    
    fetchProducts(categoryId: selectedCategoryId);
  }

  List<dynamic> get productsList => fetchedProducts;

  String selectedProductSize = "S, M, L";
  String selectedColorSize = "Black, Blue";
  String formSelectedCategory = "";
  String selectedQuality = "Premium";
  
    final List<String> availableSizes = ["S", "M", "L", "XL", "XXL", "38", "40", "42", "44", "46", "Free Size"];
  String selectedSize = "M";

  void updateSize(String value) {
    selectedSize = value;
    update();
  }

  final productNameController = TextEditingController();
  final materialController = TextEditingController();
  final productDescriptionController = TextEditingController();
  final colorController = TextEditingController();

  bool isSaving = false;
  bool isEdit = false;
  int? editingProductId;
  String? existingImageUrl;

  void setEditProduct(Map<String, dynamic> product) {
    isEdit = true;
    editingProductId = product['id'];
    productNameController.text = product['name'] ?? "";
    materialController.text = product['material'] ?? "";
    colorController.text = product['color'] ?? "";
    productDescriptionController.text = product['description'] ?? "";
    
    String sizeValue = product['size']?.toString() ?? "M";
    if (!availableSizes.contains(sizeValue)) {
      availableSizes.add(sizeValue);
    }
    selectedSize = sizeValue;
    
    selectedQuality = product['quality'] ?? "Premium";
    formSelectedCategory = product['category']?['name'] ?? "";
    existingImageUrl = product['image'];
    pickedImage = null;
    update();
    Get.to(() => const AddProductScreen());
  }

  void resetForm() {
    isEdit = false;
    editingProductId = null;
    productNameController.clear();
    materialController.clear();
    colorController.clear();
    productDescriptionController.clear();
    selectedSize = "M";
    selectedQuality = "Premium";
    pickedImage = null;
    existingImageUrl = null;
    update();
  }

  Future<void> pickProductImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      pickedImage = image;
      update();
    }
  }

  void updateFormCategory(String value) {
    formSelectedCategory = value;
    update();
  }

  void updateQuality(String value) {
    selectedQuality = value;
    update();
  }

  void clearImage() {
    pickedImage = null;
    existingImageUrl = null;
    update();
  }

  Future<void> saveProduct() async {
    if (productNameController.text.isEmpty || formSelectedCategory.isEmpty || (pickedImage == null && !isEdit)) {
      Get.snackbar(
        "Error", 
        "Please fill in all required fields and select an image",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.8),
        colorText: Colors.white,
      );
      return;
    }

    try {
      isSaving = true;
      update();

      final catObj = categoriesData.firstWhere(
        (element) => element['name'] == formSelectedCategory,
        orElse: () => null,
      );

      if (catObj == null) throw Exception("Selected category not found");

      Map<String, String> fields = {
        "name": productNameController.text,
        "category_id": catObj['id'].toString(),
        "size": selectedSize,
        "material": materialController.text,
        "color": colorController.text,
        "quality": selectedQuality,
        "description": productDescriptionController.text,
        "status": "active",
      };

      bool success;
      if (isEdit) {
        fields["_method"] = "PUT"; // Often needed for multipart updates
        success = await _productProvider.updateProduct(editingProductId!, fields, pickedImage?.path);
      } else {
        success = await _productProvider.createProduct(fields, pickedImage!.path);
      }

      if (success) {
        Get.back();
        Get.snackbar(
          "Success", 
          isEdit ? "Product updated successfully!" : "Product created successfully!",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green.withOpacity(0.8),
          colorText: Colors.white,
        );
        fetchProducts(); // Refresh list
        resetForm();
      }
    } catch (e) {
      Get.snackbar(
        "Error", 
        e.toString().replaceAll("Exception: ", ""),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.8),
        colorText: Colors.white,
      );
    } finally {
      isSaving = false;
      update();
    }
  }

  Future<void> deleteProduct(int id) async {
    AwesomeDialog(
      context: Get.context!,
      dialogType: DialogType.warning,
      animType: AnimType.bottomSlide,
      title: 'Delete Product',
      desc: 'Are you sure you want to delete this product?',
      btnCancelOnPress: () {},
      btnOkOnPress: () async {
        try {
          final success = await _productProvider.deleteProduct(id);
          if (success) {
            Get.snackbar(
              "Success", 
              "Product deleted successfully!",
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.green.withOpacity(0.8),
              colorText: Colors.white,
            );
            fetchProducts();
          }
        } catch (e) {
          Get.snackbar("Error", e.toString());
        }
      },
    ).show();
  }

  @override
  void onClose() {
    productNameController.dispose();
    materialController.dispose();
    productDescriptionController.dispose();
    colorController.dispose();
    pickedImage = null;
    super.onClose();
  }
}
