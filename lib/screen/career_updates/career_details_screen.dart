import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import '../../controller/career_controller.dart';
import '../../routes/app_routes.dart';
import 'package:url_launcher/url_launcher.dart';
import 'add_Job_circular_screen.dart';

class CareerDetailsScreen extends StatelessWidget {
  final int circularId;
  const CareerDetailsScreen({super.key, required this.circularId});

  @override
  Widget build(BuildContext context) {
    final CareerController controller = Get.find<CareerController>();
    
    // Fetch details on initialization
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.fetchDetails(circularId);
    });

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FD),
      body: Obx(() {
        if (controller.isDetailLoading.value) {
          return _buildShimmerEffect();
        }

        final item = controller.selectedCircular.value;
        if (item == null) {
          return const Center(child: Text("Circular not found"));
        }

        return CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            // Dynamic Header with Gradient
            SliverAppBar(
              expandedHeight: 220,
              pinned: true,
              stretch: true,
              backgroundColor: const Color(0xFF4A00E0),
              elevation: 0,
              leading: Container(
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 18),
                  onPressed: () => Get.back(),
                ),
              ),
              flexibleSpace: FlexibleSpaceBar(
                stretchModes: const [StretchMode.zoomBackground, StretchMode.blurBackground],
                background: Stack(
                  fit: StackFit.expand,
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xFF8E2DE2), Color(0xFF4A00E0)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                    ),
                    Positioned(
                      right: -30,
                      top: -30,
                      child: CircleAvatar(
                        radius: 80,
                        backgroundColor: Colors.white.withOpacity(0.1),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              item.status.toUpperCase(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 10,
                                letterSpacing: 1,
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            item.postTitle,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.w900,
                              fontFamily: 'Inter',
                            ),
                          ),
                          Text(
                            item.organizationName,
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.9),
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Inter',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Content Section
            SliverToBoxAdapter(
              child: Container(
                transform: Matrix4.translationValues(0, -30, 0),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 30.0),
                    Row(
                      children: [
                        _buildHighlight(Icons.groups_rounded, "Vacancies", "${item.vacancy} Post"),
                        const SizedBox(width: 16),
                        _buildHighlight(
                          Icons.timer_rounded, 
                          "Deadline", 
                          DateFormat('dd MMM yy').format(DateTime.parse(item.deadline))
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),

                    // Detail Items
                    _buildSectionTitle("Required Education"),
                    _buildDetailCard(Icons.school_rounded, item.requiredEducation, Colors.blue),
                    
                    const SizedBox(height: 24),
                    _buildSectionTitle("Job Description"),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF9FAFB),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: const Color(0xFFF1F3F5)),
                      ),
                      child: Text(
                        item.jobDescription,
                        style: const TextStyle(
                          fontSize: 15,
                          height: 1.6,
                          color: Colors.black87,
                          fontFamily: 'Inter',
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),
                    if (item.applicationLink != null && item.applicationLink!.isNotEmpty) ...[
                      _buildSectionTitle("Application Link"),
                      _buildDetailCard(
                        Icons.link_rounded, 
                        item.applicationLink!, 
                        Colors.deepPurple,
                        onTap: () async {
                          final String url = item.applicationLink!;
                          final Uri uri = Uri.parse(url);
                          try {
                            if (await canLaunchUrl(uri)) {
                              await launchUrl(uri, mode: LaunchMode.externalApplication);
                            } else {
                              Get.snackbar("Error", "Could not open link", backgroundColor: Colors.redAccent, colorText: Colors.white);
                            }
                          } catch (e) {
                            Get.snackbar("Error", "Invalid URL format", backgroundColor: Colors.redAccent, colorText: Colors.white);
                          }
                        }
                      ),
                    ],

                    const SizedBox(height: 40),
                    
                    // Admin Actions Header
                    Row(
                      children: [
                        const Text(
                          "Administrative Actions",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w800,
                            color: Colors.black38,
                            letterSpacing: 0.5,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(child: Divider(color: Colors.grey.shade200)),
                      ],
                    ),
                    const SizedBox(height: 20),
                    
                    Row(
                      children: [
                        Expanded(
                          child: _buildAdminButton(
                            Icons.edit_rounded, 
                            "Edit Details", 
                            const Color(0xFF4A00E0),
                            () {
                              controller.openEditMode(item);
                              Get.to(() => const AddJobCircularScreen());
                            }
                          ),
                        ),
                        const SizedBox(width: 12),
                        _buildDeleteButton(() {
                          AwesomeDialog(
                            context: context,
                            dialogType: DialogType.warning,
                            animType: AnimType.bottomSlide,
                            title: 'Delete Circular',
                            desc: 'Are you sure you want to permanently remove this job posting?',
                            btnCancelOnPress: () {},
                            btnOkColor: Colors.redAccent,
                            btnOkText: 'Delete',
                            btnOkOnPress: () {
                              controller.deleteCircular(item.id).then((_) {
                    
                                // Navigate back until we reach the Career Updates list screen
                                Get.until((route) => route.settings.name == AppRoutes.CAREER_UPDATES);
                              });
                            },
                          ).show();
                        }),
                      ],
                    ),
                    const SizedBox(height: 50),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget _buildShimmerEffect() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(height: 220, width: double.infinity, color: Colors.white),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(height: 60, width: double.infinity, decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20))),
                  const SizedBox(height: 24),
                  Container(height: 20, width: 150, color: Colors.white),
                  const SizedBox(height: 12),
                  Container(height: 50, width: double.infinity, decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20))),
                  const SizedBox(height: 24),
                  Container(height: 20, width: 150, color: Colors.white),
                  const SizedBox(height: 12),
                  Container(height: 150, width: double.infinity, decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20))),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHighlight(IconData icon, String label, String value) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFFF1F3F5).withOpacity(0.5),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, size: 20, color: const Color(0xFF4A00E0)),
            const SizedBox(height: 8),
            Text(label, style: const TextStyle(fontSize: 11, color: Colors.black45, fontWeight: FontWeight.w600)),
            Text(value, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: Colors.black87)),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w800,
          color: Color(0xFF1F2937),
          fontFamily: 'Inter',
        ),
      ),
    );
  }

  Widget _buildDetailCard(IconData icon, String text, Color color, {VoidCallback? onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: color.withOpacity(0.1)),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.04),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color, size: 20),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: onTap != null ? color : Colors.black87,
                  fontFamily: 'Inter',
                ),
              ),
            ),
            if (onTap != null) Icon(Icons.arrow_forward_ios_rounded, size: 14, color: color),
          ],
        ),
      ),
    );
  }

  Widget _buildAdminButton(IconData icon, String label, Color color, VoidCallback onTap) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 4,
        shadowColor: color.withOpacity(0.4),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 18),
          const SizedBox(width: 10),
          Text(label, style: const TextStyle(fontWeight: FontWeight.w800, fontFamily: 'Inter')),
        ],
      ),
    );
  }

  Widget _buildDeleteButton(VoidCallback onTap) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.red.shade50,
        borderRadius: BorderRadius.circular(16),
      ),
      child: IconButton(
        onPressed: onTap,
        icon: const Icon(Icons.delete_outline_rounded, color: Colors.redAccent),
        padding: const EdgeInsets.all(16),
      ),
    );
  }
}
