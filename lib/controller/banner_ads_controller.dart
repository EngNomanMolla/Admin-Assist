import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BannerController extends GetxController {
  List<Map<String, String>> banners = [
    {
      "title": "Career Growth",
      "subtitle": "Continuous Improvement",
      "startDate": "2026-02-08",
      "endDate": "2026-02-08",
      'image': "assets/images/png/banner.png",
    },
    {
      "title": "Career Growth",
      "subtitle": "Continuous Improvement",
      "startDate": "2026-02-08",
      "endDate": "2026-02-08",
      'image': "assets/images/png/banner.png",
    },
  ];

  String startDate = '';
  String endDate = '';

  final urlController = TextEditingController();
  final headlineController = TextEditingController();
  final subheadlineController = TextEditingController();

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

  void saveBanner() {
    if (headlineController.text.isNotEmpty && urlController.text.isNotEmpty) {
      Map<String, String> newBanner = {
        "title": headlineController.text,
        "subtitle": subheadlineController.text,
        "startDate": startDate,
        "endDate": endDate,
        'image': urlController.text,
      };

      banners.add(newBanner);

      urlController.clear();
      headlineController.clear();
      subheadlineController.clear();
      startDate = '';
      endDate = '';

      update();
      Get.back();
    }
  }

  @override
  void onClose() {
    urlController.dispose();
    headlineController.dispose();
    subheadlineController.dispose();
    super.onClose();
  }
}
