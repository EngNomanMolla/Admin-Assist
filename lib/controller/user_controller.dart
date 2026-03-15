import 'package:get/get.dart';

class User {
  final String name;
  final String email;
  final String phone;
  final String joinedDate;
  final String imageUrl;

  User({
    required this.name,
    required this.email,
    required this.phone,
    required this.joinedDate,
    required this.imageUrl,
  });
}

class UserController extends GetxController {
  List<User> users = [];

  @override
  void onInit() {
    super.onInit();
    loadUsers();
  }

  void loadUsers() {
    var data = List.generate(
      8,
      (index) => User(
        name: "Rahul Ahamed",
        email: "rahul@example.com",
        phone: "+880 1723-456789",
        joinedDate: "2026-01-15",
        imageUrl: "assets/images/png/rahuls.png",
      ),
    );

    users = data;
    update();
  }

  void updateUserInfo(int index, String newName, String newPhone) {
    users[index] = User(
      name: newName,
      email: users[index].email,
      phone: newPhone,
      joinedDate: users[index].joinedDate,
      imageUrl: users[index].imageUrl,
    );
    update();
  }

  void deleteUser(int index) {
    users.removeAt(index);
    update();
    Get.back();
  }
}
