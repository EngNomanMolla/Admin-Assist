import 'package:flutter/material.dart';
import 'package:flutter_widgets/controller/home_controller.dart';
import 'package:flutter_widgets/screen/banner_Ads/banner_ads_screen.dart';

import 'package:flutter_widgets/screen/career_updates/career_updates_screen.dart';

import 'package:flutter_widgets/screen/live_screen.dart/live_notice_screen.dart';
import 'package:flutter_widgets/screen/mentor_post_screen/mentor_post_screen.dart';
import 'package:flutter_widgets/screen/product_screen/product_screen.dart';
import 'package:flutter_widgets/screen/user_management/user_management_screen.dart';
import 'package:get/get.dart';

class HomeContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (controller) {
        return SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildAddButton(
                    "assets/icons/icon1.png",
                    "Add Notice",
                    controller.onAddNotice,
                  ),
                  _buildAddButton(
                    "assets/icons/icon2.png",
                    "Add Banner",
                    controller.onAddBanner,
                  ),
                  _buildAddButton(
                    "assets/icons/icon3.png",
                    "Add Product",
                    controller.onAddProduct,
                  ),
                  _buildAddButton(
                    "assets/icons/icon4.png",
                    "Add Career Post",
                    controller.onAddCareer,
                  ),
                ],
              ),

              SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Management",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Inter',
                    ),
                  ),
                  Text(
                    "See all",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 13,
                      fontFamily: 'Inter',
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15),

              GridView.count(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1.3,
                children: [
                  _buildCard(
                    "${controller.liveNotices}",
                    "Live Notices",
                    "assets/icons/icon5.png",
                    Colors.deepPurpleAccent,
                    true,
                    onTap: () => Get.to(() => LiveNoticeScreen()),
                  ),
                  _buildCard(
                    "${controller.bannerAds}",
                    "Banner Ads",
                    "assets/icons/icon6.png",
                    Colors.white,
                    false,
                    onTap: () => Get.to(() => const BannerAdsScreen()),
                  ),
                  _buildCard(
                    "${controller.products}",
                    "Products",
                    "assets/icons/icon7.png",
                    Colors.white,
                    false,
                    onTap: () => Get.to(() => const ProductScreen()),
                  ),
                  _buildCard(
                    "${controller.careerUpdates}",
                    "Career Updates",
                    "assets/icons/icon8.png",
                    Colors.white,
                    false,
                    onTap: () => Get.to(() => const CareerUpdatesScreen()),
                  ),
                  _buildCard(
                    "${controller.users}",
                    "Users",
                    "assets/icons/icon9.png",
                    Colors.white,
                    false,
                    onTap: () => Get.to(() => UserManagementScreen()),
                  ),
                  _buildCard(
                    "${controller.mentorPosts}",
                    "Mentor Posts",
                    "assets/icons/icon10.png",
                    Colors.white,
                    false,
                    onTap: () => Get.to(() => MentorPostScreen()),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildAddButton(String imagePath, String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          CircleAvatar(
            backgroundColor: Colors.grey.shade100,
            radius: 28,
            child: Image.asset(imagePath, height: 24, width: 24),
          ),
          SizedBox(height: 6),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              color: Colors.black87,
              fontWeight: FontWeight.w500,
              fontFamily: 'Inter',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCard(
    String count,
    String title,
    String imagePath,
    Color bgColor,
    bool isPurple, {
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 18,
                  backgroundColor: isPurple
                      ? Colors.white24
                      : Colors.grey.shade50,
                  child: Image.asset(
                    imagePath,
                    height: 18,
                    width: 18,
                    color: isPurple ? Colors.white : null,
                  ),
                ),
                Spacer(),
                Text(
                  count,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: isPurple ? Colors.white : Colors.black87,
                    fontFamily: 'Inter',
                  ),
                ),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 12,
                    color: isPurple ? Colors.white70 : Colors.black54,
                    fontFamily: 'Inter',
                  ),
                ),
              ],
            ),
            Positioned(
              right: 0,
              bottom: 10,
              child: Container(
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isPurple ? Colors.white : Colors.grey.shade100,
                ),
                child: Icon(
                  Icons.arrow_forward,
                  size: 16,
                  color: isPurple ? Colors.deepPurpleAccent : Colors.black87,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
