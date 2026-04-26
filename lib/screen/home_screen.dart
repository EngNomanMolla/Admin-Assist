import 'package:flutter/material.dart';
import 'package:flutter_widgets/controller/home_controller.dart';
import 'package:flutter_widgets/routes/app_routes.dart';
import 'package:get/get.dart';

import 'package:shimmer/shimmer.dart';

class HomeContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (controller) {
        return RefreshIndicator(
          onRefresh: controller.fetchDashboardData,
          color: const Color(0xFF4A00E0),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildAddButton(
                    Icons.campaign_rounded,
                    "Add Notice",
                    controller.onAddNotice,
                    Colors.orange,
                  ),
                  _buildAddButton(
                    Icons.view_carousel_rounded,
                    "Add Banner",
                    controller.onAddBanner,
                    Colors.blue,
                  ),
                  _buildAddButton(
                    Icons.shopping_bag_rounded,
                    "Add Product",
                    controller.onAddProduct,
                    Colors.pink,
                  ),
                  _buildAddButton(
                    Icons.work_rounded,
                    "Add Career",
                    controller.onAddCareer,
                    Colors.teal,
                  ),
                ],
              ),

              const SizedBox(height: 32),
              const Row(
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
                ],
              ),
              const SizedBox(height: 16),

              if (controller.isLoading) 
                _buildShimmerContent()
              else
                GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 1.15,
                  children: [
                    _buildCard(
                      "${controller.liveNotices}",
                      "Live Notices",
                      Icons.notifications_active_rounded,
                      Colors.deepPurpleAccent,
                      controller.primaryCardIndex == 0,
                      onTap: () {
                        controller.setPrimaryCard(0);
                        Get.toNamed(AppRoutes.LIVE_NOTICE);
                      },
                    ),
                    _buildCard(
                      "${controller.bannerAds}",
                      "Banner Ads",
                      Icons.branding_watermark_rounded,
                      Colors.blue,
                      controller.primaryCardIndex == 1,
                      onTap: () {
                        controller.setPrimaryCard(1);
                        Get.toNamed(AppRoutes.BANNER_ADS);
                      },
                    ),
                    _buildCard(
                      "${controller.products}",
                      "Products",
                      Icons.inventory_2_rounded,
                      Colors.pink,
                      controller.primaryCardIndex == 2,
                      onTap: () {
                        controller.setPrimaryCard(2);
                        Get.toNamed(AppRoutes.PRODUCTS);
                      },
                    ),
                    _buildCard(
                      "${controller.careerUpdates}",
                      "Career Updates",
                      Icons.work_history_rounded,
                      Colors.teal,
                      controller.primaryCardIndex == 3,
                      onTap: () {
                        controller.setPrimaryCard(3);
                        Get.toNamed(AppRoutes.CAREER_UPDATES);
                      },
                    ),
                    _buildCard(
                      "${controller.users}",
                      "Users",
                      Icons.group_rounded,
                      Colors.indigo,
                      controller.primaryCardIndex == 4,
                      onTap: () {
                        controller.setPrimaryCard(4);
                        Get.toNamed(AppRoutes.USERS);
                      },
                    ),
                    _buildCard(
                      "${controller.mentorPosts}",
                      "Mentor Posts",
                      Icons.post_add_rounded,
                      Colors.amber.shade700,
                      controller.primaryCardIndex == 5,
                      onTap: () {
                        controller.setPrimaryCard(5);
                        Get.toNamed(AppRoutes.MENTOR_POSTS);
                      },
                    ),
                  ],
                ),
            ],
          ),
        ));
      },
    );
  }

  Widget _buildShimmerContent() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 1.15,
      ),
      itemCount: 6,
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(22),
            ),
          ),
        );
      },
    );
  }

  Widget _buildAddButton(IconData iconData, String label, VoidCallback onTap, Color tintColor) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: tintColor.withOpacity(0.12),
              shape: BoxShape.circle,
            ),
            child: Icon(iconData, size: 24, color: tintColor),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.black87,
              fontWeight: FontWeight.w600,
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
    IconData iconData,
    Color tintColor,
    bool isPrimary, {
    required VoidCallback onTap,
  }) {
    final bgColor = isPrimary ? tintColor : Colors.white;
    final textColor = isPrimary ? Colors.white : Colors.black87;
    final subtitleColor = isPrimary ? Colors.white.withOpacity(0.9) : Colors.black54;
    final iconColor = isPrimary ? Colors.white : tintColor;
    final iconBgColor = isPrimary ? Colors.white.withOpacity(0.25) : tintColor.withOpacity(0.12);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(22),
          border: Border.all(
            color: isPrimary ? Colors.white.withOpacity(0.15) : tintColor.withOpacity(0.08),
            width: 1.0,
          ),
          boxShadow: [
            BoxShadow(
              color: tintColor.withOpacity(isPrimary ? 0.35 : 0.08),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: iconBgColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(iconData, size: 20, color: iconColor),
                ),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 14,
                  color: isPrimary ? Colors.white70 : Colors.grey.shade400,
                ),
              ],
            ),
            const Spacer(),
            Text(
              count,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w800,
                color: textColor,
                fontFamily: 'Inter',
              ),
            ),
            const SizedBox(height: 4),
            Text(
              title,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: subtitleColor,
                fontFamily: 'Inter',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
