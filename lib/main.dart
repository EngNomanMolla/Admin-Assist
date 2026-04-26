import 'package:flutter/material.dart';
import 'package:flutter_widgets/routes/app_pages.dart';
import 'package:flutter_widgets/routes/app_routes.dart';
import 'package:get/get.dart';
import 'package:flutter_widgets/services/auth_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Get.putAsync(() => AuthService().init());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = Get.find<AuthService>();
    
    return GetMaterialApp(
      title: 'Mentor Admin',
      debugShowCheckedModeBanner: false,
      initialRoute: authService.token != null ? AppRoutes.BOTTOM_NAV : AppPages.INITIAL,
      getPages: AppPages.routes,
    );
  }
}
