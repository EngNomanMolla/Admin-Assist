import 'package:flutter/material.dart';
import 'package:flutter_widgets/controller/banner_ads_controller.dart';
import 'package:flutter_widgets/controller/career_controller.dart';
import 'package:flutter_widgets/controller/live_notice_controller.dart';
import 'package:flutter_widgets/controller/product/product_controller.dart';
import 'package:flutter_widgets/screen/banner_Ads/add_banner_screen.dart';
import 'package:flutter_widgets/screen/career_updates/add_Job_circular_screen.dart';
import 'package:flutter_widgets/screen/live_notice_screen.dart/add_live_notice_screen.dart';
import 'package:flutter_widgets/screen/product_screen/add_product_screen.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  int selectedIndex = 0;

  int liveNotices = 12;
  int bannerAds = 5;
  int products = 48;
  int careerUpdates = 23;
  int users = 1247;
  int mentorPosts = 0;

  void changePage(int index) {
    if (index >= 0 && index < 3) {
      selectedIndex = index;
      update();
    }
  }

  void onAddNotice() {
    if (!Get.isRegistered<LiveNoticeController>()) {
      Get.put(LiveNoticeController());
    }
    Get.find<LiveNoticeController>().openAddNotice();
    Get.bottomSheet(
      const AddLiveNoticeScreen(),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }

  void onAddBanner() {
    if (!Get.isRegistered<BannerController>()) {
      Get.put(BannerController());
    }
    Get.find<BannerController>().openAddBanner();
    Get.bottomSheet(
      const AddBannerScreen(),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }

  void onAddProduct() {
    if (!Get.isRegistered<ProductController>()) {
      Get.put(ProductController());
    }
    Get.to(() => const AddProductScreen());
  }

  void onAddCareer() {
    if (!Get.isRegistered<CareerController>()) {
      Get.put(CareerController());
    }
    Get.find<CareerController>().clearFields();
    Get.to(() => const AddJobCircularScreen());
  }
}
