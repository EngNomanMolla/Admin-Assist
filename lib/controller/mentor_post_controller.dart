import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MentorPost {
  final String title;
  final String date;
  final String images;
  final String tag;

  MentorPost({
    required this.title,
    required this.date,
    required this.images,
    required this.tag,
  });
}

class MentorPostController extends GetxController {
  List<MentorPost> posts = [];

  final titleController = TextEditingController();
  final contentController = TextEditingController();
  String selectedPostType = 'Text';
  String? uploadedImageName;

  @override
  void onInit() {
    super.onInit();
    loadPosts();
  }

  void loadPosts() {
    var data = List.generate(
      5,
      (index) => MentorPost(
        title: "Top 10 Study Tips for Final Exams",
        date: "2026-02-10",
        images: "assets/images/png/mentor5.png",
        tag: index % 2 == 0 ? "Text" : "Image",
      ),
    );
    posts = data;
    update();
  }

  void changePostType(String type) {
    selectedPostType = type;
    update();
  }

  void pickImage() {
    uploadedImageName = "mentor_image_01.png";
    update();
  }

  void publishPost() {
    if (titleController.text.isNotEmpty) {
      final newPost = MentorPost(
        title: titleController.text,
        date: DateTime.now().toString().split(' ')[0],
        images: "assets/images/png/mentor5.png",
        tag: selectedPostType,
      );

      posts.insert(0, newPost);

      titleController.clear();
      contentController.clear();
      selectedPostType = 'Text';
      uploadedImageName = null;

      update();
      Get.back();

      Get.snackbar(
        "Success",
        "Post published successfully!",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } else {
      Get.snackbar(
        "Error",
        "Please enter a title",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
    }
  }

  void deletePost(int index) {
    posts.removeAt(index);
    update();
    Get.snackbar(
      "Deleted",
      "Post has been removed successfully",
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  void editPost(int index) {
    print("Editing post at index: $index");
  }

  @override
  void onClose() {
    titleController.dispose();
    contentController.dispose();
    super.onClose();
  }
}
