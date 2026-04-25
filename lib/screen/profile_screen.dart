import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_widgets/controller/profile_controller.dart';
import 'package:intl/intl.dart';

class ProfileScreen extends StatelessWidget {
  final ProfileController controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    final admin = controller.authService.admin;

    if (admin == null) {
      return const Center(child: Text("No admin data found"));
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF3F4F6),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Compact Profile Header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(top: 50, bottom: 30),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF8E2DE2), Color(0xFF4A00E0)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Column(
                children: [
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      Container(
                        width: 90,
                        height: 90,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white.withOpacity(0.5), width: 2),
                        ),
                        child: const Icon(Icons.person_rounded, size: 50, color: Colors.white),
                      ),
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          color: Colors.greenAccent,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.check_rounded, size: 14, color: Colors.black87),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    admin.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      fontFamily: 'Inter',
                    ),
                  ),
                  Text(
                    admin.email,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 14,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Profile Details
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(child: _buildCompactItem(Icons.badge_rounded, "ID", admin.id.toString(), Colors.blue)),
                      const SizedBox(width: 12),
                      Expanded(child: _buildCompactItem(Icons.verified_user_rounded, "Status", admin.status.toUpperCase(), Colors.green)),
                    ],
                  ),
                  const SizedBox(height: 12),
                  _buildProfileItem(
                    Icons.calendar_month_rounded, 
                    "Joined Date", 
                    DateFormat('dd MMM yyyy').format(DateTime.parse(admin.createdAt)),
                    Colors.orange
                  ),
                  
                  const SizedBox(height: 30),

                  // Action Buttons
                  _buildActionButton(
                    Icons.logout_rounded, 
                    "Logout Account", 
                    Colors.orange, 
                    () => controller.logout()
                  ),
                  const SizedBox(height: 12),
                  _buildActionButton(
                    Icons.delete_forever_rounded, 
                    "Permanently Delete", 
                    Colors.redAccent, 
                    () => controller.confirmDelete(context)
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildCompactItem(IconData icon, String label, String value, Color color) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.1), width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 18),
          const SizedBox(height: 8),
          Text(label, style: const TextStyle(color: Colors.grey, fontSize: 11, fontFamily: 'Inter')),
          Text(value, style: const TextStyle(color: Colors.black87, fontSize: 14, fontWeight: FontWeight.bold, fontFamily: 'Inter')),
        ],
      ),
    );
  }

  Widget _buildProfileItem(IconData icon, String label, String value, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.1), width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                  fontFamily: 'Inter',
                ),
              ),
              Text(
                value,
                style: const TextStyle(
                  color: Colors.black87,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Inter',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(IconData icon, String label, Color color, VoidCallback onTap) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          elevation: 0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 18),
            const SizedBox(width: 10),
            Text(
              label,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                fontFamily: 'Inter',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
