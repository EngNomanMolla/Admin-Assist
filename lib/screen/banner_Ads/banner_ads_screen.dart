import 'package:flutter/material.dart';
import 'package:flutter_widgets/controller/banner_ads_controller.dart';
import 'package:flutter_widgets/screen/banner_Ads/add_banner_screen.dart';
import 'package:get/get.dart';

class BannerAdsScreen extends StatelessWidget {
  const BannerAdsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BannerController>(
      init: BannerController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: const Color(0xFFFDFDFD),
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,

            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black54),
              onPressed: () {
                Get.back();
              },
            ),
            title: const Text(
              "Banner Ads",
              style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.w500,
              ),
            ),
            centerTitle: true,
          ),
          body: controller.banners.isEmpty
              ? const Center(child: Text("No Banners Found"))
              : ListView.builder(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                  itemCount: controller.banners.length,
                  itemBuilder: (context, index) {
                    final item = controller.banners[index];
                    return _buildBannerCard(item);
                  },
                ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Get.bottomSheet(
                const AddBannerScreen(),
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
              );
            },
            backgroundColor: const Color(0xFF7B4DFF),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            child: const Icon(Icons.add, color: Colors.white, size: 30),
          ),
        );
      },
    );
  }

  Widget _buildBannerCard(Map<String, String> data) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            height: 160,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                image: data['image']!.startsWith('http')
                    ? NetworkImage(data['image']!) as ImageProvider
                    : AssetImage(data['image']!),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.black.withOpacity(0.3), Colors.transparent],
                ),
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data['title']!,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    data['subtitle']!,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _dateBadge("Start date: ${data['startDate']}"),
                _dateBadge("End date: ${data['endDate']}"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _dateBadge(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.black.withOpacity(0.05)),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 11,
          color: Colors.black54,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
