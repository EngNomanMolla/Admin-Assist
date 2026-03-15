import 'package:flutter/material.dart';
import 'package:flutter_widgets/controller/live_notice_controller.dart';

import 'package:flutter_widgets/screen/live_screen.dart/add_live_notice_screen.dart';
import 'package:get/get.dart';

class LiveNoticeScreen extends StatelessWidget {
  final LiveNoticeController controller = Get.put(LiveNoticeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_none, color: Colors.black),
          ),
        ],
        centerTitle: true,
        title: GetBuilder<LiveNoticeController>(
          builder: (controller) {
            return Column(
              children: [
                const Text(
                  "Live Notices",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                Text(
                  "${controller.notices.length} total notices",
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ],
            );
          },
        ),
      ),
      body: GetBuilder<LiveNoticeController>(
        builder: (controller) {
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: controller.notices.length,
            itemBuilder: (context, index) {
              final notice = controller.notices[index];
              return _buildNoticeCard(notice, index, controller);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.bottomSheet(
          const AddLiveNoticeScreen(),
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
        ),
        backgroundColor: const Color(0xFF7B61FF),
        child: const Icon(Icons.add, color: Colors.white, size: 30),
      ),
    );
  }

  Widget _buildNoticeCard(
    Map<String, String> notice,
    int index,
    LiveNoticeController controller,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  notice['title'] ?? "",
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              PopupMenuButton<String>(
                icon: const Icon(Icons.more_vert, color: Colors.grey),
                onSelected: (val) {
                  if (val == 'delete') controller.removeNotice(index);
                },
                itemBuilder: (context) => [
                  const PopupMenuItem(
                    value: 'edit',
                    child: Text(
                      "Edit",
                      style: TextStyle(color: Color(0xFF7B61FF)),
                    ),
                  ),
                  const PopupMenuItem(value: 'delete', child: Text("Delete")),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              _buildDataBox("Start date: ${notice['startDate']}"),
              const SizedBox(width: 10),
              _buildDataBox("End date: ${notice['endDate']}"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDataBox(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F4F9),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: const TextStyle(fontSize: 11, color: Color(0xFF7A869A)),
      ),
    );
  }
}
