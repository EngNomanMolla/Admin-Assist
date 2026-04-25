import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_widgets/controller/live_notice_controller.dart';
import 'package:flutter_widgets/screen/live_notice_screen.dart/add_live_notice_screen.dart';
import 'package:flutter_widgets/models/notice_model.dart';
import 'package:get/get.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

import 'package:shimmer/shimmer.dart';

class LiveNoticeScreen extends StatelessWidget {
  final LiveNoticeController controller = Get.put(LiveNoticeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFE8E3FF), Color(0xFFFFE8F4), Color(0xFFE3F2FF)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            // Custom Vibrant Header
            Container(
              padding: const EdgeInsets.only(top: 50, bottom: 20, left: 16, right: 16),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF8E2DE2), Color(0xFF4A00E0)], // Vibrant purple to deep blue
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Color(0x334A00E0), // Reduced shadow opacity
                    blurRadius: 10, // Reduced blur
                    offset: Offset(0, 4), // Reduced offset
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 18),
                      onPressed: () => Get.back(),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Live Notices",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w800,
                            fontSize: 20,
                            fontFamily: 'Inter',
                          ),
                        ),
                        const SizedBox(height: 2),
                        Obx(() {
                          return Text(
                            "${controller.notices.length} Active Notices",
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.8),
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                              fontFamily: 'Inter',
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.campaign_rounded, color: Colors.white, size: 20),
                  ),
                ],
              ),
            ),
            
            // Body List View
            Expanded(
              child: Obx(() {
                if (controller.isLoadingNotices.value) {
                  return _buildShimmerLoading();
                }

                if (controller.notices.isEmpty) {
                  return const Center(
                    child: Text(
                      "No notices found.",
                      style: TextStyle(fontFamily: 'Inter', color: Colors.grey),
                    ),
                  );
                }

                return ListView.builder(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 80), // Reduced padding
                  itemCount: controller.notices.length,
                  itemBuilder: (context, index) {
                    final notice = controller.notices[index];
                    return _buildNoticeCard(notice, index, controller, context);
                  },
                );
              }),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.openAddNotice();
          Get.bottomSheet(
            const AddLiveNoticeScreen(),
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
          );
        },
        backgroundColor: const Color(0xFF7B61FF), // Theme color
        elevation: 4,
        child: const Icon(Icons.add_rounded, color: Colors.white, size: 28),
      ),
    );
  }

  Widget _buildShimmerLoading() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: 5,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.85),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.white, width: 2),
          ),
          child: Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    Container(
                      width: 24,
                      height: 24,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Container(
                  width: double.infinity,
                  height: 16,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  width: 200,
                  height: 16,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                const SizedBox(height: 14),
                Row(
                  children: [
                    Container(
                      width: 100,
                      height: 24,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      width: 100,
                      height: 24,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }


  Widget _buildNoticeCard(
    Notice notice,
    int index,
    LiveNoticeController controller,
    BuildContext context,
  ) {
    // Cycle of vibrant accent colors for cards
    final colors = [
      Colors.pinkAccent,
      Colors.blueAccent,
      Colors.orangeAccent,
      Colors.tealAccent.shade700,
      Colors.deepPurpleAccent,
    ];
    final accentColor = colors[index % colors.length];

    return Container(
      margin: const EdgeInsets.only(bottom: 12), // Reduced margin
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.85),
        borderRadius: BorderRadius.circular(16), // Slightly smaller radius
        border: Border.all(color: Colors.white, width: 2),
        boxShadow: [
          BoxShadow(
            color: accentColor.withOpacity(0.1), // Softer shadow
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Padding(
            padding: const EdgeInsets.all(16), // Reduced padding
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: accentColor.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        Icons.campaign_rounded,
                        color: accentColor,
                        size: 20, // Smaller icon
                      ),
                    ),
                    SizedBox(
                      height: 30, // Compact menu button
                      width: 30,
                      child: PopupMenuButton<String>(
                        icon: const Icon(Icons.more_horiz_rounded, color: Colors.grey, size: 20),
                        padding: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        color: Colors.white,
                        onSelected: (val) {
                          if (val == 'edit') {
                            controller.openEditNotice(notice);
                            Get.bottomSheet(
                              const AddLiveNoticeScreen(),
                              isScrollControlled: true,
                              backgroundColor: Colors.transparent,
                            );
                          } else if (val == 'delete') {
                            Future.delayed(Duration.zero, () {
                              AwesomeDialog(
                                context: context,
                                dialogType: DialogType.warning,
                                animType: AnimType.bottomSlide,
                                title: 'Delete Notice',
                                desc: 'Are you sure you want to delete this notice? This action cannot be undone.',
                                btnCancelOnPress: () {},
                                btnOkOnPress: () {
                                  controller.deleteNotice(notice.id);
                                },
                                btnOkColor: Colors.redAccent,
                                btnOkText: 'Delete',
                                btnCancelText: 'Cancel',
                              ).show();
                            });
                          }
                        },
                        itemBuilder: (context) => [
                          const PopupMenuItem(
                            value: 'edit',
                            child: Row(
                              children: [
                                Icon(Icons.edit_rounded, size: 16, color: Colors.blue),
                                SizedBox(width: 8),
                                Text("Edit", style: TextStyle(fontFamily: 'Inter', fontSize: 13)),
                              ],
                            ),
                          ),
                          const PopupMenuItem(
                            value: 'delete',
                            child: Row(
                              children: [
                                Icon(Icons.delete_outline_rounded, size: 16, color: Colors.red),
                                SizedBox(width: 8),
                                Text("Delete", style: TextStyle(fontFamily: 'Inter', fontSize: 13)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  notice.noticeText,
                  style: const TextStyle(
                    fontSize: 15, // Reduced font size
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                    fontFamily: 'Inter',
                    height: 1.3,
                  ),
                ),
                const SizedBox(height: 14),
                // Used Wrap to prevent right side overflow
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    _buildDataBox(Icons.calendar_today_rounded, "Start: ${notice.formattedStartDate}", accentColor),
                    _buildDataBox(Icons.event_rounded, "End: ${notice.formattedEndDate}", accentColor),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDataBox(IconData icon, String text, Color accentColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: BoxDecoration(
        color: accentColor.withOpacity(0.08),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: accentColor.withOpacity(0.2)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min, // Ensures the Wrap works correctly
        children: [
          Icon(icon, size: 12, color: accentColor),
          const SizedBox(width: 4),
          Text(
            text,
            style: TextStyle(
              fontSize: 11,
              color: accentColor.withOpacity(0.9),
              fontWeight: FontWeight.w700,
              fontFamily: 'Inter',
            ),
          ),
        ],
      ),
    );
  }
}
