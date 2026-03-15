import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  String selectedCategory = "All";
  final List<String> categories = ["All", "Men's", "Women's", "Kids"];

  final List<Map<String, String>> allProducts = [
    {
      "name": "Men's Classic Shirt",
      "size": "M, L, XL",
      "category": "Men's",
      "image": "assets/images/png/mens.png",
    },
    {
      "name": "Casual Denim",
      "size": "6-8, 10-12",
      "category": "Men's",
      "image": "assets/images/png/mens.png",
    },
    {
      "name": "Slim Fit Jacket",
      "size": "L, XL",
      "category": "Men's",
      "image": "assets/images/png/mens.png",
    },
    {
      "name": "Men's Polo T-Shirt",
      "size": "M, L",
      "category": "Men's",
      "image": "assets/images/png/mens.png",
    },
    {
      "name": "Urban Style Shirt",
      "size": "XL",
      "category": "Men's",
      "image": "assets/images/png/mens.png",
    },
    {
      "name": "Classic Men's Vest",
      "size": "S, M, L",
      "category": "Men's",
      "image": "assets/images/png/mens.png",
    },

    {
      "name": "Winter Jacket",
      "size": "L, XL",
      "category": "Women's",
      "image": "assets/images/png/womens.png",
    },
    {
      "name": "Party Wear Dress",
      "size": "S, M",
      "category": "Women's",
      "image": "assets/images/png/womens.png",
    },
    {
      "name": "Floral Summer Top",
      "size": "M, L",
      "category": "Women's",
      "image": "assets/images/png/womens.png",
    },
    {
      "name": "Denim Skirt",
      "size": "S, M",
      "category": "Women's",
      "image": "assets/images/png/womens.png",
    },
    {
      "name": "Designer Gown",
      "size": "L, XL",
      "category": "Women's",
      "image": "assets/images/png/womens.png",
    },
    {
      "name": "Casual Kurti",
      "size": "M, L, XL",
      "category": "Women's",
      "image": "assets/images/png/womens.png",
    },

    {
      "name": "Summer Floral Dress",
      "size": "S, M, L",
      "category": "Kids",
      "image": "assets/images/png/kids.png",
    },
    {
      "name": "Kids Denim Jacket",
      "size": "6-8, 10-12",
      "category": "Kids",
      "image": "assets/images/png/kids.png",
    },
    {
      "name": "Baby Cotton Tee",
      "size": "2-4 years",
      "category": "Kids",
      "image": "assets/images/png/kids.png",
    },
    {
      "name": "Cute Party Wear",
      "size": "4-6 years",
      "category": "Kids",
      "image": "assets/images/png/kids.png",
    },
    {
      "name": "Kids School Shoes",
      "size": "Various",
      "category": "Kids",
      "image": "assets/images/png/kids.png",
    },
    {
      "name": "Cartoon Printed Top",
      "size": "8-10 years",
      "category": "Kids",
      "image": "assets/images/png/kids.png",
    },
  ];

  List<Map<String, String>> get filteredProducts {
    if (selectedCategory == "All") {
      List<Map<String, String>> mens = allProducts
          .where((p) => p['category'] == "Men's")
          .toList();
      List<Map<String, String>> womens = allProducts
          .where((p) => p['category'] == "Women's")
          .toList();
      List<Map<String, String>> kids = allProducts
          .where((p) => p['category'] == "Kids")
          .toList();

      List<Map<String, String>> mixedList = [];

      if (mens.isNotEmpty) mixedList.add(mens[0]);
      if (womens.isNotEmpty) mixedList.add(womens[0]);
      if (kids.isNotEmpty) mixedList.add(kids[0]);
      if (womens.length > 1) mixedList.add(womens[1]);
      if (mens.length > 1) mixedList.add(mens[1]);
      if (kids.length > 1) mixedList.add(kids[1]);

      return mixedList;
    } else {
      return allProducts
          .where((p) => p['category'] == selectedCategory)
          .toList();
    }
  }

  String selectedProductSize = "S, M, L";
  String selectedColorSize = "Black, Blue";
  String formSelectedCategory = "Men's";
  String selectedQuality = "Premium";

  final productNameController = TextEditingController();
  final materialController = TextEditingController();
  final productDescriptionController = TextEditingController();
  final thumbnailURLController = TextEditingController();

  void changeCategory(String category) {
    selectedCategory = category;
    update();
  }

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
