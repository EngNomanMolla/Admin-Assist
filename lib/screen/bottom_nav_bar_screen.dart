import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/home_controller.dart';
import 'home_screen.dart';
import 'calculator_screen.dart';
import 'profile_screen.dart';

class BottomNavBarScreen extends StatelessWidget {
  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: GetBuilder<HomeController>(
          builder: (homeCtrl) {
            if (homeCtrl.selectedIndex != 0) return const SizedBox.shrink();
            return AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              title: const Column(
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
            );
          },
        ),
      ),
      body: GetBuilder<HomeController>(
        builder: (homeCtrl) {
          switch (homeCtrl.selectedIndex) {
            case 0:
              return HomeContent();
            case 1:
              return CalculatorScreen();
            case 2:
              return const Center(
                child: Text(
                  "Notifications",
                  style: TextStyle(fontFamily: 'Inter'),
                ),
              );
            case 3:
              return ProfileScreen();
            default:
              return HomeContent();
          }
        },
      ),
      bottomNavigationBar: GetBuilder<HomeController>(
        builder: (homeCtrl) {
          return NavigationBarTheme(
            data: NavigationBarThemeData(
              labelTextStyle: MaterialStateProperty.resolveWith<TextStyle>(
                (Set<MaterialState> states) {
                  if (states.contains(MaterialState.selected)) {
                    return const TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple,
                    );
                  }
                  return const TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey,
                  );
                },
              ),
            ),
            child: NavigationBar(
              selectedIndex: homeCtrl.selectedIndex,
              onDestinationSelected: homeCtrl.changePage,
              backgroundColor: Colors.white,
              indicatorColor: Colors.deepPurple.withOpacity(0.15),
              elevation: 8,
              shadowColor: Colors.black.withOpacity(0.5),
              labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
              destinations: const [
                NavigationDestination(
                  icon: Icon(Icons.home_outlined, color: Colors.grey),
                  selectedIcon: Icon(Icons.home_rounded, color: Colors.deepPurple),
                  label: 'Home',
                ),
                NavigationDestination(
                  icon: Icon(Icons.calculate_outlined, color: Colors.grey),
                  selectedIcon: Icon(Icons.calculate_rounded, color: Colors.deepPurple),
                  label: 'Calculator',
                ),
                NavigationDestination(
                  icon: Icon(Icons.notifications_outlined, color: Colors.grey),
                  selectedIcon: Icon(Icons.notifications_rounded, color: Colors.deepPurple),
                  label: 'Notification',
                ),
                NavigationDestination(
                  icon: Icon(Icons.person_outline_rounded, color: Colors.grey),
                  selectedIcon: Icon(Icons.person_rounded, color: Colors.deepPurple),
                  label: 'Profile',
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
