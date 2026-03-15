import 'package:flutter/material.dart';
import 'package:flutter_widgets/screen/career_updates/add_Job_circular_screen.dart';
import 'package:get/get.dart';
import 'package:flutter_widgets/controller/career_controller.dart';

class CareerUpdatesScreen extends StatelessWidget {
  const CareerUpdatesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CareerController());

    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        title: GetBuilder<CareerController>(
          builder: (controller) {
            return Column(
              children: [
                const Text(
                  "Career Updates",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                Text(
                  "${controller.circulars.length} active job circulars",
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ],
            );
          },
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.clearFields();
          Get.to(() => const AddJobCircularScreen());
        },
        backgroundColor: const Color(0xFF7B4DFF),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        child: const Icon(Icons.add, color: Colors.white),
      ),

      body: GetBuilder<CareerController>(
        builder: (controller) {
          if (controller.circulars.isEmpty) {
            return const Center(child: Text("No circulars available"));
          }
          return ListView.builder(
            padding: const EdgeInsets.all(15),
            itemCount: controller.circulars.length,
            itemBuilder: (context, index) {
              var item = controller.circulars[index];
              return _buildJobCard(item, index, controller);
            },
          );
        },
      ),
    );
  }

  Widget _buildJobCard(
    Map<String, String> item,
    int index,
    CareerController controller,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item['company'] ?? "No Company",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  Text(
                    item['role'] ?? "No Role",
                    style: const TextStyle(color: Colors.grey, fontSize: 13),
                  ),
                ],
              ),
              PopupMenuButton<String>(
                icon: const Icon(Icons.more_vert, color: Colors.black54),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                onSelected: (value) {
                  if (value == 'delete') {
                    controller.deleteCircular(index);
                  }
                },
                itemBuilder: (context) => [
                  const PopupMenuItem(
                    value: 'edit',
                    child: Text(
                      'Edit',
                      style: TextStyle(color: Color(0xFF7B4DFF)),
                    ),
                  ),
                  const PopupMenuItem(value: 'delete', child: Text('Delete')),
                ],
              ),
            ],
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              _buildBadge(
                item['positions'] ?? "0 Positions",
                const Color(0xFFE3F2FD),
                Colors.blue,
              ),
              const SizedBox(width: 10),
              _buildBadge(
                "Deadline: ${item['deadline'] ?? "N/A"}",
                const Color.fromARGB(255, 248, 246, 246),
                Colors.redAccent,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBadge(String text, Color bgColor, Color textColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: textColor,
          fontSize: 11,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
