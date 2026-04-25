import 'package:flutter/material.dart';
import 'package:flutter_widgets/routes/app_pages.dart';
import 'package:flutter_widgets/routes/app_routes.dart';
import 'package:get/get.dart';
import 'package:flutter_widgets/services/auth_service.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(AuthService());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    );
  }
}
