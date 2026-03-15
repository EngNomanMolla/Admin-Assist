import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/home_controller.dart';
import 'home_screen.dart';

class NavigetionScreen extends StatelessWidget {
  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Admin",
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontFamily: 'Inter',
              ),
            ),
            Text(
              "Welcome back",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 12,
                fontFamily: 'Inter',
              ),
            ),
          ],
        ),
      ),
      body: GetBuilder<HomeController>(
        builder: (homeCtrl) {
          switch (homeCtrl.selectedIndex) {
            case 0:
              return HomeContent();
            case 1:
              return const Center(
                child: Text(
                  "Calculator",
                  style: TextStyle(fontFamily: 'Inter'),
                ),
              );
            case 2:
              return const Center(
                child: Text(
                  "Notifications",
                  style: TextStyle(fontFamily: 'Inter'),
                ),
              );
            case 3:
              return const Center(
                child: Text("Profile", style: TextStyle(fontFamily: 'Inter')),
              );
            default:
              return HomeContent();
          }
        },
      ),
      bottomNavigationBar: GetBuilder<HomeController>(
        builder: (homeCtrl) {
          return BottomNavigationBar(
            currentIndex: homeCtrl.selectedIndex,
            onTap: homeCtrl.changePage,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Colors.deepPurple,
            unselectedItemColor: Colors.grey,
            showUnselectedLabels: true,
            selectedLabelStyle: const TextStyle(
              fontFamily: 'Inter',
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
            unselectedLabelStyle: const TextStyle(
              fontFamily: 'Inter',
              fontSize: 12,
            ),
            items: [
              _buildNavItem(
                'assets/icons/icon11.png',
                "Home",
                0,
                homeCtrl.selectedIndex,
              ),
              _buildNavItem(
                'assets/icons/icon12.png',
                "Calculator",
                1,
                homeCtrl.selectedIndex,
              ),
              _buildNavItem(
                'assets/icons/icon13.png',
                "Notification",
                2,
                homeCtrl.selectedIndex,
              ),
              _buildNavItem(
                'assets/icons/icon14.png',
                "Profile",
                3,
                homeCtrl.selectedIndex,
              ),
            ],
          );
        },
      ),
    );
  }

  BottomNavigationBarItem _buildNavItem(
    String imagePath,
    String label,
    int index,
    int currentIndex,
  ) {
    bool isSelected = index == currentIndex;
    return BottomNavigationBarItem(
      icon: Image.asset(
        imagePath,
        width: 24,
        height: 24,
        fit: BoxFit.contain,
        color: isSelected ? Colors.deepPurple : Colors.grey,
        gaplessPlayback: true,
      ),
      label: label,
    );
  }
}
