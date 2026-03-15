import 'package:flutter/material.dart';
import 'package:flutter_widgets/controller/user_controller.dart';
import 'package:get/get.dart';

class UserDetailsScreen extends StatelessWidget {
  final int userIndex;
  UserDetailsScreen({required this.userIndex});

  final UserController controller = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF7B39FD),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.back(),
        ),
      ),

      body: GetBuilder<UserController>(
        builder: (controller) {
          final user = controller.users[userIndex];

          return SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(bottom: 40),
                  decoration: const BoxDecoration(color: Color(0xFF7B39FD)),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 55,
                        backgroundColor: Colors.white24,
                        child: CircleAvatar(
                          radius: 50,
                          backgroundImage: AssetImage(user.imageUrl),
                        ),
                      ),
                      const SizedBox(height: 15),
                      Text(
                        user.name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(25),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        _buildInfoRow(
                          Icons.email_outlined,
                          "Email",
                          user.email,
                          const Color(0xFFF3E8FF),
                          const Color(0xFF7B39FD),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 15),
                          child: Divider(
                            color: Color(0xFFF1F1F1),
                            thickness: 1,
                          ),
                        ),
                        _buildInfoRow(
                          Icons.phone_outlined,
                          "Phone",
                          user.phone,
                          const Color(0xFFE0F2FE),
                          Colors.blue,
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 15),
                          child: Divider(
                            color: Color(0xFFF1F1F1),
                            thickness: 1,
                          ),
                        ),
                        _buildInfoRow(
                          Icons.calendar_today_outlined,
                          "Joined Date",
                          user.joinedDate,
                          const Color(0xFFDCFCE7),
                          Colors.green,
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 40),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: SizedBox(
                    width: double.infinity,
                    height: 60,
                    child: ElevatedButton.icon(
                      onPressed: () => controller.deleteUser(userIndex),
                      icon: const Icon(
                        Icons.delete_outline,
                        color: Colors.redAccent,
                      ),
                      label: const Text(
                        "Delete User",
                        style: TextStyle(
                          color: Colors.redAccent,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFFF5F5),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildInfoRow(
    IconData icon,
    String title,
    String value,
    Color bgColor,
    Color iconColor,
  ) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Icon(icon, color: iconColor, size: 24),
        ),
        const SizedBox(width: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(color: Colors.grey.shade500, fontSize: 13),
            ),
            const SizedBox(height: 2),
            Text(
              value,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
