import 'package:get/get.dart';

class HomeController extends GetxController {
  int selectedIndex = 0;

  int liveNotices = 12;
  int bannerAds = 5;
  int products = 48;
  int careerUpdates = 23;
  int users = 1247;
  int mentorPosts = 0;

  void changePage(int index) {
    if (index >= 0 && index < 4) {
      selectedIndex = index;
      update();
    }
  }

  void onAddNotice() {
    liveNotices++;
    update();
  }

  void onAddBanner() {
    bannerAds++;
    update();
  }

  void onAddProduct() {
    products++;
    update();
  }

  void onAddCareer() {
    careerUpdates++;
    update();
  }
}
