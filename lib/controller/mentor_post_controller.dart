import 'dart:io';
import 'package:flutter_widgets/provider/mentor_post_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:intl/intl.dart';

class MentorPost {
  final int id;
  final String title;
  final String date;
  final String imageUrl;
  final String type;
  final String content;
  final String status;

  MentorPost({
    required this.id,
    required this.title,
    required this.date,
    required this.imageUrl,
    required this.type,
    required this.content,
    required this.status,
  });

  factory MentorPost.fromJson(Map<String, dynamic> json) {
    String formattedDate = "";
    if (json['created_at'] != null) {
      try {
        DateTime dt = DateTime.parse(json['created_at'].toString());
        formattedDate = DateFormat('dd MMM yy').format(dt);
      } catch (e) {
        formattedDate = json['created_at'].toString().split('T')[0];
      }
    }

    return MentorPost(
      id: json['id'] ?? 0,
      title: json['title'] ?? "",
      date: formattedDate,
      imageUrl: json['file_url'] ?? "",
      type: json['type'] ?? "text",
      content: json['content'] ?? "",
      status: json['status'] ?? "active",
    );
  }
}

class MentorPostController extends GetxController {
  final MentorPostProvider _provider = MentorPostProvider();
  
  List<MentorPost> posts = [];
  bool isLoading = false;

  final titleController = TextEditingController();
  final contentController = TextEditingController();
  String selectedPostType = 'Text';
  XFile? pickedImage;
  final ImagePicker _picker = ImagePicker();

  @override
  void onInit() {
    super.onInit();
    fetchPosts();
  }

  Future<void> fetchPosts() async {
    try {
      isLoading = true;
      update();
      final data = await _provider.fetchMentorPosts();
      posts = data.map((e) => MentorPost.fromJson(e)).toList();
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading = false;
      update();
    }
  }

  void changePostType(String type) {
    selectedPostType = type;
    update();
  }

  Future<void> pickPostImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      pickedImage = image;
      update();
    }
  }

  void clearImage() {
    pickedImage = null;
    update();
  }

  void publishPost() {
    // API for publishing will be implemented if requested
    if (titleController.text.isNotEmpty) {
      Get.snackbar("Info", "Create Post API integration coming soon!");
      Get.back();
      resetForm();
    }
  }

  void resetForm() {
    titleController.clear();
    contentController.clear();
    selectedPostType = 'Text';
    pickedImage = null;
    update();
  }



  Future<void> deletePost(int id) async {
    AwesomeDialog(
      context: Get.context!,
      dialogType: DialogType.warning,
      animType: AnimType.bottomSlide,
      title: 'Confirm Delete',
      desc: 'Are you sure you want to delete this mentor post?',
      btnCancelOnPress: () {},
      btnOkOnPress: () async {
        try {
          final success = await _provider.deleteMentorPost(id);
          if (success) {
            posts.removeWhere((element) => element.id == id);
            update();
            Get.snackbar(
              "Success", 
              "Post deleted successfully!",
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.green.withOpacity(0.8),
              colorText: Colors.white,
            );
          }
        } catch (e) {
          Get.snackbar("Error", e.toString());
        }
      },
    ).show();
  }

  void editPost(MentorPost post) {
    // To be implemented
  }

  @override
  void onClose() {
    titleController.dispose();
    contentController.dispose();
    super.onClose();
  }
}
