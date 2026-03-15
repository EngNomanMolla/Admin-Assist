import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LiveNoticeController extends GetxController {
  final noticeController = TextEditingController();
  String startDate = "";
  String endDate = "";

  List<Map<String, String>> notices = [
    {
      "title": "System maintenance scheduled for tomorrow 2 AM - 4 AM",
      "startDate": "2026-02-08",
      "endDate": "2026-02-08",
    },
    {
      "title": "New mentorship program applications are now open",
      "startDate": "2026-02-10",
      "endDate": "2026-02-12",
    },
    {
      "title": "Upcoming workshop on Flutter GetX State Management",
      "startDate": "2026-02-15",
      "endDate": "2026-02-15",
    },
    {
      "title":
          "Notice regarding office holiday for International Mother Language Day",
      "startDate": "2026-02-21",
      "endDate": "2026-02-21",
    },
  ];

  Future<void> selectDate(BuildContext context, bool isStartDate) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null) {
      String formattedDate =
          "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
      if (isStartDate) {
        startDate = formattedDate;
      } else {
        endDate = formattedDate;
      }
      update();
    }
  }

  void saveNotice() {
    if (noticeController.text.isNotEmpty &&
        startDate.isNotEmpty &&
        endDate.isNotEmpty) {
      notices.add({
        "title": noticeController.text,
        "startDate": startDate,
        "endDate": endDate,
      });
      noticeController.clear();
      startDate = "";
      endDate = "";
      update();
      Get.back();
    }
  }

  void removeNotice(int index) {
    notices.removeAt(index);
    update();
  }
}
