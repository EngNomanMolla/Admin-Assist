import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../models/banner_model.dart';
import '../provider/banner_provider.dart';

class BannerController extends GetxController {
  final BannerProvider _bannerProvider = BannerProvider();
  var banners = <BannerAd>[].obs;

  var isLoading = false.obs;
  var isUploadMode = true.obs; // true for Gallery, false for URL
  var selectedImage = Rxn<File>();
  final ImagePicker _picker = ImagePicker();

  final urlController = TextEditingController();
  final headlineController = TextEditingController();
  final subheadlineController = TextEditingController();
  
  String startDate = '';
  String endDate = '';

  var isEditing = false.obs;
  int? editingBannerId;

  @override
  void onInit() {
    super.onInit();
    fetchBanners();
  }

  Future<void> fetchBanners() async {
    try {
      isLoading(true);
      final response = await _bannerProvider.fetchBanners();
      if (response['banners'] != null) {
        final List<dynamic> bannerList = response['banners'];
        banners.assignAll(bannerList.map((e) => BannerAd.fromJson(e)).toList());
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to fetch banners: ${e.toString()}",
          backgroundColor: Colors.redAccent, colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM, margin: const EdgeInsets.all(16));
    } finally {
      isLoading(false);
    }
  }

  void openAddBanner() {
    isEditing(false);
    editingBannerId = null;
    _clearForm();
  }

  void openEditBanner(BannerAd banner) {
    isEditing(true);
    editingBannerId = banner.id;
    headlineController.text = banner.headline;
    subheadlineController.text = banner.subheadline;
    urlController.text = banner.image;
    startDate = banner.startDate.split('T')[0];
    endDate = banner.endDate.split('T')[0];
    
    if (!banner.image.startsWith('http') && !banner.image.startsWith('assets/')) {
      selectedImage.value = File(banner.image);
      isUploadMode(true);
    } else {
      isUploadMode(false);
      selectedImage.value = null;
    }
    update();
  }

  Future<void> pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      selectedImage.value = File(image.path);
      urlController.text = image.path; 
    }
  }

  void toggleMode(bool mode) {
    isUploadMode.value = mode;
    if (mode) {
      urlController.clear();
    } else {
      selectedImage.value = null;
    }
  }

  Future<void> selectDate(BuildContext context, bool isStartDate) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null) {
      String formattedDate =
          "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
      if (isStartDate) {
        startDate = formattedDate;
      } else {
        endDate = formattedDate;
      }
      update();
    }
  }

  Future<void> saveBanner() async {
    String? imagePath = isUploadMode.value ? (selectedImage.value?.path) : urlController.text;

    if (headlineController.text.isEmpty || (imagePath == null || imagePath.isEmpty)) {
      Get.snackbar("Error", "Please fill all fields",
          backgroundColor: Colors.redAccent, colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM, margin: const EdgeInsets.all(16));
      return;
    }

    final Map<String, String> data = {
      'headline': headlineController.text,
      'subheadline': subheadlineController.text,
      'start_date': startDate,
      'end_date': endDate,
      'status': 'active',
    };

    try {
      isLoading(true);
      if (isEditing.value) {
        await _bannerProvider.updateBanner(editingBannerId!, data, imagePath);
      } else {
        await _bannerProvider.createBanner(data, imagePath);
      }
      await fetchBanners();
      Get.back(); // Close bottom sheet first
      Get.snackbar("Success", isEditing.value ? "Banner updated successfully" : "Banner created successfully",
          backgroundColor: Colors.green, colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM, margin: const EdgeInsets.all(16));
    } catch (e) {
      Get.snackbar("Error", e.toString().replaceAll("Exception:", ""),
          backgroundColor: Colors.redAccent, colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM, margin: const EdgeInsets.all(16));
    } finally {
      isLoading(false);
    }
  }

  Future<void> removeBanner(int id) async {
    try {
      isLoading(true);
      await _bannerProvider.deleteBanner(id);
      banners.removeWhere((element) => element.id == id);
      Get.snackbar("Success", "Banner deleted successfully",
          backgroundColor: Colors.green, colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM, margin: const EdgeInsets.all(16));
    } catch (e) {
      Get.snackbar("Error", "Failed to delete: ${e.toString()}",
          backgroundColor: Colors.redAccent, colorText: Colors.white);
    } finally {
      isLoading(false);
    }
  }

  void _clearForm() {
    urlController.clear();
    headlineController.clear();
    subheadlineController.clear();
    startDate = '';
    endDate = '';
    selectedImage.value = null;
    isUploadMode(true);
    update();
  }

  @override
  void onClose() {
    urlController.dispose();
    headlineController.dispose();
    subheadlineController.dispose();
    super.onClose();
  }
}
