import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_widgets/provider/category_provider.dart';
import 'package:flutter_widgets/provider/product_provider.dart';

class ProductController extends GetxController {
  final CategoryProvider _categoryProvider = CategoryProvider();
  final ProductProvider _productProvider = ProductProvider();
  
  String selectedCategory = "All";
  int? selectedCategoryId;
  List<String> categories = ["All"];
  List<dynamic> categoriesData = [];
  
  bool isLoadingCategories = false;
  bool isLoadingProducts = false;
  
  List<dynamic> fetchedProducts = [];

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
  String formSelectedCategory = "Men's";
  String selectedQuality = "Premium";

  final productNameController = TextEditingController();
  final materialController = TextEditingController();
  final productDescriptionController = TextEditingController();
  final thumbnailURLController = TextEditingController();

  void updateFormCategory(String value) {
    formSelectedCategory = value;
    update();
  }

  void updateQuality(String value) {
    selectedQuality = value;
    update();
  }

  void saveProduct() {
    Get.back();
  }

  @override
  void onClose() {
    productNameController.dispose();
    materialController.dispose();
    productDescriptionController.dispose();
    thumbnailURLController.dispose();
    super.onClose();
  }
}
