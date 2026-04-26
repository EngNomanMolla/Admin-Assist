import 'package:flutter/material.dart';
import 'package:flutter_widgets/controller/banner_ads_controller.dart';
import 'package:flutter_widgets/controller/career_controller.dart';
import 'package:flutter_widgets/controller/live_notice_controller.dart';
import 'package:flutter_widgets/controller/mentor_post_controller.dart';
import 'package:flutter_widgets/controller/product/product_controller.dart';
import 'package:flutter_widgets/screen/banner_Ads/add_banner_screen.dart';
import 'package:flutter_widgets/screen/career_updates/add_Job_circular_screen.dart';
import 'package:flutter_widgets/screen/live_notice_screen.dart/add_live_notice_screen.dart';
import 'package:flutter_widgets/screen/mentor_post_screen/add_post_screen.dart';
import 'package:flutter_widgets/screen/product_screen/add_product_screen.dart';
import 'package:get/get.dart';

import 'package:flutter_widgets/provider/dashboard_provider.dart';
import 'package:flutter_widgets/services/auth_service.dart';

class HomeController extends GetxController {
  final DashboardProvider _dashboardProvider = DashboardProvider();
  
  int selectedIndex = 0;
  bool isLoading = false;

  int liveNotices = 0;
  int bannerAds = 0;
  int products = 0;
  int careerUpdates = 0;
  int users = 0;
  int mentorPosts = 0;

  int primaryCardIndex = 0; // Tracks the last selected card

  @override
  void onInit() {
    super.onInit();
    fetchDashboardData();
  }

  void setPrimaryCard(int index) {
    primaryCardIndex = index;
    update();
  }

  Future<void> fetchDashboardData() async {
    try {
      isLoading = true;
      update();
      final data = await _dashboardProvider.fetchDashboardData();
      liveNotices = data['live_notices'] ?? 0;
      bannerAds = data['banner_ads'] ?? 0;
      products = data['products'] ?? 0;
      careerUpdates = data['career_updates'] ?? 0;
      users = data['users'] ?? 0;
      mentorPosts = data['mentor_posts'] ?? 0;
    } catch (e) {
      debugPrint("Dashboard Error: $e");
    } finally {
      isLoading = false;
      update();
    }
  }

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

  void onAddMentorPost() {
    if (!Get.isRegistered<MentorPostController>()) {
      Get.put(MentorPostController());
    }
    Get.find<MentorPostController>().resetForm();
    Get.dialog(const AddPostDialog());
  }
}
