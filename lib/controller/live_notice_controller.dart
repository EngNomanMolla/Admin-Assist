import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_widgets/provider/notice_provider.dart';
import 'package:flutter_widgets/services/auth_service.dart';
import 'package:flutter_widgets/models/notice_model.dart';

class LiveNoticeController extends GetxController {
  final noticeController = TextEditingController();
  String startDate = "";
  String endDate = "";
  var isLoading = false.obs;
  var isLoadingNotices = false.obs;

  final NoticeProvider _noticeProvider = NoticeProvider();

  RxList<Notice> notices = <Notice>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchNotices();
  }

  Future<void> fetchNotices() async {
    final token = Get.find<AuthService>().token;
    if (token == null) return;

    try {
      isLoadingNotices(true);
      final response = await _noticeProvider.fetchNotices(token);
      final List<Notice> fetchedNotices = response.map((data) => Notice.fromJson(data)).toList();
      
      // Sort to show newest first if needed, though usually backend does it
      notices.value = fetchedNotices;
    } catch (e) {
      Get.snackbar("Error", "Failed to load notices: ${e.toString().replaceAll('Exception: ', '')}",
          backgroundColor: Colors.redAccent, colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM, margin: const EdgeInsets.all(16));
    } finally {
      isLoadingNotices(false);
    }
  }


  int? editingNoticeId;

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

  void openAddNotice() {
    noticeController.clear();
    startDate = "";
    endDate = "";
    editingNoticeId = null;
    update();
  }

  void openEditNotice(Notice notice) {
    noticeController.text = notice.noticeText;
    // Extract yyyy-mm-dd from "2026-04-25T00:00:00.000000Z"
    startDate = notice.startDate.split('T')[0];
    endDate = notice.endDate.split('T')[0];
    editingNoticeId = notice.id;
    update();
  }

  Future<void> saveNotice() async {
    final text = noticeController.text.trim();
    if (text.isNotEmpty && startDate.isNotEmpty && endDate.isNotEmpty) {
      final token = Get.find<AuthService>().token;
      
      if (token == null) {
        Get.snackbar("Error", "Authentication token not found. Please log in again.",
            backgroundColor: Colors.redAccent, colorText: Colors.white,
            snackPosition: SnackPosition.BOTTOM, margin: const EdgeInsets.all(16));
        return;
      }

      try {
        isLoading(true);
        update(); 
        
        if (editingNoticeId != null) {
          // Update existing
          await _noticeProvider.updateNotice(
            noticeId: editingNoticeId!,
            noticeText: text,
            startDate: startDate,
            endDate: endDate,
            token: token,
          );
        } else {
          // Create new
          await _noticeProvider.createNotice(
            noticeText: text,
            startDate: startDate,
            endDate: endDate,
            token: token,
          );
        }

        // Re-fetch notices to update the UI with real data
        await fetchNotices();

        noticeController.clear();
        startDate = "";
        endDate = "";
        editingNoticeId = null;
        
        Get.back();
        Get.snackbar("Success", editingNoticeId != null ? "Notice updated successfully!" : "Notice created successfully!",
            backgroundColor: Colors.green, colorText: Colors.white,
            snackPosition: SnackPosition.BOTTOM, margin: const EdgeInsets.all(16));
      } catch (e) {
        Get.snackbar("Error", e.toString().replaceAll('Exception: ', ''),
            backgroundColor: Colors.redAccent, colorText: Colors.white,
            snackPosition: SnackPosition.BOTTOM, margin: const EdgeInsets.all(16));
      } finally {
        isLoading(false);
        update();
      }
    } else {
      Get.snackbar("Error", "Please fill in all fields",
          backgroundColor: Colors.orangeAccent, colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM, margin: const EdgeInsets.all(16));
    }
  }

  Future<void> deleteNotice(int noticeId) async {
    final token = Get.find<AuthService>().token;
    if (token == null) {
      Get.snackbar("Error", "Authentication token not found.",
          backgroundColor: Colors.redAccent, colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM, margin: const EdgeInsets.all(16));
      return;
    }

    try {
      // Show loading state over the list
      isLoadingNotices(true);
      await _noticeProvider.deleteNotice(noticeId: noticeId, token: token);
      
      Get.snackbar("Success", "Notice deleted successfully!",
          backgroundColor: Colors.green, colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM, margin: const EdgeInsets.all(16));
          
      // Re-fetch to update list
      await fetchNotices();
    } catch (e) {
      Get.snackbar("Error", e.toString().replaceAll('Exception: ', ''),
          backgroundColor: Colors.redAccent, colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM, margin: const EdgeInsets.all(16));
      isLoadingNotices(false); // Stop loading if failed
    }
  }
}
