import 'package:flutter/material.dart';
import 'package:flutter_widgets/controller/user_controller.dart';
import 'package:flutter_widgets/models/user_model.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

class UserDetailsScreen extends StatelessWidget {
  final int userIndex;
  UserDetailsScreen({super.key, required this.userIndex});

  final UserController controller = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<UserController>(
        builder: (controller) {
          final user = controller.users[userIndex];

          return SingleChildScrollView(
            child: Column(
              children: [
                // Custom Vibrant Header
                Container(
                  padding: const EdgeInsets.only(top: 50, bottom: 40, left: 16, right: 16),
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
                      Row(
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
                          const Spacer(),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Hero(
                        tag: 'user_avatar_$userIndex',
                        child: CircleAvatar(
                          radius: 55,
                          backgroundColor: Colors.white24,
                          child: CircleAvatar(
                            radius: 50,
                            backgroundImage: NetworkImage(
                              "https://ui-avatars.com/api/?name=${user.name.replaceAll(' ', '+')}&background=random&color=fff",
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      Text(
                        user.name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Inter',
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "ID: #${user.id}",
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.8),
                          fontSize: 14,
                          fontFamily: 'Inter',
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
                          DateFormat('dd MMM yyyy').format(DateTime.parse(user.createdAt)),
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
                      onPressed: () {
                        AwesomeDialog(
                          context: context,
                          dialogType: DialogType.warning,
                          animType: AnimType.bottomSlide,
                          title: 'Confirm Delete',
                          desc: 'Are you sure you want to delete this user permanently?',
                          btnCancelOnPress: () {},
                          btnOkOnPress: () => controller.deleteUser(user.id),
                          btnOkColor: Colors.redAccent,
                        ).show();
                      },
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
                          fontFamily: 'Inter',
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
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(color: Colors.grey.shade500, fontSize: 13, fontFamily: 'Inter'),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                  fontFamily: 'Inter',
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
