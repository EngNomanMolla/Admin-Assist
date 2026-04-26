import 'package:flutter_widgets/screen/career_updates/career_details_screen.dart';
import 'package:get/get.dart';
import 'package:flutter_widgets/routes/app_routes.dart';
import 'package:flutter_widgets/screen/bottom_nav_bar_screen.dart';
import 'package:flutter_widgets/screen/banner_Ads/banner_ads_screen.dart';
import 'package:flutter_widgets/screen/career_updates/career_updates_screen.dart';
import 'package:flutter_widgets/screen/live_notice_screen.dart/live_notice_screen.dart';
import 'package:flutter_widgets/screen/mentor_post_screen/mentor_post_screen.dart';
import 'package:flutter_widgets/screen/product_screen/product_screen.dart';
import 'package:flutter_widgets/screen/user_management/user_list_screen.dart';
import 'package:flutter_widgets/screen/auth/sign_in_screen.dart';
import 'package:flutter_widgets/screen/auth/sign_up_screen.dart';

class AppPages {
  static const INITIAL = AppRoutes.SIGN_IN;

  static final routes = [
    GetPage(
      name: AppRoutes.SIGN_IN,
      page: () => const SignInScreen(),
    ),
    GetPage(
      name: AppRoutes.SIGN_UP,
      page: () => const SignUpScreen(),
    ),
    GetPage(
      name: AppRoutes.BOTTOM_NAV,
      page: () => BottomNavBarScreen(),
    ),
    GetPage(
      name: AppRoutes.LIVE_NOTICE,
      page: () => LiveNoticeScreen(),
    ),
    GetPage(
      name: AppRoutes.BANNER_ADS,
      page: () => const BannerAdsScreen(),
    ),
    GetPage(
      name: AppRoutes.PRODUCTS,
      page: () => const ProductScreen(),
    ),
    GetPage(
      name: AppRoutes.CAREER_UPDATES,
      page: () => const CareerUpdatesScreen(),
    ),
    GetPage(
      name: AppRoutes.CAREER_DETAILS,
      page: () => CareerDetailsScreen(circularId: Get.arguments),
    ),
    GetPage(
      name: AppRoutes.USERS,
      page: () => UserListScreen(),
    ),
    GetPage(
      name: AppRoutes.MENTOR_POSTS,
      page: () => MentorPostScreen(),
    ),
  ];
}
